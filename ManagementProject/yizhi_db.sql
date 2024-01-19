/*
 Navicat Premium Data Transfer

 Source Server         : mysql8
 Source Server Type    : MySQL
 Source Server Version : 80011
 Source Host           : 192.168.38.130:3306
 Source Schema         : yizhi_db

 Target Server Type    : MySQL
 Target Server Version : 80011
 File Encoding         : 65001

 Date: 06/04/2022 15:30:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for blog_content
-- ----------------------------
DROP TABLE IF EXISTS `blog_content`;
CREATE TABLE `blog_content` (
  `cid` bigint(20) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL COMMENT '标题',
  `slug` varchar(255) DEFAULT NULL,
  `created` bigint(20) DEFAULT NULL COMMENT '创建人id',
  `modified` bigint(20) DEFAULT NULL COMMENT '最近修改人id',
  `content` text COMMENT '内容',
  `type` varchar(16) DEFAULT NULL COMMENT '类型',
  `tags` varchar(200) DEFAULT NULL COMMENT '标签',
  `categories` varchar(200) DEFAULT NULL COMMENT '分类',
  `hits` int(5) DEFAULT NULL,
  `comments_num` int(5) DEFAULT '0' COMMENT '评论数量',
  `allow_comment` int(1) DEFAULT '0' COMMENT '开启评论',
  `allow_ping` int(1) DEFAULT '0' COMMENT '允许ping',
  `allow_feed` int(1) DEFAULT '0' COMMENT '允许反馈',
  `status` int(1) DEFAULT NULL COMMENT '状态',
  `author` varchar(100) DEFAULT NULL COMMENT '作者',
  `gtm_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gtm_modified` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章内容';

-- ----------------------------
-- Records of blog_content
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for oa_notify
-- ----------------------------
DROP TABLE IF EXISTS `oa_notify`;
CREATE TABLE `oa_notify` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '标题',
  `content` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '内容',
  `files` varchar(2000) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '附件',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '状态',
  `create_by` bigint(20) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `oa_notify_del_flag` (`del_flag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='通知通告';

-- ----------------------------
-- Records of oa_notify
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for oa_notify_record
-- ----------------------------
DROP TABLE IF EXISTS `oa_notify_record`;
CREATE TABLE `oa_notify_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `notify_id` bigint(20) DEFAULT NULL COMMENT '通知通告ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '接受人',
  `is_read` tinyint(1) DEFAULT '0' COMMENT '阅读标记',
  `read_date` date DEFAULT NULL COMMENT '阅读时间',
  PRIMARY KEY (`id`),
  KEY `oa_notify_record_notify_id` (`notify_id`),
  KEY `oa_notify_record_user_id` (`user_id`),
  KEY `oa_notify_record_read_flag` (`is_read`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='通知通告发送记录';

-- ----------------------------
-- Records of oa_notify_record
-- ----------------------------
BEGIN;
INSERT INTO `oa_notify_record` VALUES (24, 44, 1, 1, '2018-10-18');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(200) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `CRON_EXPRESSION` varchar(200) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
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
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
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
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_locks` VALUES ('schedulerFactoryBean', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('schedulerFactoryBean', 'TRIGGER_ACCESS');
COMMIT;

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(200) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
BEGIN;
INSERT INTO `qrtz_scheduler_state` VALUES ('schedulerFactoryBean', 'xiaozhedeMacBook-Pro.local1649229268047', 1649230187126, 15000);
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(200) NOT NULL,
  `TRIGGER_GROUP` varchar(200) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
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
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
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
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for s_student_info
-- ----------------------------
DROP TABLE IF EXISTS `s_student_info`;
CREATE TABLE `s_student_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `student_id` varchar(255) DEFAULT NULL COMMENT '学号',
  `exam_id` varchar(255) DEFAULT NULL COMMENT '考生号',
  `class_id` int(11) DEFAULT NULL COMMENT '所属班级',
  `student_name` varchar(255) DEFAULT NULL COMMENT '学生姓名',
  `certify` varchar(255) DEFAULT NULL COMMENT '身份证号',
  `mail_address` varchar(255) DEFAULT NULL COMMENT '家庭住址',
  `foreign_lanaguage` varchar(255) DEFAULT NULL COMMENT '外语语种',
  `student_sex` varchar(255) DEFAULT NULL COMMENT '性别',
  `nation` varchar(255) DEFAULT NULL COMMENT '民族',
  `political` varchar(255) DEFAULT NULL COMMENT '政治面貌',
  `card_id` varchar(255) DEFAULT NULL COMMENT '一卡通卡号',
  `telephone` varchar(255) DEFAULT NULL COMMENT '手机号',
  `subject_type` varchar(255) DEFAULT NULL COMMENT '科类',
  `tocollege` int(11) DEFAULT NULL COMMENT '所属学院',
  `tocampus` int(11) DEFAULT NULL COMMENT '所属校区',
  `tomajor` int(11) DEFAULT NULL COMMENT '所属专业',
  `birthplace` varchar(255) DEFAULT NULL COMMENT '生源地',
  `grade` varchar(255) DEFAULT NULL COMMENT '层次',
  `isstate` int(2) DEFAULT NULL COMMENT '在校状态',
  `birthday` varchar(255) DEFAULT NULL COMMENT '生日',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `add_time` datetime DEFAULT NULL COMMENT '添加时间',
  `add_userid` int(11) DEFAULT NULL COMMENT '添加人',
  `edit_time` datetime DEFAULT NULL COMMENT '修改时间',
  `edit_userid` int(11) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of s_student_info
-- ----------------------------
BEGIN;
INSERT INTO `s_student_info` VALUES (5, '20190577', '201906189753', 2, '张大鹏', '200207198679887', 'zhangtianyou@qq.com', '英语', '1', '汉族', '团员', '9876765', '18811345555', '0', 1, NULL, 1, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-05 12:21:20', 1, '2022-04-06 15:24:55', 1);
INSERT INTO `s_student_info` VALUES (6, '20190511', '201906189701', 1, '刘晓天', '230207198679887', 'liuxiaotian@me.com', '英语', '1', '汉族', '团员', '9876765', '18811345555', '0', 1, NULL, 1, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:37:42', 1, '2022-04-06 13:19:45', 1);
INSERT INTO `s_student_info` VALUES (7, '20190512', '201906189702', 2, '肖则凯', '230207198679887', 'xiaozhekai@me.com', '英语', '1', '汉族', '团员', '9876765', '18811345555', '0', 1, NULL, 1, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:38:25', 1, '2022-04-06 15:25:02', 1);
INSERT INTO `s_student_info` VALUES (8, '20190513', '201906189703', 1, '李红梅', '230207198679887', 'lihongmei@me.com', '英语', '1', '汉族', '团员', '9876765', '18811345555', '0', 1, NULL, 1, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:38:39', 1, '2022-04-06 11:14:27', 1);
INSERT INTO `s_student_info` VALUES (9, '20190514', '201906189704', 2, '汪峰', '230207198679887', 'wangfeng@me.com', '英语', '1', '汉族', '团员', '9876765', '18811345555', '0', 1, NULL, 1, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:38:53', 1, '2022-04-06 15:25:10', 1);
INSERT INTO `s_student_info` VALUES (10, '20190515', '201906189705', 1, '刘亦菲', '230207198679887', 'liuyif@me.com', '英语', '1', '汉族', '团员', '9876765', '18811345555', '0', 2, NULL, 2, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:39:05', 1, '2022-04-06 15:27:15', 1);
INSERT INTO `s_student_info` VALUES (11, '20190516', '201906189706', 1, '张雪珂', '230207198679887', 'zhangxueke@me.com', '英语', '1', '汉族', '团员', '9876765', '18811345555', '0', 1, NULL, 1, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:39:17', 1, '2022-04-06 11:14:58', 1);
INSERT INTO `s_student_info` VALUES (12, '20190517', '201906189707', 1, '李黄梅', '230207198679887', 'lihuangmei@me.com', '英语', '1', '汉族', '团员', '9876765', '18811345555', '0', 1, NULL, 1, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:39:29', 1, '2022-04-06 11:15:07', 1);
INSERT INTO `s_student_info` VALUES (13, '20190517', '201906189708', 1, '洪峰', '230207198679887', 'hognfeng@me.com', '英语', '1', '汉族', '团员', '9876765', '18811345555', '0', 2, NULL, 2, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:39:36', 1, '2022-04-06 15:27:38', 1);
INSERT INTO `s_student_info` VALUES (14, '20190518', '201906189711', 1, '张瑞', '230207198679887', 'xiaozhe@me.com', '英语', '1', '汉族', '团员', '9876765', '18811345555', '0', 1, NULL, 1, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:39:45', 1, '2022-04-06 11:17:10', 1);
INSERT INTO `s_student_info` VALUES (15, '20190519', '1098', 1, '屠洪刚', '230207198679887', 'xiaozhe@me.com', '英语', '男', '汉族', '团员', '9876765', '18811345555', '0', 1, NULL, 1, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:39:54', 1, NULL, NULL);
INSERT INTO `s_student_info` VALUES (16, '20190520', '1098', 1, '李雷雷', '230207198679887', 'xiaozhe@me.com', '英语', '男', '汉族', '团员', '9876765', '18811345555', '0', 1, NULL, 1, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:40:05', 1, NULL, NULL);
INSERT INTO `s_student_info` VALUES (17, '20190521', '1098', 1, '李丽红', '230207198679887', 'xiaozhe@me.com', '英语', '男', '汉族', '团员', '9876765', '18811345555', '0', 1, NULL, 1, '北京', '啥层次', 0, '1986-10-11 00:00:00', '补考三次没过', '2022-04-06 10:40:43', 1, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_class
-- ----------------------------
DROP TABLE IF EXISTS `sys_class`;
CREATE TABLE `sys_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `class_name` varchar(255) DEFAULT NULL COMMENT '班级名称',
  `single_name` varchar(255) DEFAULT NULL COMMENT '简称',
  `tocollege_id` int(11) DEFAULT NULL COMMENT '所属学院',
  `tomajor_id` int(11) DEFAULT NULL COMMENT '所属专业',
  `class_num` varchar(255) DEFAULT NULL COMMENT '班级编号',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_class
-- ----------------------------
BEGIN;
INSERT INTO `sys_class` VALUES (1, '计算机科学与技术2201班', '计科2201', 1, 1, '2201');
INSERT INTO `sys_class` VALUES (2, '计算机科学与技术2202班', '计科2202', 1, 1, '2202');
COMMIT;

-- ----------------------------
-- Table structure for sys_college
-- ----------------------------
DROP TABLE IF EXISTS `sys_college`;
CREATE TABLE `sys_college` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `college_name` varchar(255) DEFAULT NULL COMMENT '学院名称',
  `single_name` varchar(255) DEFAULT NULL COMMENT '简称',
  `introduce` varchar(255) DEFAULT NULL COMMENT '学院介绍',
  `college_num` varchar(255) DEFAULT NULL COMMENT '学校编码',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_college
-- ----------------------------
BEGIN;
INSERT INTO `sys_college` VALUES (1, '信息科学技术学院', '信科', '信息科学技术学院', '123456');
INSERT INTO `sys_college` VALUES (2, '软件工程学院', '工院', '成立于1986年', '1234567');
COMMIT;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '上级部门ID，一级部门为0',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `area` int(11) DEFAULT NULL COMMENT '校区',
  `user_id` bigint(20) DEFAULT NULL,
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='部门管理';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` VALUES (9, 0, '总公司', -1, NULL, 2, '', 1);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '标签名',
  `value` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '数据值',
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `description` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `parent_id` bigint(64) DEFAULT '0' COMMENT '父级编号',
  `create_by` int(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`name`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='字典表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict` VALUES (1, '正常', '0', 'del_flag', '删除标记', 10, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (3, '显示', '1', 'show_hide', '显示/隐藏', 10, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (4, '隐藏', '0', 'show_hide', '显示/隐藏', 20, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (53, '发布', '0', 'cms_del_flag', '内容状态', 10, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (54, '删除', '1', 'cms_del_flag', '内容状态', 20, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (55, '审核', '2', 'cms_del_flag', '内容状态', 15, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (73, '增删改查', 'crud', 'gen_category', '代码生成分类', 10, 0, 1, NULL, 1, NULL, NULL, '1');
INSERT INTO `sys_dict` VALUES (74, '增删改查（包含从表）', 'crud_many', 'gen_category', '代码生成分类', 20, 0, 1, NULL, 1, NULL, NULL, '1');
INSERT INTO `sys_dict` VALUES (75, '树结构', 'tree', 'gen_category', '代码生成分类', 30, 0, 1, NULL, 1, NULL, NULL, '1');
INSERT INTO `sys_dict` VALUES (76, '=', '=', 'gen_query_type', '查询方式', 10, 0, 1, NULL, 1, NULL, NULL, '1');
INSERT INTO `sys_dict` VALUES (78, '&gt;', '&gt;', 'gen_query_type', '查询方式', 30, 0, 1, NULL, 1, NULL, NULL, '1');
INSERT INTO `sys_dict` VALUES (79, '&lt;', '&lt;', 'gen_query_type', '查询方式', 40, 0, 1, NULL, 1, NULL, NULL, '1');
INSERT INTO `sys_dict` VALUES (80, 'Between', 'between', 'gen_query_type', '查询方式', 50, 0, 1, NULL, 1, NULL, NULL, '1');
INSERT INTO `sys_dict` VALUES (81, 'Like', 'like', 'gen_query_type', '查询方式', 60, 0, 1, NULL, 1, NULL, NULL, '1');
INSERT INTO `sys_dict` VALUES (82, 'Left Like', 'left_like', 'gen_query_type', '查询方式', 70, 0, 1, NULL, 1, NULL, NULL, '1');
INSERT INTO `sys_dict` VALUES (83, 'Right Like', 'right_like', 'gen_query_type', '查询方式', 80, 0, 1, NULL, 1, NULL, NULL, '1');
INSERT INTO `sys_dict` VALUES (96, '男', '1', 'sex', '性别', 10, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (97, '女', '2', 'sex', '性别', 20, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (105, '会议通告', '1', 'oa_notify_type', '通知通告类型', 10, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (106, '奖惩通告', '2', 'oa_notify_type', '通知通告类型', 20, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (107, '活动通告', '3', 'oa_notify_type', '通知通告类型', 30, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (108, '草稿', '0', 'oa_notify_status', '通知通告状态', 10, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (109, '发布', '1', 'oa_notify_status', '通知通告状态', 20, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (110, '未读', '0', 'oa_notify_read', '通知通告状态', 10, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (111, '已读', '1', 'oa_notify_read', '通知通告状态', 20, 0, 1, NULL, 1, NULL, NULL, '0');
INSERT INTO `sys_dict` VALUES (112, '草稿', '0', 'oa_notify_status', '通知通告状态', 10, 0, 1, NULL, 1, NULL, '', '0');
INSERT INTO `sys_dict` VALUES (146, '经理', '1', 'job', '职务', NULL, NULL, NULL, '2022-02-11 11:16:56', NULL, '2022-02-11 11:17:18', '', '');
INSERT INTO `sys_dict` VALUES (147, '部门负责人', '2', 'job', '职务', NULL, NULL, NULL, '2022-02-11 11:17:50', NULL, '2022-02-11 11:18:12', '', '');
COMMIT;

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL COMMENT '文件类型',
  `url` varchar(200) DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件上传';

-- ----------------------------
-- Records of sys_file
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `time` int(11) DEFAULT NULL COMMENT '响应时间',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` mediumtext COMMENT '请求参数',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3181 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
BEGIN;
INSERT INTO `sys_log` VALUES (3058, 1, 'admin', '删除角色', 13, 'com.yizhi.system.controller.RoleController.save()', '59', '127.0.0.1', '2022-02-11 10:53:23');
INSERT INTO `sys_log` VALUES (3059, 1, 'admin', '删除角色', 8, 'com.yizhi.system.controller.RoleController.save()', '58', '127.0.0.1', '2022-02-11 10:53:25');
INSERT INTO `sys_log` VALUES (3060, 1, 'admin', '删除角色', 8, 'com.yizhi.system.controller.RoleController.save()', '57', '127.0.0.1', '2022-02-11 10:53:26');
INSERT INTO `sys_log` VALUES (3061, 1, 'admin', '删除角色', 9, 'com.yizhi.system.controller.RoleController.save()', '56', '127.0.0.1', '2022-02-11 10:53:28');
INSERT INTO `sys_log` VALUES (3062, 1, 'admin', '删除角色', 8, 'com.yizhi.system.controller.RoleController.save()', '49', '127.0.0.1', '2022-02-11 10:53:30');
INSERT INTO `sys_log` VALUES (3063, 1, 'admin', '添加用户', 1, 'com.yizhi.system.controller.UserController.add()', '{\"roles\":[{\"gmtCreate\":1502469832000,\"gmtModified\":1502536499000,\"remark\":\"拥有最高权限\",\"roleId\":1,\"roleName\":\"超级管理员\",\"roleSign\":\"admin\",\"userIdCreate\":2}]}', '127.0.0.1', '2022-02-11 11:00:31');
INSERT INTO `sys_log` VALUES (3064, 1, 'admin', '添加角色', 0, 'com.yizhi.system.controller.RoleController.add()', NULL, '127.0.0.1', '2022-02-11 11:00:55');
INSERT INTO `sys_log` VALUES (3065, 1, 'admin', '保存角色', 11, 'com.yizhi.system.controller.RoleController.save()', '{\"menuIds\":[84,89,88,87,86,90,85,-1],\"remark\":\"\",\"roleId\":60,\"roleName\":\"普通用户\"}', '127.0.0.1', '2022-02-11 11:01:09');
INSERT INTO `sys_log` VALUES (3066, 1, 'admin', '编辑用户', 9, 'com.yizhi.system.controller.UserController.edit()', '{\"user\":{\"birth\":1543507200000,\"city\":\"北京市市辖区\",\"deptDO\":{\"name\":\"总公司\",\"parentId\":0},\"deptId\":9,\"deptName\":\"总公司\",\"district\":\"东城区\",\"email\":\"admin@example.com\",\"gmtCreate\":1502804439000,\"gmtModified\":1554687746000,\"hobby\":\"11\",\"job\":0,\"liveAddress\":\"1\",\"mobile\":\"18765432134\",\"name\":\"超级管理员\",\"password\":\"27bd386e70f280e24c2f4f2a549b82cf\",\"picId\":1,\"province\":\"北京市\",\"receiveMsg\":0,\"sex\":96,\"status\":1,\"userId\":1,\"userIdCreate\":1,\"username\":\"admin\"},\"roles\":[{\"remark\":\"\",\"roleId\":60,\"roleName\":\"普通用户\",\"roleSign\":\"false\"},{\"gmtCreate\":1502469832000,\"gmtModified\":1502536499000,\"remark\":\"拥有最高权限\",\"roleId\":1,\"roleName\":\"超级管理员\",\"roleSign\":\"true\",\"userIdCreate\":2}]}', '127.0.0.1', '2022-02-11 11:14:40');
INSERT INTO `sys_log` VALUES (3067, 1, 'admin', '添加用户', 1, 'com.yizhi.system.controller.UserController.add()', '{\"roles\":[{\"remark\":\"\",\"roleId\":60,\"roleName\":\"普通用户\"},{\"gmtCreate\":1502469832000,\"gmtModified\":1502536499000,\"remark\":\"拥有最高权限\",\"roleId\":1,\"roleName\":\"超级管理员\",\"roleSign\":\"admin\",\"userIdCreate\":2}]}', '127.0.0.1', '2022-02-11 11:14:47');
INSERT INTO `sys_log` VALUES (3068, 1, 'admin', '添加用户', 1, 'com.yizhi.system.controller.UserController.add()', '{\"roles\":[{\"remark\":\"\",\"roleId\":60,\"roleName\":\"普通用户\"},{\"gmtCreate\":1502469832000,\"gmtModified\":1502536499000,\"remark\":\"拥有最高权限\",\"roleId\":1,\"roleName\":\"超级管理员\",\"roleSign\":\"admin\",\"userIdCreate\":2}]}', '127.0.0.1', '2022-02-11 11:15:50');
INSERT INTO `sys_log` VALUES (3069, 1, 'admin', '添加用户', 2, 'com.yizhi.system.controller.UserController.add()', '{\"roles\":[{\"remark\":\"\",\"roleId\":60,\"roleName\":\"普通用户\"},{\"gmtCreate\":1502469832000,\"gmtModified\":1502536499000,\"remark\":\"拥有最高权限\",\"roleId\":1,\"roleName\":\"超级管理员\",\"roleSign\":\"admin\",\"userIdCreate\":2}]}', '127.0.0.1', '2022-02-11 11:16:26');
INSERT INTO `sys_log` VALUES (3070, 1, 'admin', '添加用户', 1, 'com.yizhi.system.controller.UserController.add()', '{\"roles\":[{\"remark\":\"\",\"roleId\":60,\"roleName\":\"普通用户\"},{\"gmtCreate\":1502469832000,\"gmtModified\":1502536499000,\"remark\":\"拥有最高权限\",\"roleId\":1,\"roleName\":\"超级管理员\",\"roleSign\":\"admin\",\"userIdCreate\":2}]}', '127.0.0.1', '2022-02-11 11:17:54');
INSERT INTO `sys_log` VALUES (3071, 1, 'admin', '登录', 41, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-02-11 11:55:08');
INSERT INTO `sys_log` VALUES (3072, 1, 'admin', '添加菜单', 2, 'com.yizhi.system.controller.MenuController.add()', '{\"pId\":0,\"pName\":\"根目录\"}', '127.0.0.1', '2022-02-11 11:55:17');
INSERT INTO `sys_log` VALUES (3073, 1, 'admin', '保存菜单', 7, 'com.yizhi.system.controller.MenuController.save()', '{\"icon\":\"fa fa-group\",\"menuId\":162,\"name\":\"学生管理\",\"orderNum\":0,\"parentId\":0,\"perms\":\"\",\"type\":0,\"url\":\"\",\"valid\":0}', '127.0.0.1', '2022-02-11 11:55:49');
INSERT INTO `sys_log` VALUES (3074, 1, 'admin', '添加菜单', 4, 'com.yizhi.system.controller.MenuController.add()', '{\"pId\":162,\"pName\":\"学生管理\"}', '127.0.0.1', '2022-02-11 11:55:59');
INSERT INTO `sys_log` VALUES (3075, 1, 'admin', '添加菜单', 3, 'com.yizhi.system.controller.MenuController.add()', '{\"pId\":162,\"pName\":\"学生管理\"}', '127.0.0.1', '2022-02-11 11:56:05');
INSERT INTO `sys_log` VALUES (3076, 1, 'admin', '保存菜单', 8, 'com.yizhi.system.controller.MenuController.save()', '{\"icon\":\"\",\"menuId\":163,\"name\":\"学院管理\",\"parentId\":162,\"perms\":\"\",\"type\":1,\"url\":\"student/college\",\"valid\":0}', '127.0.0.1', '2022-02-11 11:56:46');
INSERT INTO `sys_log` VALUES (3077, 1, 'admin', '编辑菜单', 5, 'com.yizhi.system.controller.MenuController.edit()', '{\"pId\":162,\"pName\":\"学生管理\",\"menu\":{\"icon\":\"\",\"menuId\":163,\"name\":\"学院管理\",\"parentId\":162,\"perms\":\"\",\"type\":1,\"url\":\"student/college\",\"valid\":0}}', '127.0.0.1', '2022-02-11 11:57:05');
INSERT INTO `sys_log` VALUES (3078, 1, 'admin', '更新菜单', 8, 'com.yizhi.system.controller.MenuController.update()', '{\"icon\":\"\",\"menuId\":163,\"name\":\"学院管理\",\"orderNum\":1,\"parentId\":162,\"perms\":\"student:college:college\",\"type\":1,\"url\":\"student/college\",\"valid\":0}', '127.0.0.1', '2022-02-11 11:57:24');
INSERT INTO `sys_log` VALUES (3079, 1, 'admin', '添加菜单', 3, 'com.yizhi.system.controller.MenuController.add()', '{\"pId\":162,\"pName\":\"学生管理\"}', '127.0.0.1', '2022-02-11 11:57:28');
INSERT INTO `sys_log` VALUES (3080, 1, 'admin', '保存菜单', 7, 'com.yizhi.system.controller.MenuController.save()', '{\"icon\":\"\",\"menuId\":164,\"name\":\"专业管理\",\"orderNum\":2,\"parentId\":162,\"perms\":\"student:major:major\",\"type\":1,\"url\":\"student/major\",\"valid\":0}', '127.0.0.1', '2022-02-11 11:57:59');
INSERT INTO `sys_log` VALUES (3081, 1, 'admin', '添加菜单', 0, 'com.yizhi.system.controller.MenuController.add()', '{\"pId\":0,\"pName\":\"根目录\"}', '127.0.0.1', '2022-02-11 11:58:02');
INSERT INTO `sys_log` VALUES (3082, 1, 'admin', '保存菜单', 7, 'com.yizhi.system.controller.MenuController.save()', '{\"icon\":\"\",\"menuId\":165,\"name\":\"班级管理\",\"orderNum\":3,\"parentId\":0,\"perms\":\"student:class:class\",\"type\":1,\"url\":\"student/class\",\"valid\":0}', '127.0.0.1', '2022-02-11 11:58:29');
INSERT INTO `sys_log` VALUES (3083, 1, 'admin', '编辑菜单', 2, 'com.yizhi.system.controller.MenuController.edit()', '{\"pId\":0,\"pName\":\"根目录\",\"menu\":{\"icon\":\"\",\"menuId\":165,\"name\":\"班级管理\",\"orderNum\":3,\"parentId\":0,\"perms\":\"student:class:class\",\"type\":1,\"url\":\"student/class\",\"valid\":0}}', '127.0.0.1', '2022-02-11 11:58:41');
INSERT INTO `sys_log` VALUES (3084, 1, 'admin', '添加菜单', 3, 'com.yizhi.system.controller.MenuController.add()', '{\"pId\":162,\"pName\":\"学生管理\"}', '127.0.0.1', '2022-02-11 11:59:10');
INSERT INTO `sys_log` VALUES (3085, 1, 'admin', '保存菜单', 6, 'com.yizhi.system.controller.MenuController.save()', '{\"icon\":\"\",\"menuId\":166,\"name\":\"学生管理\",\"orderNum\":4,\"parentId\":162,\"perms\":\"student:studentInfo:studentInfo\",\"type\":1,\"url\":\"student/studentInfo\",\"valid\":0}', '127.0.0.1', '2022-02-11 11:59:39');
INSERT INTO `sys_log` VALUES (3086, 1, 'admin', '编辑角色', 1, 'com.yizhi.system.controller.RoleController.edit()', '1', '127.0.0.1', '2022-02-11 12:04:06');
INSERT INTO `sys_log` VALUES (3087, 1, 'admin', '更新角色', 25, 'com.yizhi.system.controller.RoleController.update()', '{\"menuIds\":[12,13,14,24,25,26,55,56,62,15,61,20,21,22,74,75,76,79,80,81,83,103,104,88,89,86,87,90,92,72,6,7,2,73,3,78,71,1,85,84,77,162,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,163,164,165,166,-1],\"remark\":\"拥有最高权限\",\"roleId\":1,\"roleName\":\"超级管理员\"}', '127.0.0.1', '2022-02-11 12:04:14');
INSERT INTO `sys_log` VALUES (3088, 1, 'admin', '登录', 7, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-02-11 12:04:30');
INSERT INTO `sys_log` VALUES (3089, 1, 'admin', '登录', 14, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-02-11 13:05:53');
INSERT INTO `sys_log` VALUES (3090, 1, 'admin', '学院（部或系）表保存', 8, 'com.yizhi.student.controller.CollegeController.save()', '{\"collegeName\":\"信息科学技术学院\",\"collegeNum\":\"123456\",\"id\":1,\"introduce\":\"信科,信息科学技术学院\"}', '127.0.0.1', '2022-02-11 13:11:16');
INSERT INTO `sys_log` VALUES (3091, 1, 'admin', '学院（部或系）表修改', 10, 'com.yizhi.student.controller.CollegeController.update()', '{\"collegeName\":\"信息科学技术学院\",\"collegeNum\":\"123456\",\"id\":1,\"introduce\":\"信息科学技术学院\",\"singleName\":\"信科\"}', '127.0.0.1', '2022-02-11 13:13:55');
INSERT INTO `sys_log` VALUES (3092, 1, 'admin', '专业名称表保存', 6, 'com.yizhi.student.controller.MajorController.save()', '{\"id\":1,\"introduce\":\"计算机专业涵盖软件工程专业，主要培养具有良好的科学素养，系统地、较好地掌握计算机科学与技术包括计算机硬件、软件与应用的基本理论、基本知识和基本技能与方法，能在科研部门、教育单位、企业、事业、技术和行政管理部门等单位从事计算机教学、科学研究和应用的计算机科学与技术学科的高级科学技术人才。\",\"majorName\":\"计算机科学与技术\",\"majorNum\":\"00001\",\"singleName\":\"CST\",\"tocollegeId\":1}', '127.0.0.1', '2022-02-11 13:16:12');
INSERT INTO `sys_log` VALUES (3093, 1, 'admin', '专业名称表修改', 8, 'com.yizhi.student.controller.MajorController.update()', '{\"id\":1,\"introduce\":\"计算机专业涵盖软件工程专业，主要培养具有良好的科学素养，系统地、较好地掌握计算机科学与技术包括计算机硬件、软件与应用的基本理论、基本知识和基本技能与方法，能在科研部门、教育单位、企业、事业、技术和行政管理部门等单位从事计算机教学、科学研究和应用的计算机科学与技术学科的高级科学技术人才。\",\"majorName\":\"计算机科学与技术\",\"majorNum\":\"0001\",\"singleName\":\"CST\",\"tocollegeId\":1}', '127.0.0.1', '2022-02-11 13:17:03');
INSERT INTO `sys_log` VALUES (3094, 1, 'admin', '班级表保存', 6, 'com.yizhi.student.controller.ClassController.save()', '{\"className\":\"计算机科学与技术2201班\",\"classNum\":\"2201\",\"id\":1,\"singleName\":\"计科2201\",\"tocollegeId\":1,\"tomajorId\":1}', '127.0.0.1', '2022-02-11 13:18:00');
INSERT INTO `sys_log` VALUES (3095, 1, 'admin', '生基础信息表保存', 8, 'com.yizhi.student.controller.StudentInfoController.save()', '{\"addTime\":1644549071000,\"addUserid\":1,\"birthday\":936159132000,\"birthplace\":\"中国北京西城区\",\"cardId\":\"1111111\",\"certify\":\"350781196403072249\",\"classId\":1,\"editTime\":1644549071000,\"editUserid\":1,\"examId\":\"220101\",\"foreignLanaguage\":\"英语\",\"grade\":\"1\",\"id\":1,\"isstate\":1,\"mailAddress\":\"北京市西城区\",\"nation\":\"汉\",\"note\":\"1\",\"political\":\"群众\",\"studentId\":\"220101\",\"studentName\":\"程庆明\",\"studentSex\":\"1\",\"subjectType\":1,\"telephone\":\"13854627896\",\"tocampus\":1,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-02-11 13:22:57');
INSERT INTO `sys_log` VALUES (3096, 1, 'admin', '生基础信息表修改', 12, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":936115200000,\"birthplace\":\"中国北京西城区\",\"cardId\":\"1111111\",\"certify\":\"350781196403072249\",\"classId\":1,\"examId\":\"220101\",\"foreignLanaguage\":\"英语\",\"grade\":\"1\",\"id\":1,\"isstate\":1,\"mailAddress\":\"北京市西城区\",\"nation\":\"汉\",\"note\":\"1\",\"political\":\"群众\",\"studentId\":\"220101\",\"studentName\":\"程庆明\",\"studentSex\":\"1\",\"subjectType\":1,\"telephone\":\"13854627896\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-02-11 14:07:05');
INSERT INTO `sys_log` VALUES (3097, 1, 'admin', '生基础信息表修改', 6, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":936115200000,\"birthplace\":\"中国北京西城区\",\"cardId\":\"1111111\",\"certify\":\"350781196403072249\",\"classId\":1,\"examId\":\"220101\",\"foreignLanaguage\":\"英语\",\"grade\":\"1\",\"id\":1,\"isstate\":1,\"mailAddress\":\"北京市西城区\",\"nation\":\"汉\",\"note\":\"1\",\"political\":\"群众\",\"studentId\":\"220101\",\"studentName\":\"程庆明\",\"studentSex\":\"2\",\"subjectType\":1,\"telephone\":\"13854627896\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-02-11 14:10:39');
INSERT INTO `sys_log` VALUES (3098, 1, 'admin', '登录', 58, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-03-30 13:48:43');
INSERT INTO `sys_log` VALUES (3099, 1, 'admin', '生基础信息表修改', 62, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":936115200000,\"birthplace\":\"中国北京西城区\",\"cardId\":\"1111111\",\"certify\":\"350781196403072249\",\"classId\":1,\"examId\":\"220101\",\"foreignLanaguage\":\"英语\",\"grade\":\"1\",\"id\":1,\"isstate\":1,\"mailAddress\":\"北京市西城区\",\"nation\":\"汉\",\"note\":\"1\",\"political\":\"群众\",\"studentId\":\"220101\",\"studentName\":\"程庆明\",\"studentSex\":\"1\",\"subjectType\":1,\"telephone\":\"13854627896\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-03-30 14:24:50');
INSERT INTO `sys_log` VALUES (3100, 1, 'admin', '生基础信息表修改', 73, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":936115200000,\"birthplace\":\"中国北京西城区\",\"cardId\":\"1111111\",\"certify\":\"350781196403072249\",\"classId\":1,\"examId\":\"220101\",\"foreignLanaguage\":\"英语\",\"grade\":\"1\",\"id\":1,\"isstate\":1,\"mailAddress\":\"北京市西城区\",\"nation\":\"汉\",\"note\":\"1\",\"political\":\"群众\",\"studentId\":\"220101\",\"studentName\":\"程庆明大大\",\"studentSex\":\"1\",\"subjectType\":1,\"telephone\":\"13854627896\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-03-30 14:25:07');
INSERT INTO `sys_log` VALUES (3101, 1, 'admin', '生基础信息表修改', 97, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":936115200000,\"birthplace\":\"中国北京西城区\",\"cardId\":\"1111111\",\"certify\":\"350781196403072249\",\"classId\":1,\"examId\":\"220101\",\"foreignLanaguage\":\"英语\",\"grade\":\"1\",\"id\":1,\"isstate\":1,\"mailAddress\":\"北京市西城区\",\"nation\":\"汉\",\"note\":\"1\",\"political\":\"群众\",\"studentId\":\"220101\",\"studentName\":\"程庆明\",\"studentSex\":\"1\",\"subjectType\":1,\"telephone\":\"13854627896\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-03-30 14:33:47');
INSERT INTO `sys_log` VALUES (3102, -1, '获取用户信息为空', '登录', 33, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-03-30 17:45:25');
INSERT INTO `sys_log` VALUES (3103, -1, '获取用户信息为空', '登录', 11, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-03-30 17:45:32');
INSERT INTO `sys_log` VALUES (3104, -1, '获取用户信息为空', '登录', 10, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-03-30 17:45:45');
INSERT INTO `sys_log` VALUES (3105, -1, '获取用户信息为空', '登录', 1, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-03-30 17:46:13');
INSERT INTO `sys_log` VALUES (3106, 1, 'admin', '登录', 35, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-03-30 17:46:23');
INSERT INTO `sys_log` VALUES (3107, 1, 'admin', '编辑角色', 5, 'com.yizhi.system.controller.RoleController.edit()', '1', '127.0.0.1', '2022-03-30 17:48:25');
INSERT INTO `sys_log` VALUES (3108, 1, 'admin', '登录', 61, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-04-02 09:13:14');
INSERT INTO `sys_log` VALUES (3109, 1, 'admin', '生基础信息表删除', 76, 'com.yizhi.student.controller.StudentInfoController.remove()', '1', '127.0.0.1', '2022-04-02 09:26:29');
INSERT INTO `sys_log` VALUES (3110, 1, 'admin', '编辑角色', 5, 'com.yizhi.system.controller.RoleController.edit()', '60', '127.0.0.1', '2022-04-02 09:27:27');
INSERT INTO `sys_log` VALUES (3111, 1, 'admin', '登录', 57, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-04-02 13:13:02');
INSERT INTO `sys_log` VALUES (3112, 1, 'admin', '登录', 54, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-04-02 14:11:05');
INSERT INTO `sys_log` VALUES (3113, 1, 'admin', '登录', 49, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-04-05 11:05:37');
INSERT INTO `sys_log` VALUES (3114, 1, 'admin', '登录', 68, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-04-05 14:47:35');
INSERT INTO `sys_log` VALUES (3115, 1, 'admin', '登录', 56, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-04-05 19:08:28');
INSERT INTO `sys_log` VALUES (3116, 1, 'admin', '生基础信息表修改', 77, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649156929663,\"editUserid\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":5,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"666\",\"studentName\":\"张天佑\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-05 19:08:50');
INSERT INTO `sys_log` VALUES (3117, 1, 'admin', '生基础信息表修改', 28, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649156963327,\"editUserid\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":5,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"7777\",\"studentName\":\"张天佑\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-05 19:09:23');
INSERT INTO `sys_log` VALUES (3118, 1, 'admin', '学生基础信息表修改', 41, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649158161021,\"editUserid\":1,\"examId\":\"09876\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":2,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"123\",\"studentName\":\"刘大龙\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-05 19:29:21');
INSERT INTO `sys_log` VALUES (3119, 1, 'admin', '学生基础信息表修改', 91, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649158197801,\"editUserid\":1,\"examId\":\"09876\",\"foreignLanaguage\":\"英语\",\"grade\":\"很高层次\",\"id\":2,\"isstate\":1,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过,这是第四次不考了\",\"political\":\"团员\",\"studentId\":\"123\",\"studentName\":\"刘大龙\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-05 19:29:58');
INSERT INTO `sys_log` VALUES (3120, 1, 'admin', '学生基础信息表修改', 9, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649158236528,\"editUserid\":1,\"examId\":\"09876\",\"foreignLanaguage\":\"英语\",\"grade\":\"很高层次\",\"id\":2,\"isstate\":1,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过,这是第四次不考了\",\"political\":\"团员\",\"studentId\":\"123\",\"studentName\":\"刘大龙\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-05 19:30:37');
INSERT INTO `sys_log` VALUES (3121, 1, 'admin', '登录', 98, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-04-06 09:01:55');
INSERT INTO `sys_log` VALUES (3122, 1, 'admin', '登录', 20, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-04-06 10:17:48');
INSERT INTO `sys_log` VALUES (3123, 1, 'admin', '学生基础信息表修改', 83, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649212067016,\"editUserid\":1,\"examId\":\"09876\",\"foreignLanaguage\":\"英语\",\"grade\":\"很高层次\",\"id\":2,\"isstate\":1,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过,这是第四次不考了\",\"political\":\"团员\",\"studentId\":\"20190618\",\"studentName\":\"刘大龙\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:27:47');
INSERT INTO `sys_log` VALUES (3124, 1, 'admin', '学生基础信息表修改', 62, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649212087400,\"editUserid\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":5,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190577\",\"studentName\":\"张天佑\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:28:07');
INSERT INTO `sys_log` VALUES (3125, 1, 'admin', '学生基础信息表修改', 51, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649212104843,\"editUserid\":1,\"examId\":\"201906189876\",\"foreignLanaguage\":\"英语\",\"grade\":\"很高层次\",\"id\":2,\"isstate\":1,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过,这是第四次不考了\",\"political\":\"团员\",\"studentId\":\"20190618\",\"studentName\":\"刘大龙\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:28:25');
INSERT INTO `sys_log` VALUES (3126, 1, 'admin', '学生基础信息表修改', 45, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"200207198679887\",\"classId\":1,\"editTime\":1649212142308,\"editUserid\":1,\"examId\":\"201906189753\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":5,\"isstate\":0,\"mailAddress\":\"zhangtianyou@qq.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190577\",\"studentName\":\"张天佑\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:29:02');
INSERT INTO `sys_log` VALUES (3127, 1, 'admin', '学生基础信息表修改', 87, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"210207198679887\",\"classId\":1,\"editTime\":1649212153300,\"editUserid\":1,\"examId\":\"201906189876\",\"foreignLanaguage\":\"英语\",\"grade\":\"很高层次\",\"id\":2,\"isstate\":1,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过,这是第四次不考了\",\"political\":\"团员\",\"studentId\":\"20190618\",\"studentName\":\"刘大龙\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:29:13');
INSERT INTO `sys_log` VALUES (3128, 1, 'admin', '学生基础信息表修改', 40, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"210207198679887\",\"classId\":1,\"editTime\":1649212536244,\"editUserid\":1,\"examId\":\"201906189876\",\"foreignLanaguage\":\"英语\",\"grade\":\"很高层次\",\"id\":2,\"isstate\":1,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过,这是第四次不考了\",\"political\":\"团员\",\"studentId\":\"20190618\",\"studentName\":\"刘文龙\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:35:36');
INSERT INTO `sys_log` VALUES (3129, 1, 'admin', '学生基础信息表修改', 85, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"200207198679887\",\"classId\":1,\"editTime\":1649212554715,\"editUserid\":1,\"examId\":\"201906189753\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":5,\"isstate\":0,\"mailAddress\":\"zhangtianyou@qq.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190577\",\"studentName\":\"张大鹏\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:35:55');
INSERT INTO `sys_log` VALUES (3130, 1, 'admin', '学生基础信息表保存功能', 45, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212662294,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":6,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190511\",\"studentName\":\"刘晓天\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:37:42');
INSERT INTO `sys_log` VALUES (3131, 1, 'admin', '学生基础信息表保存功能', 80, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212705493,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":7,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190512\",\"studentName\":\"肖则凯\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:38:26');
INSERT INTO `sys_log` VALUES (3132, 1, 'admin', '学生基础信息表保存功能', 43, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212718768,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":8,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190513\",\"studentName\":\"李红梅\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:38:39');
INSERT INTO `sys_log` VALUES (3133, 1, 'admin', '学生基础信息表保存功能', 43, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212733485,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":9,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190514\",\"studentName\":\"汪峰\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:38:54');
INSERT INTO `sys_log` VALUES (3134, 1, 'admin', '学生基础信息表保存功能', 90, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212745328,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":10,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190515\",\"studentName\":\"刘亦菲\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:39:05');
INSERT INTO `sys_log` VALUES (3135, 1, 'admin', '学生基础信息表保存功能', 80, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212756733,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":11,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190516\",\"studentName\":\"张雪珂\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:39:17');
INSERT INTO `sys_log` VALUES (3136, 1, 'admin', '学生基础信息表保存功能', 48, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212769266,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":12,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190517\",\"studentName\":\"李黄梅\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:39:29');
INSERT INTO `sys_log` VALUES (3137, 1, 'admin', '学生基础信息表保存功能', 19, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212776391,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":13,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190517\",\"studentName\":\"洪峰\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:39:36');
INSERT INTO `sys_log` VALUES (3138, 1, 'admin', '学生基础信息表保存功能', 20, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212785364,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":14,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190518\",\"studentName\":\"张瑞\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:39:45');
INSERT INTO `sys_log` VALUES (3139, 1, 'admin', '学生基础信息表保存功能', 70, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212794211,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":15,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190519\",\"studentName\":\"屠洪刚\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:39:54');
INSERT INTO `sys_log` VALUES (3140, 1, 'admin', '学生基础信息表保存功能', 100, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212804673,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":16,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190520\",\"studentName\":\"李雷雷\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:40:05');
INSERT INTO `sys_log` VALUES (3141, 1, 'admin', '学生基础信息表保存功能', 34, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212842643,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":17,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190521\",\"studentName\":\"李丽红\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:40:43');
INSERT INTO `sys_log` VALUES (3142, 1, 'admin', '学生基础信息表保存功能', 69, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649212852236,\"addUserid\":1,\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"1098\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":18,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190522\",\"studentName\":\"洪之光\",\"studentSex\":\"男\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 10:40:52');
INSERT INTO `sys_log` VALUES (3143, 1, 'admin', '学生基础信息表修改', 60, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214771280,\"editUserid\":1,\"examId\":\"201906189701\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":6,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190511\",\"studentName\":\"刘晓天\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:12:51');
INSERT INTO `sys_log` VALUES (3144, 1, 'admin', '学生基础信息表修改', 47, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214787498,\"editUserid\":1,\"examId\":\"201906189702\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":7,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190512\",\"studentName\":\"肖则凯\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:13:08');
INSERT INTO `sys_log` VALUES (3145, 1, 'admin', '学生基础信息表修改', 68, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214795068,\"editUserid\":1,\"examId\":\"201906189703\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":8,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190513\",\"studentName\":\"李红梅\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:13:15');
INSERT INTO `sys_log` VALUES (3146, 1, 'admin', '学生基础信息表修改', 12, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214802325,\"editUserid\":1,\"examId\":\"201906189704\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":9,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190514\",\"studentName\":\"汪峰\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:13:22');
INSERT INTO `sys_log` VALUES (3147, 1, 'admin', '学生基础信息表修改', 90, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214809232,\"editUserid\":1,\"examId\":\"201906189705\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":10,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190515\",\"studentName\":\"刘亦菲\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:13:29');
INSERT INTO `sys_log` VALUES (3148, 1, 'admin', '学生基础信息表修改', 37, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214817310,\"editUserid\":1,\"examId\":\"201906189706\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":11,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190516\",\"studentName\":\"张雪珂\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:13:37');
INSERT INTO `sys_log` VALUES (3149, 1, 'admin', '学生基础信息表修改', 14, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214824801,\"editUserid\":1,\"examId\":\"201906189707\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":12,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190517\",\"studentName\":\"李黄梅\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:13:45');
INSERT INTO `sys_log` VALUES (3150, 1, 'admin', '学生基础信息表修改', 41, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214832600,\"editUserid\":1,\"examId\":\"201906189708\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":13,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190517\",\"studentName\":\"洪峰\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:13:53');
INSERT INTO `sys_log` VALUES (3151, 1, 'admin', '学生基础信息表修改', 49, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214845828,\"editUserid\":1,\"examId\":\"201906189701\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":6,\"isstate\":0,\"mailAddress\":\"liuxiaotian@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190511\",\"studentName\":\"刘晓天\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:14:06');
INSERT INTO `sys_log` VALUES (3152, 1, 'admin', '学生基础信息表修改', 13, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214856572,\"editUserid\":1,\"examId\":\"201906189702\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":7,\"isstate\":0,\"mailAddress\":\"xiaozhekai@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190512\",\"studentName\":\"肖则凯\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:14:17');
INSERT INTO `sys_log` VALUES (3153, 1, 'admin', '学生基础信息表修改', 63, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214867057,\"editUserid\":1,\"examId\":\"201906189703\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":8,\"isstate\":0,\"mailAddress\":\"lihongmei@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190513\",\"studentName\":\"李红梅\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:14:27');
INSERT INTO `sys_log` VALUES (3154, 1, 'admin', '学生基础信息表修改', 10, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214877990,\"editUserid\":1,\"examId\":\"201906189704\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":9,\"isstate\":0,\"mailAddress\":\"wangfeng@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190514\",\"studentName\":\"汪峰\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:14:38');
INSERT INTO `sys_log` VALUES (3155, 1, 'admin', '学生基础信息表修改', 96, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214888181,\"editUserid\":1,\"examId\":\"201906189705\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":10,\"isstate\":0,\"mailAddress\":\"liuyif@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190515\",\"studentName\":\"刘亦菲\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:14:48');
INSERT INTO `sys_log` VALUES (3156, 1, 'admin', '学生基础信息表修改', 67, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214897635,\"editUserid\":1,\"examId\":\"201906189706\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":11,\"isstate\":0,\"mailAddress\":\"zhangxueke@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190516\",\"studentName\":\"张雪珂\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:14:58');
INSERT INTO `sys_log` VALUES (3157, 1, 'admin', '学生基础信息表修改', 45, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214906722,\"editUserid\":1,\"examId\":\"201906189707\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":12,\"isstate\":0,\"mailAddress\":\"lihuangmei@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190517\",\"studentName\":\"李黄梅\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:15:07');
INSERT INTO `sys_log` VALUES (3158, 1, 'admin', '学生基础信息表修改', 106, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649214916939,\"editUserid\":1,\"examId\":\"201906189708\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":13,\"isstate\":0,\"mailAddress\":\"hognfeng@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190517\",\"studentName\":\"洪峰\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:15:17');
INSERT INTO `sys_log` VALUES (3159, 1, 'admin', '学生基础信息表删除', 71, 'com.yizhi.student.controller.StudentInfoController.remove()', '2', '127.0.0.1', '2022-04-06 11:15:40');
INSERT INTO `sys_log` VALUES (3160, 1, 'admin', '学生基础信息表修改', 40, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649215030328,\"editUserid\":1,\"examId\":\"201906189711\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":14,\"isstate\":0,\"mailAddress\":\"xiaozhe@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190518\",\"studentName\":\"张瑞\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 11:17:10');
INSERT INTO `sys_log` VALUES (3161, -1, '获取用户信息为空', '登录', 2, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-04-06 13:12:50');
INSERT INTO `sys_log` VALUES (3162, 1, 'admin', '登录', 34, 'com.yizhi.system.controller.LoginController.ajaxLogin()', NULL, '127.0.0.1', '2022-04-06 13:12:57');
INSERT INTO `sys_log` VALUES (3163, 1, 'admin', '学生基础信息表修改', 54, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649222384765,\"editUserid\":1,\"examId\":\"201906189701\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":6,\"isstate\":0,\"mailAddress\":\"liuxiaotian@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190511\",\"studentName\":\"刘晓天\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 13:19:45');
INSERT INTO `sys_log` VALUES (3164, 1, 'admin', '学生基础信息表保存功能', 6, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"birthday\":1649779200000,\"birthplace\":\"111111\",\"cardId\":\"1111111\",\"certify\":\"11111111\",\"classId\":1,\"examId\":\"1\",\"foreignLanaguage\":\"111111\",\"grade\":\"11111\",\"isstate\":8,\"mailAddress\":\"111111\",\"nation\":\"111111\",\"note\":\"111111\",\"political\":\"11111\",\"studentId\":\"1\",\"studentName\":\"aaa noo\",\"studentSex\":\"1\",\"subjectType\":11111,\"telephone\":\"4008001230\"}', '127.0.0.1', '2022-04-06 14:45:54');
INSERT INTO `sys_log` VALUES (3165, 1, 'admin', '学生基础信息表保存功能', 5, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"birthday\":1649779200000,\"birthplace\":\"111111\",\"cardId\":\"1111111\",\"certify\":\"11111111\",\"classId\":1,\"examId\":\"1\",\"foreignLanaguage\":\"111111\",\"grade\":\"11111\",\"isstate\":8,\"mailAddress\":\"111111\",\"nation\":\"111111\",\"note\":\"111111\",\"political\":\"11111\",\"studentId\":\"1\",\"studentName\":\"aaa noo\",\"studentSex\":\"1\",\"subjectType\":11111,\"telephone\":\"4008001230\"}', '127.0.0.1', '2022-04-06 14:46:31');
INSERT INTO `sys_log` VALUES (3166, 1, 'admin', '学生基础信息表保存功能', 102, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649228753012,\"addUserid\":1,\"birthday\":813340800000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"examId\":\"20190100\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":19,\"isstate\":0,\"mailAddress\":\"hongzhiguang@qq.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190522\",\"studentName\":\"宏达民\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocampus\":0,\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 15:05:53');
INSERT INTO `sys_log` VALUES (3167, 1, 'admin', '学生基础信息表修改', 103, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":813340800000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649228906341,\"editUserid\":1,\"examId\":\"20190100\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":19,\"isstate\":0,\"mailAddress\":\"hongzhiguang@qq.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190522\",\"studentName\":\"大张伟\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 15:08:26');
INSERT INTO `sys_log` VALUES (3168, 1, 'admin', '学生基础信息表保存功能', 11, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"birthday\":1648915200000,\"birthplace\":\"北京\",\"cardId\":\"大幅度发\",\"certify\":\"11111\",\"classId\":1,\"examId\":\"11111\",\"foreignLanaguage\":\"英语\",\"grade\":\"大沙发斯蒂芬\",\"isstate\":1,\"mailAddress\":\"11111\",\"nation\":\"顶顶顶顶\",\"note\":\"爱对方答复\",\"political\":\"大是大非\",\"studentId\":\"11111\",\"studentName\":\"11111\",\"studentSex\":\"1\",\"subjectType\":123123123,\"telephone\":\"123123123\",\"tocollege\":1}', '127.0.0.1', '2022-04-06 15:13:27');
INSERT INTO `sys_log` VALUES (3169, 1, 'admin', '学生基础信息表保存功能', 100, 'com.yizhi.student.controller.StudentInfoController.post()', '{\"addTime\":1649229373282,\"addUserid\":1,\"birthday\":1648915200000,\"birthplace\":\"111111\",\"cardId\":\"11111111\",\"certify\":\"11111\",\"classId\":1,\"examId\":\"11111\",\"foreignLanaguage\":\"11111\",\"grade\":\"1\",\"id\":20,\"isstate\":1,\"mailAddress\":\"11111\",\"nation\":\"汗\",\"note\":\"111111\",\"political\":\"111111\",\"studentId\":\"11111\",\"studentName\":\"111111\",\"studentSex\":\"1\",\"subjectType\":1111111,\"telephone\":\"1111111\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 15:16:13');
INSERT INTO `sys_log` VALUES (3170, 1, 'admin', '学生基础信息表删除', 93, 'com.yizhi.student.controller.StudentInfoController.remove()', '20', '127.0.0.1', '2022-04-06 15:20:25');
INSERT INTO `sys_log` VALUES (3171, 1, 'admin', '学生基础信息表批量删除', 37, 'com.yizhi.student.controller.StudentInfoController.remove()', '[18,19]', '127.0.0.1', '2022-04-06 15:20:37');
INSERT INTO `sys_log` VALUES (3172, 1, 'admin', '班级表保存', 105, 'com.yizhi.student.controller.ClassController.save()', '{\"className\":\"计算机科学与技术2202班\",\"classNum\":\"02\",\"id\":2,\"singleName\":\"计科2202\",\"tocollegeId\":1,\"tomajorId\":1}', '127.0.0.1', '2022-04-06 15:24:25');
INSERT INTO `sys_log` VALUES (3173, 1, 'admin', '班级表修改', 45, 'com.yizhi.student.controller.ClassController.update()', '{\"className\":\"计算机科学与技术2202班\",\"classNum\":\"2202\",\"id\":2,\"singleName\":\"计科2202\",\"tocollegeId\":1,\"tomajorId\":1}', '127.0.0.1', '2022-04-06 15:24:43');
INSERT INTO `sys_log` VALUES (3174, 1, 'admin', '学生基础信息表修改', 23, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"200207198679887\",\"classId\":2,\"editTime\":1649229895482,\"editUserid\":1,\"examId\":\"201906189753\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":5,\"isstate\":0,\"mailAddress\":\"zhangtianyou@qq.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190577\",\"studentName\":\"张大鹏\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 15:24:56');
INSERT INTO `sys_log` VALUES (3175, 1, 'admin', '学生基础信息表修改', 72, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":2,\"editTime\":1649229902446,\"editUserid\":1,\"examId\":\"201906189702\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":7,\"isstate\":0,\"mailAddress\":\"xiaozhekai@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190512\",\"studentName\":\"肖则凯\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 15:25:03');
INSERT INTO `sys_log` VALUES (3176, 1, 'admin', '学生基础信息表修改', 16, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":2,\"editTime\":1649229910084,\"editUserid\":1,\"examId\":\"201906189704\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":9,\"isstate\":0,\"mailAddress\":\"wangfeng@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190514\",\"studentName\":\"汪峰\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":1,\"tomajor\":1}', '127.0.0.1', '2022-04-06 15:25:10');
INSERT INTO `sys_log` VALUES (3177, 1, 'admin', '学院（部或系）表保存', 91, 'com.yizhi.student.controller.CollegeController.save()', '{\"collegeName\":\"软件工程学院\",\"collegeNum\":\"1234567\",\"id\":2,\"introduce\":\"成立于1986年\",\"singleName\":\"工院\"}', '127.0.0.1', '2022-04-06 15:26:17');
INSERT INTO `sys_log` VALUES (3178, 1, 'admin', '专业名称表保存', 63, 'com.yizhi.student.controller.MajorController.save()', '{\"id\":2,\"introduce\":\"专业的软件编程学院\",\"majorName\":\"软件工程\",\"majorNum\":\"0002\",\"singleName\":\"软工\",\"tocollegeId\":2}', '127.0.0.1', '2022-04-06 15:26:48');
INSERT INTO `sys_log` VALUES (3179, 1, 'admin', '学生基础信息表修改', 101, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649230034950,\"editUserid\":1,\"examId\":\"201906189705\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":10,\"isstate\":0,\"mailAddress\":\"liuyif@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190515\",\"studentName\":\"刘亦菲\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":2,\"tomajor\":2}', '127.0.0.1', '2022-04-06 15:27:15');
INSERT INTO `sys_log` VALUES (3180, 1, 'admin', '学生基础信息表修改', 74, 'com.yizhi.student.controller.StudentInfoController.update()', '{\"birthday\":529344000000,\"birthplace\":\"北京\",\"cardId\":\"9876765\",\"certify\":\"230207198679887\",\"classId\":1,\"editTime\":1649230057662,\"editUserid\":1,\"examId\":\"201906189708\",\"foreignLanaguage\":\"英语\",\"grade\":\"啥层次\",\"id\":13,\"isstate\":0,\"mailAddress\":\"hognfeng@me.com\",\"nation\":\"汉族\",\"note\":\"补考三次没过\",\"political\":\"团员\",\"studentId\":\"20190517\",\"studentName\":\"洪峰\",\"studentSex\":\"1\",\"subjectType\":0,\"telephone\":\"18811345555\",\"tocollege\":2,\"tomajor\":2}', '127.0.0.1', '2022-04-06 15:27:38');
COMMIT;

-- ----------------------------
-- Table structure for sys_major
-- ----------------------------
DROP TABLE IF EXISTS `sys_major`;
CREATE TABLE `sys_major` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `major_name` varchar(255) DEFAULT NULL COMMENT '专业名称',
  `single_name` varchar(255) DEFAULT NULL COMMENT '简称',
  `introduce` varchar(255) DEFAULT NULL COMMENT '专业介绍',
  `major_num` varchar(255) DEFAULT NULL COMMENT '专业编号',
  `tocollege_id` int(11) DEFAULT NULL COMMENT '所属学院',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_major
-- ----------------------------
BEGIN;
INSERT INTO `sys_major` VALUES (1, '计算机科学与技术', 'CST', '计算机专业涵盖软件工程专业，主要培养具有良好的科学素养，系统地、较好地掌握计算机科学与技术包括计算机硬件、软件与应用的基本理论、基本知识和基本技能与方法，能在科研部门、教育单位、企业、事业、技术和行政管理部门等单位从事计算机教学、科学研究和应用的计算机科学与技术学科的高级科学技术人才。', '0001', 1);
INSERT INTO `sys_major` VALUES (2, '软件工程', '软工', '专业的软件编程学院', '0002', 2);
COMMIT;

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
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `valid` int(11) DEFAULT '0' COMMENT '是否有效： 0有效 1无效',
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8 COMMENT='菜单管理';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES (1, 0, '基础管理', '', '', 0, 'fa fa-bars', 2, '2017-08-09 22:49:47', NULL, 0);
INSERT INTO `sys_menu` VALUES (2, 3, '系统菜单', 'sys/menu/', 'sys:menu:menu', 1, 'fa fa-th-list', 2, '2017-08-09 22:55:15', NULL, 0);
INSERT INTO `sys_menu` VALUES (3, 0, '系统管理', NULL, NULL, 0, 'fa fa-desktop', 1, '2017-08-09 23:06:55', '2017-08-14 14:13:43', 0);
INSERT INTO `sys_menu` VALUES (6, 3, '用户管理', 'sys/user/', 'sys:user:user', 1, 'fa fa-user', 0, '2017-08-10 14:12:11', NULL, 0);
INSERT INTO `sys_menu` VALUES (7, 3, '角色管理', 'sys/role', 'sys:role:role', 1, 'fa fa-paw', 1, '2017-08-10 14:13:19', NULL, 0);
INSERT INTO `sys_menu` VALUES (12, 6, '新增', '', 'sys:user:add', 2, '', 0, '2017-08-14 10:51:35', NULL, 0);
INSERT INTO `sys_menu` VALUES (13, 6, '编辑', '', 'sys:user:edit', 2, '', 0, '2017-08-14 10:52:06', NULL, 0);
INSERT INTO `sys_menu` VALUES (14, 6, '删除', NULL, 'sys:user:remove', 2, NULL, 0, '2017-08-14 10:52:24', NULL, 0);
INSERT INTO `sys_menu` VALUES (15, 7, '新增', '', 'sys:role:add', 2, '', 0, '2017-08-14 10:56:37', NULL, 0);
INSERT INTO `sys_menu` VALUES (20, 2, '新增', '', 'sys:menu:add', 2, '', 0, '2017-08-14 10:59:32', NULL, 0);
INSERT INTO `sys_menu` VALUES (21, 2, '编辑', '', 'sys:menu:edit', 2, '', 0, '2017-08-14 10:59:56', NULL, 0);
INSERT INTO `sys_menu` VALUES (22, 2, '删除', '', 'sys:menu:remove', 2, '', 0, '2017-08-14 11:00:26', NULL, 0);
INSERT INTO `sys_menu` VALUES (24, 6, '批量删除', '', 'sys:user:batchRemove', 2, '', 0, '2017-08-14 17:27:18', NULL, 0);
INSERT INTO `sys_menu` VALUES (25, 6, '停用', NULL, 'sys:user:disable', 2, NULL, 0, '2017-08-14 17:27:43', NULL, 0);
INSERT INTO `sys_menu` VALUES (26, 6, '重置密码', '', 'sys:user:resetPwd', 2, '', 0, '2017-08-14 17:28:34', NULL, 0);
INSERT INTO `sys_menu` VALUES (49, 0, '博客管理', '', '', 0, 'fa fa-rss', 6, NULL, NULL, 1);
INSERT INTO `sys_menu` VALUES (50, 49, '文章列表', 'blog/bContent', 'blog:bContent:bContent', 1, 'fa fa-file-image-o', 1, NULL, NULL, 1);
INSERT INTO `sys_menu` VALUES (51, 50, '新增', '', 'blog:bContent:add', 2, '', NULL, NULL, NULL, 1);
INSERT INTO `sys_menu` VALUES (55, 7, '编辑', '', 'sys:role:edit', 2, '', NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (56, 7, '删除', '', 'sys:role:remove', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (58, 50, '编辑', '', 'blog:bContent:edit', 2, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_menu` VALUES (59, 50, '删除', '', 'blog:bContent:remove', 2, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_menu` VALUES (60, 50, '批量删除', '', 'blog:bContent:batchRemove', 2, NULL, NULL, NULL, NULL, 1);
INSERT INTO `sys_menu` VALUES (61, 2, '批量删除', '', 'sys:menu:batchRemove', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (62, 7, '批量删除', '', 'sys:role:batchRemove', 2, NULL, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (68, 49, '发布文章', '/blog/bContent/add', 'blog:bContent:add', 1, 'fa fa-edit', 0, NULL, NULL, 1);
INSERT INTO `sys_menu` VALUES (71, 1, '文件管理', '/common/sysFile', 'common:sysFile:sysFile', 1, 'fa fa-folder-open', 6, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (72, 77, '计划任务', 'common/job', 'common:taskScheduleJob', 1, 'fa fa-hourglass-1', 4, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (73, 3, '部门管理', '/system/sysDept', 'system:sysDept:sysDept', 1, 'fa fa-users', 3, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (74, 73, '增加', '/system/sysDept/add', 'system:sysDept:add', 2, NULL, 1, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (75, 73, '刪除', 'system/sysDept/remove', 'system:sysDept:remove', 2, NULL, 2, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (76, 73, '编辑', '/system/sysDept/edit', 'system:sysDept:edit', 2, NULL, 3, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (77, 0, '系统工具', '', '', 0, 'fa fa-gear', 4, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (78, 1, '数据字典', '/common/sysDict', 'common:sysDict:sysDict', 1, 'fa fa-book', 1, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (79, 78, '增加', '/common/sysDict/add', 'common:sysDict:add', 2, NULL, 2, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (80, 78, '编辑', '/common/sysDict/edit', 'common:sysDict:edit', 2, NULL, 2, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (81, 78, '删除', '/common/sysDict/remove', 'common:sysDict:remove', 2, '', 3, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (83, 78, '批量删除', '/common/sysDict/batchRemove', 'common:sysDict:batchRemove', 2, '', 4, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (84, 0, '通知管理', '', '', 0, 'fa fa-laptop', 3, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (85, 84, '通知公告', 'oa/notify', 'oa:notify:notify', 1, 'fa fa-pencil-square', 1, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (86, 85, '新增', 'oa/notify/add', 'oa:notify:add', 2, 'fa fa-plus', 1, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (87, 85, '编辑', 'oa/notify/edit', 'oa:notify:edit', 2, 'fa fa-pencil-square-o', 2, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (88, 85, '删除', 'oa/notify/remove', 'oa:notify:remove', 2, 'fa fa-minus', NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (89, 85, '批量删除', 'oa/notify/batchRemove', 'oa:notify:batchRemove', 2, '', NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (90, 84, '我的通知', 'oa/notify/selfNotify', '', 1, 'fa fa-envelope-square', 2, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (92, 77, '在线用户', 'sys/online', '', 1, 'fa fa-user', NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (103, 71, '删除', '', 'common:sysFile:remove', 2, '', NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (104, 71, '上传', '', 'common:sysFile:upload', 2, '', NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (162, 0, '学生管理', '', '', 0, 'fa fa-group', 0, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (163, 162, '学院管理', 'student/college', 'student:college:college', 1, '', 1, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (164, 162, '专业管理', 'student/major', 'student:major:major', 1, '', 2, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (165, 162, '班级管理', 'student/class', 'student:class:class', 1, '', 3, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (166, 162, '学生管理', 'student/studentInfo', 'student:studentInfo:studentInfo', 1, '', 4, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (167, 163, '新增', '', 'student:college:add', 2, '', 0, '2017-08-14 10:59:32', '2022-02-11 12:00:59', 0);
INSERT INTO `sys_menu` VALUES (168, 163, '编辑', '', 'student:college:edit', 2, '', 0, '2017-08-14 10:59:56', '2022-02-11 12:01:01', 0);
INSERT INTO `sys_menu` VALUES (169, 163, '删除', '', 'student:college:remove', 2, '', 0, '2017-08-14 11:00:26', '2022-02-11 12:01:03', 0);
INSERT INTO `sys_menu` VALUES (170, 163, '批量删除', '', 'student:college:batchRemove', 2, '', 0, '2017-08-14 17:27:18', '2022-02-11 12:01:05', 0);
INSERT INTO `sys_menu` VALUES (171, 164, '新增', '', 'student:major:add', 2, '', 0, '2017-08-14 10:59:32', '2022-02-11 12:00:59', 0);
INSERT INTO `sys_menu` VALUES (172, 164, '编辑', '', 'student:major:edit', 2, '', 0, '2017-08-14 10:59:56', '2022-02-11 12:01:01', 0);
INSERT INTO `sys_menu` VALUES (173, 164, '删除', '', 'student:major:remove', 2, '', 0, '2017-08-14 11:00:26', '2022-02-11 12:01:03', 0);
INSERT INTO `sys_menu` VALUES (174, 164, '批量删除', '', 'student:major:batchRemove', 2, '', 0, '2017-08-14 17:27:18', '2022-02-11 12:01:05', 0);
INSERT INTO `sys_menu` VALUES (175, 165, '新增', '', 'student:class:add', 2, '', 0, '2017-08-14 10:59:32', '2022-02-11 12:00:59', 0);
INSERT INTO `sys_menu` VALUES (176, 165, '编辑', '', 'student:class:edit', 2, '', 0, '2017-08-14 10:59:56', '2022-02-11 12:01:01', 0);
INSERT INTO `sys_menu` VALUES (177, 165, '删除', '', 'student:class:remove', 2, '', 0, '2017-08-14 11:00:26', '2022-02-11 12:01:03', 0);
INSERT INTO `sys_menu` VALUES (178, 165, '批量删除', '', 'student:class:batchRemove', 2, '', 0, '2017-08-14 17:27:18', '2022-02-11 12:01:05', 0);
INSERT INTO `sys_menu` VALUES (179, 166, '新增', '', 'student:studentInfo:add', 2, '', 0, '2017-08-14 10:59:32', '2022-02-11 12:00:59', 0);
INSERT INTO `sys_menu` VALUES (180, 166, '编辑', '', 'student:studentInfo:edit', 2, '', 0, '2017-08-14 10:59:56', '2022-02-11 12:01:01', 0);
INSERT INTO `sys_menu` VALUES (181, 166, '删除', '', 'student:studentInfo:remove', 2, '', 0, '2017-08-14 11:00:26', '2022-02-11 12:01:03', 0);
INSERT INTO `sys_menu` VALUES (182, 166, '批量删除', '', 'student:studentInfo:batchRemove', 2, '', 0, '2017-08-14 17:27:18', '2022-02-11 12:01:05', 0);
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `role_sign` varchar(100) DEFAULT NULL COMMENT '角色标识',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `user_id_create` bigint(255) DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', '拥有最高权限', 2, '2017-08-12 00:43:52', '2017-08-12 19:14:59');
INSERT INTO `sys_role` VALUES (60, '普通用户', NULL, '', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7101 DEFAULT CHARSET=utf8 COMMENT='角色与菜单对应关系';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` VALUES (367, 44, 1);
INSERT INTO `sys_role_menu` VALUES (368, 44, 32);
INSERT INTO `sys_role_menu` VALUES (369, 44, 33);
INSERT INTO `sys_role_menu` VALUES (370, 44, 34);
INSERT INTO `sys_role_menu` VALUES (371, 44, 35);
INSERT INTO `sys_role_menu` VALUES (372, 44, 28);
INSERT INTO `sys_role_menu` VALUES (373, 44, 29);
INSERT INTO `sys_role_menu` VALUES (374, 44, 30);
INSERT INTO `sys_role_menu` VALUES (375, 44, 38);
INSERT INTO `sys_role_menu` VALUES (376, 44, 4);
INSERT INTO `sys_role_menu` VALUES (377, 44, 27);
INSERT INTO `sys_role_menu` VALUES (378, 45, 38);
INSERT INTO `sys_role_menu` VALUES (379, 46, 3);
INSERT INTO `sys_role_menu` VALUES (380, 46, 20);
INSERT INTO `sys_role_menu` VALUES (381, 46, 21);
INSERT INTO `sys_role_menu` VALUES (382, 46, 22);
INSERT INTO `sys_role_menu` VALUES (383, 46, 23);
INSERT INTO `sys_role_menu` VALUES (384, 46, 11);
INSERT INTO `sys_role_menu` VALUES (385, 46, 12);
INSERT INTO `sys_role_menu` VALUES (386, 46, 13);
INSERT INTO `sys_role_menu` VALUES (387, 46, 14);
INSERT INTO `sys_role_menu` VALUES (388, 46, 24);
INSERT INTO `sys_role_menu` VALUES (389, 46, 25);
INSERT INTO `sys_role_menu` VALUES (390, 46, 26);
INSERT INTO `sys_role_menu` VALUES (391, 46, 15);
INSERT INTO `sys_role_menu` VALUES (392, 46, 2);
INSERT INTO `sys_role_menu` VALUES (393, 46, 6);
INSERT INTO `sys_role_menu` VALUES (394, 46, 7);
INSERT INTO `sys_role_menu` VALUES (598, 50, 38);
INSERT INTO `sys_role_menu` VALUES (632, 38, 42);
INSERT INTO `sys_role_menu` VALUES (737, 51, 38);
INSERT INTO `sys_role_menu` VALUES (738, 51, 39);
INSERT INTO `sys_role_menu` VALUES (739, 51, 40);
INSERT INTO `sys_role_menu` VALUES (740, 51, 41);
INSERT INTO `sys_role_menu` VALUES (741, 51, 4);
INSERT INTO `sys_role_menu` VALUES (742, 51, 32);
INSERT INTO `sys_role_menu` VALUES (743, 51, 33);
INSERT INTO `sys_role_menu` VALUES (744, 51, 34);
INSERT INTO `sys_role_menu` VALUES (745, 51, 35);
INSERT INTO `sys_role_menu` VALUES (746, 51, 27);
INSERT INTO `sys_role_menu` VALUES (747, 51, 28);
INSERT INTO `sys_role_menu` VALUES (748, 51, 29);
INSERT INTO `sys_role_menu` VALUES (749, 51, 30);
INSERT INTO `sys_role_menu` VALUES (750, 51, 1);
INSERT INTO `sys_role_menu` VALUES (1064, 54, 53);
INSERT INTO `sys_role_menu` VALUES (1095, 55, 2);
INSERT INTO `sys_role_menu` VALUES (1096, 55, 6);
INSERT INTO `sys_role_menu` VALUES (1097, 55, 7);
INSERT INTO `sys_role_menu` VALUES (1098, 55, 3);
INSERT INTO `sys_role_menu` VALUES (1099, 55, 50);
INSERT INTO `sys_role_menu` VALUES (1100, 55, 49);
INSERT INTO `sys_role_menu` VALUES (1101, 55, 1);
INSERT INTO `sys_role_menu` VALUES (1856, 53, 28);
INSERT INTO `sys_role_menu` VALUES (1857, 53, 29);
INSERT INTO `sys_role_menu` VALUES (1858, 53, 30);
INSERT INTO `sys_role_menu` VALUES (1859, 53, 27);
INSERT INTO `sys_role_menu` VALUES (1860, 53, 57);
INSERT INTO `sys_role_menu` VALUES (1861, 53, 71);
INSERT INTO `sys_role_menu` VALUES (1862, 53, 48);
INSERT INTO `sys_role_menu` VALUES (1863, 53, 72);
INSERT INTO `sys_role_menu` VALUES (1864, 53, 1);
INSERT INTO `sys_role_menu` VALUES (1865, 53, 7);
INSERT INTO `sys_role_menu` VALUES (1866, 53, 55);
INSERT INTO `sys_role_menu` VALUES (1867, 53, 56);
INSERT INTO `sys_role_menu` VALUES (1868, 53, 62);
INSERT INTO `sys_role_menu` VALUES (1869, 53, 15);
INSERT INTO `sys_role_menu` VALUES (1870, 53, 2);
INSERT INTO `sys_role_menu` VALUES (1871, 53, 61);
INSERT INTO `sys_role_menu` VALUES (1872, 53, 20);
INSERT INTO `sys_role_menu` VALUES (1873, 53, 21);
INSERT INTO `sys_role_menu` VALUES (1874, 53, 22);
INSERT INTO `sys_role_menu` VALUES (2247, 63, -1);
INSERT INTO `sys_role_menu` VALUES (2248, 63, 84);
INSERT INTO `sys_role_menu` VALUES (2249, 63, 85);
INSERT INTO `sys_role_menu` VALUES (2250, 63, 88);
INSERT INTO `sys_role_menu` VALUES (2251, 63, 87);
INSERT INTO `sys_role_menu` VALUES (2252, 64, 84);
INSERT INTO `sys_role_menu` VALUES (2253, 64, 89);
INSERT INTO `sys_role_menu` VALUES (2254, 64, 88);
INSERT INTO `sys_role_menu` VALUES (2255, 64, 87);
INSERT INTO `sys_role_menu` VALUES (2256, 64, 86);
INSERT INTO `sys_role_menu` VALUES (2257, 64, 85);
INSERT INTO `sys_role_menu` VALUES (2258, 65, 89);
INSERT INTO `sys_role_menu` VALUES (2259, 65, 88);
INSERT INTO `sys_role_menu` VALUES (2260, 65, 86);
INSERT INTO `sys_role_menu` VALUES (2262, 67, 48);
INSERT INTO `sys_role_menu` VALUES (2263, 68, 88);
INSERT INTO `sys_role_menu` VALUES (2264, 68, 87);
INSERT INTO `sys_role_menu` VALUES (2265, 69, 89);
INSERT INTO `sys_role_menu` VALUES (2266, 69, 88);
INSERT INTO `sys_role_menu` VALUES (2267, 69, 86);
INSERT INTO `sys_role_menu` VALUES (2268, 69, 87);
INSERT INTO `sys_role_menu` VALUES (2269, 69, 85);
INSERT INTO `sys_role_menu` VALUES (2270, 69, 84);
INSERT INTO `sys_role_menu` VALUES (2271, 70, 85);
INSERT INTO `sys_role_menu` VALUES (2272, 70, 89);
INSERT INTO `sys_role_menu` VALUES (2273, 70, 88);
INSERT INTO `sys_role_menu` VALUES (2274, 70, 87);
INSERT INTO `sys_role_menu` VALUES (2275, 70, 86);
INSERT INTO `sys_role_menu` VALUES (2276, 70, 84);
INSERT INTO `sys_role_menu` VALUES (2277, 71, 87);
INSERT INTO `sys_role_menu` VALUES (2278, 72, 59);
INSERT INTO `sys_role_menu` VALUES (2279, 73, 48);
INSERT INTO `sys_role_menu` VALUES (2280, 74, 88);
INSERT INTO `sys_role_menu` VALUES (2281, 74, 87);
INSERT INTO `sys_role_menu` VALUES (2282, 75, 88);
INSERT INTO `sys_role_menu` VALUES (2283, 75, 87);
INSERT INTO `sys_role_menu` VALUES (2284, 76, 85);
INSERT INTO `sys_role_menu` VALUES (2285, 76, 89);
INSERT INTO `sys_role_menu` VALUES (2286, 76, 88);
INSERT INTO `sys_role_menu` VALUES (2287, 76, 87);
INSERT INTO `sys_role_menu` VALUES (2288, 76, 86);
INSERT INTO `sys_role_menu` VALUES (2289, 76, 84);
INSERT INTO `sys_role_menu` VALUES (2292, 78, 88);
INSERT INTO `sys_role_menu` VALUES (2293, 78, 87);
INSERT INTO `sys_role_menu` VALUES (2294, 78, NULL);
INSERT INTO `sys_role_menu` VALUES (2295, 78, NULL);
INSERT INTO `sys_role_menu` VALUES (2296, 78, NULL);
INSERT INTO `sys_role_menu` VALUES (2308, 80, 87);
INSERT INTO `sys_role_menu` VALUES (2309, 80, 86);
INSERT INTO `sys_role_menu` VALUES (2310, 80, -1);
INSERT INTO `sys_role_menu` VALUES (2311, 80, 84);
INSERT INTO `sys_role_menu` VALUES (2312, 80, 85);
INSERT INTO `sys_role_menu` VALUES (2328, 79, 72);
INSERT INTO `sys_role_menu` VALUES (2329, 79, 48);
INSERT INTO `sys_role_menu` VALUES (2330, 79, 77);
INSERT INTO `sys_role_menu` VALUES (2331, 79, 84);
INSERT INTO `sys_role_menu` VALUES (2332, 79, 89);
INSERT INTO `sys_role_menu` VALUES (2333, 79, 88);
INSERT INTO `sys_role_menu` VALUES (2334, 79, 87);
INSERT INTO `sys_role_menu` VALUES (2335, 79, 86);
INSERT INTO `sys_role_menu` VALUES (2336, 79, 85);
INSERT INTO `sys_role_menu` VALUES (2337, 79, -1);
INSERT INTO `sys_role_menu` VALUES (2338, 77, 89);
INSERT INTO `sys_role_menu` VALUES (2339, 77, 88);
INSERT INTO `sys_role_menu` VALUES (2340, 77, 87);
INSERT INTO `sys_role_menu` VALUES (2341, 77, 86);
INSERT INTO `sys_role_menu` VALUES (2342, 77, 85);
INSERT INTO `sys_role_menu` VALUES (2343, 77, 84);
INSERT INTO `sys_role_menu` VALUES (2344, 77, 72);
INSERT INTO `sys_role_menu` VALUES (2345, 77, -1);
INSERT INTO `sys_role_menu` VALUES (2346, 77, 77);
INSERT INTO `sys_role_menu` VALUES (7030, 60, 84);
INSERT INTO `sys_role_menu` VALUES (7031, 60, 89);
INSERT INTO `sys_role_menu` VALUES (7032, 60, 88);
INSERT INTO `sys_role_menu` VALUES (7033, 60, 87);
INSERT INTO `sys_role_menu` VALUES (7034, 60, 86);
INSERT INTO `sys_role_menu` VALUES (7035, 60, 90);
INSERT INTO `sys_role_menu` VALUES (7036, 60, 85);
INSERT INTO `sys_role_menu` VALUES (7037, 60, -1);
INSERT INTO `sys_role_menu` VALUES (7038, 1, 12);
INSERT INTO `sys_role_menu` VALUES (7039, 1, 13);
INSERT INTO `sys_role_menu` VALUES (7040, 1, 14);
INSERT INTO `sys_role_menu` VALUES (7041, 1, 24);
INSERT INTO `sys_role_menu` VALUES (7042, 1, 25);
INSERT INTO `sys_role_menu` VALUES (7043, 1, 26);
INSERT INTO `sys_role_menu` VALUES (7044, 1, 55);
INSERT INTO `sys_role_menu` VALUES (7045, 1, 56);
INSERT INTO `sys_role_menu` VALUES (7046, 1, 62);
INSERT INTO `sys_role_menu` VALUES (7047, 1, 15);
INSERT INTO `sys_role_menu` VALUES (7048, 1, 61);
INSERT INTO `sys_role_menu` VALUES (7049, 1, 20);
INSERT INTO `sys_role_menu` VALUES (7050, 1, 21);
INSERT INTO `sys_role_menu` VALUES (7051, 1, 22);
INSERT INTO `sys_role_menu` VALUES (7052, 1, 74);
INSERT INTO `sys_role_menu` VALUES (7053, 1, 75);
INSERT INTO `sys_role_menu` VALUES (7054, 1, 76);
INSERT INTO `sys_role_menu` VALUES (7055, 1, 79);
INSERT INTO `sys_role_menu` VALUES (7056, 1, 80);
INSERT INTO `sys_role_menu` VALUES (7057, 1, 81);
INSERT INTO `sys_role_menu` VALUES (7058, 1, 83);
INSERT INTO `sys_role_menu` VALUES (7059, 1, 103);
INSERT INTO `sys_role_menu` VALUES (7060, 1, 104);
INSERT INTO `sys_role_menu` VALUES (7061, 1, 88);
INSERT INTO `sys_role_menu` VALUES (7062, 1, 89);
INSERT INTO `sys_role_menu` VALUES (7063, 1, 86);
INSERT INTO `sys_role_menu` VALUES (7064, 1, 87);
INSERT INTO `sys_role_menu` VALUES (7065, 1, 90);
INSERT INTO `sys_role_menu` VALUES (7066, 1, 92);
INSERT INTO `sys_role_menu` VALUES (7067, 1, 72);
INSERT INTO `sys_role_menu` VALUES (7068, 1, 6);
INSERT INTO `sys_role_menu` VALUES (7069, 1, 7);
INSERT INTO `sys_role_menu` VALUES (7070, 1, 2);
INSERT INTO `sys_role_menu` VALUES (7071, 1, 73);
INSERT INTO `sys_role_menu` VALUES (7072, 1, 3);
INSERT INTO `sys_role_menu` VALUES (7073, 1, 78);
INSERT INTO `sys_role_menu` VALUES (7074, 1, 71);
INSERT INTO `sys_role_menu` VALUES (7075, 1, 1);
INSERT INTO `sys_role_menu` VALUES (7076, 1, 85);
INSERT INTO `sys_role_menu` VALUES (7077, 1, 84);
INSERT INTO `sys_role_menu` VALUES (7078, 1, 77);
INSERT INTO `sys_role_menu` VALUES (7079, 1, 162);
INSERT INTO `sys_role_menu` VALUES (7080, 1, 167);
INSERT INTO `sys_role_menu` VALUES (7081, 1, 168);
INSERT INTO `sys_role_menu` VALUES (7082, 1, 169);
INSERT INTO `sys_role_menu` VALUES (7083, 1, 170);
INSERT INTO `sys_role_menu` VALUES (7084, 1, 171);
INSERT INTO `sys_role_menu` VALUES (7085, 1, 172);
INSERT INTO `sys_role_menu` VALUES (7086, 1, 173);
INSERT INTO `sys_role_menu` VALUES (7087, 1, 174);
INSERT INTO `sys_role_menu` VALUES (7088, 1, 175);
INSERT INTO `sys_role_menu` VALUES (7089, 1, 176);
INSERT INTO `sys_role_menu` VALUES (7090, 1, 177);
INSERT INTO `sys_role_menu` VALUES (7091, 1, 178);
INSERT INTO `sys_role_menu` VALUES (7092, 1, 179);
INSERT INTO `sys_role_menu` VALUES (7093, 1, 180);
INSERT INTO `sys_role_menu` VALUES (7094, 1, 181);
INSERT INTO `sys_role_menu` VALUES (7095, 1, 182);
INSERT INTO `sys_role_menu` VALUES (7096, 1, 163);
INSERT INTO `sys_role_menu` VALUES (7097, 1, 164);
INSERT INTO `sys_role_menu` VALUES (7098, 1, 165);
INSERT INTO `sys_role_menu` VALUES (7099, 1, 166);
INSERT INTO `sys_role_menu` VALUES (7100, 1, -1);
COMMIT;

-- ----------------------------
-- Table structure for sys_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_task`;
CREATE TABLE `sys_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cron_expression` varchar(255) DEFAULT NULL COMMENT 'cron表达式',
  `method_name` varchar(255) DEFAULT NULL COMMENT '任务调用的方法名',
  `is_concurrent` varchar(255) DEFAULT NULL COMMENT '任务是否有状态',
  `description` varchar(255) DEFAULT NULL COMMENT '任务描述',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `bean_class` varchar(255) DEFAULT NULL COMMENT '任务执行时调用哪个类的方法 包名+类名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `job_status` varchar(255) DEFAULT NULL COMMENT '任务状态',
  `job_group` varchar(255) DEFAULT NULL COMMENT '任务分组',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `spring_bean` varchar(255) DEFAULT NULL COMMENT 'Spring bean',
  `job_name` varchar(255) DEFAULT NULL COMMENT '任务名',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_task
-- ----------------------------
BEGIN;
INSERT INTO `sys_task` VALUES (2, '0/10 * * * * ?', 'run1', '1', '', '4028ea815a3d2a8c015a3d2f8d2a0002', 'com.bootdo.common.task.WelcomeJob', '2017-05-19 18:30:56', '0', 'group1', '2017-05-19 18:31:07', NULL, '', 'welcomJob');
INSERT INTO `sys_task` VALUES (8, '0/10 * * * * ?', NULL, NULL, '0 30 0 1 * ?\r\n清除无效文件 节省空间', NULL, 'com.bootdo.common.task.clearLogJob', NULL, '0', 'group2', NULL, NULL, NULL, 'clearLog');
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `name` varchar(100) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '所属部门',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(255) DEFAULT NULL COMMENT '状态 0:禁用，1:正常',
  `user_id_create` bigint(255) DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `sex` bigint(32) DEFAULT NULL COMMENT '性别',
  `birth` datetime DEFAULT NULL COMMENT '出身日期',
  `pic_id` bigint(32) DEFAULT NULL,
  `live_address` varchar(500) DEFAULT NULL COMMENT '现居住地',
  `hobby` varchar(255) DEFAULT NULL COMMENT '爱好',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '所在城市',
  `district` varchar(255) DEFAULT NULL COMMENT '所在地区',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信openid',
  `job` int(11) DEFAULT NULL COMMENT '职务',
  `receive_msg` int(11) DEFAULT NULL COMMENT '接收推送:0不接收 1接收',
  `headimg` varchar(255) DEFAULT NULL COMMENT '头像',
  `gzh_openid` varchar(50) DEFAULT NULL COMMENT '公众号openid',
  `user_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=172 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES (1, 'admin', '超级管理员', '27bd386e70f280e24c2f4f2a549b82cf', 9, 'admin@example.com', '18765432134', 1, 1, '2017-08-15 21:40:39', '2019-04-08 09:42:26', 96, '2018-11-30 00:00:00', 1, '1', '11', '北京市', '北京市市辖区', '东城区', NULL, 0, 0, NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=735 DEFAULT CHARSET=utf8 COMMENT='用户与角色对应关系';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` VALUES (734, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for t_msg
-- ----------------------------
DROP TABLE IF EXISTS `t_msg`;
CREATE TABLE `t_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `content` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '0未读 1已读',
  `userid` int(11) DEFAULT NULL COMMENT '消息接受者',
  `addtime` datetime DEFAULT NULL COMMENT '发送时间',
  `title` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='消息发送表';

-- ----------------------------
-- Records of t_msg
-- ----------------------------
BEGIN;
INSERT INTO `t_msg` VALUES (1, '[{\"pcontent\":\"2019032717332151\",\"pname\":\"项目编号\"},{\"pcontent\":\"12\",\"pname\":\"项目名称\"},{\"pcontent\":\"后勤管理处\",\"pname\":\"使用单位\"},{\"pcontent\":\"\",\"pname\":\"请与招标人联系办理合同签订事项\"}]', 0, 1, '2019-03-30 09:39:43', '中标通知', '');
INSERT INTO `t_msg` VALUES (2, '[{\"pcontent\":\"2019032717332151\",\"pname\":\"项目编号\"},{\"pcontent\":\"12\",\"pname\":\"项目名称\"},{\"pcontent\":\"后勤管理处\",\"pname\":\"使用单位\"},{\"pcontent\":\"\",\"pname\":\"请与招标人联系办理合同签订事项\"}]', 0, 1, '2019-03-30 09:41:26', '中标通知', '');
INSERT INTO `t_msg` VALUES (3, '[{\"pcontent\":\"2019032717332151\",\"pname\":\"项目编号\"},{\"pcontent\":\"12\",\"pname\":\"项目名称\"},{\"pcontent\":\"后勤管理处\",\"pname\":\"使用单位\"},{\"pcontent\":\"\",\"pname\":\"请与招标人联系办理合同签订事项\"}]', 0, 122, '2019-03-30 09:47:22', '中标通知', '');
INSERT INTO `t_msg` VALUES (4, '[{\"pcontent\":\"2019032717332151\",\"pname\":\"项目编号\"},{\"pcontent\":\"12\",\"pname\":\"项目名称\"},{\"pcontent\":\"后勤管理处\",\"pname\":\"使用单位\"},{\"pcontent\":\"\",\"pname\":\"请与招标人联系办理合同签订事项\"}]', 0, 122, '2019-03-30 09:48:41', '中标通知', '');
INSERT INTO `t_msg` VALUES (5, '[{\"pcontent\":\"2019032717332151\",\"pname\":\"项目编号\"},{\"pcontent\":\"12\",\"pname\":\"项目名称\"},{\"pcontent\":\"后勤管理处\",\"pname\":\"使用单位\"},{\"pcontent\":\"\",\"pname\":\"请与招标人联系办理合同签订事项\"}]', 0, 122, '2019-03-30 09:51:12', '中标通知', '');
INSERT INTO `t_msg` VALUES (6, '[{\"pcontent\":\"超级管理员\",\"pname\":\"申请人\"},{\"pcontent\":\"测试任务4\",\"pname\":\"申请项目\"},{\"pcontent\":\"2019-03-30 10:43\",\"pname\":\"申请时间\"},{\"pcontent\":\"待初审\",\"pname\":\"申请状态\"}]', 0, 122, '2019-03-30 10:43:36', '有申请项目待您审核', '');
INSERT INTO `t_msg` VALUES (7, '[{\"pcontent\":\"项目申报\",\"pname\":\"业务类型\"},{\"pcontent\":\"测试任务4\",\"pname\":\"项目名称\"},{\"pcontent\":\"未通过\",\"pname\":\"审核结果\"},{\"pcontent\":\"囤华飞\",\"pname\":\"审核人\"},{\"pcontent\":\"该项目描述不清晰，请改正\",\"pname\":\"审核意见\"}]', 0, 1, '2019-03-30 11:12:13', '您提交的任务有新的审核动态', '');
INSERT INTO `t_msg` VALUES (8, '[{\"pcontent\":\"项目申报\",\"pname\":\"业务类型\"},{\"pcontent\":\"测试任务4\",\"pname\":\"项目名称\"},{\"pcontent\":\"未通过\",\"pname\":\"审核结果\"},{\"pcontent\":\"囤华飞\",\"pname\":\"审核人\"},{\"pcontent\":\"该项目描述不清晰，请改正\",\"pname\":\"审核意见\"}]', 0, 122, '2019-03-30 11:15:00', '您提交的任务有新的审核动态', '');
INSERT INTO `t_msg` VALUES (9, '[{\"pcontent\":\"项目申报\",\"pname\":\"业务类型\"},{\"pcontent\":\"测试任务4\",\"pname\":\"项目名称\"},{\"pcontent\":\"未通过\",\"pname\":\"审核结果\"},{\"pcontent\":\"囤华飞\",\"pname\":\"审核人\"},{\"pcontent\":\"该项目描述不清晰，请改正\",\"pname\":\"审核意见\"}]', 0, 122, '2019-03-30 11:16:28', '您提交的任务有新的审核动态', '');
INSERT INTO `t_msg` VALUES (10, '[{\"pcontent\":\"项目申报\",\"pname\":\"业务类型\"},{\"pcontent\":\"测试任务4\",\"pname\":\"项目名称\"},{\"pcontent\":\"审核通过\",\"pname\":\"审核结果\"},{\"pcontent\":\"囤华飞\",\"pname\":\"审核人\"},{\"pcontent\":\"可以，通过\",\"pname\":\"审核意见\"}]', 0, 122, '2019-03-30 11:24:43', '您提交的任务有新的审核动态', '');
INSERT INTO `t_msg` VALUES (11, '[{\"pcontent\":\"囤华飞\",\"pname\":\"申请人\"},{\"pcontent\":\"测试任务4\",\"pname\":\"申请项目\"},{\"pcontent\":\"2019-03-30 10:43\",\"pname\":\"申请时间\"},{\"pcontent\":\"待复审\",\"pname\":\"申请状态\"}]', 0, 122, '2019-03-30 11:24:43', '有申请项目待您审核', '');
INSERT INTO `t_msg` VALUES (12, '[{\"pcontent\":\"项目申报\",\"pname\":\"业务类型\"},{\"pcontent\":\"测试任务4\",\"pname\":\"项目名称\"},{\"pcontent\":\"审核通过\",\"pname\":\"审核结果\"},{\"pcontent\":\"囤华飞\",\"pname\":\"审核人\"},{\"pcontent\":\"可以，通过\",\"pname\":\"审核意见\"}]', 0, 122, '2019-03-30 11:25:48', '您提交的任务有新的审核动态', '');
INSERT INTO `t_msg` VALUES (13, '[{\"pcontent\":\"囤华飞\",\"pname\":\"申请人\"},{\"pcontent\":\"测试任务4\",\"pname\":\"申请项目\"},{\"pcontent\":\"2019-03-30 10:43\",\"pname\":\"申请时间\"},{\"pcontent\":\"待复审\",\"pname\":\"申请状态\"}]', 0, 122, '2019-03-30 11:25:48', '有申请项目待您审核', '');
INSERT INTO `t_msg` VALUES (14, '[{\"pcontent\":\"项目申报\",\"pname\":\"业务类型\"},{\"pcontent\":\"测试任务4\",\"pname\":\"项目名称\"},{\"pcontent\":\"未通过\",\"pname\":\"审核结果\"},{\"pcontent\":\"囤华飞\",\"pname\":\"审核人\"},{\"pcontent\":\"该项目描述不清晰，请改正\",\"pname\":\"审核意见\"}]', 0, 122, '2019-03-30 11:26:22', '您提交的任务有新的审核动态', '');
INSERT INTO `t_msg` VALUES (15, '[{\"pcontent\":\"项目申报\",\"pname\":\"业务类型\"},{\"pcontent\":\"测试任务4\",\"pname\":\"项目名称\"},{\"pcontent\":\"未通过\",\"pname\":\"审核结果\"},{\"pcontent\":\"囤华飞\",\"pname\":\"审核人\"},{\"pcontent\":\"该项目描述不清晰，请改正\",\"pname\":\"审核意见\"}]', 0, 122, '2019-03-30 13:49:43', '您提交的任务有新的审核动态', '');
INSERT INTO `t_msg` VALUES (16, '[{\"pcontent\":\"囤华飞\",\"pname\":\"申请人\"},{\"pcontent\":\"测试任务4\",\"pname\":\"申请项目\"},{\"pcontent\":\"2019-03-30 10:43\",\"pname\":\"申请时间\"},{\"pcontent\":\"待初审\",\"pname\":\"申请状态\"}]', 0, 122, '2019-03-30 13:50:28', '有申请项目待您审核', '');
INSERT INTO `t_msg` VALUES (17, '[{\"pcontent\":\"项目申报\",\"pname\":\"业务类型\"},{\"pcontent\":\"测试任务4\",\"pname\":\"项目名称\"},{\"pcontent\":\"审核通过\",\"pname\":\"审核结果\"},{\"pcontent\":\"囤华飞\",\"pname\":\"审核人\"},{\"pcontent\":\"一级通过\",\"pname\":\"审核意见\"}]', 0, 122, '2019-03-30 13:50:47', '您提交的任务有新的审核动态', '');
INSERT INTO `t_msg` VALUES (18, '[{\"pcontent\":\"囤华飞\",\"pname\":\"申请人\"},{\"pcontent\":\"测试任务4\",\"pname\":\"申请项目\"},{\"pcontent\":\"2019-03-30 10:43\",\"pname\":\"申请时间\"},{\"pcontent\":\"待复审\",\"pname\":\"申请状态\"}]', 0, 122, '2019-03-30 13:50:47', '有申请项目待您审核', '');
INSERT INTO `t_msg` VALUES (19, '[{\"pcontent\":\"项目申报\",\"pname\":\"业务类型\"},{\"pcontent\":\"测试任务4\",\"pname\":\"项目名称\"},{\"pcontent\":\"审核通过\",\"pname\":\"审核结果\"},{\"pcontent\":\"囤华飞\",\"pname\":\"审核人\"},{\"pcontent\":\"一级通过\",\"pname\":\"审核意见\"}]', 0, 122, '2019-03-30 15:28:09', '您提交的任务有新的审核动态', '');
INSERT INTO `t_msg` VALUES (20, '[{\"pcontent\":\"测试任务4\",\"pname\":\"标题\"},{\"pcontent\":\"2019-03-30 10:43\",\"pname\":\"日期\"},{\"pcontent\":\"这是待审核的项目内容，我修改后了\",\"pname\":\"内容\"}]', 0, 122, '2019-03-30 15:28:09', '邀请提醒，有新项目请您投标', '');
INSERT INTO `t_msg` VALUES (21, '[{\"pcontent\":\"201903271633254\",\"pname\":\"项目编号\"},{\"pcontent\":\"关于测试项目的设备采购计划\",\"pname\":\"项目名称\"},{\"pcontent\":\"后勤管理处\",\"pname\":\"使用单位\"},{\"pcontent\":\"\",\"pname\":\"请与招标人联系办理合同签订事项\"}]', 0, 167, '2019-04-09 10:19:25', '中标通知', '');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
