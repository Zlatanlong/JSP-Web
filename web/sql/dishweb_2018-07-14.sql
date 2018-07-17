# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.22)
# Database: dishweb
# Generation Time: 2018-07-14 09:26:23 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table 2016_s1_colleges
# ------------------------------------------------------------

DROP TABLE IF EXISTS `2016_s1_colleges`;

CREATE TABLE `2016_s1_colleges` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `2016_s1_colleges` WRITE;
/*!40000 ALTER TABLE `2016_s1_colleges` DISABLE KEYS */;

INSERT INTO `2016_s1_colleges` (`id`, `name`)
VALUES
	(1,'中国石油大学（华东）');

/*!40000 ALTER TABLE `2016_s1_colleges` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table 2016_s1_dishes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `2016_s1_dishes`;

CREATE TABLE `2016_s1_dishes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `wname` varchar(20) DEFAULT NULL,
  `salty` float DEFAULT '3',
  `sweet` float DEFAULT '3',
  `sour` float DEFAULT '3',
  `hot` float DEFAULT '3',
  `price` float DEFAULT NULL,
  `imgurl` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dishes_windows_wname_fk` (`wname`),
  CONSTRAINT `dishes_windows_wname_fk` FOREIGN KEY (`wname`) REFERENCES `2016_s1_windows` (`wname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `2016_s1_dishes` WRITE;
/*!40000 ALTER TABLE `2016_s1_dishes` DISABLE KEYS */;

INSERT INTO `2016_s1_dishes` (`id`, `name`, `wname`, `salty`, `sweet`, `sour`, `hot`, `price`, `imgurl`)
VALUES
	(1,'土豆辣椒肉','唐岛湾1楼1号餐厅',3.0625,2.96875,2.875,2.65625,6.3,'001.jpg'),
	(2,'2号好吃的','唐岛湾1楼1号餐厅',3.625,2.5,2.875,4.125,3.3,'002.jpg'),
	(6,'新家5','唐岛湾1楼1号餐厅',3,3,3,3,2.6,'20180714170658.png'),
	(7,'124','唐岛湾1楼1号餐厅',3,3,3,3,12,'20180714171852.png');

/*!40000 ALTER TABLE `2016_s1_dishes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table 2016_s1_evaluate
# ------------------------------------------------------------

DROP TABLE IF EXISTS `2016_s1_evaluate`;

CREATE TABLE `2016_s1_evaluate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(20) NOT NULL DEFAULT '',
  `did` int(11) NOT NULL,
  `salty` int(11) DEFAULT '3',
  `sweet` int(11) DEFAULT '3',
  `sour` int(11) DEFAULT '3',
  `hot` int(11) DEFAULT '3',
  PRIMARY KEY (`id`),
  KEY `评价人` (`uname`),
  KEY `评价的菜` (`did`),
  CONSTRAINT `评价人` FOREIGN KEY (`uname`) REFERENCES `2016_s1_users` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `评价的菜` FOREIGN KEY (`did`) REFERENCES `2016_s1_dishes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `2016_s1_evaluate` WRITE;
/*!40000 ALTER TABLE `2016_s1_evaluate` DISABLE KEYS */;

INSERT INTO `2016_s1_evaluate` (`id`, `uname`, `did`, `salty`, `sweet`, `sour`, `hot`)
VALUES
	(13,'123',1,1,2,3,4),
	(14,'123',2,2,3,4,2),
	(17,'2',1,3,3,3,3),
	(19,'杜雪雪',2,4,3,2,4),
	(21,'杜雪雪',1,2,3,4,2),
	(24,'2',2,4,2,3,5),
	(25,'李昌隆',1,2,3,4,2),
	(26,'王勇策',1,4,3,2,3);

/*!40000 ALTER TABLE `2016_s1_evaluate` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table 2016_s1_praise
# ------------------------------------------------------------

DROP TABLE IF EXISTS `2016_s1_praise`;

CREATE TABLE `2016_s1_praise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `praise_users_id_fk` (`uid`),
  KEY `praise_ibfk_1` (`rid`),
  CONSTRAINT `2016_s1_praise_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `2016_s1_reply` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `praise_users_id_fk` FOREIGN KEY (`uid`) REFERENCES `2016_s1_users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `2016_s1_praise` WRITE;
/*!40000 ALTER TABLE `2016_s1_praise` DISABLE KEYS */;

INSERT INTO `2016_s1_praise` (`id`, `uid`, `rid`)
VALUES
	(1,2,4),
	(2,2,2),
	(3,2,1),
	(4,3,3),
	(6,6,1),
	(7,6,2),
	(8,6,4),
	(10,6,3),
	(12,6,7),
	(13,6,8),
	(14,6,9),
	(19,5,1),
	(20,6,14),
	(21,6,15),
	(22,3,8),
	(24,3,9),
	(25,2,14),
	(30,5,17),
	(32,2,17),
	(33,2,15),
	(34,1,1),
	(35,1,4),
	(36,24,18),
	(37,24,17),
	(38,24,15),
	(39,24,14),
	(40,24,4),
	(41,24,1);

