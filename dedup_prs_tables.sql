CREATE TABLE IF NOT EXISTS `usa_participants` (
  `partId` int(11) NOT NULL,
  `fname` varchar(50) NOT NULL,
  `lname` varchar(50) NOT NULL,
  `prefName` varchar(100) DEFAULT NULL,
  `email` varchar(128) NOT NULL,
  `pass` varchar(128) DEFAULT NULL,
  `pPhone` varchar(15) NOT NULL,
  `sPhone` varchar(15) DEFAULT NULL,
  `sex` varchar(10) NOT NULL,
  `dob` date DEFAULT NULL,
  `address1` varchar(100) NOT NULL,
  `address2` varchar(100) DEFAULT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `zip` varchar(12) NOT NULL,
  `country` varchar(3) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `userRegion` enum('USCA','EUUK','APAC','OTH') DEFAULT NULL,
  `medType` enum('MED','VOL','CVOL','ISHA','NONE') DEFAULT NULL,
  `ethnicity` varchar(20) DEFAULT NULL,
  `occupation` varchar(128) DEFAULT NULL,
  `sFId` varchar(20) DEFAULT NULL,
  `ssoId` varchar(50) DEFAULT NULL,
  `ssoCountry` varchar(2) DEFAULT NULL COMMENT 'sso country of residence',
  `lastUpd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB AUTO_INCREMENT=29807 DEFAULT CHARSET=utf8;

ALTER TABLE `usa_participants`  ADD PRIMARY KEY (`partId`);
ALTER TABLE `usa_participants`
  MODIFY `partId` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=29807;

INSERT INTO `usa_participants` (`partId`, `fname`, `lname`, `prefName`, `email`, `pass`, `pPhone`, `sPhone`, `sex`, `dob`, `address1`, `address2`, `city`, `state`, `zip`, `country`, `age`, `userRegion`, `medType`, `ethnicity`, `occupation`, `sFId`, `ssoId`, `ssoCountry`, `lastUpd`) VALUES
(28476, 'first-28476', 'last-28476', NULL, '28476@28476.com', NULL, '', '', 'Female', NULL, '', '', 'Sandy', 'UT', '84092', 'US', 18, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 17:10:25'),
(28477, 'first-28477', 'last-28477', NULL, '28477@28477.com', NULL, '', '', 'Female', NULL, '', '', 'Riverton', 'UT', '84065', 'US', 39, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 17:10:25'),
(28478, 'first-28478', 'last-28478', NULL, '28478@28478.com', NULL, '', '', 'Female', NULL, '', '', 'Sandy', 'UT', '84092', 'US', 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 17:10:25'),
(28479, 'first-28479', 'last-28479', NULL, '28479@28479.com', NULL, '', '', 'Male', NULL, '', '', 'South Jordan', 'UT', '84009', 'US', 34, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 17:10:25'),
(28480, 'first-28480', 'last-28480', NULL, '28480@28480.com', NULL, '', '', 'Male', NULL, '', '', 'Taylorsville', 'UT', '84129', 'AF', 68, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 17:10:25'),
(28481, 'first-28481', 'last-28481', NULL, '28481@28481.com', NULL, '', '', 'Male', NULL, '', '', 'Las Vegas', 'NV', '89149-4640', 'US', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 17:10:25'),
(1, 'john', 'smith', NULL, 'johnsmith@gmail.com', NULL, '', '', 'Male', NULL, '', '', 'Las Vegas', 'NV', '89149-4640', 'US', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 17:10:25'),
(2, 'johnny', 'smith', NULL, 'johnsmith@gmail.com', NULL, '', '', 'Male', NULL, '', '', 'Las Vegas', 'NV', '89149-4640', 'US', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2019-01-19 17:10:25');


/***************/

CREATE TABLE IF NOT EXISTS `meetreg` (
  `partMeetId` int(11) NOT NULL,
  `pmLocId` int(11) NOT NULL,
  `partId` int(11) NOT NULL,
  `regDate` datetime NOT NULL,
  `partDob` date DEFAULT NULL,
  `maritalStatus` varchar(1) DEFAULT NULL,
  `partOcc` varchar(100) DEFAULT NULL,
  `partEdu` varchar(100) DEFAULT NULL,
  `phyAilment` text,
  `menAilment` text,
  `noSamyama` tinyint(4) DEFAULT NULL,
  `samDates` varchar(150) DEFAULT NULL,
  `meetRegStatus` tinyint(4) NOT NULL DEFAULT '1',
  `attStatus` tinyint(4) DEFAULT NULL,
  `attDate` date DEFAULT NULL,
  `intStatus` tinyint(4) DEFAULT NULL,
  `intDate` date DEFAULT NULL,
  `intComments` text,
  `interId` int(11) DEFAULT NULL,
  `meetRegComment` text,
  `pgmEditComment` text,
  `hashtag` varchar(100) DEFAULT NULL,
  `photoFlag` tinyint(4) DEFAULT '0',
  `insFlag` tinyint(4) DEFAULT '0',
  `visaFlag` tinyint(4) DEFAULT '0',
  `citizenFlag` tinyint(4) DEFAULT NULL,
  `passportFlag` tinyint(4) DEFAULT '0',
  `appvStatus` tinyint(4) DEFAULT '0',
  `appvComment` text,
  `wlStatus` tinyint(4) DEFAULT NULL,
  `apprBtch` varchar(2) DEFAULT NULL,
  `emegContType` varchar(50) DEFAULT NULL,
  `emegName` varchar(50) DEFAULT NULL,
  `emegPhone` varchar(15) DEFAULT NULL,
  `emegEmail` varchar(128) DEFAULT NULL,
  `purClothing` tinyint(4) DEFAULT '0',
  `purBedding` tinyint(4) DEFAULT '0',
  `arrDate` date DEFAULT NULL,
  `arrTime` varchar(10) DEFAULT NULL,
  `depDate` date DEFAULT NULL,
  `depTime` varchar(10) DEFAULT NULL,
  `arrMode` tinyint(4) DEFAULT NULL,
  `depMode` tinyint(4) DEFAULT NULL,
  `stayBooking` tinyint(1) DEFAULT NULL,
  `splPowerOpt` tinyint(1) DEFAULT NULL,
  `splFoodAllergy` tinyint(1) DEFAULT NULL,
  `splNeedDone` tinyint(1) DEFAULT NULL,
  `lastUpdTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `meetreg`
  MODIFY `partMeetId` int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE `meetreg`
ADD PRIMARY KEY (`partMeetId`),
ADD KEY `pmLocId` (`pmLocId`),
ADD KEY `partId` (`partId`);

/********************/
CREATE TABLE IF NOT EXISTS `partadditional` (
  `pgmPartId` int(11) NOT NULL,
  `partId` int(11) NOT NULL,
  `pgmId` int(11) NOT NULL,
  `pgmType` tinyint(4) NOT NULL,
  `questId` int(11) NOT NULL,
  `answer` text NOT NULL,
  `createdTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `partadditional` (`pgmPartId`, `partId`, `pgmId`, `pgmType`, `questId`, `answer`, `createdTimestamp`) VALUES
(34644, 28476, 1456, 2, 1, 'No', '2019-01-10 04:41:36'),
(34644, 28476, 1456, 2, 2, 'No', '2019-01-10 04:41:36'),
(34644, 28476, 1456, 2, 3, 'My mom has hypothyroidism and Dad has high blood pressure', '2019-01-10 04:41:36'),
(34645, 28477, 1509, 2, 1, '', '2019-01-10 04:45:00');

/*************************/


CREATE TABLE IF NOT EXISTS `partprogram` (
  `pgmPartId` int(11) NOT NULL,
  `partId` int(11) DEFAULT NULL,
  `childId` int(11) DEFAULT NULL,
  `pgmId` int(11) DEFAULT NULL,
  `pgmType` tinyint(4) DEFAULT NULL,
  `cmeOption` tinyint(4) DEFAULT NULL,
  `pgmAmt` int(11) DEFAULT NULL,
  `pgmCurr` varchar(3) DEFAULT NULL,
  `pgmCtry` varchar(2) NOT NULL DEFAULT 'US',
  `regDate` datetime DEFAULT NULL,
  `pgmGrp` tinyint(4) DEFAULT NULL,
  `pgmGrpId` int(11) DEFAULT NULL,
  `txnId` varchar(28) DEFAULT NULL,
  `corrId` varchar(255) DEFAULT NULL,
  `pmtStatus` tinyint(4) DEFAULT '1',
  `cStatus` char(1) DEFAULT 'A',
  `comment` text,
  `offline` varchar(100) DEFAULT NULL,
  `offlineCode` smallint(6) DEFAULT NULL,
  `couponCode` varchar(25) DEFAULT NULL,
  `partAge` smallint(6) DEFAULT NULL,
  `accomType` smallint(6) DEFAULT NULL,
  `shuttle1` varchar(32) DEFAULT NULL,
  `shuttle2` varchar(32) DEFAULT NULL,
  `shuttlePrice` int(11) DEFAULT NULL,
  `acommStDate` datetime DEFAULT NULL,
  `acommEnDate` datetime DEFAULT NULL,
  `acommPrice` int(11) DEFAULT NULL,
  `acommTxnId` varchar(20) DEFAULT NULL,
  `shmMMYYYY` varchar(15) DEFAULT NULL,
  `shmCity` varchar(100) DEFAULT NULL,
  `shmCenter` varchar(50) DEFAULT NULL,
  `teachName` varchar(50) DEFAULT NULL,
  `oldPgmId` int(11) DEFAULT NULL,
  `retAmt` int(11) DEFAULT NULL,
  `retDate` datetime DEFAULT NULL,
  `tagLocation` varchar(10) DEFAULT NULL,
  `zoneInfo` varchar(10) DEFAULT NULL,
  `lastUpd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `SF_UPDATE` tinyint(1) DEFAULT '0',
  `salesforce_ppr_id` varchar(30) DEFAULT NULL,
  `attendStatus` enum('Attended','NoShow','Cancel','Refund','Dropout','default','PValidated','Reschedule','CQComplete','CTComplete','CDenied') DEFAULT 'default',
  `attUpdDate` datetime DEFAULT NULL,
  `paymentType` enum('Partial','Full') NOT NULL DEFAULT 'Full',
  `nofInstallments` int(6) NOT NULL DEFAULT '0',
  `amountToPayEveryMonth` int(6) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=37397 DEFAULT CHARSET=utf8;

ALTER TABLE `partprogram`  ADD PRIMARY KEY (`pgmPartId`);
ALTER TABLE `partprogram`  MODIFY `pgmPartId` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=37397;


--
-- Dumping data for table `partprogram`
--

INSERT INTO `partprogram` (`pgmPartId`, `partId`, `childId`, `pgmId`, `pgmType`, `cmeOption`, `pgmAmt`, `pgmCurr`, `pgmCtry`, `regDate`, `pgmGrp`, `pgmGrpId`, `txnId`, `corrId`, `pmtStatus`, `cStatus`, `comment`, `offline`, `offlineCode`, `couponCode`, `partAge`, `accomType`, `shuttle1`, `shuttle2`, `shuttlePrice`, `acommStDate`, `acommEnDate`, `acommPrice`, `acommTxnId`, `shmMMYYYY`, `shmCity`, `shmCenter`, `teachName`, `oldPgmId`, `retAmt`, `retDate`, `tagLocation`, `zoneInfo`, `lastUpd`, `SF_UPDATE`, `salesforce_ppr_id`, `attendStatus`, `attUpdDate`, `paymentType`, `nofInstallments`, `amountToPayEveryMonth`) VALUES
(34644, 28476, NULL, 1456, 4, 0, 325, 'USD', 'US', '2019-01-09 20:41:36', 0, 0, '01T77005SK375340J', '985ba29f85536', 1, 'A', 'TPrice 325 SCost ', NULL, NULL, '', NULL, 0, '', '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, NULL, '', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, '2019-01-10 05:30:25', 1, NULL, 'default', NULL, 'Full', 0, 0),
(34645, 28477, NULL, 1509, 26, 0, 175, 'USD', 'US', '2019-01-09 20:45:00', 0, 0, '1F748164JP300172C', '9ec29f248060d', 1, 'A', 'TPrice 175 SCost ', NULL, NULL, '', NULL, 0, '', '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, NULL, '', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, '2019-01-10 05:30:29', 1, NULL, 'default', NULL, 'Full', 0, 0),
(34646, 28478, NULL, 1456, 4, 0, 325, 'USD', 'US', '2019-01-09 20:46:41', 0, 0, '0KL03241W5545920R', '89a573cca78b7', 1, 'A', 'TPrice 325 SCost ', NULL, NULL, '', NULL, 0, '', '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, NULL, '', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, '2019-01-10 05:30:34', 1, NULL, 'default', NULL, 'Full', 0, 0),
(34647, 28479, NULL, 1456, 4, 0, 325, 'USD', 'US', '2019-01-09 20:46:45', 0, 0, '8LW84136FR704981J', '8ef4e7b498936', 1, 'A', 'TPrice 325 SCost ', NULL, NULL, '', NULL, 0, '', '', 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, NULL, '', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, '2019-01-10 05:30:36', 1, NULL, 'default', NULL, 'Full', 0, 0);

/**************/


CREATE TABLE IF NOT EXISTS `partshuttle` (
  `partShuttleId` int(11) NOT NULL,
  `partId` int(11) NOT NULL,
  `shuttleId` int(11) NOT NULL,
  `regDate` datetime NOT NULL,
  `shuttleAmt` int(11) NOT NULL,
  `txnId` varchar(20) NOT NULL,
  `corrId` varchar(20) NOT NULL,
  `cStatus` varchar(1) DEFAULT NULL,
  `offline` varchar(100) DEFAULT NULL,
  `comment` text,
  `lastUpd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `SF_UPDATE` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3919 DEFAULT CHARSET=utf8;

ALTER TABLE `partshuttle` ADD PRIMARY KEY (`partShuttleId`);
ALTER TABLE `partshuttle` MODIFY `partShuttleId` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3919;
--
-- Dumping data for table `partshuttle`
--

INSERT INTO `partshuttle` (`partShuttleId`, `partId`, `shuttleId`, `regDate`, `shuttleAmt`, `txnId`, `corrId`, `cStatus`, `offline`, `comment`, `lastUpd`, `SF_UPDATE`) VALUES
(3858, 28492, 342, '2019-01-10 06:01:01', 40, '62T36558JD755690T', '9559c8f1e478f', 'A', NULL, '', '2019-01-10 15:30:26', 1),
(3876, 28605, 350, '2019-01-12 07:01:35', 40, '9J6245212S2312909', '524b1436c3917', 'A', NULL, '', '2019-01-13 04:30:16', 1),
(3877, 28605, 352, '2019-01-12 07:01:35', 40, '9J6245212S2312909', '524b1436c3917', 'A', NULL, '', '2019-01-13 04:30:18', 1),
(3903, 28516, 344, '2019-01-15 04:01:39', 40, '1YT054297S409980F', '319c2824482cc', 'A', NULL, '', '2019-01-16 01:30:28', 1),
(3911, 28824, 353, '2019-01-16 06:01:53', 40, '62794815XH583654Y', '5acaae67d7e74', 'A', NULL, '', '2019-01-17 03:30:52', 1);

/***************/


CREATE TABLE IF NOT EXISTS `partvoladditional` (
  `pgmVolId` int(11) NOT NULL,
  `partId` int(11) NOT NULL,
  `pgmId` int(11) NOT NULL,
  `pgmType` tinyint(4) NOT NULL,
  `questId` int(11) NOT NULL,
  `answer` text NOT NULL,
  `createdTimestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `partvoladditional`
--

INSERT INTO `partvoladditional` (`pgmVolId`, `partId`, `pgmId`, `pgmType`, `questId`, `answer`, `createdTimestamp`) VALUES
(2997, 28977, 282, 18, 2, 'on', '2019-03-08 22:57:51'),
(2997, 28977, 282, 18, 7, 'on', '2019-03-08 22:57:51'),
(2997, 28977, 282, 18, 3, 'Peanut Allergy', '2019-03-08 22:57:51'),
(2997, 28977, 282, 18, 4, 'Computer Programming', '2019-03-08 22:57:51'),
(2998, 28978, 282, 18, 2, 'on', '2019-03-09 15:23:46'),
(2998, 28978, 282, 18, 7, 'on', '2019-03-09 15:23:46');


/**********************/


CREATE TABLE IF NOT EXISTS `part_extended` (
  `partId` int(11) NOT NULL,
  `ssoId` varchar(255) DEFAULT NULL,
  `dose1date` date NOT NULL,
  `dose2date` date NOT NULL,
  `lastBoosterDate` date DEFAULT NULL,
  `vaccineManufacturer` varchar(30) NOT NULL,
  `vaccineCardUrl` varchar(255) NOT NULL,
  `vaccineStatus` enum('approved','reupload','denied','pending') NOT NULL DEFAULT 'pending',
  `vaccineComment` text,
  `egency1Name` varchar(50) DEFAULT NULL,
  `egency1Phone` varchar(15) DEFAULT NULL,
  `egency1Relation` varchar(10) DEFAULT NULL,
  `egency2Name` varchar(50) DEFAULT NULL,
  `egency2Phone` varchar(15) DEFAULT NULL,
  `egency2Relation` varchar(10) DEFAULT NULL,
  `SF_update` tinyint(1) NOT NULL DEFAULT '0',
  `lastUpd` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `part_extended`
--

INSERT INTO `part_extended` (`partId`, `ssoId`, `dose1date`, `dose2date`, `lastBoosterDate`, `vaccineManufacturer`, `vaccineCardUrl`, `vaccineStatus`, `vaccineComment`, `egency1Name`, `egency1Phone`, `egency1Relation`, `egency2Name`, `egency2Phone`, `egency2Relation`, `SF_update`, `lastUpd`) VALUES
(29082, '6kcbCVzrk5h0uwJ7FrU7LWLyoYi2', '2021-12-13', '2021-12-13', '0000-00-00', 'Other', '895277347367', 'approved', 'Approve from deined', NULL, NULL, NULL, NULL, NULL, NULL, 0, '2021-12-17 19:06:18'),
(29089, 'qPm5yuuxO2a0oXc4RFqAiAOUHrq1', '2021-12-05', '2021-12-07', '2021-12-12', 'Other', '895084579942', 'reupload', 'Test Approve', NULL, NULL, NULL, NULL, NULL, NULL, 0, '2021-12-18 21:27:04'),
(29448, '4b3ac83f81a44cfdb7c2c0dad2d29d8f', '2020-12-15', '2021-02-10', '2021-12-06', 'Moderna', '895310879361', 'approved', 'Only ILM ppt approve', NULL, NULL, NULL, NULL, NULL, NULL, 0, '2021-12-17 18:47:26'),
(29508, 'BU1vaOr3w2eXYhkUx1hn9DGClxH3', '2021-12-02', '2021-12-08', '2021-12-13', 'AstraZeneca', '895294957252', 'pending', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '2021-12-13 14:56:00');



ALTER TABLE `part_extended`
  ADD PRIMARY KEY (`partId`),
  ADD KEY `ssoId` (`ssoId`);
  
  
  
/**********************/


CREATE TABLE IF NOT EXISTS `volprogram` (
  `pgmVolId` int(11) NOT NULL,
  `partId` int(11) DEFAULT NULL,
  `pgmId` int(11) DEFAULT NULL,
  `pgmType` tinyint(4) DEFAULT NULL,
  `pgmAmt` int(11) DEFAULT NULL,
  `pgmCurr` varchar(3) DEFAULT NULL,
  `regDate` datetime DEFAULT NULL,
  `txnId` varchar(20) DEFAULT NULL,
  `corrId` varchar(20) DEFAULT NULL,
  `pmtStatus` tinyint(4) DEFAULT '1',
  `cStatus` char(1) DEFAULT 'A',
  `comment` text,
  `offline` varchar(100) DEFAULT NULL,
  `couponCode` varchar(25) DEFAULT NULL,
  `accomType` smallint(6) DEFAULT NULL,
  `shuttle1` varchar(32) DEFAULT NULL,
  `shuttle2` varchar(32) DEFAULT NULL,
  `shuttlePrice` int(11) DEFAULT NULL,
  `acommStDate` datetime DEFAULT NULL,
  `acommEnDate` datetime DEFAULT NULL,
  `acommPrice` int(11) DEFAULT NULL,
  `acommStTime` varchar(12) DEFAULT NULL,
  `acommEnTime` varchar(12) DEFAULT NULL,
  `age` tinyint(4) DEFAULT NULL,
  `teacherName` varchar(50) DEFAULT NULL,
  `teacherCity` varchar(50) DEFAULT NULL,
  `pgmMMYY` varchar(15) DEFAULT NULL,
  `volMMYY` varchar(15) DEFAULT NULL,
  `lastUpd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `SF_UPDATE` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=3025 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `volprogram`
--

INSERT INTO `volprogram` (`pgmVolId`, `partId`, `pgmId`, `pgmType`, `pgmAmt`, `pgmCurr`, `regDate`, `txnId`, `corrId`, `pmtStatus`, `cStatus`, `comment`, `offline`, `couponCode`, `accomType`, `shuttle1`, `shuttle2`, `shuttlePrice`, `acommStDate`, `acommEnDate`, `acommPrice`, `acommStTime`, `acommEnTime`, `age`, `teacherName`, `teacherCity`, `pgmMMYY`, `volMMYY`, `lastUpd`, `SF_UPDATE`) VALUES
(2997, 28977, 282, 18, 45, 'GBP', '2019-03-08 17:57:51', 'My Debug TXN ID ', 'My Debug Corr ID', 1, 'A', 'TPrice 45 ACost  SCost 0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, '', '', '', NULL, '2019-03-08 22:57:51', 0),
(2998, 28978, 282, 18, 45, 'GBP', '2019-03-09 10:23:46', 'My Debug TXN ID ', 'My Debug Corr ID', 1, 'A', 'TPrice 45 ACost  SCost 0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, '', '', '', NULL, '2019-03-09 15:23:46', 0),
(2999, 28979, 282, 18, 45, 'GBP', '2019-03-09 10:33:00', 'My Debug TXN ID ', 'My Debug Corr ID', 1, 'A', 'TPrice 45 ACost  SCost 0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, '', '', '', NULL, '2019-03-09 15:33:00', 0),
(3000, 28980, 282, 18, 45, 'GBP', '2019-03-09 14:47:32', 'My Debug TXN ID ', 'My Debug Corr ID', 1, 'A', 'TPrice 45 ACost  SCost 0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 33, '', '', '', NULL, '2019-03-09 19:47:32', 0);


ALTER TABLE `volprogram`  ADD PRIMARY KEY (`pgmVolId`);

ALTER TABLE `volprogram`  MODIFY `pgmVolId` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3025;
