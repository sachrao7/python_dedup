# PRS Data Dedup


### Source Data: `usa_participant` 

export prod table to csv  -> `usa_participants-2.csv`

```bash
turlapati.v@data-manager:~/data$ ls -ltr
total 58104
-rw-r--r-- 1 root        root        28886324 Feb 15 16:38 usa_participants-2.csv
# Total Records: 135464
```


### Problem: Email should be the primary key in prod usa_participant table 

[0] Exploratory analysis on email id fields 
[1] Identify subsets/duplicate emails within the source csv file 
[2] Define deduplication strategy for the above set
[3] Analyze duplicate records bin them by category 
[4] How to execute the dedup strategy downstream (to all child tables, resolving the records)


### [0] Exploratory analysis on email id fields 

**How many email id’s are valid?**

Use this python package “py3-validate-email” to validate the email id, this package not only does regex check it also ping the domain 

```bash 
from validate_email import validate_email

In [27]: validate_email(email_address='a@gmail.com')
Out[27]: False
 
In [28]: validate_email(email_address='tkmallik@gmail.com')
Out[28]: True
```

Next Step: Run this through and weed out bad email id’s also check if we have a tight email check at intake. 


### [1] Identify subsets/duplicate emails within the source csv file 

There are 3534 duplicate email id. This will be the main target set 

```bash
In [8]: mysql("select email, count(1) as dups from df group by email having count(1) > 1")
Out[8]: 
                         email  dups
0                         None     3
1           1217briv@gmail.com     2
2              122353c@att.net     2
3     18mariaceleste@gmail.com     2
4          19.chetna@gmail.com     2
...                        ...   ...
3530      yvesdeb@sympatico.ca     2
3531        zamaneh05@yahoo.ca     3
3532     zari.karimi@gmail.com     2
3533     zeke_eyes@hotmail.com     2
3534        zhanihai@gmail.com     2
```

### [2] Define deduplication strategy for the above set

Main columns of interest in the source csv -  fname, lname, gender and  email 

We need to develop a script to identify records as below and produce a similarity match score  
<img width="674" alt="image" src="https://github.com/krishnaturlapati/dedup/assets/2637461/28eb2211-95c3-44ca-b4fb-a65caae3be4f">

email

### [3]  Analyze duplicate records bin them by category 

Sample test cases/types of subsets with same email id 
Input Fields: FirstName, LastName, Gender, Email Id
Output Fields: FirstName, LastName, Gender, Email Id, Match %

Binning: For Same Email Id:

Total Count: 4819

<img width="643" alt="image" src="https://github.com/krishnaturlapati/dedup/assets/2637461/954bd128-356b-493a-a923-f34da3bff475">


Test Cases 


```bash
Sample outputs 

Input: 
TC0= ['Lakshmi Narasimhan Yeri Ranganathan Male yrln2012@gmail.com', 'Lakshmi Narasimhan Male yrln2012@gmail.com']

Model Output:
Lakshmi Narasimhan Yeri Ranganathan Male yrln2012@gmail.com Lakshmi Narasimhan Yeri Ranganathan Male yrln2012@gmail.com 100
Lakshmi Narasimhan Yeri Ranganathan Male yrln2012@gmail.com Lakshmi Narasimhan Male yrln2012@gmail.com 83
Lakshmi Narasimhan Male yrln2012@gmail.com Lakshmi Narasimhan Yeri Ranganathan Male yrln2012@gmail.com 83
Lakshmi Narasimhan Male yrln2012@gmail.com Lakshmi Narasimhan Male yrln2012@gmail.com 100
```

Case-1
```bash
Tc1 = ['Sai Ganesh Male wellness.ganesh@gmail.com','Sai Ganesh Chintala MALE wellness.ganesh@gmail.com']
Sai Ganesh Male wellness.ganesh@gmail.com Sai Ganesh Male wellness.ganesh@gmail.com 100
Sai Ganesh Male wellness.ganesh@gmail.com Sai Ganesh Chintala MALE wellness.ganesh@gmail.com 86
Sai Ganesh Chintala MALE wellness.ganesh@gmail.com Sai Ganesh Male wellness.ganesh@gmail.com 86
Sai Ganesh Chintala MALE wellness.ganesh@gmail.com Sai Ganesh Chintala MALE wellness.ganesh@gmail.com 100
``` 
 
Case-2
```bash
Tc2 = ['Yogini Patel Female yoginiptl@gmail.com', 'Rashva  Patel Male yoginiptl@gmail.com'] 
 
Yogini Patel Female yoginiptl@gmail.com Yogini Patel Female yoginiptl@gmail.com 100
Rashva  Patel Male yoginiptl@gmail.com Rashva  Patel Male yoginiptl@gmail.com 100
Yogini Patel Female yoginiptl@gmail.com Rashva  Patel Male yoginiptl@gmail.com 78
Rashva  Patel Male yoginiptl@gmail.com Yogini Patel Female yoginiptl@gmail.com 78
``` 
 