/*!40000 ALTER TABLE `2016_s1_praise` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table 2016_s1_reply
# ------------------------------------------------------------

DROP TABLE IF EXISTS `2016_s1_reply`;

CREATE TABLE `2016_s1_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(20) DEFAULT '',
  `text` varchar(100) DEFAULT NULL,
  `dname` varchar(20) DEFAULT NULL,
  `did` int(11) DEFAULT NULL,
  `praise` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `回复者` (`uname`),
  KEY `reply_dishes_id_fk` (`did`),
  CONSTRAINT `reply_dishes_id_fk` FOREIGN KEY (`did`) REFERENCES `2016_s1_dishes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `回复者` FOREIGN KEY (`uname`) REFERENCES `2016_s1_users` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `2016_s1_reply` WRITE;
/*!40000 ALTER TABLE `2016_s1_reply` DISABLE KEYS */;

INSERT INTO `2016_s1_reply` (`id`, `uname`, `text`, `dname`, `did`, `praise`)
VALUES
	(1,'2','中文试试','土豆辣椒肉',1,8),
	(2,'2','顶楼上','土豆辣椒肉',1,3),
	(3,'123','这个没回复过','2号好吃的',2,2),
	(4,'123','2楼你说的不对','土豆辣椒肉',1,4),
	(7,'杜雪雪','我也想吃','2号好吃的',2,1),
	(8,'杜雪雪','我也想吃','2号好吃的',2,2),
	(9,'杜雪雪','新的评论顶楼上的！','2号好吃的',2,2),
	(14,'杜雪雪','土豆辣椒肉我喜欢啊！','土豆辣椒肉',1,3),
	(15,'杜雪雪','新的评论！','土豆辣椒肉',1,3),
	(17,'李昌隆','你们都吃了啊！','土豆辣椒肉',1,3),
	(18,'王勇策','我也来吃！','土豆辣椒肉',1,1);

/*!40000 ALTER TABLE `2016_s1_reply` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table 2016_s1_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `2016_s1_users`;

CREATE TABLE `2016_s1_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `password` varchar(16) DEFAULT NULL,
  `right` int(11) DEFAULT '1',
  `sex` enum('男','女') DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `collegeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name_uindex` (`name`),
  KEY `user_colleges_id_fk` (`collegeid`),
  CONSTRAINT `user_colleges_id_fk` FOREIGN KEY (`collegeid`) REFERENCES `2016_s1_colleges` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `2016_s1_users` WRITE;
/*!40000 ALTER TABLE `2016_s1_users` DISABLE KEYS */;

INSERT INTO `2016_s1_users` (`id`, `name`, `password`, `right`, `sex`, `age`, `collegeid`)
VALUES
	(1,'123','456',2,'男',20,1),
	(2,'2','123',2,NULL,NULL,NULL),
	(3,'刘艺璇','123',1,NULL,NULL,NULL),
	(4,'lcl','123',1,'男',20,1),
	(5,'李昌隆','123',1,'男',21,1),
	(6,'杜雪雪','123',1,'女',20,1),
	(7,'杜雪雪1','123',1,'男',20,1),
	(8,'杜雪雪12','',1,'男',20,1),
	(11,'杜雪雪512','123',1,'男',20,1),
	(12,'杜雪雪56789','123',1,'男',20,1),
	(13,'qwe123','123',1,'男',12,1),
	(14,'rt123','123',1,'男',1,1),
	(15,'杜雪雪ad','123',1,'男',20,1),
	(18,'杜雪雪iopp','123',1,'男',20,1),
	(22,'杜雪雪124','123',1,'男',20,1),
	(23,'杜雪雪tyh','123',1,'女',20,1),
	(24,'王勇策','123',1,'女',20,1),
	(25,'张铨','123',1,'男',20,1);

/*!40000 ALTER TABLE `2016_s1_users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table 2016_s1_windows
# ------------------------------------------------------------

DROP TABLE IF EXISTS `2016_s1_windows`;

CREATE TABLE `2016_s1_windows` (
  `wname` varchar(20) NOT NULL,
  `collegeid` int(11) DEFAULT NULL,
  PRIMARY KEY (`wname`),
  KEY `windows_colleges_id_fk` (`collegeid`),
  CONSTRAINT `windows_colleges_id_fk` FOREIGN KEY (`collegeid`) REFERENCES `2016_s1_colleges` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `2016_s1_windows` WRITE;
/*!40000 ALTER TABLE `2016_s1_windows` DISABLE KEYS */;

INSERT INTO `2016_s1_windows` (`wname`, `collegeid`)
VALUES
	('唐岛湾1楼1号餐厅',1),
	('玉兰3楼1号',1);

/*!40000 ALTER TABLE `2016_s1_windows` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
