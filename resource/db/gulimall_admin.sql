/*
Navicat MySQL Data Transfer

Source Server         : 192.168.56.10_3306
Source Server Version : 50727
Source Host           : 192.168.56.10:3306
Source Database       : gulimall_admin

Target Server Type    : MYSQL
Target Server Version : 50727
File Encoding         : 65001

Date: 2020-03-11 17:35:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_CRON_TRIGGERS` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', '0 0/30 * * * ?', 'Etc/UTC');

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(200) DEFAULT NULL,
  `JOB_GROUP` varchar(200) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`),
  KEY `IDX_QRTZ_FT_TRIG_INST_NAME` (`SCHED_NAME`,`INSTANCE_NAME`),
  KEY `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`),
  KEY `IDX_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------
INSERT INTO `QRTZ_JOB_DETAILS` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', null, 'io.renren.modules.job.utils.ScheduleJob', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002E696F2E72656E72656E2E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016D7E5877707874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000174000672656E72656E74000CE58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------
INSERT INTO `QRTZ_LOCKS` VALUES ('RenrenScheduler', 'STATE_ACCESS');
INSERT INTO `QRTZ_LOCKS` VALUES ('RenrenScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------
INSERT INTO `QRTZ_SCHEDULER_STATE` VALUES ('RenrenScheduler', '398b46e373ca1583849178560', '1583857581231', '15000');

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `QRTZ_TRIGGERS` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `JOB_NAME` varchar(200) NOT NULL,
  `JOB_GROUP` varchar(200) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`),
  KEY `IDX_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`),
  KEY `IDX_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`),
  KEY `IDX_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`),
  KEY `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`),
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `QRTZ_JOB_DETAILS` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------
INSERT INTO `QRTZ_TRIGGERS` VALUES ('RenrenScheduler', 'TASK_1', 'DEFAULT', 'TASK_1', 'DEFAULT', null, '1583857800000', '1583856000000', '5', 'WAITING', 'CRON', '1569813024000', '0', null, '2', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000174000D4A4F425F504152414D5F4B45597372002E696F2E72656E72656E2E6D6F64756C65732E6A6F622E656E746974792E5363686564756C654A6F62456E7469747900000000000000010200074C00086265616E4E616D657400124C6A6176612F6C616E672F537472696E673B4C000A63726561746554696D657400104C6A6176612F7574696C2F446174653B4C000E63726F6E45787072657373696F6E71007E00094C00056A6F6249647400104C6A6176612F6C616E672F4C6F6E673B4C0006706172616D7371007E00094C000672656D61726B71007E00094C00067374617475737400134C6A6176612F6C616E672F496E74656765723B7870740008746573745461736B7372000E6A6176612E7574696C2E44617465686A81014B597419030000787077080000016D7E5877707874000E3020302F3330202A202A202A203F7372000E6A6176612E6C616E672E4C6F6E673B8BE490CC8F23DF0200014A000576616C7565787200106A6176612E6C616E672E4E756D62657286AC951D0B94E08B0200007870000000000000000174000672656E72656E74000CE58F82E695B0E6B58BE8AF95737200116A6176612E6C616E672E496E746567657212E2A0A4F781873802000149000576616C75657871007E0013000000007800);

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job` (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务';

-- ----------------------------
-- Records of schedule_job
-- ----------------------------
INSERT INTO `schedule_job` VALUES ('1', 'testTask', 'renren', '0 0/30 * * * ?', '0', '参数测试', '2019-09-30 02:46:30');

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log` (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint(20) NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) DEFAULT NULL COMMENT 'spring bean名称',
  `params` varchar(2000) DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) DEFAULT NULL COMMENT '失败信息',
  `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`),
  KEY `job_id` (`job_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1307 DEFAULT CHARSET=utf8mb4 COMMENT='定时任务日志';

-- ----------------------------
-- Records of schedule_job_log
-- ----------------------------
INSERT INTO `schedule_job_log` VALUES ('1', '1', 'testTask', 'renren', '0', null, '0', '2019-09-30 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('2', '1', 'testTask', 'renren', '0', null, '0', '2019-09-30 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('3', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('4', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('5', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('6', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('7', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('8', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('9', '1', 'testTask', 'renren', '0', null, '0', '2019-09-30 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('10', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('11', '1', 'testTask', 'renren', '0', null, '0', '2019-09-30 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('12', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('13', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('14', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('15', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('16', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('17', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('18', '1', 'testTask', 'renren', '0', null, '0', '2019-09-30 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('19', '1', 'testTask', 'renren', '0', null, '0', '2019-09-30 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('20', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('21', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('22', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('23', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('24', '1', 'testTask', 'renren', '0', null, '1', '2019-09-30 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('25', '1', 'testTask', 'renren', '0', null, '0', '2019-09-30 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('26', '1', 'testTask', 'renren', '0', null, '9', '2019-10-01 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('27', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('28', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 01:00:00');
INSERT INTO `schedule_job_log` VALUES ('29', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 01:30:00');
INSERT INTO `schedule_job_log` VALUES ('30', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 02:00:00');
INSERT INTO `schedule_job_log` VALUES ('31', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 02:30:00');
INSERT INTO `schedule_job_log` VALUES ('32', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 03:00:00');
INSERT INTO `schedule_job_log` VALUES ('33', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 03:30:00');
INSERT INTO `schedule_job_log` VALUES ('34', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 04:00:00');
INSERT INTO `schedule_job_log` VALUES ('35', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 04:30:00');
INSERT INTO `schedule_job_log` VALUES ('36', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 05:00:00');
INSERT INTO `schedule_job_log` VALUES ('37', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 05:30:00');
INSERT INTO `schedule_job_log` VALUES ('38', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 06:00:00');
INSERT INTO `schedule_job_log` VALUES ('39', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 06:30:00');
INSERT INTO `schedule_job_log` VALUES ('40', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 07:00:00');
INSERT INTO `schedule_job_log` VALUES ('41', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 07:30:00');
INSERT INTO `schedule_job_log` VALUES ('42', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 08:00:00');
INSERT INTO `schedule_job_log` VALUES ('43', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 08:30:00');
INSERT INTO `schedule_job_log` VALUES ('44', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('45', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('46', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('47', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('48', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('49', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('50', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('51', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('52', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('53', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('54', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('55', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('56', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('57', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('58', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('59', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('60', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('61', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('62', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('63', '1', 'testTask', 'renren', '0', null, '0', '2019-10-01 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('64', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('65', '1', 'testTask', 'renren', '0', null, '1', '2019-10-01 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('66', '1', 'testTask', 'renren', '0', null, '5', '2019-10-02 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('67', '1', 'testTask', 'renren', '0', null, '1', '2019-10-02 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('68', '1', 'testTask', 'renren', '0', null, '0', '2019-10-02 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('69', '1', 'testTask', 'renren', '0', null, '1', '2019-10-02 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('70', '1', 'testTask', 'renren', '0', null, '1', '2019-10-02 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('71', '1', 'testTask', 'renren', '0', null, '1', '2019-10-02 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('72', '1', 'testTask', 'renren', '0', null, '1', '2019-10-02 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('73', '1', 'testTask', 'renren', '0', null, '1', '2019-10-02 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('74', '1', 'testTask', 'renren', '0', null, '1', '2019-10-28 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('75', '1', 'testTask', 'renren', '0', null, '1', '2019-10-28 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('76', '1', 'testTask', 'renren', '0', null, '1', '2019-10-28 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('77', '1', 'testTask', 'renren', '0', null, '5', '2019-10-29 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('78', '1', 'testTask', 'renren', '0', null, '2', '2019-10-29 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('79', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 01:00:00');
INSERT INTO `schedule_job_log` VALUES ('80', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 01:30:00');
INSERT INTO `schedule_job_log` VALUES ('81', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 02:00:00');
INSERT INTO `schedule_job_log` VALUES ('82', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 02:30:00');
INSERT INTO `schedule_job_log` VALUES ('83', '1', 'testTask', 'renren', '0', null, '0', '2019-10-29 03:00:00');
INSERT INTO `schedule_job_log` VALUES ('84', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 03:30:00');
INSERT INTO `schedule_job_log` VALUES ('85', '1', 'testTask', 'renren', '0', null, '0', '2019-10-29 04:00:00');
INSERT INTO `schedule_job_log` VALUES ('86', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 04:30:00');
INSERT INTO `schedule_job_log` VALUES ('87', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 05:00:00');
INSERT INTO `schedule_job_log` VALUES ('88', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 05:30:00');
INSERT INTO `schedule_job_log` VALUES ('89', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 06:00:00');
INSERT INTO `schedule_job_log` VALUES ('90', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 06:30:00');
INSERT INTO `schedule_job_log` VALUES ('91', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 07:00:00');
INSERT INTO `schedule_job_log` VALUES ('92', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 07:30:00');
INSERT INTO `schedule_job_log` VALUES ('93', '1', 'testTask', 'renren', '0', null, '0', '2019-10-29 08:00:00');
INSERT INTO `schedule_job_log` VALUES ('94', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 08:30:00');
INSERT INTO `schedule_job_log` VALUES ('95', '1', 'testTask', 'renren', '0', null, '4', '2019-10-29 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('96', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('97', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('98', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('99', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('100', '1', 'testTask', 'renren', '0', null, '0', '2019-10-29 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('101', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('102', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('103', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('104', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('105', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('106', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('107', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('108', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('109', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('110', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('111', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('112', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('113', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('114', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('115', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('116', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('117', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('118', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('119', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 21:30:03');
INSERT INTO `schedule_job_log` VALUES ('120', '1', 'testTask', 'renren', '0', null, '0', '2019-10-29 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('121', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('122', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('123', '1', 'testTask', 'renren', '0', null, '1', '2019-10-29 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('124', '1', 'testTask', 'renren', '0', null, '14', '2019-10-30 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('125', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('126', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 01:00:00');
INSERT INTO `schedule_job_log` VALUES ('127', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 01:30:00');
INSERT INTO `schedule_job_log` VALUES ('128', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 02:00:00');
INSERT INTO `schedule_job_log` VALUES ('129', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 02:30:00');
INSERT INTO `schedule_job_log` VALUES ('130', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 03:00:00');
INSERT INTO `schedule_job_log` VALUES ('131', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 03:30:00');
INSERT INTO `schedule_job_log` VALUES ('132', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 04:00:00');
INSERT INTO `schedule_job_log` VALUES ('133', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 04:30:00');
INSERT INTO `schedule_job_log` VALUES ('134', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 05:00:00');
INSERT INTO `schedule_job_log` VALUES ('135', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 05:30:00');
INSERT INTO `schedule_job_log` VALUES ('136', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 06:00:00');
INSERT INTO `schedule_job_log` VALUES ('137', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 06:30:00');
INSERT INTO `schedule_job_log` VALUES ('138', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 07:00:00');
INSERT INTO `schedule_job_log` VALUES ('139', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 07:30:00');
INSERT INTO `schedule_job_log` VALUES ('140', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 08:00:00');
INSERT INTO `schedule_job_log` VALUES ('141', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 08:30:00');
INSERT INTO `schedule_job_log` VALUES ('142', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('143', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('144', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('145', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('146', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('147', '1', 'testTask', 'renren', '0', null, '2', '2019-10-30 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('148', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('149', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('150', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('151', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('152', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('153', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('154', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('155', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('156', '1', 'testTask', 'renren', '0', null, '2', '2019-10-30 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('157', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('158', '1', 'testTask', 'renren', '0', null, '6', '2019-10-30 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('159', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('160', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('161', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('162', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('163', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('164', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('165', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('166', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('167', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('168', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('169', '1', 'testTask', 'renren', '0', null, '1', '2019-10-30 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('170', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('171', '1', 'testTask', 'renren', '0', null, '0', '2019-10-30 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('172', '1', 'testTask', 'renren', '0', null, '5', '2019-10-31 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('173', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('174', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 01:00:00');
INSERT INTO `schedule_job_log` VALUES ('175', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 01:30:00');
INSERT INTO `schedule_job_log` VALUES ('176', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 02:00:00');
INSERT INTO `schedule_job_log` VALUES ('177', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 02:30:00');
INSERT INTO `schedule_job_log` VALUES ('178', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 03:00:00');
INSERT INTO `schedule_job_log` VALUES ('179', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 03:30:00');
INSERT INTO `schedule_job_log` VALUES ('180', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 04:00:00');
INSERT INTO `schedule_job_log` VALUES ('181', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 04:30:00');
INSERT INTO `schedule_job_log` VALUES ('182', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 05:00:00');
INSERT INTO `schedule_job_log` VALUES ('183', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 05:30:00');
INSERT INTO `schedule_job_log` VALUES ('184', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 06:00:00');
INSERT INTO `schedule_job_log` VALUES ('185', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 06:30:00');
INSERT INTO `schedule_job_log` VALUES ('186', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 07:00:00');
INSERT INTO `schedule_job_log` VALUES ('187', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 07:30:00');
INSERT INTO `schedule_job_log` VALUES ('188', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 08:00:00');
INSERT INTO `schedule_job_log` VALUES ('189', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 08:30:00');
INSERT INTO `schedule_job_log` VALUES ('190', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('191', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('192', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('193', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('194', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('195', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('196', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('197', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('198', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('199', '1', 'testTask', 'renren', '0', null, '2', '2019-10-31 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('200', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('201', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('202', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('203', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('204', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('205', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('206', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('207', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('208', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('209', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('210', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('211', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('212', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('213', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('214', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('215', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('216', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('217', '1', 'testTask', 'renren', '0', null, '0', '2019-10-31 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('218', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('219', '1', 'testTask', 'renren', '0', null, '1', '2019-10-31 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('220', '1', 'testTask', 'renren', '0', null, '6', '2019-11-01 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('221', '1', 'testTask', 'renren', '0', null, '2', '2019-11-01 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('222', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 01:00:00');
INSERT INTO `schedule_job_log` VALUES ('223', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 01:30:00');
INSERT INTO `schedule_job_log` VALUES ('224', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 02:00:00');
INSERT INTO `schedule_job_log` VALUES ('225', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 02:30:00');
INSERT INTO `schedule_job_log` VALUES ('226', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 03:00:00');
INSERT INTO `schedule_job_log` VALUES ('227', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 03:30:00');
INSERT INTO `schedule_job_log` VALUES ('228', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 04:00:00');
INSERT INTO `schedule_job_log` VALUES ('229', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 04:30:00');
INSERT INTO `schedule_job_log` VALUES ('230', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 05:00:00');
INSERT INTO `schedule_job_log` VALUES ('231', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 05:30:00');
INSERT INTO `schedule_job_log` VALUES ('232', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 06:00:00');
INSERT INTO `schedule_job_log` VALUES ('233', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 06:30:00');
INSERT INTO `schedule_job_log` VALUES ('234', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 07:00:00');
INSERT INTO `schedule_job_log` VALUES ('235', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 07:30:00');
INSERT INTO `schedule_job_log` VALUES ('236', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 08:00:00');
INSERT INTO `schedule_job_log` VALUES ('237', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 08:30:00');
INSERT INTO `schedule_job_log` VALUES ('238', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('239', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('240', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('241', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('242', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('243', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('244', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('245', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('246', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('247', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('248', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('249', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('250', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('251', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('252', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('253', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('254', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('255', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('256', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('257', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('258', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('259', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('260', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('261', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('262', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('263', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('264', '1', 'testTask', 'renren', '0', null, '0', '2019-11-01 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('265', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('266', '1', 'testTask', 'renren', '0', null, '1', '2019-11-01 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('267', '1', 'testTask', 'renren', '0', null, '12', '2019-11-02 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('268', '1', 'testTask', 'renren', '0', null, '4', '2019-11-02 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('269', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('270', '1', 'testTask', 'renren', '0', null, '0', '2019-11-02 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('271', '1', 'testTask', 'renren', '0', null, '0', '2019-11-02 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('272', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('273', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('274', '1', 'testTask', 'renren', '0', null, '0', '2019-11-02 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('275', '1', 'testTask', 'renren', '0', null, '0', '2019-11-02 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('276', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('277', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('278', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('279', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('280', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('281', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('282', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('283', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('284', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('285', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('286', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('287', '1', 'testTask', 'renren', '0', null, '1', '2019-11-02 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('288', '1', 'testTask', 'renren', '0', null, '0', '2019-11-02 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('289', '1', 'testTask', 'renren', '0', null, '0', '2019-11-02 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('290', '1', 'testTask', 'renren', '0', null, '0', '2019-11-04 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('291', '1', 'testTask', 'renren', '0', null, '0', '2019-11-04 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('292', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('293', '1', 'testTask', 'renren', '0', null, '0', '2019-11-04 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('294', '1', 'testTask', 'renren', '0', null, '0', '2019-11-04 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('295', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('296', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('297', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('298', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('299', '1', 'testTask', 'renren', '0', null, '0', '2019-11-04 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('300', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('301', '1', 'testTask', 'renren', '0', null, '0', '2019-11-04 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('302', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('303', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('304', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('305', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('306', '1', 'testTask', 'renren', '0', null, '0', '2019-11-04 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('307', '1', 'testTask', 'renren', '0', null, '0', '2019-11-04 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('308', '1', 'testTask', 'renren', '0', null, '0', '2019-11-04 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('309', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('310', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('311', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('312', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('313', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('314', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('315', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('316', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('317', '1', 'testTask', 'renren', '0', null, '1', '2019-11-04 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('318', '1', 'testTask', 'renren', '0', null, '7', '2019-11-05 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('319', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('320', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 01:00:00');
INSERT INTO `schedule_job_log` VALUES ('321', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 01:30:00');
INSERT INTO `schedule_job_log` VALUES ('322', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 02:00:00');
INSERT INTO `schedule_job_log` VALUES ('323', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 02:30:00');
INSERT INTO `schedule_job_log` VALUES ('324', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 03:00:00');
INSERT INTO `schedule_job_log` VALUES ('325', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 03:30:00');
INSERT INTO `schedule_job_log` VALUES ('326', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 04:00:00');
INSERT INTO `schedule_job_log` VALUES ('327', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 04:30:00');
INSERT INTO `schedule_job_log` VALUES ('328', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 05:00:00');
INSERT INTO `schedule_job_log` VALUES ('329', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 05:30:00');
INSERT INTO `schedule_job_log` VALUES ('330', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 06:00:00');
INSERT INTO `schedule_job_log` VALUES ('331', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 06:30:00');
INSERT INTO `schedule_job_log` VALUES ('332', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 07:00:00');
INSERT INTO `schedule_job_log` VALUES ('333', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 07:30:00');
INSERT INTO `schedule_job_log` VALUES ('334', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 08:00:00');
INSERT INTO `schedule_job_log` VALUES ('335', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 08:30:00');
INSERT INTO `schedule_job_log` VALUES ('336', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('337', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('338', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('339', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('340', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('341', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('342', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('343', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('344', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('345', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('346', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('347', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('348', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('349', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('350', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('351', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('352', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('353', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 17:30:02');
INSERT INTO `schedule_job_log` VALUES ('354', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('355', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('356', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('357', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('358', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('359', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('360', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('361', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('362', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('363', '1', 'testTask', 'renren', '0', null, '0', '2019-11-05 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('364', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('365', '1', 'testTask', 'renren', '0', null, '1', '2019-11-05 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('366', '1', 'testTask', 'renren', '0', null, '4', '2019-11-06 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('367', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('368', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 01:00:00');
INSERT INTO `schedule_job_log` VALUES ('369', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 01:30:00');
INSERT INTO `schedule_job_log` VALUES ('370', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 02:00:00');
INSERT INTO `schedule_job_log` VALUES ('371', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 02:30:00');
INSERT INTO `schedule_job_log` VALUES ('372', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 03:00:00');
INSERT INTO `schedule_job_log` VALUES ('373', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 03:30:00');
INSERT INTO `schedule_job_log` VALUES ('374', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 04:00:00');
INSERT INTO `schedule_job_log` VALUES ('375', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 04:30:00');
INSERT INTO `schedule_job_log` VALUES ('376', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 05:00:00');
INSERT INTO `schedule_job_log` VALUES ('377', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 05:30:00');
INSERT INTO `schedule_job_log` VALUES ('378', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 06:00:00');
INSERT INTO `schedule_job_log` VALUES ('379', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 06:30:00');
INSERT INTO `schedule_job_log` VALUES ('380', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 07:00:00');
INSERT INTO `schedule_job_log` VALUES ('381', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 07:30:00');
INSERT INTO `schedule_job_log` VALUES ('382', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 08:00:00');
INSERT INTO `schedule_job_log` VALUES ('383', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 08:30:00');
INSERT INTO `schedule_job_log` VALUES ('384', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('385', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('386', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('387', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('388', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('389', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('390', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('391', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('392', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('393', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('394', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('395', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('396', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('397', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('398', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('399', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('400', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('401', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('402', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('403', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('404', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('405', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('406', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('407', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('408', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('409', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('410', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('411', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('412', '1', 'testTask', 'renren', '0', null, '0', '2019-11-06 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('413', '1', 'testTask', 'renren', '0', null, '1', '2019-11-06 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('414', '1', 'testTask', 'renren', '0', null, '5', '2019-11-07 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('415', '1', 'testTask', 'renren', '0', null, '2', '2019-11-07 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('416', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 01:00:00');
INSERT INTO `schedule_job_log` VALUES ('417', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 01:30:00');
INSERT INTO `schedule_job_log` VALUES ('418', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 02:00:00');
INSERT INTO `schedule_job_log` VALUES ('419', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 02:30:00');
INSERT INTO `schedule_job_log` VALUES ('420', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 03:00:00');
INSERT INTO `schedule_job_log` VALUES ('421', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 03:30:00');
INSERT INTO `schedule_job_log` VALUES ('422', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 04:00:00');
INSERT INTO `schedule_job_log` VALUES ('423', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 04:30:00');
INSERT INTO `schedule_job_log` VALUES ('424', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 05:00:00');
INSERT INTO `schedule_job_log` VALUES ('425', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 05:30:00');
INSERT INTO `schedule_job_log` VALUES ('426', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 06:00:00');
INSERT INTO `schedule_job_log` VALUES ('427', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 06:30:00');
INSERT INTO `schedule_job_log` VALUES ('428', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 07:00:00');
INSERT INTO `schedule_job_log` VALUES ('429', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 07:30:00');
INSERT INTO `schedule_job_log` VALUES ('430', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 08:00:00');
INSERT INTO `schedule_job_log` VALUES ('431', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 08:30:00');
INSERT INTO `schedule_job_log` VALUES ('432', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('433', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('434', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('435', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('436', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('437', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('438', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('439', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('440', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('441', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('442', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('443', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('444', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('445', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('446', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('447', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('448', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('449', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('450', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('451', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('452', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('453', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('454', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('455', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('456', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('457', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('458', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('459', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('460', '1', 'testTask', 'renren', '0', null, '1', '2019-11-07 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('461', '1', 'testTask', 'renren', '0', null, '0', '2019-11-07 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('462', '1', 'testTask', 'renren', '0', null, '7', '2019-11-08 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('463', '1', 'testTask', 'renren', '0', null, '1', '2019-11-08 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('464', '1', 'testTask', 'renren', '0', null, '0', '2019-11-08 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('465', '1', 'testTask', 'renren', '0', null, '1', '2019-11-08 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('466', '1', 'testTask', 'renren', '0', null, '0', '2019-11-08 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('467', '1', 'testTask', 'renren', '0', null, '0', '2019-11-08 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('468', '1', 'testTask', 'renren', '0', null, '0', '2019-11-08 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('469', '1', 'testTask', 'renren', '0', null, '1', '2019-11-08 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('470', '1', 'testTask', 'renren', '0', null, '1', '2019-11-08 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('471', '1', 'testTask', 'renren', '0', null, '0', '2019-11-08 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('472', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('473', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('474', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('475', '1', 'testTask', 'renren', '0', null, '0', '2019-11-11 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('476', '1', 'testTask', 'renren', '0', null, '0', '2019-11-11 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('477', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('478', '1', 'testTask', 'renren', '0', null, '0', '2019-11-11 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('479', '1', 'testTask', 'renren', '0', null, '0', '2019-11-11 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('480', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('481', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('482', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('483', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('484', '1', 'testTask', 'renren', '0', null, '0', '2019-11-11 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('485', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('486', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('487', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('488', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('489', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('490', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('491', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('492', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('493', '1', 'testTask', 'renren', '0', null, '0', '2019-11-11 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('494', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('495', '1', 'testTask', 'renren', '0', null, '0', '2019-11-11 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('496', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('497', '1', 'testTask', 'renren', '0', null, '0', '2019-11-11 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('498', '1', 'testTask', 'renren', '0', null, '1', '2019-11-11 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('499', '1', 'testTask', 'renren', '0', null, '11', '2019-11-12 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('500', '1', 'testTask', 'renren', '0', null, '2', '2019-11-12 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('501', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('502', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('503', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('504', '1', 'testTask', 'renren', '0', null, '0', '2019-11-12 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('505', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('506', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('507', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('508', '1', 'testTask', 'renren', '0', null, '0', '2019-11-12 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('509', '1', 'testTask', 'renren', '0', null, '0', '2019-11-12 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('510', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('511', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('512', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('513', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('514', '1', 'testTask', 'renren', '0', null, '0', '2019-11-12 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('515', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('516', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('517', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('518', '1', 'testTask', 'renren', '0', null, '0', '2019-11-12 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('519', '1', 'testTask', 'renren', '0', null, '0', '2019-11-12 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('520', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('521', '1', 'testTask', 'renren', '0', null, '0', '2019-11-12 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('522', '1', 'testTask', 'renren', '0', null, '0', '2019-11-12 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('523', '1', 'testTask', 'renren', '0', null, '0', '2019-11-12 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('524', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('525', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('526', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('527', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('528', '1', 'testTask', 'renren', '0', null, '1', '2019-11-12 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('529', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('530', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('531', '1', 'testTask', 'renren', '0', null, '0', '2019-11-13 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('532', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('533', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('534', '1', 'testTask', 'renren', '0', null, '0', '2019-11-13 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('535', '1', 'testTask', 'renren', '0', null, '4', '2019-11-13 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('536', '1', 'testTask', 'renren', '0', null, '0', '2019-11-13 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('537', '1', 'testTask', 'renren', '0', null, '3', '2019-11-13 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('538', '1', 'testTask', 'renren', '0', null, '0', '2019-11-13 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('539', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('540', '1', 'testTask', 'renren', '0', null, '0', '2019-11-13 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('541', '1', 'testTask', 'renren', '0', null, '0', '2019-11-13 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('542', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('543', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('544', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('545', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('546', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('547', '1', 'testTask', 'renren', '0', null, '0', '2019-11-13 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('548', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('549', '1', 'testTask', 'renren', '0', null, '0', '2019-11-13 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('550', '1', 'testTask', 'renren', '0', null, '3', '2019-11-13 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('551', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('552', '1', 'testTask', 'renren', '0', null, '0', '2019-11-13 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('553', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('554', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('555', '1', 'testTask', 'renren', '0', null, '0', '2019-11-13 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('556', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('557', '1', 'testTask', 'renren', '0', null, '1', '2019-11-13 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('558', '1', 'testTask', 'renren', '0', null, '10', '2019-11-14 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('559', '1', 'testTask', 'renren', '0', null, '0', '2019-11-14 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('560', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('561', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('562', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('563', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('564', '1', 'testTask', 'renren', '0', null, '0', '2019-11-14 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('565', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('566', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('567', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('568', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('569', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('570', '1', 'testTask', 'renren', '0', null, '0', '2019-11-14 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('571', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('572', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('573', '1', 'testTask', 'renren', '0', null, '0', '2019-11-14 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('574', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('575', '1', 'testTask', 'renren', '0', null, '0', '2019-11-14 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('576', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('577', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('578', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('579', '1', 'testTask', 'renren', '0', null, '0', '2019-11-14 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('580', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('581', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('582', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('583', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('584', '1', 'testTask', 'renren', '0', null, '1', '2019-11-14 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('585', '1', 'testTask', 'renren', '0', null, '15', '2019-11-15 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('586', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 01:00:00');
INSERT INTO `schedule_job_log` VALUES ('587', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 01:30:00');
INSERT INTO `schedule_job_log` VALUES ('588', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 02:00:00');
INSERT INTO `schedule_job_log` VALUES ('589', '1', 'testTask', 'renren', '0', null, '0', '2019-11-15 02:30:00');
INSERT INTO `schedule_job_log` VALUES ('590', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 03:00:00');
INSERT INTO `schedule_job_log` VALUES ('591', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 03:30:00');
INSERT INTO `schedule_job_log` VALUES ('592', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 04:00:00');
INSERT INTO `schedule_job_log` VALUES ('593', '1', 'testTask', 'renren', '0', null, '0', '2019-11-15 04:30:00');
INSERT INTO `schedule_job_log` VALUES ('594', '1', 'testTask', 'renren', '0', null, '0', '2019-11-15 05:00:00');
INSERT INTO `schedule_job_log` VALUES ('595', '1', 'testTask', 'renren', '0', null, '0', '2019-11-15 05:30:00');
INSERT INTO `schedule_job_log` VALUES ('596', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 06:00:00');
INSERT INTO `schedule_job_log` VALUES ('597', '1', 'testTask', 'renren', '0', null, '0', '2019-11-15 06:30:00');
INSERT INTO `schedule_job_log` VALUES ('598', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 07:00:00');
INSERT INTO `schedule_job_log` VALUES ('599', '1', 'testTask', 'renren', '0', null, '0', '2019-11-15 07:30:00');
INSERT INTO `schedule_job_log` VALUES ('600', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 08:00:00');
INSERT INTO `schedule_job_log` VALUES ('601', '1', 'testTask', 'renren', '0', null, '0', '2019-11-15 08:30:00');
INSERT INTO `schedule_job_log` VALUES ('602', '1', 'testTask', 'renren', '0', null, '0', '2019-11-15 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('603', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('604', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('605', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('606', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('607', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('608', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('609', '1', 'testTask', 'renren', '0', null, '4', '2019-11-15 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('610', '1', 'testTask', 'renren', '0', null, '0', '2019-11-15 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('611', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('612', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('613', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('614', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('615', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('616', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('617', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('618', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('619', '1', 'testTask', 'renren', '0', null, '0', '2019-11-15 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('620', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('621', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('622', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('623', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('624', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('625', '1', 'testTask', 'renren', '0', null, '1', '2019-11-15 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('626', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('627', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('628', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('629', '1', 'testTask', 'renren', '0', null, '0', '2019-11-16 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('630', '1', 'testTask', 'renren', '0', null, '0', '2019-11-16 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('631', '1', 'testTask', 'renren', '0', null, '2', '2019-11-16 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('632', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('633', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('634', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('635', '1', 'testTask', 'renren', '0', null, '2', '2019-11-16 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('636', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('637', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('638', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('639', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('640', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('641', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('642', '1', 'testTask', 'renren', '0', null, '0', '2019-11-16 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('643', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('644', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('645', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('646', '1', 'testTask', 'renren', '0', null, '0', '2019-11-16 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('647', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('648', '1', 'testTask', 'renren', '0', null, '0', '2019-11-16 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('649', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('650', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('651', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('652', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('653', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('654', '1', 'testTask', 'renren', '0', null, '1', '2019-11-16 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('655', '1', 'testTask', 'renren', '0', null, '4', '2019-11-17 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('656', '1', 'testTask', 'renren', '0', null, '0', '2019-11-17 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('657', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('658', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('659', '1', 'testTask', 'renren', '0', null, '0', '2019-11-17 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('660', '1', 'testTask', 'renren', '0', null, '0', '2019-11-17 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('661', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('662', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('663', '1', 'testTask', 'renren', '0', null, '0', '2019-11-17 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('664', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('665', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('666', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('667', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('668', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('669', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('670', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('671', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('672', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('673', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('674', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('675', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('676', '1', 'testTask', 'renren', '0', null, '1', '2019-11-17 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('677', '1', 'testTask', 'renren', '0', null, '0', '2019-11-17 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('678', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('679', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('680', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('681', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('682', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('683', '1', 'testTask', 'renren', '0', null, '0', '2019-11-18 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('684', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('685', '1', 'testTask', 'renren', '0', null, '0', '2019-11-18 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('686', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('687', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('688', '1', 'testTask', 'renren', '0', null, '0', '2019-11-18 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('689', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('690', '1', 'testTask', 'renren', '0', null, '0', '2019-11-18 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('691', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('692', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('693', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('694', '1', 'testTask', 'renren', '0', null, '2', '2019-11-18 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('695', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('696', '1', 'testTask', 'renren', '0', null, '0', '2019-11-18 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('697', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('698', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('699', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('700', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('701', '1', 'testTask', 'renren', '0', null, '0', '2019-11-18 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('702', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('703', '1', 'testTask', 'renren', '0', null, '1', '2019-11-18 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('704', '1', 'testTask', 'renren', '0', null, '0', '2019-11-18 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('705', '1', 'testTask', 'renren', '0', null, '0', '2019-11-18 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('706', '1', 'testTask', 'renren', '0', null, '14', '2019-11-19 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('707', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('708', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('709', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('710', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('711', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('712', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('713', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('714', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('715', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('716', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('717', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('718', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('719', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('720', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('721', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('722', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('723', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('724', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('725', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('726', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('727', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('728', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('729', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('730', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('731', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('732', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('733', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('734', '1', 'testTask', 'renren', '0', null, '1', '2019-11-19 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('735', '1', 'testTask', 'renren', '0', null, '0', '2019-11-19 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('736', '1', 'testTask', 'renren', '0', null, '4', '2019-11-20 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('737', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('738', '1', 'testTask', 'renren', '0', null, '0', '2019-11-20 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('739', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('740', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('741', '1', 'testTask', 'renren', '0', null, '0', '2019-11-20 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('742', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('743', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('744', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('745', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('746', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('747', '1', 'testTask', 'renren', '0', null, '0', '2019-11-20 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('748', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('749', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('750', '1', 'testTask', 'renren', '0', null, '0', '2019-11-20 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('751', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('752', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('753', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('754', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('755', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('756', '1', 'testTask', 'renren', '0', null, '0', '2019-11-20 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('757', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('758', '1', 'testTask', 'renren', '0', null, '0', '2019-11-20 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('759', '1', 'testTask', 'renren', '0', null, '0', '2019-11-20 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('760', '1', 'testTask', 'renren', '0', null, '0', '2019-11-20 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('761', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('762', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('763', '1', 'testTask', 'renren', '0', null, '1', '2019-11-20 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('764', '1', 'testTask', 'renren', '0', null, '0', '2019-11-20 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('765', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('766', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('767', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('768', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('769', '1', 'testTask', 'renren', '0', null, '0', '2019-11-21 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('770', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('771', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('772', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('773', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('774', '1', 'testTask', 'renren', '0', null, '0', '2019-11-21 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('775', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('776', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('777', '1', 'testTask', 'renren', '0', null, '0', '2019-11-21 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('778', '1', 'testTask', 'renren', '0', null, '0', '2019-11-21 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('779', '1', 'testTask', 'renren', '0', null, '0', '2019-11-21 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('780', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('781', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('782', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('783', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('784', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('785', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('786', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('787', '1', 'testTask', 'renren', '0', null, '0', '2019-11-21 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('788', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('789', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('790', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('791', '1', 'testTask', 'renren', '0', null, '1', '2019-11-21 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('792', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('793', '1', 'testTask', 'renren', '0', null, '0', '2019-11-22 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('794', '1', 'testTask', 'renren', '0', null, '0', '2019-11-22 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('795', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('796', '1', 'testTask', 'renren', '0', null, '0', '2019-11-22 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('797', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('798', '1', 'testTask', 'renren', '0', null, '0', '2019-11-22 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('799', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('800', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('801', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('802', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('803', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('804', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('805', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('806', '1', 'testTask', 'renren', '0', null, '4', '2019-11-22 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('807', '1', 'testTask', 'renren', '0', null, '9', '2019-11-22 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('808', '1', 'testTask', 'renren', '0', null, '2', '2019-11-22 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('809', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('810', '1', 'testTask', 'renren', '0', null, '2', '2019-11-22 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('811', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('812', '1', 'testTask', 'renren', '0', null, '1', '2019-11-22 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('813', '1', 'testTask', 'renren', '0', null, '2', '2019-11-22 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('814', '1', 'testTask', 'renren', '0', null, '2', '2019-11-22 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('815', '1', 'testTask', 'renren', '0', null, '2', '2019-11-22 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('816', '1', 'testTask', 'renren', '0', null, '29', '2019-11-23 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('817', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('818', '1', 'testTask', 'renren', '0', null, '0', '2019-11-24 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('819', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('820', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('821', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('822', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('823', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('824', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('825', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('826', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('827', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('828', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('829', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('830', '1', 'testTask', 'renren', '0', null, '1', '2019-11-24 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('831', '1', 'testTask', 'renren', '0', null, '2', '2019-11-25 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('832', '1', 'testTask', 'renren', '0', null, '0', '2019-11-25 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('833', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('834', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('835', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('836', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('837', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('838', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('839', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('840', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('841', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('842', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('843', '1', 'testTask', 'renren', '0', null, '4', '2019-11-25 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('844', '1', 'testTask', 'renren', '0', null, '2', '2019-11-25 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('845', '1', 'testTask', 'renren', '0', null, '2', '2019-11-25 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('846', '1', 'testTask', 'renren', '0', null, '2', '2019-11-25 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('847', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('848', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('849', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('850', '1', 'testTask', 'renren', '0', null, '2', '2019-11-25 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('851', '1', 'testTask', 'renren', '0', null, '1', '2019-11-25 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('852', '1', 'testTask', 'renren', '0', null, '2', '2019-11-25 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('853', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('854', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('855', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('856', '1', 'testTask', 'renren', '0', null, '6', '2019-11-26 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('857', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('858', '1', 'testTask', 'renren', '0', null, '0', '2019-11-26 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('859', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('860', '1', 'testTask', 'renren', '0', null, '0', '2019-11-26 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('861', '1', 'testTask', 'renren', '0', null, '0', '2019-11-26 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('862', '1', 'testTask', 'renren', '0', null, '0', '2019-11-26 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('863', '1', 'testTask', 'renren', '0', null, '0', '2019-11-26 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('864', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('865', '1', 'testTask', 'renren', '0', null, '5', '2019-11-26 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('866', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('867', '1', 'testTask', 'renren', '0', null, '4', '2019-11-26 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('868', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('869', '1', 'testTask', 'renren', '0', null, '0', '2019-11-26 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('870', '1', 'testTask', 'renren', '0', null, '2', '2019-11-26 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('871', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('872', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('873', '1', 'testTask', 'renren', '0', null, '0', '2019-11-26 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('874', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('875', '1', 'testTask', 'renren', '0', null, '1', '2019-11-26 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('876', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('877', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('878', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('879', '1', 'testTask', 'renren', '0', null, '4', '2019-11-27 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('880', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('881', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('882', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('883', '1', 'testTask', 'renren', '0', null, '2', '2019-11-27 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('884', '1', 'testTask', 'renren', '0', null, '0', '2019-11-27 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('885', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('886', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('887', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('888', '1', 'testTask', 'renren', '0', null, '2', '2019-11-27 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('889', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('890', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('891', '1', 'testTask', 'renren', '0', null, '0', '2019-11-27 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('892', '1', 'testTask', 'renren', '0', null, '0', '2019-11-27 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('893', '1', 'testTask', 'renren', '0', null, '0', '2019-11-27 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('894', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('895', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('896', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('897', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('898', '1', 'testTask', 'renren', '0', null, '1', '2019-11-27 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('899', '1', 'testTask', 'renren', '0', null, '37', '2019-11-27 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('900', '1', 'testTask', 'renren', '0', null, '508', '2019-11-28 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('901', '1', 'testTask', 'renren', '0', null, '20', '2019-11-28 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('902', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('903', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('904', '1', 'testTask', 'renren', '0', null, '2', '2019-11-28 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('905', '1', 'testTask', 'renren', '0', null, '0', '2019-11-28 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('906', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('907', '1', 'testTask', 'renren', '0', null, '0', '2019-11-28 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('908', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('909', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('910', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('911', '1', 'testTask', 'renren', '0', null, '0', '2019-11-28 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('912', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('913', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('914', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('915', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('916', '1', 'testTask', 'renren', '0', null, '0', '2019-11-28 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('917', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('918', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('919', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('920', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('921', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('922', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('923', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('924', '1', 'testTask', 'renren', '0', null, '0', '2019-11-28 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('925', '1', 'testTask', 'renren', '0', null, '0', '2019-11-28 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('926', '1', 'testTask', 'renren', '0', null, '1', '2019-11-28 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('927', '1', 'testTask', 'renren', '0', null, '0', '2019-11-28 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('928', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('929', '1', 'testTask', 'renren', '0', null, '0', '2019-11-29 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('930', '1', 'testTask', 'renren', '0', null, '0', '2019-11-29 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('931', '1', 'testTask', 'renren', '0', null, '0', '2019-11-29 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('932', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('933', '1', 'testTask', 'renren', '0', null, '0', '2019-11-29 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('934', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('935', '1', 'testTask', 'renren', '0', null, '0', '2019-11-29 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('936', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('937', '1', 'testTask', 'renren', '0', null, '0', '2019-11-29 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('938', '1', 'testTask', 'renren', '0', null, '0', '2019-11-29 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('939', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('940', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('941', '1', 'testTask', 'renren', '0', null, '0', '2019-11-29 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('942', '1', 'testTask', 'renren', '0', null, '3', '2019-11-29 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('943', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('944', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('945', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('946', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('947', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('948', '1', 'testTask', 'renren', '0', null, '1', '2019-11-29 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('949', '1', 'testTask', 'renren', '0', null, '0', '2019-11-29 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('950', '1', 'testTask', 'renren', '0', null, '1', '2019-11-30 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('951', '1', 'testTask', 'renren', '0', null, '1', '2019-11-30 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('952', '1', 'testTask', 'renren', '0', null, '1', '2019-11-30 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('953', '1', 'testTask', 'renren', '0', null, '1', '2019-11-30 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('954', '1', 'testTask', 'renren', '0', null, '1', '2019-11-30 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('955', '1', 'testTask', 'renren', '0', null, '1', '2019-11-30 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('956', '1', 'testTask', 'renren', '0', null, '0', '2019-11-30 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('957', '1', 'testTask', 'renren', '0', null, '1', '2019-11-30 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('958', '1', 'testTask', 'renren', '0', null, '1', '2019-11-30 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('959', '1', 'testTask', 'renren', '0', null, '3', '2019-12-01 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('960', '1', 'testTask', 'renren', '0', null, '1', '2019-12-01 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('961', '1', 'testTask', 'renren', '0', null, '2', '2019-12-01 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('962', '1', 'testTask', 'renren', '0', null, '1', '2019-12-01 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('963', '1', 'testTask', 'renren', '0', null, '1', '2019-12-01 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('964', '1', 'testTask', 'renren', '0', null, '0', '2019-12-01 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('965', '1', 'testTask', 'renren', '0', null, '1', '2019-12-01 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('966', '1', 'testTask', 'renren', '0', null, '1', '2019-12-01 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('967', '1', 'testTask', 'renren', '0', null, '1', '2019-12-01 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('968', '1', 'testTask', 'renren', '0', null, '1', '2019-12-01 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('969', '1', 'testTask', 'renren', '0', null, '0', '2019-12-01 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('970', '1', 'testTask', 'renren', '0', null, '7', '2019-12-02 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('971', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('972', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 01:00:00');
INSERT INTO `schedule_job_log` VALUES ('973', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 01:30:00');
INSERT INTO `schedule_job_log` VALUES ('974', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 02:00:00');
INSERT INTO `schedule_job_log` VALUES ('975', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 02:30:00');
INSERT INTO `schedule_job_log` VALUES ('976', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 03:00:00');
INSERT INTO `schedule_job_log` VALUES ('977', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 03:30:00');
INSERT INTO `schedule_job_log` VALUES ('978', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 04:00:00');
INSERT INTO `schedule_job_log` VALUES ('979', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 04:30:00');
INSERT INTO `schedule_job_log` VALUES ('980', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 05:00:00');
INSERT INTO `schedule_job_log` VALUES ('981', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 05:30:00');
INSERT INTO `schedule_job_log` VALUES ('982', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 06:00:00');
INSERT INTO `schedule_job_log` VALUES ('983', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 06:30:00');
INSERT INTO `schedule_job_log` VALUES ('984', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 07:00:00');
INSERT INTO `schedule_job_log` VALUES ('985', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 07:30:00');
INSERT INTO `schedule_job_log` VALUES ('986', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 08:00:00');
INSERT INTO `schedule_job_log` VALUES ('987', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 08:30:00');
INSERT INTO `schedule_job_log` VALUES ('988', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 09:00:00');
INSERT INTO `schedule_job_log` VALUES ('989', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('990', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('991', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('992', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('993', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('994', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('995', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('996', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('997', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('998', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('999', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1000', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1001', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1002', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1003', '1', 'testTask', 'renren', '0', null, '1', '2019-12-02 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1004', '1', 'testTask', 'renren', '0', null, '2', '2019-12-02 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1005', '1', 'testTask', 'renren', '0', null, '0', '2019-12-02 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1006', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1007', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1008', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1009', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1010', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1011', '1', 'testTask', 'renren', '0', null, '0', '2019-12-11 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1012', '1', 'testTask', 'renren', '0', null, '0', '2019-12-11 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1013', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1014', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1015', '1', 'testTask', 'renren', '0', null, '0', '2019-12-11 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1016', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('1017', '1', 'testTask', 'renren', '0', null, '0', '2019-12-11 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('1018', '1', 'testTask', 'renren', '0', null, '0', '2019-12-11 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('1019', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('1020', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('1021', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('1022', '1', 'testTask', 'renren', '0', null, '1', '2019-12-11 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('1023', '1', 'testTask', 'renren', '0', null, '1', '2019-12-12 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1024', '1', 'testTask', 'renren', '0', null, '0', '2019-12-13 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('1025', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('1026', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1027', '1', 'testTask', 'renren', '0', null, '0', '2019-12-13 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1028', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('1029', '1', 'testTask', 'renren', '0', null, '2', '2019-12-13 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1030', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1031', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1032', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1033', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1034', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1035', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1036', '1', 'testTask', 'renren', '0', null, '0', '2019-12-13 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1037', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1038', '1', 'testTask', 'renren', '0', null, '0', '2019-12-13 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1039', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('1040', '1', 'testTask', 'renren', '0', null, '2', '2019-12-13 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('1041', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('1042', '1', 'testTask', 'renren', '0', null, '0', '2019-12-13 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('1043', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('1044', '1', 'testTask', 'renren', '0', null, '1', '2019-12-13 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('1045', '1', 'testTask', 'renren', '0', null, '1', '2019-12-15 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('1046', '1', 'testTask', 'renren', '0', null, '5', '2019-12-16 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('1047', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 00:30:00');
INSERT INTO `schedule_job_log` VALUES ('1048', '1', 'testTask', 'renren', '0', null, '0', '2019-12-16 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('1049', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('1050', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('1051', '1', 'testTask', 'renren', '0', null, '0', '2019-12-16 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('1052', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('1053', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1054', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1055', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('1056', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1057', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1058', '1', 'testTask', 'renren', '0', null, '0', '2019-12-16 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1059', '1', 'testTask', 'renren', '0', null, '0', '2019-12-16 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1060', '1', 'testTask', 'renren', '0', null, '3', '2019-12-16 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1061', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1062', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1063', '1', 'testTask', 'renren', '0', null, '1', '2019-12-16 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1064', '1', 'testTask', 'renren', '0', null, '1', '2019-12-18 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('1065', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('1066', '1', 'testTask', 'renren', '0', null, '0', '2019-12-19 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('1067', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('1068', '1', 'testTask', 'renren', '0', null, '2', '2019-12-19 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('1069', '1', 'testTask', 'renren', '0', null, '0', '2019-12-19 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1070', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1071', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('1072', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1073', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1074', '1', 'testTask', 'renren', '0', null, '0', '2019-12-19 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1075', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1076', '1', 'testTask', 'renren', '0', null, '0', '2019-12-19 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1077', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1078', '1', 'testTask', 'renren', '0', null, '0', '2019-12-19 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1079', '1', 'testTask', 'renren', '0', null, '2', '2019-12-19 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1080', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1081', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1082', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('1083', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('1084', '1', 'testTask', 'renren', '0', null, '2', '2019-12-19 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('1085', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('1086', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('1087', '1', 'testTask', 'renren', '0', null, '2', '2019-12-19 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('1088', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('1089', '1', 'testTask', 'renren', '0', null, '3', '2019-12-19 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('1090', '1', 'testTask', 'renren', '0', null, '0', '2019-12-19 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('1091', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('1092', '1', 'testTask', 'renren', '0', null, '1', '2019-12-19 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('1093', '1', 'testTask', 'renren', '0', null, '14', '2019-12-20 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('1094', '1', 'testTask', 'renren', '0', null, '1', '2019-12-20 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('1095', '1', 'testTask', 'renren', '0', null, '1', '2019-12-20 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('1096', '1', 'testTask', 'renren', '0', null, '1', '2019-12-20 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1097', '1', 'testTask', 'renren', '0', null, '1', '2019-12-20 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1098', '1', 'testTask', 'renren', '0', null, '0', '2019-12-20 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('1099', '1', 'testTask', 'renren', '0', null, '0', '2019-12-20 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1100', '1', 'testTask', 'renren', '0', null, '1', '2019-12-20 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1101', '1', 'testTask', 'renren', '0', null, '1', '2019-12-20 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1102', '1', 'testTask', 'renren', '0', null, '1', '2019-12-20 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1103', '1', 'testTask', 'renren', '0', null, '0', '2020-01-09 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1104', '1', 'testTask', 'renren', '0', null, '1', '2020-01-09 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1105', '1', 'testTask', 'renren', '0', null, '1', '2020-01-09 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1106', '1', 'testTask', 'renren', '0', null, '1', '2020-01-09 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1107', '1', 'testTask', 'renren', '0', null, '2', '2020-01-09 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1108', '1', 'testTask', 'renren', '0', null, '1', '2020-01-09 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1109', '1', 'testTask', 'renren', '0', null, '0', '2020-01-09 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1110', '1', 'testTask', 'renren', '0', null, '1', '2020-01-09 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('1111', '1', 'testTask', 'renren', '0', null, '1', '2020-01-09 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('1112', '1', 'testTask', 'renren', '0', null, '0', '2020-01-09 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('1113', '1', 'testTask', 'renren', '0', null, '1', '2020-01-09 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('1114', '1', 'testTask', 'renren', '0', null, '1', '2020-01-09 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('1115', '1', 'testTask', 'renren', '0', null, '2', '2020-01-09 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('1116', '1', 'testTask', 'renren', '0', null, '1', '2020-01-09 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('1117', '1', 'testTask', 'renren', '0', null, '1', '2020-01-09 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('1118', '1', 'testTask', 'renren', '0', null, '2', '2020-01-09 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('1119', '1', 'testTask', 'renren', '0', null, '2', '2020-01-09 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('1120', '1', 'testTask', 'renren', '0', null, '1', '2020-01-09 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('1121', '1', 'testTask', 'renren', '0', null, '14', '2020-01-10 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('1122', '1', 'testTask', 'renren', '0', null, '1', '2020-01-27 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1123', '1', 'testTask', 'renren', '0', null, '1', '2020-01-27 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1124', '1', 'testTask', 'renren', '0', null, '1', '2020-01-27 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('1125', '1', 'testTask', 'renren', '0', null, '1', '2020-01-27 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1126', '1', 'testTask', 'renren', '0', null, '1', '2020-01-27 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1127', '1', 'testTask', 'renren', '0', null, '1', '2020-01-27 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1128', '1', 'testTask', 'renren', '0', null, '0', '2020-01-27 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1129', '1', 'testTask', 'renren', '0', null, '2', '2020-01-28 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('1130', '1', 'testTask', 'renren', '0', null, '1', '2020-01-28 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1131', '1', 'testTask', 'renren', '0', null, '1', '2020-01-28 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1132', '1', 'testTask', 'renren', '0', null, '1', '2020-01-28 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('1133', '1', 'testTask', 'renren', '0', null, '0', '2020-01-28 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1134', '1', 'testTask', 'renren', '0', null, '10', '2020-01-28 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1135', '1', 'testTask', 'renren', '0', null, '1', '2020-01-28 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1136', '1', 'testTask', 'renren', '0', null, '1', '2020-01-28 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1137', '1', 'testTask', 'renren', '0', null, '1', '2020-01-28 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1138', '1', 'testTask', 'renren', '0', null, '1', '2020-01-28 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1139', '1', 'testTask', 'renren', '0', null, '1', '2020-01-28 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1140', '1', 'testTask', 'renren', '0', null, '0', '2020-01-28 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1141', '1', 'testTask', 'renren', '0', null, '0', '2020-01-28 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1142', '1', 'testTask', 'renren', '0', null, '1', '2020-01-28 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1143', '1', 'testTask', 'renren', '0', null, '1', '2020-01-28 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('1144', '1', 'testTask', 'renren', '0', null, '1', '2020-01-28 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('1145', '1', 'testTask', 'renren', '0', null, '0', '2020-01-28 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('1146', '1', 'testTask', 'renren', '0', null, '0', '2020-01-28 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('1147', '1', 'testTask', 'renren', '0', null, '1', '2020-01-29 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('1148', '1', 'testTask', 'renren', '0', null, '1', '2020-01-29 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1149', '1', 'testTask', 'renren', '0', null, '12', '2020-01-29 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('1150', '1', 'testTask', 'renren', '0', null, '1', '2020-01-29 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1151', '1', 'testTask', 'renren', '0', null, '1', '2020-01-29 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1152', '1', 'testTask', 'renren', '0', null, '1', '2020-01-29 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1153', '1', 'testTask', 'renren', '0', null, '1', '2020-01-29 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1154', '1', 'testTask', 'renren', '0', null, '1', '2020-01-29 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1155', '1', 'testTask', 'renren', '0', null, '0', '2020-01-29 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1156', '1', 'testTask', 'renren', '0', null, '1', '2020-01-29 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1157', '1', 'testTask', 'renren', '0', null, '0', '2020-01-29 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1158', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('1159', '1', 'testTask', 'renren', '0', null, '2', '2020-01-30 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('1160', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1161', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1162', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('1163', '1', 'testTask', 'renren', '0', null, '3', '2020-01-30 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1164', '1', 'testTask', 'renren', '0', null, '2', '2020-01-30 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1165', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1166', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1167', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1168', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1169', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1170', '1', 'testTask', 'renren', '0', null, '0', '2020-01-30 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1171', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1172', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1173', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('1174', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('1175', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('1176', '1', 'testTask', 'renren', '0', null, '0', '2020-01-30 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('1177', '1', 'testTask', 'renren', '0', null, '1', '2020-01-30 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('1178', '1', 'testTask', 'renren', '0', null, '3', '2020-02-01 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('1179', '1', 'testTask', 'renren', '0', null, '1', '2020-02-01 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('1180', '1', 'testTask', 'renren', '0', null, '1', '2020-02-01 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('1181', '1', 'testTask', 'renren', '0', null, '1', '2020-02-01 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1182', '1', 'testTask', 'renren', '0', null, '1', '2020-02-01 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1183', '1', 'testTask', 'renren', '0', null, '0', '2020-02-18 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1184', '1', 'testTask', 'renren', '0', null, '1', '2020-02-18 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1185', '1', 'testTask', 'renren', '0', null, '10', '2020-02-18 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1186', '1', 'testTask', 'renren', '0', null, '0', '2020-02-18 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1187', '1', 'testTask', 'renren', '0', null, '1', '2020-02-18 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('1188', '1', 'testTask', 'renren', '0', null, '1', '2020-02-18 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('1189', '1', 'testTask', 'renren', '0', null, '1', '2020-02-18 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('1190', '1', 'testTask', 'renren', '0', null, '1', '2020-02-18 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('1191', '1', 'testTask', 'renren', '0', null, '0', '2020-02-18 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('1192', '1', 'testTask', 'renren', '0', null, '1', '2020-02-18 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('1193', '1', 'testTask', 'renren', '0', null, '1', '2020-02-18 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('1194', '1', 'testTask', 'renren', '0', null, '1', '2020-02-18 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('1195', '1', 'testTask', 'renren', '0', null, '1', '2020-02-18 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('1196', '1', 'testTask', 'renren', '0', null, '1', '2020-02-18 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('1197', '1', 'testTask', 'renren', '0', null, '1', '2020-02-18 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('1198', '1', 'testTask', 'renren', '0', null, '1', '2020-02-19 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1199', '1', 'testTask', 'renren', '0', null, '1', '2020-02-19 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1200', '1', 'testTask', 'renren', '0', null, '1', '2020-02-19 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1201', '1', 'testTask', 'renren', '0', null, '1', '2020-02-19 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1202', '1', 'testTask', 'renren', '0', null, '1', '2020-02-19 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1203', '1', 'testTask', 'renren', '0', null, '1', '2020-02-19 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1204', '1', 'testTask', 'renren', '0', null, '1', '2020-02-19 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('1205', '1', 'testTask', 'renren', '0', null, '1', '2020-02-19 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('1206', '1', 'testTask', 'renren', '0', null, '0', '2020-02-19 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('1207', '1', 'testTask', 'renren', '0', null, '1', '2020-02-19 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('1208', '1', 'testTask', 'renren', '0', null, '0', '2020-02-19 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('1209', '1', 'testTask', 'renren', '0', null, '1', '2020-02-20 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1210', '1', 'testTask', 'renren', '0', null, '1', '2020-02-20 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('1211', '1', 'testTask', 'renren', '0', null, '1', '2020-02-20 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1212', '1', 'testTask', 'renren', '0', null, '1', '2020-02-20 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1213', '1', 'testTask', 'renren', '0', null, '1', '2020-02-20 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1214', '1', 'testTask', 'renren', '0', null, '0', '2020-02-20 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1215', '1', 'testTask', 'renren', '0', null, '0', '2020-02-20 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1216', '1', 'testTask', 'renren', '0', null, '1', '2020-02-20 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1217', '1', 'testTask', 'renren', '0', null, '1', '2020-02-20 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1218', '1', 'testTask', 'renren', '0', null, '1', '2020-02-20 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1219', '1', 'testTask', 'renren', '0', null, '1', '2020-02-20 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1220', '1', 'testTask', 'renren', '0', null, '2', '2020-02-20 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('1221', '1', 'testTask', 'renren', '0', null, '1', '2020-02-21 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('1222', '1', 'testTask', 'renren', '0', null, '1', '2020-02-21 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('1223', '1', 'testTask', 'renren', '0', null, '1', '2020-02-21 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1224', '1', 'testTask', 'renren', '0', null, '0', '2020-02-21 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1225', '1', 'testTask', 'renren', '0', null, '1', '2020-02-22 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('1226', '1', 'testTask', 'renren', '0', null, '0', '2020-02-22 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1227', '1', 'testTask', 'renren', '0', null, '0', '2020-02-22 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1228', '1', 'testTask', 'renren', '0', null, '1', '2020-02-22 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('1229', '1', 'testTask', 'renren', '0', null, '1', '2020-02-22 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1230', '1', 'testTask', 'renren', '0', null, '3', '2020-02-22 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1231', '1', 'testTask', 'renren', '0', null, '2', '2020-02-22 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1232', '1', 'testTask', 'renren', '0', null, '1', '2020-02-22 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1233', '1', 'testTask', 'renren', '0', null, '1', '2020-02-22 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1234', '1', 'testTask', 'renren', '0', null, '0', '2020-02-22 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1235', '1', 'testTask', 'renren', '0', null, '4', '2020-02-22 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1236', '1', 'testTask', 'renren', '0', null, '0', '2020-02-22 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1237', '1', 'testTask', 'renren', '0', null, '1', '2020-02-22 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1238', '1', 'testTask', 'renren', '0', null, '1', '2020-02-24 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1239', '1', 'testTask', 'renren', '0', null, '1', '2020-02-24 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1240', '1', 'testTask', 'renren', '0', null, '0', '2020-02-24 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1241', '1', 'testTask', 'renren', '0', null, '0', '2020-02-24 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1242', '1', 'testTask', 'renren', '0', null, '0', '2020-02-24 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1243', '1', 'testTask', 'renren', '0', null, '1', '2020-02-24 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('1244', '1', 'testTask', 'renren', '0', null, '1', '2020-02-24 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('1245', '1', 'testTask', 'renren', '0', null, '1', '2020-02-24 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('1246', '1', 'testTask', 'renren', '0', null, '3', '2020-02-24 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('1247', '1', 'testTask', 'renren', '0', null, '1', '2020-02-24 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('1248', '1', 'testTask', 'renren', '0', null, '1', '2020-02-24 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('1249', '1', 'testTask', 'renren', '0', null, '0', '2020-02-24 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('1250', '1', 'testTask', 'renren', '0', null, '1', '2020-02-24 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('1251', '1', 'testTask', 'renren', '0', null, '1', '2020-02-24 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('1252', '1', 'testTask', 'renren', '0', null, '1', '2020-02-24 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('1253', '1', 'testTask', 'renren', '0', null, '1', '2020-02-24 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('1254', '1', 'testTask', 'renren', '0', null, '10', '2020-02-25 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('1255', '1', 'testTask', 'renren', '0', null, '0', '2020-02-25 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1256', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 12:30:00');
INSERT INTO `schedule_job_log` VALUES ('1257', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 13:00:00');
INSERT INTO `schedule_job_log` VALUES ('1258', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 13:30:00');
INSERT INTO `schedule_job_log` VALUES ('1259', '1', 'testTask', 'renren', '0', null, '0', '2020-02-25 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1260', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1261', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1262', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1263', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1264', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1265', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1266', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1267', '1', 'testTask', 'renren', '0', null, '2', '2020-02-25 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1268', '1', 'testTask', 'renren', '0', null, '3', '2020-02-25 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('1269', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('1270', '1', 'testTask', 'renren', '0', null, '2', '2020-02-25 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('1271', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('1272', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('1273', '1', 'testTask', 'renren', '0', null, '1', '2020-02-25 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('1274', '1', 'testTask', 'renren', '0', null, '2', '2020-02-25 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('1275', '1', 'testTask', 'renren', '0', null, '3', '2020-02-25 22:00:00');
INSERT INTO `schedule_job_log` VALUES ('1276', '1', 'testTask', 'renren', '0', null, '1', '2020-03-04 09:30:00');
INSERT INTO `schedule_job_log` VALUES ('1277', '1', 'testTask', 'renren', '0', null, '1', '2020-03-04 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('1278', '1', 'testTask', 'renren', '0', null, '2', '2020-03-04 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('1279', '1', 'testTask', 'renren', '0', null, '1', '2020-03-04 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('1280', '1', 'testTask', 'renren', '0', null, '9', '2020-03-05 00:00:00');
INSERT INTO `schedule_job_log` VALUES ('1281', '1', 'testTask', 'renren', '0', null, '2', '2020-03-05 10:00:00');
INSERT INTO `schedule_job_log` VALUES ('1282', '1', 'testTask', 'renren', '0', null, '2', '2020-03-05 10:30:00');
INSERT INTO `schedule_job_log` VALUES ('1283', '1', 'testTask', 'renren', '0', null, '1', '2020-03-05 11:00:00');
INSERT INTO `schedule_job_log` VALUES ('1284', '1', 'testTask', 'renren', '0', null, '1', '2020-03-05 11:30:00');
INSERT INTO `schedule_job_log` VALUES ('1285', '1', 'testTask', 'renren', '0', null, '3', '2020-03-05 12:00:00');
INSERT INTO `schedule_job_log` VALUES ('1286', '1', 'testTask', 'renren', '0', null, '1', '2020-03-05 14:00:00');
INSERT INTO `schedule_job_log` VALUES ('1287', '1', 'testTask', 'renren', '0', null, '1', '2020-03-05 14:30:00');
INSERT INTO `schedule_job_log` VALUES ('1288', '1', 'testTask', 'renren', '0', null, '0', '2020-03-05 15:00:00');
INSERT INTO `schedule_job_log` VALUES ('1289', '1', 'testTask', 'renren', '0', null, '0', '2020-03-05 15:30:00');
INSERT INTO `schedule_job_log` VALUES ('1290', '1', 'testTask', 'renren', '0', null, '0', '2020-03-05 16:00:00');
INSERT INTO `schedule_job_log` VALUES ('1291', '1', 'testTask', 'renren', '0', null, '1', '2020-03-05 16:30:00');
INSERT INTO `schedule_job_log` VALUES ('1292', '1', 'testTask', 'renren', '0', null, '1', '2020-03-05 17:00:00');
INSERT INTO `schedule_job_log` VALUES ('1293', '1', 'testTask', 'renren', '0', null, '1', '2020-03-05 17:30:00');
INSERT INTO `schedule_job_log` VALUES ('1294', '1', 'testTask', 'renren', '0', null, '1', '2020-03-05 18:00:00');
INSERT INTO `schedule_job_log` VALUES ('1295', '1', 'testTask', 'renren', '0', null, '4', '2020-03-05 18:30:00');
INSERT INTO `schedule_job_log` VALUES ('1296', '1', 'testTask', 'renren', '0', null, '1', '2020-03-05 19:00:00');
INSERT INTO `schedule_job_log` VALUES ('1297', '1', 'testTask', 'renren', '0', null, '4', '2020-03-05 19:30:00');
INSERT INTO `schedule_job_log` VALUES ('1298', '1', 'testTask', 'renren', '0', null, '3', '2020-03-05 20:00:00');
INSERT INTO `schedule_job_log` VALUES ('1299', '1', 'testTask', 'renren', '0', null, '1', '2020-03-05 20:30:00');
INSERT INTO `schedule_job_log` VALUES ('1300', '1', 'testTask', 'renren', '0', null, '2', '2020-03-05 21:00:00');
INSERT INTO `schedule_job_log` VALUES ('1301', '1', 'testTask', 'renren', '0', null, '1', '2020-03-05 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('1302', '1', 'testTask', 'renren', '0', null, '1', '2020-03-07 21:30:00');
INSERT INTO `schedule_job_log` VALUES ('1303', '1', 'testTask', 'renren', '0', null, '10', '2020-03-10 22:30:00');
INSERT INTO `schedule_job_log` VALUES ('1304', '1', 'testTask', 'renren', '0', null, '0', '2020-03-10 23:00:00');
INSERT INTO `schedule_job_log` VALUES ('1305', '1', 'testTask', 'renren', '0', null, '1', '2020-03-10 23:30:00');
INSERT INTO `schedule_job_log` VALUES ('1306', '1', 'testTask', 'renren', '0', null, '0', '2020-03-11 00:00:00');

-- ----------------------------
-- Table structure for sys_captcha
-- ----------------------------
DROP TABLE IF EXISTS `sys_captcha`;
CREATE TABLE `sys_captcha` (
  `uuid` char(36) NOT NULL COMMENT 'uuid',
  `code` varchar(6) NOT NULL COMMENT '验证码',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统验证码';

-- ----------------------------
-- Records of sys_captcha
-- ----------------------------
INSERT INTO `sys_captcha` VALUES ('05c69d0b-1ba0-41f0-8944-475ab4274986', 'fmb86', '2020-03-07 20:47:16');
INSERT INTO `sys_captcha` VALUES ('071ccd85-732c-4812-8e9d-7c29faf8a01f', 'f8ge3', '2019-09-30 11:38:08');
INSERT INTO `sys_captcha` VALUES ('08fa63a8-9d73-4d4e-8717-b5b89795ede5', 'b2cwy', '2020-03-07 20:51:57');
INSERT INTO `sys_captcha` VALUES ('123eeb2b-9032-4154-87fc-ffcaadf552b6', '7e33g', '2019-12-19 09:57:22');
INSERT INTO `sys_captcha` VALUES ('144b1d72-d40b-480e-8533-eca4c69888c8', 'dfene', '2020-03-07 20:52:14');
INSERT INTO `sys_captcha` VALUES ('180c1579-0cdc-4caf-8c1a-0a741680cc0b', '355nd', '2019-10-29 11:30:28');
INSERT INTO `sys_captcha` VALUES ('20bfa304-b049-4850-8873-91bec5406416', '787nn', '2019-10-29 10:23:53');
INSERT INTO `sys_captcha` VALUES ('22439312-a5d8-4af4-84bf-03c54022c453', 'dpnpb', '2019-10-29 11:30:26');
INSERT INTO `sys_captcha` VALUES ('27a9ab10-263c-4018-8e8a-b29910250f67', '4y32y', '2019-09-30 11:38:00');
INSERT INTO `sys_captcha` VALUES ('2800b4e3-2911-4a56-8841-91e1c786162e', 'nan5c', '2020-02-22 11:45:23');
INSERT INTO `sys_captcha` VALUES ('2c4ad84d-73b0-4ad3-83d2-238f40657a49', 'dmyp6', '2019-09-30 11:38:13');
INSERT INTO `sys_captcha` VALUES ('38bf7980-41dc-478c-8bec-51476ee55d8b', 'fnda8', '2019-10-28 23:33:57');
INSERT INTO `sys_captcha` VALUES ('40520a5f-5516-4b35-83e7-897901d0819c', 'cw2mf', '2019-10-29 10:22:31');
INSERT INTO `sys_captcha` VALUES ('45c192b3-bb8d-4fe0-8903-1b5e0e2876ed', 'w53ym', '2019-10-29 10:18:19');
INSERT INTO `sys_captcha` VALUES ('4fffb991-9d5c-4af3-8033-bbdb70c69976', 'app6d', '2020-03-04 09:19:01');
INSERT INTO `sys_captcha` VALUES ('57c3a23b-3931-4cec-89fe-695c03d661e0', '865y4', '2020-02-21 15:39:45');
INSERT INTO `sys_captcha` VALUES ('5a0ea466-40b1-426f-8c95-406c372efafd', 'm2gpx', '2019-10-29 12:10:55');
INSERT INTO `sys_captcha` VALUES ('6097823b-7a6d-4b9a-8aff-2f32f1202ea0', '4adp3', '2019-10-29 10:23:57');
INSERT INTO `sys_captcha` VALUES ('63314ba2-a03b-4118-82e7-da54f00213d9', 'b567x', '2019-10-29 10:46:24');
INSERT INTO `sys_captcha` VALUES ('678118fa-1a9a-4bc4-8cab-d568070542e9', '3ey5a', '2019-10-28 23:16:36');
INSERT INTO `sys_captcha` VALUES ('6f664f22-22cb-4ede-8799-4b8cebfaa258', 'bp5mg', '2019-10-28 23:18:39');
INSERT INTO `sys_captcha` VALUES ('6f82a9f4-221b-4486-848e-3a83f00252c7', 'pamw5', '2020-02-22 11:45:20');
INSERT INTO `sys_captcha` VALUES ('7123ebc0-3ec3-4c73-8461-f8a240ab9858', '72f5y', '2019-10-29 10:56:10');
INSERT INTO `sys_captcha` VALUES ('72846ba8-afff-4f74-891e-de56255c5d37', 'a42an', '2019-10-29 10:22:35');
INSERT INTO `sys_captcha` VALUES ('733e465e-ff41-4d8d-85a0-7265b34b711e', '8pbeg', '2020-03-07 20:51:43');
INSERT INTO `sys_captcha` VALUES ('7a611a55-b45f-43c4-8632-60d78055ddd8', 'n8fcg', '2019-10-28 23:26:12');
INSERT INTO `sys_captcha` VALUES ('8a8482fa-0bab-4d8d-83f2-00050f58ddf3', '6c22w', '2019-10-29 10:21:59');
INSERT INTO `sys_captcha` VALUES ('8abf953f-bb4e-4a25-8515-468e58ee6554', 'pnp3n', '2020-02-22 12:01:29');
INSERT INTO `sys_captcha` VALUES ('8fcff20f-d518-43e1-84a8-6f859cd76d3c', 'wxx2n', '2020-03-07 21:27:14');
INSERT INTO `sys_captcha` VALUES ('96c9d01e-7cf9-4ecb-8817-a5c6030c5c8f', 'nxb4m', '2019-10-28 23:22:26');
INSERT INTO `sys_captcha` VALUES ('a40f0707-8853-4944-8895-15276df7f4a1', 'mmdan', '2020-03-07 20:51:28');
INSERT INTO `sys_captcha` VALUES ('a6dd10cb-3db3-4ac0-8d72-7c1244681631', 'cx6a2', '2019-10-28 23:12:59');
INSERT INTO `sys_captcha` VALUES ('a801ecf8-1602-47e0-8a07-436b0136cc89', 'yygyx', '2020-03-07 20:45:43');
INSERT INTO `sys_captcha` VALUES ('a94444c3-6cb0-4662-8ca6-47e7bb3c99c6', 'w72aa', '2019-10-28 23:11:06');
INSERT INTO `sys_captcha` VALUES ('aad10794-43b6-4546-849d-d401848dd972', 'pnmmg', '2019-09-30 11:38:14');
INSERT INTO `sys_captcha` VALUES ('af32a584-dfea-433d-8275-633d19a85b7e', 'ebf65', '2020-03-07 20:53:10');
INSERT INTO `sys_captcha` VALUES ('bc7e0494-4f9e-4262-8b1d-e87580ae8834', 'e5cnp', '2020-02-21 15:39:23');
INSERT INTO `sys_captcha` VALUES ('c624ad95-1349-495b-85aa-41a7b11fc9ba', 'fg62b', '2019-10-28 21:37:30');
INSERT INTO `sys_captcha` VALUES ('c868dc0a-d6b9-45aa-8081-771ab87807ea', 'm3na3', '2020-03-07 20:43:03');
INSERT INTO `sys_captcha` VALUES ('cd46d32b-172c-48d9-8db2-861246571e2f', '6wxcf', '2019-10-29 10:21:55');
INSERT INTO `sys_captcha` VALUES ('d155122f-d753-4bca-8977-f38ce6cecdb2', 'edgp7', '2019-10-29 10:22:24');
INSERT INTO `sys_captcha` VALUES ('d7a93a64-a420-40be-8b8e-c449b53d8862', 'ddnew', '2019-10-29 10:52:53');
INSERT INTO `sys_captcha` VALUES ('df31e84c-420d-44a2-8093-ce53c801235c', 'cpd5n', '2019-10-29 10:19:32');
INSERT INTO `sys_captcha` VALUES ('e410a7c2-3409-4fde-8217-d824035d0f1b', 'cn2bg', '2019-10-29 12:10:55');
INSERT INTO `sys_captcha` VALUES ('eb756ff9-5300-4969-885b-4248e58e43c9', 'eecxf', '2020-03-07 20:51:32');
INSERT INTO `sys_captcha` VALUES ('edcb5be1-97da-4b7d-8fd5-9861f4e2653d', 'nfad5', '2019-10-28 23:15:07');
INSERT INTO `sys_captcha` VALUES ('f6992138-55ce-4d90-8876-a9fd99287f88', 'd8xpp', '2019-11-04 21:52:50');
INSERT INTO `sys_captcha` VALUES ('fcdc0016-ac09-4a4b-8c4c-376c1ca8c801', 'mw85n', '2019-10-29 11:30:26');
INSERT INTO `sys_captcha` VALUES ('fee96fac-a4b8-46ab-89bb-93d3673163e8', '2b4nd', '2020-02-21 21:46:43');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `param_key` varchar(50) DEFAULT NULL COMMENT 'key',
  `param_value` varchar(2000) DEFAULT NULL COMMENT 'value',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态   0：隐藏   1：显示',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `param_key` (`param_key`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='系统配置信息表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES ('1', 'CLOUD_STORAGE_CONFIG_KEY', '{\"aliyunAccessKeyId\":\"\",\"aliyunAccessKeySecret\":\"\",\"aliyunBucketName\":\"\",\"aliyunDomain\":\"\",\"aliyunEndPoint\":\"\",\"aliyunPrefix\":\"\",\"qcloudBucketName\":\"\",\"qcloudDomain\":\"\",\"qcloudPrefix\":\"\",\"qcloudSecretId\":\"\",\"qcloudSecretKey\":\"\",\"qiniuAccessKey\":\"NrgMfABZxWLo5B-YYSjoE8-AZ1EISdi1Z3ubLOeZ\",\"qiniuBucketName\":\"ios-app\",\"qiniuDomain\":\"http://7xqbwh.dl1.z0.glb.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuSecretKey\":\"uIwJHevMRWU0VLxFvgy0tAcOdGqasdtVlJkdy6vV\",\"type\":1}', '0', '云存储配置信息');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COMMENT='系统日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":31,\"parentId\":0,\"name\":\"商品系统\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"editor\",\"orderNum\":0}]', '9', '0:0:0:0:0:0:0:1', '2019-10-28 21:34:21');
INSERT INTO `sys_log` VALUES ('2', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":32,\"parentId\":31,\"name\":\"分类维护\",\"url\":\"product/category\",\"perms\":\"\",\"type\":1,\"icon\":\"menu\",\"orderNum\":0}]', '8', '0:0:0:0:0:0:0:1', '2019-10-28 21:35:21');
INSERT INTO `sys_log` VALUES ('3', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":33,\"parentId\":31,\"name\":\"品牌管理\",\"url\":\"product/brand\",\"perms\":\"\",\"type\":1,\"icon\":\"editor\",\"orderNum\":0}]', '17', '0:0:0:0:0:0:0:1', '2019-11-06 10:19:56');
INSERT INTO `sys_log` VALUES ('4', 'admin', '删除菜单', 'io.renren.modules.sys.controller.SysMenuController.delete()', '[33]', '322', '0:0:0:0:0:0:0:1', '2019-11-06 10:40:06');
INSERT INTO `sys_log` VALUES ('5', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":34,\"parentId\":31,\"name\":\"品牌管理\",\"url\":\"product/brand\",\"perms\":\"\",\"type\":1,\"icon\":\"editor\",\"orderNum\":0}]', '8', '0:0:0:0:0:0:0:1', '2019-11-06 10:52:28');
INSERT INTO `sys_log` VALUES ('6', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":35,\"parentId\":31,\"name\":\"属性维护\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"system\",\"orderNum\":0}]', '11', '0:0:0:0:0:0:0:1', '2019-11-13 11:59:27');
INSERT INTO `sys_log` VALUES ('7', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":36,\"parentId\":35,\"name\":\"基本属性\",\"url\":\"product/baseatr\",\"perms\":\"\",\"type\":1,\"icon\":\"\",\"orderNum\":0}]', '8', '0:0:0:0:0:0:0:1', '2019-11-13 11:59:56');
INSERT INTO `sys_log` VALUES ('8', 'admin', '删除菜单', 'io.renren.modules.sys.controller.SysMenuController.delete()', '[35]', '4', '0:0:0:0:0:0:0:1', '2019-11-13 12:08:23');
INSERT INTO `sys_log` VALUES ('9', 'admin', '删除菜单', 'io.renren.modules.sys.controller.SysMenuController.delete()', '[36]', '311', '0:0:0:0:0:0:0:1', '2019-11-13 12:08:28');
INSERT INTO `sys_log` VALUES ('10', 'admin', '删除菜单', 'io.renren.modules.sys.controller.SysMenuController.delete()', '[35]', '11', '0:0:0:0:0:0:0:1', '2019-11-13 12:08:34');
INSERT INTO `sys_log` VALUES ('11', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":37,\"parentId\":31,\"name\":\"平台属性\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"system\",\"orderNum\":0}]', '11', '0:0:0:0:0:0:0:1', '2019-11-13 20:05:22');
INSERT INTO `sys_log` VALUES ('12', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":38,\"parentId\":37,\"name\":\"属性分组\",\"url\":\"product/attrgroup\",\"perms\":\"\",\"type\":1,\"icon\":\"tubiao\",\"orderNum\":0}]', '7', '0:0:0:0:0:0:0:1', '2019-11-13 20:06:12');
INSERT INTO `sys_log` VALUES ('13', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":39,\"parentId\":37,\"name\":\"规格参数\",\"url\":\"product/baseattr\",\"perms\":\"\",\"type\":1,\"icon\":\"log\",\"orderNum\":0}]', '6', '0:0:0:0:0:0:0:1', '2019-11-13 20:07:29');
INSERT INTO `sys_log` VALUES ('14', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":40,\"parentId\":37,\"name\":\"销售属性\",\"url\":\"product/saleattr\",\"perms\":\"\",\"type\":1,\"icon\":\"zonghe\",\"orderNum\":0}]', '8', '0:0:0:0:0:0:0:1', '2019-11-13 20:08:00');
INSERT INTO `sys_log` VALUES ('15', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":41,\"parentId\":31,\"name\":\"商品维护\",\"url\":\"product/spu\",\"perms\":\"\",\"type\":1,\"icon\":\"zonghe\",\"orderNum\":0}]', '7', '0:0:0:0:0:0:0:1', '2019-11-13 20:13:12');
INSERT INTO `sys_log` VALUES ('16', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":42,\"parentId\":0,\"name\":\"优惠营销\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"mudedi\",\"orderNum\":0}]', '5', '0:0:0:0:0:0:0:1', '2019-11-13 20:14:52');
INSERT INTO `sys_log` VALUES ('17', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":43,\"parentId\":0,\"name\":\"库存系统\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"shouye\",\"orderNum\":0}]', '7', '0:0:0:0:0:0:0:1', '2019-11-13 20:15:20');
INSERT INTO `sys_log` VALUES ('18', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":44,\"parentId\":0,\"name\":\"订单系统\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"config\",\"orderNum\":0}]', '5', '0:0:0:0:0:0:0:1', '2019-11-13 20:15:48');
INSERT INTO `sys_log` VALUES ('19', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":45,\"parentId\":0,\"name\":\"用户系统\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"admin\",\"orderNum\":0}]', '5', '0:0:0:0:0:0:0:1', '2019-11-13 20:16:12');
INSERT INTO `sys_log` VALUES ('20', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":46,\"parentId\":0,\"name\":\"内容管理\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"sousuo\",\"orderNum\":0}]', '3', '0:0:0:0:0:0:0:1', '2019-11-13 20:16:56');
INSERT INTO `sys_log` VALUES ('21', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":47,\"parentId\":42,\"name\":\"优惠券管理\",\"url\":\"coupon/coupon\",\"perms\":\"\",\"type\":1,\"icon\":\"zhedie\",\"orderNum\":0}]', '7', '0:0:0:0:0:0:0:1', '2019-11-13 20:19:59');
INSERT INTO `sys_log` VALUES ('22', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":48,\"parentId\":42,\"name\":\"发放记录\",\"url\":\"coupon/history\",\"perms\":\"\",\"type\":1,\"icon\":\"sql\",\"orderNum\":0}]', '15', '0:0:0:0:0:0:0:1', '2019-11-13 20:20:52');
INSERT INTO `sys_log` VALUES ('23', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":49,\"parentId\":42,\"name\":\"专题活动\",\"url\":\"coupon/subject\",\"perms\":\"\",\"type\":1,\"icon\":\"tixing\",\"orderNum\":0}]', '7', '0:0:0:0:0:0:0:1', '2019-11-13 20:21:58');
INSERT INTO `sys_log` VALUES ('24', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":50,\"parentId\":42,\"name\":\"秒杀活动\",\"url\":\"coupon/seckill\",\"perms\":\"\",\"type\":1,\"icon\":\"daohang\",\"orderNum\":0}]', '7', '0:0:0:0:0:0:0:1', '2019-11-13 20:22:32');
INSERT INTO `sys_log` VALUES ('25', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":51,\"parentId\":42,\"name\":\"积分维护\",\"url\":\"coupon/bounds\",\"perms\":\"\",\"type\":1,\"icon\":\"geren\",\"orderNum\":0}]', '5', '0:0:0:0:0:0:0:1', '2019-11-13 20:25:13');
INSERT INTO `sys_log` VALUES ('26', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":52,\"parentId\":42,\"name\":\"满减折扣\",\"url\":\"coupon/full\",\"perms\":\"\",\"type\":1,\"icon\":\"shoucang\",\"orderNum\":0}]', '9', '0:0:0:0:0:0:0:1', '2019-11-13 20:26:21');
INSERT INTO `sys_log` VALUES ('27', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":53,\"parentId\":43,\"name\":\"仓库维护\",\"url\":\"ware/wareinfo\",\"perms\":\"\",\"type\":1,\"icon\":\"shouye\",\"orderNum\":0}]', '5', '0:0:0:0:0:0:0:1', '2019-11-13 20:27:51');
INSERT INTO `sys_log` VALUES ('28', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":54,\"parentId\":43,\"name\":\"库存工作单\",\"url\":\"ware/task\",\"perms\":\"\",\"type\":1,\"icon\":\"log\",\"orderNum\":0}]', '14', '0:0:0:0:0:0:0:1', '2019-11-13 20:28:55');
INSERT INTO `sys_log` VALUES ('29', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":55,\"parentId\":43,\"name\":\"商品库存\",\"url\":\"ware/sku\",\"perms\":\"\",\"type\":1,\"icon\":\"jiesuo\",\"orderNum\":0}]', '5', '0:0:0:0:0:0:0:1', '2019-11-13 20:29:31');
INSERT INTO `sys_log` VALUES ('30', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":56,\"parentId\":44,\"name\":\"订单查询\",\"url\":\"order/order\",\"perms\":\"\",\"type\":1,\"icon\":\"zhedie\",\"orderNum\":0}]', '6', '0:0:0:0:0:0:0:1', '2019-11-13 20:31:55');
INSERT INTO `sys_log` VALUES ('31', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":57,\"parentId\":44,\"name\":\"退货单处理\",\"url\":\"order/return\",\"perms\":\"\",\"type\":1,\"icon\":\"shanchu\",\"orderNum\":0}]', '5', '0:0:0:0:0:0:0:1', '2019-11-13 20:33:04');
INSERT INTO `sys_log` VALUES ('32', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":58,\"parentId\":44,\"name\":\"等级规则\",\"url\":\"order/settings\",\"perms\":\"\",\"type\":1,\"icon\":\"system\",\"orderNum\":0}]', '5', '0:0:0:0:0:0:0:1', '2019-11-13 20:34:34');
INSERT INTO `sys_log` VALUES ('33', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":59,\"parentId\":44,\"name\":\"支付流水查询\",\"url\":\"order/payment\",\"perms\":\"\",\"type\":1,\"icon\":\"job\",\"orderNum\":0}]', '5', '0:0:0:0:0:0:0:1', '2019-11-13 20:37:41');
INSERT INTO `sys_log` VALUES ('34', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":60,\"parentId\":44,\"name\":\"退款流水查询\",\"url\":\"order/refund\",\"perms\":\"\",\"type\":1,\"icon\":\"mudedi\",\"orderNum\":0}]', '6', '0:0:0:0:0:0:0:1', '2019-11-13 20:38:16');
INSERT INTO `sys_log` VALUES ('35', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":61,\"parentId\":45,\"name\":\"会员列表\",\"url\":\"member/member\",\"perms\":\"\",\"type\":1,\"icon\":\"geren\",\"orderNum\":0}]', '7', '0:0:0:0:0:0:0:1', '2019-11-13 20:40:14');
INSERT INTO `sys_log` VALUES ('36', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":62,\"parentId\":45,\"name\":\"会员等级\",\"url\":\"member/level\",\"perms\":\"\",\"type\":1,\"icon\":\"tubiao\",\"orderNum\":0}]', '14', '0:0:0:0:0:0:0:1', '2019-11-13 20:40:34');
INSERT INTO `sys_log` VALUES ('37', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":63,\"parentId\":45,\"name\":\"积分变化\",\"url\":\"member/growth\",\"perms\":\"\",\"type\":1,\"icon\":\"bianji\",\"orderNum\":0}]', '6', '0:0:0:0:0:0:0:1', '2019-11-13 20:43:14');
INSERT INTO `sys_log` VALUES ('38', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":64,\"parentId\":45,\"name\":\"统计信息\",\"url\":\"member/statistics\",\"perms\":\"\",\"type\":1,\"icon\":\"sql\",\"orderNum\":0}]', '4', '0:0:0:0:0:0:0:1', '2019-11-13 20:43:52');
INSERT INTO `sys_log` VALUES ('39', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":65,\"parentId\":46,\"name\":\"首页推荐\",\"url\":\"content/index\",\"perms\":\"\",\"type\":1,\"icon\":\"shouye\",\"orderNum\":0}]', '6', '0:0:0:0:0:0:0:1', '2019-11-13 20:44:47');
INSERT INTO `sys_log` VALUES ('40', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":66,\"parentId\":46,\"name\":\"分类热门\",\"url\":\"content/category\",\"perms\":\"\",\"type\":1,\"icon\":\"zhedie\",\"orderNum\":0}]', '7', '0:0:0:0:0:0:0:1', '2019-11-13 20:45:24');
INSERT INTO `sys_log` VALUES ('41', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":67,\"parentId\":46,\"name\":\"评论管理\",\"url\":\"content/comments\",\"perms\":\"\",\"type\":1,\"icon\":\"pinglun\",\"orderNum\":0}]', '20', '0:0:0:0:0:0:0:1', '2019-11-13 20:48:21');
INSERT INTO `sys_log` VALUES ('42', 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":41,\"parentId\":31,\"name\":\"商品维护\",\"url\":\"product/spu\",\"perms\":\"\",\"type\":0,\"icon\":\"zonghe\",\"orderNum\":0}]', '11', '0:0:0:0:0:0:0:1', '2019-11-17 12:18:52');
INSERT INTO `sys_log` VALUES ('43', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":68,\"parentId\":41,\"name\":\"spu管理\",\"url\":\"product/spu\",\"perms\":\"\",\"type\":1,\"icon\":\"config\",\"orderNum\":0}]', '9', '0:0:0:0:0:0:0:1', '2019-11-17 12:19:52');
INSERT INTO `sys_log` VALUES ('44', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":69,\"parentId\":41,\"name\":\"发布商品\",\"url\":\"product/spuadd\",\"perms\":\"\",\"type\":1,\"icon\":\"bianji\",\"orderNum\":0}]', '14', '0:0:0:0:0:0:0:1', '2019-11-17 12:49:04');
INSERT INTO `sys_log` VALUES ('45', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":70,\"parentId\":43,\"name\":\"采购单维护\",\"url\":\"\",\"perms\":\"\",\"type\":0,\"icon\":\"tubiao\",\"orderNum\":0}]', '12', '0:0:0:0:0:0:0:1', '2019-11-17 13:29:35');
INSERT INTO `sys_log` VALUES ('46', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":71,\"parentId\":70,\"name\":\"发布采购项\",\"url\":\"ware/purchaseitem\",\"perms\":\"\",\"type\":1,\"icon\":\"editor\",\"orderNum\":0}]', '7', '0:0:0:0:0:0:0:1', '2019-11-17 13:30:23');
INSERT INTO `sys_log` VALUES ('47', 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":71,\"parentId\":70,\"name\":\"采购需求\",\"url\":\"ware/purchaseitem\",\"perms\":\"\",\"type\":1,\"icon\":\"editor\",\"orderNum\":0}]', '6', '0:0:0:0:0:0:0:1', '2019-11-17 13:30:57');
INSERT INTO `sys_log` VALUES ('48', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":72,\"parentId\":70,\"name\":\"采购单\",\"url\":\"ware/purchase\",\"perms\":\"\",\"type\":1,\"icon\":\"menu\",\"orderNum\":0}]', '5', '0:0:0:0:0:0:0:1', '2019-11-17 13:31:32');
INSERT INTO `sys_log` VALUES ('49', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":73,\"parentId\":41,\"name\":\"商品管理\",\"url\":\"product/manager\",\"perms\":\"\",\"type\":1,\"icon\":\"zonghe\",\"orderNum\":0}]', '8', '0:0:0:0:0:0:0:1', '2019-11-17 13:36:18');
INSERT INTO `sys_log` VALUES ('50', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":74,\"parentId\":42,\"name\":\"会员价格\",\"url\":\"coupon/memberprice\",\"perms\":\"\",\"type\":1,\"icon\":\"\",\"orderNum\":0}]', '11', '0:0:0:0:0:0:0:1', '2019-11-24 16:23:33');
INSERT INTO `sys_log` VALUES ('51', 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":74,\"parentId\":42,\"name\":\"会员价格\",\"url\":\"coupon/memberprice\",\"perms\":\"\",\"type\":1,\"icon\":\"admin\",\"orderNum\":0}]', '9', '0:0:0:0:0:0:0:1', '2019-11-24 16:23:48');
INSERT INTO `sys_log` VALUES ('52', 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '[{\"userId\":2,\"username\":\"leifengyang\",\"password\":\"ed1b7fbd834332e5395d8823be934478141c3285ddccae1c55b192306571b886\",\"salt\":\"M78W7WGGh2RD0QGKm86j\",\"email\":\"aaaa@qq.com\",\"mobile\":\"12345678912\",\"status\":1,\"roleIdList\":[],\"createUserId\":1,\"createTime\":\"Nov 29, 2019 9:46:09 AM\"}]', '179', '0:0:0:0:0:0:0:1', '2019-11-29 09:46:09');
INSERT INTO `sys_log` VALUES ('53', 'admin', '保存菜单', 'io.renren.modules.sys.controller.SysMenuController.save()', '[{\"menuId\":75,\"parentId\":42,\"name\":\"每日秒杀\",\"url\":\"aaaaaaaa\",\"perms\":\"\",\"type\":1,\"icon\":\"job\",\"orderNum\":0}]', '8', '0:0:0:0:0:0:0:1', '2020-02-18 18:42:37');
INSERT INTO `sys_log` VALUES ('54', 'admin', '修改菜单', 'io.renren.modules.sys.controller.SysMenuController.update()', '[{\"menuId\":75,\"parentId\":42,\"name\":\"每日秒杀\",\"url\":\"coupon/seckillsession\",\"perms\":\"\",\"type\":1,\"icon\":\"job\",\"orderNum\":0}]', '11', '0:0:0:0:0:0:0:1', '2020-02-18 18:43:10');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=utf8mb4 COMMENT='菜单管理';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '0', '系统管理', null, null, '0', 'system', '0');
INSERT INTO `sys_menu` VALUES ('2', '1', '管理员列表', 'sys/user', null, '1', 'admin', '1');
INSERT INTO `sys_menu` VALUES ('3', '1', '角色管理', 'sys/role', null, '1', 'role', '2');
INSERT INTO `sys_menu` VALUES ('4', '1', '菜单管理', 'sys/menu', null, '1', 'menu', '3');
INSERT INTO `sys_menu` VALUES ('5', '1', 'SQL监控', 'http://localhost:8080/renren-fast/druid/sql.html', null, '1', 'sql', '4');
INSERT INTO `sys_menu` VALUES ('6', '1', '定时任务', 'job/schedule', null, '1', 'job', '5');
INSERT INTO `sys_menu` VALUES ('7', '6', '查看', null, 'sys:schedule:list,sys:schedule:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('8', '6', '新增', null, 'sys:schedule:save', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('9', '6', '修改', null, 'sys:schedule:update', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('10', '6', '删除', null, 'sys:schedule:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('11', '6', '暂停', null, 'sys:schedule:pause', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('12', '6', '恢复', null, 'sys:schedule:resume', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('13', '6', '立即执行', null, 'sys:schedule:run', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('14', '6', '日志列表', null, 'sys:schedule:log', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('15', '2', '查看', null, 'sys:user:list,sys:user:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('16', '2', '新增', null, 'sys:user:save,sys:role:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('17', '2', '修改', null, 'sys:user:update,sys:role:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('18', '2', '删除', null, 'sys:user:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('19', '3', '查看', null, 'sys:role:list,sys:role:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('20', '3', '新增', null, 'sys:role:save,sys:menu:list', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('21', '3', '修改', null, 'sys:role:update,sys:menu:list', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('22', '3', '删除', null, 'sys:role:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('23', '4', '查看', null, 'sys:menu:list,sys:menu:info', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('24', '4', '新增', null, 'sys:menu:save,sys:menu:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('25', '4', '修改', null, 'sys:menu:update,sys:menu:select', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('26', '4', '删除', null, 'sys:menu:delete', '2', null, '0');
INSERT INTO `sys_menu` VALUES ('27', '1', '参数管理', 'sys/config', 'sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete', '1', 'config', '6');
INSERT INTO `sys_menu` VALUES ('29', '1', '系统日志', 'sys/log', 'sys:log:list', '1', 'log', '7');
INSERT INTO `sys_menu` VALUES ('30', '1', '文件上传', 'oss/oss', 'sys:oss:all', '1', 'oss', '6');
INSERT INTO `sys_menu` VALUES ('31', '0', '商品系统', '', '', '0', 'editor', '0');
INSERT INTO `sys_menu` VALUES ('32', '31', '分类维护', 'product/category', '', '1', 'menu', '0');
INSERT INTO `sys_menu` VALUES ('34', '31', '品牌管理', 'product/brand', '', '1', 'editor', '0');
INSERT INTO `sys_menu` VALUES ('37', '31', '平台属性', '', '', '0', 'system', '0');
INSERT INTO `sys_menu` VALUES ('38', '37', '属性分组', 'product/attrgroup', '', '1', 'tubiao', '0');
INSERT INTO `sys_menu` VALUES ('39', '37', '规格参数', 'product/baseattr', '', '1', 'log', '0');
INSERT INTO `sys_menu` VALUES ('40', '37', '销售属性', 'product/saleattr', '', '1', 'zonghe', '0');
INSERT INTO `sys_menu` VALUES ('41', '31', '商品维护', 'product/spu', '', '0', 'zonghe', '0');
INSERT INTO `sys_menu` VALUES ('42', '0', '优惠营销', '', '', '0', 'mudedi', '0');
INSERT INTO `sys_menu` VALUES ('43', '0', '库存系统', '', '', '0', 'shouye', '0');
INSERT INTO `sys_menu` VALUES ('44', '0', '订单系统', '', '', '0', 'config', '0');
INSERT INTO `sys_menu` VALUES ('45', '0', '用户系统', '', '', '0', 'admin', '0');
INSERT INTO `sys_menu` VALUES ('46', '0', '内容管理', '', '', '0', 'sousuo', '0');
INSERT INTO `sys_menu` VALUES ('47', '42', '优惠券管理', 'coupon/coupon', '', '1', 'zhedie', '0');
INSERT INTO `sys_menu` VALUES ('48', '42', '发放记录', 'coupon/history', '', '1', 'sql', '0');
INSERT INTO `sys_menu` VALUES ('49', '42', '专题活动', 'coupon/subject', '', '1', 'tixing', '0');
INSERT INTO `sys_menu` VALUES ('50', '42', '秒杀活动', 'coupon/seckill', '', '1', 'daohang', '0');
INSERT INTO `sys_menu` VALUES ('51', '42', '积分维护', 'coupon/bounds', '', '1', 'geren', '0');
INSERT INTO `sys_menu` VALUES ('52', '42', '满减折扣', 'coupon/full', '', '1', 'shoucang', '0');
INSERT INTO `sys_menu` VALUES ('53', '43', '仓库维护', 'ware/wareinfo', '', '1', 'shouye', '0');
INSERT INTO `sys_menu` VALUES ('54', '43', '库存工作单', 'ware/task', '', '1', 'log', '0');
INSERT INTO `sys_menu` VALUES ('55', '43', '商品库存', 'ware/sku', '', '1', 'jiesuo', '0');
INSERT INTO `sys_menu` VALUES ('56', '44', '订单查询', 'order/order', '', '1', 'zhedie', '0');
INSERT INTO `sys_menu` VALUES ('57', '44', '退货单处理', 'order/return', '', '1', 'shanchu', '0');
INSERT INTO `sys_menu` VALUES ('58', '44', '等级规则', 'order/settings', '', '1', 'system', '0');
INSERT INTO `sys_menu` VALUES ('59', '44', '支付流水查询', 'order/payment', '', '1', 'job', '0');
INSERT INTO `sys_menu` VALUES ('60', '44', '退款流水查询', 'order/refund', '', '1', 'mudedi', '0');
INSERT INTO `sys_menu` VALUES ('61', '45', '会员列表', 'member/member', '', '1', 'geren', '0');
INSERT INTO `sys_menu` VALUES ('62', '45', '会员等级', 'member/level', '', '1', 'tubiao', '0');
INSERT INTO `sys_menu` VALUES ('63', '45', '积分变化', 'member/growth', '', '1', 'bianji', '0');
INSERT INTO `sys_menu` VALUES ('64', '45', '统计信息', 'member/statistics', '', '1', 'sql', '0');
INSERT INTO `sys_menu` VALUES ('65', '46', '首页推荐', 'content/index', '', '1', 'shouye', '0');
INSERT INTO `sys_menu` VALUES ('66', '46', '分类热门', 'content/category', '', '1', 'zhedie', '0');
INSERT INTO `sys_menu` VALUES ('67', '46', '评论管理', 'content/comments', '', '1', 'pinglun', '0');
INSERT INTO `sys_menu` VALUES ('68', '41', 'spu管理', 'product/spu', '', '1', 'config', '0');
INSERT INTO `sys_menu` VALUES ('69', '41', '发布商品', 'product/spuadd', '', '1', 'bianji', '0');
INSERT INTO `sys_menu` VALUES ('70', '43', '采购单维护', '', '', '0', 'tubiao', '0');
INSERT INTO `sys_menu` VALUES ('71', '70', '采购需求', 'ware/purchaseitem', '', '1', 'editor', '0');
INSERT INTO `sys_menu` VALUES ('72', '70', '采购单', 'ware/purchase', '', '1', 'menu', '0');
INSERT INTO `sys_menu` VALUES ('73', '41', '商品管理', 'product/manager', '', '1', 'zonghe', '0');
INSERT INTO `sys_menu` VALUES ('74', '42', '会员价格', 'coupon/memberprice', '', '1', 'admin', '0');
INSERT INTO `sys_menu` VALUES ('75', '42', '每日秒杀', 'coupon/seckillsession', '', '1', 'job', '0');

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='文件上传';

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色与菜单对应关系';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `salt` varchar(20) DEFAULT NULL COMMENT '盐',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `create_user_id` bigint(20) DEFAULT NULL COMMENT '创建者ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='系统用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '9ec9750e709431dad22365cabc5c625482e574c74adaebba7dd02f1129e4ce1d', 'YzcmCZNvbXocrsz9dm8e', 'root@renren.io', '13612345678', '1', '1', '2016-11-11 11:11:11');
INSERT INTO `sys_user` VALUES ('2', 'leifengyang', 'ed1b7fbd834332e5395d8823be934478141c3285ddccae1c55b192306571b886', 'M78W7WGGh2RD0QGKm86j', 'aaaa@qq.com', '12345678912', '1', '1', '2019-11-29 09:46:09');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与角色对应关系';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_token`;
CREATE TABLE `sys_user_token` (
  `user_id` bigint(20) NOT NULL,
  `token` varchar(100) NOT NULL COMMENT 'token',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统用户Token';

-- ----------------------------
-- Records of sys_user_token
-- ----------------------------
INSERT INTO `sys_user_token` VALUES ('1', '4576ed62b3a5f3c489a17b416690c3c1', '2020-03-08 09:22:45', '2020-03-07 21:22:45');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `mobile` varchar(20) NOT NULL COMMENT '手机号',
  `password` varchar(64) DEFAULT NULL COMMENT '密码',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='用户';

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('1', 'mark', '13612345678', '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918', '2017-03-23 22:37:41');

-- ----------------------------
-- Table structure for undo_log
-- ----------------------------
DROP TABLE IF EXISTS `undo_log`;
CREATE TABLE `undo_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(20) NOT NULL,
  `xid` varchar(100) NOT NULL,
  `context` varchar(128) NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int(11) NOT NULL,
  `log_created` datetime NOT NULL,
  `log_modified` datetime NOT NULL,
  `ext` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ux_undo_log` (`xid`,`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of undo_log
-- ----------------------------
