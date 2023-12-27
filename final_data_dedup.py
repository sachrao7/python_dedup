from itertools import combinations
import datetime
from tkinter import E
from fuzzywuzzy import fuzz
import mysql.connector
import logging
import sys
from mysql.connector import connect
from typing import List
import traceback
from mysql.connector import Error
from mysql.connector import pooling
from mysqlx import InterfaceError
import pandas as pd
import time
import os
import glob


logger = logging.getLogger()
FORMAT = "App:DataDedup Date:%(asctime)s  LogLevel:%(levelname)s Script:%(filename)s linenum:%(lineno)s method:%(funcName)s() message:%(message)s"
logging.basicConfig(stream=sys.stdout, level=logging.INFO, format=FORMAT)


def clean_up():
    path = os.getcwd()
    print(path)
    for file in glob.glob(path+"/*.csv"):
        os.remove(file)


class MySqlRepo:
    pool = None

    def __init__(self):
        """ connection string information this is temporary, these attrs will eventually be system driver """
        self.host = 'localhost'
        self.database = 'sfdcdev'
        self.user = 'root'
        self.password = 'secret'
        self.pool_name = 'sfdc_pool'
        MySqlRepo.pool = self.create_session()

    def create_session(self):
        """ Mysql connection pool """
        try:
            pool = pooling.MySQLConnectionPool(pool_name=self.pool_name,
                                               pool_size=5,
                                               pool_reset_session=True,
                                               host=self.host,
                                               database=self.database,
                                               user=self.user,
                                               password=self.password,
                                               autocommit=True)
            logger.info("Created a pool object ")
            return pool
        except Exception as e:
            logger.error("Failed to create a session " + str(e))
            traceback.print_exc()
            return e

    def fetch(self, db_query: str, type: str) -> List:
        """ fetch the database query return database results in list of dict format [{}, {}]"""
        if db_query is None or db_query == '':
            logger.error("Received empty sql query string")
            raise ValueError()

        try:
            connect_obj = self.pool.get_connection()
            cursor = connect_obj.cursor(dictionary=True)
            if type != "update":
                cursor.execute(db_query)
                return cursor.fetchall()
            else:
                cursor.execute(db_query, multi=True)
                connect_obj.commit()

        except Error as e:
            logger.error("Failed to fetch data " + str(e))
            raise e
        finally:
            if connect_obj.is_connected():
                cursor.close()
                connect_obj.close()


def get_participant_info_from_mysql() -> str:
    try:
        curr_path = os.getcwd()
        logger.info("Extract participant data")
        query = """select CONCAT(fname,'~',lname,'~',sex,'~',email) as c1 from usa_participants 
        where email in (select email from usa_participants group by email having count(1) > 1) """
        data = MySqlRepo().fetch(db_query=query)
        logger.info(f"Fetched {len(data)} records")
        data_df = pd.DataFrame(data)
        save_path = curr_path + f'/target_list_{str(int(time.time()))}.csv'
        data_df.to_csv(save_path, index=False)
        logger.info(f"File saved to this path {save_path}")
        logger.info("Step-1 Done")
        return save_path
    except Exception as e:
        logger.error("Failed to retrieve data " + str(e))


def generate_match_ratio(target_list_path: str) -> str:
    df1 = pd.read_csv(target_list_path)
    df2 = pd.read_csv(target_list_path)
    match_ratio = []
    cwd = os.getcwd()
    try:
        for i, r1 in df1.iterrows():
            for j, r2 in df2.iterrows():
                if r1['c1'] != r2['c1'] and r1['c1'].split('~')[-1] == r2['c1'].split('~')[-1]:
                    ratio = fuzz.token_sort_ratio(r1['c1'], r2['c1'])
                    match_ratio.append(
                        [r1['c1'], r2['c1'], r2['c1'].split('~')[-1], ratio])
        df = pd.DataFrame(match_ratio, columns=[
                          'c1', 'c2', 'email', 'match_ratio'])
        # save all matches
        save_path = cwd + f'/match_ratio_{str(int(time.time()))}.csv'
        df.to_csv(save_path, index=False)

        # save match ratio > 90
        df_match_gt_90 = df.query('match_ratio > 90')
        save_path = cwd + f'/match_ratio_gt_90_{str(int(time.time()))}.csv'
        df_match_gt_90.to_csv(save_path, index=False)
        logging.info(f"Found {len(df_match_gt_90)} records")

        # save only emailid for match ratio > 90
        df_90_email = df_match_gt_90[['email']].drop_duplicates()
        save_path_email = cwd + \
            f'/match_ratio_gt_90_email_{str(int(time.time()))}.csv'
        df_90_email.to_csv(save_path_email, index=False)
        logging.info("Step-2 Done")
        return save_path_email
    except Exception as e:
        logger.error("Generate combos failed " + str(e))


def updat_mysql(dup_emails_path):
    dup_emails = pd.read_csv(dup_emails_path)
    emails = dup_emails['email'].to_list()
    logging.info(f"Found {len(emails)} to fix")
    for email in emails:
        update_sequence(email)


def update_sequence():
    pass


def get_partid_parent_child_from_mysql(email) -> List:
    # query = """select partId, r from (select partId, email, lastUpd, rank() over(partition by email order by lastUpd) as r
    #    from usa_participants where email = '{0}') t""".format(email)
    query = """ select  group_concat(partId order by r desc) as pc_list from (
    select partId, email, lastUpd, rank() over(partition by email order by lastUpd) as r
    from usa_participants 
    where email = '{0}'
    ) t order by r desc
    """.format(email)
    logging.info(query)
    try:
        data = MySqlRepo().fetch(db_query=query, type="select")
        pc_list_str = data[0]['pc_list']
        pc_list = []
        for pc in pc_list_str.split(','):
            pc_list.append(pc.strip())
        logging.info(f"Parent child relationship {pc_list}")
        return pc_list
    except Exception as e:
        logging.error(
            "Failed to run get_partid_parent_child_from_mysql " + str(e))


def update_partId_in_child_tbls(pc_list):
    # partadditional
    base_sql = """ SET SQL_SAFE_UPDATES = 0; """
    update_query_stub = "update partadditional set partId = {0} where partId = {1};"
    parent = pc_list[0]
    final_sql = base_sql
    for child in pc_list[1:]:
        final_sql += update_query_stub.format(child, parent)
    logging.info(final_sql)

    data = MySqlRepo().fetch(db_query=final_sql, type="update")


def main(args):
    # Step-0:
    # if args[1] == 'True':
    #    clean_up()
    # Step-1:
    #path = get_participant_info_from_mysql()
    # Step-2:
    # generate_match_ratio(path)
    # Step-3:
    path = '/Users/venkatkrishnaturlapati/code/ishait/salesforce-connector/data_dedup_final/match_ratio_gt_90_email_1652042711.csv'
    email = "tkmallik@gmail.com"
    pc_list = get_partid_parent_child_from_mysql(email)
    # Step-4:
    update_partId_in_child_tbls(pc_list)


if __name__ == "__main__":
    main(sys.argv)
