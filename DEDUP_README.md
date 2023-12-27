# Dedup Users 

## Objective 
Develop a script to identify users from `usa_participant` table with same email id and come up with a match score to determine similarity between two enities.  


## Scope
There are many sub cases to this problem: 

1. Same email same gender 
2. Same email different genders 
3. Same email for the entire family
4. Same email with different language 
5. Same email with different last name 

The scope of the problem is reduced to use case `#1`   

| Fname   |      Lname      |  Gender | Email|
|----------|-------------|------|------|
| John |  Smith | Male |  johnsmith@gmail.com|
| Johny |  Smith | Male |  johnsmith@gmail.com|


## Approach 

Step1: Treat Fname+Lname+Gender+Email as one continous string

Step2: Generate combos, if we have three strings `s1,s2,s3`, then we end up with three combos `(s1,s2), (s1,s3), (s2,s3).`

Step3: Use `fuzzywuzzy` python based text processing library to determine the similarity between string1 and string2. Run this match on all combos from `Step2` where email is common between both the strings.

Step4: Identify all records with match ratio > 90%



## Local Setup

Install Miniconda or Anaconda and create an sfdc virtual env 

```bash
# create an env
conda env create -f environment.yml
# update packages in an env
conda env update -n sfdc --file environment.yml
```

IntelliJ Setup
```
# set env path (Windows)
set PYTHONPATH=%PYTHONPATH%;C:\Users\Turla\code\Isha\sfdc\feat-data-dedup

```


Docker Setup

```
docker pull mysql
docker run -d --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=secret -e MYSQL_DATABASE=sfdcdev mysql
```

Install MySQL Workbench to connect to the local MySQL Server  `https://dev.mysql.com/downloads/workbench/`

Run the sql script in `tests\unit\dedup\dedup_prs_tables.sql`

## Rectify Duplicates

Load the match ratio file to this table structure. The tie breaker is the last update time stamp from  `usa_participant` table

```sql
CREATE TABLE `usap_dedup` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `person1` varchar(500) NOT NULL,
 `person2` varchar(500) NOT NULL,
 `match_ratio` int(3) NOT NULL,
 `merge_ts` datetime DEFAULT NULL,
 `primary_detected` varchar(10) DEFAULT NULL,
 `manual_merge` tinyint(1) DEFAULT NULL,
 `manual_merge_by` varchar(100) DEFAULT NULL,
 `manual_merge_comment` varchar(500) DEFAULT NULL,
 `created_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `lastUpd_ts` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8
```


Downstream table dependencies 

Tables of relations for usa_participants (partId)

* meetreg
* partadditional
* partProgram
* partshuttle
* partVolAdditional
* part_extended
* pgmcheck_iiimeet_sg
* volprogram
* childpending (parentId)
* child_participants (parentId)

## Person lineage 

## Manual merge flow
