/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.5.54-log : Database - scw
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`scw` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `scw`;

/*Table structure for table `t_admin` */

DROP TABLE IF EXISTS `t_admin`;

CREATE TABLE `t_admin` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `loginacct` varchar(255) NOT NULL,
  `userpswd` char(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `createtime` char(19) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ;

/*Data for the table `t_admin` */

insert  into `t_admin`(`id`,`loginacct`,`userpswd`,`username`,`email`,`createtime`) values (1,'superadmin','$2a$10$ME/1hXJK10sf0DuiIylyLe3EeuBq9bVtej.R84Qe64keW5iPQTpOS','超级管理员','admin@atguigu.com','2019-01-12 17:18:00'),(2,'zhangsan','$2a$10$ME/1hXJK10sf0DuiIylyLe3EeuBq9bVtej.R84Qe64keW5iPQTpOS','zhangsan','test@atguigu.com','2019-01-12 17:18:00');

/*Table structure for table `t_admin_role` */

DROP TABLE IF EXISTS `t_admin_role`;

CREATE TABLE `t_admin_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adminid` int(11) DEFAULT NULL,
  `roleid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_1` (`adminid`),
  KEY `FK_Reference_2` (`roleid`),
  CONSTRAINT `FK_Reference_1` FOREIGN KEY (`adminid`) REFERENCES `t_admin` (`id`),
  CONSTRAINT `FK_Reference_2` FOREIGN KEY (`roleid`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 ;

/*Data for the table `t_admin_role` */

insert  into `t_admin_role`(`id`,`adminid`,`roleid`) values (4,2,5),(7,2,8),(8,1,1),(9,1,2),(10,1,3),(11,1,4),(12,1,5),(13,1,6),(14,1,7),(15,1,8),(16,1,9);

/*Table structure for table `t_menu` */

DROP TABLE IF EXISTS `t_menu`;

CREATE TABLE `t_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 ;

/*Data for the table `t_menu` */

insert  into `t_menu`(`id`,`pid`,`name`,`icon`,`url`) values (1,0,'控制面板','glyphicon glyphicon-dashboard','main.html'),(2,0,'权限管理','glyphicon glyphicon glyphicon-tasks',NULL),(3,2,'用户维护','glyphicon glyphicon-user','admin/index'),(4,2,'角色维护','glyphicon glyphicon-king','role/index'),(5,2,'权限维护','glyphicon glyphicon-lock','permission/index'),(6,2,'菜单维护','glyphicon glyphicon-th-list','menu/index'),(7,0,'业务审核','glyphicon glyphicon-ok',NULL),(8,7,'实名认证审核','glyphicon glyphicon-check','auth_cert/index.html'),(9,7,'广告审核','glyphicon glyphicon-check','auth_adv/index.html'),(10,7,'项目审核','glyphicon glyphicon-check','auth_project/index.html'),(11,0,'业务管理','glyphicon glyphicon-th-large',NULL),(12,11,'资质维护','glyphicon glyphicon-picture','cert/index.html'),(13,11,'分类管理','glyphicon glyphicon-equalizer','certtype/index.html'),(14,11,'流程管理','glyphicon glyphicon-random','process/index.html'),(15,11,'广告管理','glyphicon glyphicon-hdd','advert/index.html'),(16,11,'消息模板','glyphicon glyphicon-comment','message/index.html'),(17,11,'项目分类','glyphicon glyphicon-list','projectType/index.html'),(18,11,'项目标签','glyphicon glyphicon-tags','tag/index.html'),(19,0,'参数管理','glyphicon glyphicon-list-alt','param/index.html');

/*Table structure for table `t_permission` */

DROP TABLE IF EXISTS `t_permission`;

CREATE TABLE `t_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT ,
  `name` varchar(255) DEFAULT NULL ,
  `title` varchar(255) DEFAULT NULL ,
  `icon` varchar(255) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL ,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 ;

/*Data for the table `t_permission` */

insert  into `t_permission`(`id`,`name`,`title`,`icon`,`pid`) values (1,'user','用户模块','glyphicon glyphicon-user',0),(2,'user:add','新增','glyphicon glyphicon-plus',1),(3,'user:delete','删除','glyphicon glyphicon-remove',1),(4,'user:update','更新','glyphicon glyphicon-pencil',1),(5,'user:get','查询','glyphicon glyphicon-zoom-in',1),(6,'user:assign:role','授予角色','glyphicon glyphicon-user',1),(7,'role','角色模块','glyphicon glyphicon-heart',0),(8,'role:add','新增','glyphicon glyphicon-plus',7),(9,'role:delete','删除','glyphicon glyphicon-remove',7),(10,'role:get','查询','glyphicon glyphicon-zoom-in',7),(11,'role:update','修改','glyphicon glyphicon-pencil',7),(12,'role:assign:permission','授予权限','glyphicon glyphicon-user',7),(13,'menu','菜单模块','glyphicon glyphicon-th-list',0),(14,'menu:add','新增','glyphicon glyphicon-plus',13),(15,'menu:delete','删除','glyphicon glyphicon-remove',13),(16,'menu:update','修改','glyphicon glyphicon-pencil',13),(17,'menu:get','查询','glyphicon glyphicon-zoom-in',13),(18,'menu:assign:permission','授予权限','glyphicon glyphicon-user',13);

/*Table structure for table `t_permission_menu` */

DROP TABLE IF EXISTS `t_permission_menu`;

CREATE TABLE `t_permission_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `menuid` int(11) DEFAULT NULL,
  `permissionid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_10` (`menuid`),
  KEY `FK_Reference_9` (`permissionid`),
  CONSTRAINT `FK_Reference_10` FOREIGN KEY (`menuid`) REFERENCES `t_menu` (`id`),
  CONSTRAINT `FK_Reference_9` FOREIGN KEY (`permissionid`) REFERENCES `t_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ;

/*Data for the table `t_permission_menu` */

insert  into `t_permission_menu`(`id`,`menuid`,`permissionid`) values (1,3,1),(2,3,2),(3,3,3);

/*Table structure for table `t_role` */

DROP TABLE IF EXISTS `t_role`;

CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 ;

/*Data for the table `t_role` */

insert  into `t_role`(`id`,`name`) values (1,'PM - 项目经理'),(2,'SE - 软件工程师'),(3,'PG - 程序员'),(4,'TL - 组长'),(5,'GL - 组长'),(6,'QA - 品质保证'),(7,'QC - 品质控制'),(8,'SA - 软件架构师'),(9,'CMO / CMS - 配置管理员');

/*Table structure for table `t_role_permission` */

DROP TABLE IF EXISTS `t_role_permission`;

CREATE TABLE `t_role_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleid` int(11) DEFAULT NULL,
  `permissionid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Reference_3` (`roleid`),
  KEY `FK_Reference_4` (`permissionid`),
  CONSTRAINT `FK_Reference_3` FOREIGN KEY (`roleid`) REFERENCES `t_role` (`id`),
  CONSTRAINT `FK_Reference_4` FOREIGN KEY (`permissionid`) REFERENCES `t_permission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ;

/*Data for the table `t_role_permission` */

insert  into `t_role_permission`(`id`,`roleid`,`permissionid`) values (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