Case-3
```bash
Tc3 = ['Yuliya Madueno Female ykosovets@yahoo.com', 'Katherin Sophie Adler Female ykosovets@yahoo.com']
 
Yuliya Madueno Female ykosovets@yahoo.com Yuliya Madueno Female ykosovets@yahoo.com 100
Katherin Sophie Adler Female ykosovets@yahoo.com Katherin Sophie Adler Female ykosovets@yahoo.com 100
Yuliya Madueno Female ykosovets@yahoo.com Katherin Sophie Adler Female ykosovets@yahoo.com 70
Katherin Sophie Adler Female ykosovets@yahoo.com Yuliya Madueno Female ykosovets@yahoo.com 70
```

Case-4

```bash
Tc4 = ['Youssef Alayche Male youssef-chess@hotmail.com', 'Dalal Alayche Female youssef-chess@hotmail.com', 'Sawssan Mansour  Female youssef-chess@hotmail.com', 'Ahmad Alayche  Male youssef-chess@hotmail.com']
  
Youssef Alayche Male youssef-chess@hotmail.com Youssef Alayche Male youssef-chess@hotmail.com 100
Ahmad Alayche  Male youssef-chess@hotmail.com Ahmad Alayche  Male youssef-chess@hotmail.com 100
Sawssan Mansour  Female youssef-chess@hotmail.com Sawssan Mansour  Female youssef-chess@hotmail.com 100
Dalal Alayche Female youssef-chess@hotmail.com Dalal Alayche Female youssef-chess@hotmail.com 100
Youssef Alayche Male youssef-chess@hotmail.com Dalal Alayche Female youssef-chess@hotmail.com 83
Youssef Alayche Male youssef-chess@hotmail.com Sawssan Mansour  Female youssef-chess@hotmail.com 74
Youssef Alayche Male youssef-chess@hotmail.com Ahmad Alayche  Male youssef-chess@hotmail.com 88
Dalal Alayche Female youssef-chess@hotmail.com Youssef Alayche Male youssef-chess@hotmail.com 84
Dalal Alayche Female youssef-chess@hotmail.com Sawssan Mansour  Female youssef-chess@hotmail.com 78
Dalal Alayche Female youssef-chess@hotmail.com Ahmad Alayche  Male youssef-chess@hotmail.com 87
Sawssan Mansour  Female youssef-chess@hotmail.com Youssef Alayche Male youssef-chess@hotmail.com 74
Sawssan Mansour  Female youssef-chess@hotmail.com Dalal Alayche Female youssef-chess@hotmail.com 78
Sawssan Mansour  Female youssef-chess@hotmail.com Ahmad Alayche  Male youssef-chess@hotmail.com 76
Ahmad Alayche  Male youssef-chess@hotmail.com Youssef Alayche Male youssef-chess@hotmail.com 88
Ahmad Alayche  Male youssef-chess@hotmail.com Dalal Alayche Female youssef-chess@hotmail.com 87
Ahmad Alayche  Male youssef-chess@hotmail.com Sawssan Mansour  Female youssef-chess@hotmail.com 76
``` 
 
 
Case-5

```bash
Tc5 = ['yingying shi Female yingyinsc@gmail.com', 'yang wang Male yingyinsc@gmail.com', 'Yingying Sylvia Shi Female yingyinsc@gmail.com']
 
yingying shi Female yingyinsc@gmail.com yingying shi Female yingyinsc@gmail.com 100
Yingying Sylvia Shi Female yingyinsc@gmail.com Yingying Sylvia Shi Female yingyinsc@gmail.com 100
yingying shi Female yingyinsc@gmail.com yang wang Male yingyinsc@gmail.com 79
yingying shi Female yingyinsc@gmail.com Yingying Sylvia Shi Female yingyinsc@gmail.com 87
yang wang Male yingyinsc@gmail.com yingying shi Female yingyinsc@gmail.com 79
yang wang Male yingyinsc@gmail.com yang wang Male yingyinsc@gmail.com 100
yang wang Male yingyinsc@gmail.com Yingying Sylvia Shi Female yingyinsc@gmail.com 72
Yingying Sylvia Shi Female yingyinsc@gmail.com yingying shi Female yingyinsc@gmail.com 87
Yingying Sylvia Shi Female yingyinsc@gmail.com yang wang Male yingyinsc@gmail.com 72
``` 
 
Csae-6

```
Tc6 = ['James Midgley Male yinmizhi@yahoo.co.uk','Ian Midgley Male yinmizhi@yahoo.co.uk']
 
James Midgley Male yinmizhi@yahoo.co.uk James Midgley Male yinmizhi@yahoo.co.uk 100
Ian Midgley Male yinmizhi@yahoo.co.uk Ian Midgley Male yinmizhi@yahoo.co.uk 100
James Midgley Male yinmizhi@yahoo.co.uk Ian Midgley Male yinmizhi@yahoo.co.uk 92
Ian Midgley Male yinmizhi@yahoo.co.uk James Midgley Male yinmizhi@yahoo.co.uk 92
```

Case-7
```bash
TC7 = [‘chetna~josyula~FEMALE~19.chetna@gmail.com’, ‘Chetna~J~~19.chetna@gmail.com’,  77]
Match may be very low but compared to all other fuzzy matches this is highest. So they both are similar 
```
