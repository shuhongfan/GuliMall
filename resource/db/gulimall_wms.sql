/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.120.20
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 192.168.120.20:3306
 Source Schema         : gulimall_wms

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 14/06/2022 18:09:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for undo_log
-- ----------------------------
DROP TABLE IF EXISTS `undo_log`;
CREATE TABLE `undo_log`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `branch_id` bigint(0) NOT NULL,
  `xid` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `context` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rollback_info` longblob NOT NULL,
  `log_status` int(0) NOT NULL,
  `log_created` datetime(0) NOT NULL,
  `log_modified` datetime(0) NOT NULL,
  `ext` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ux_undo_log`(`xid`, `branch_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of undo_log
-- ----------------------------

-- ----------------------------
-- Table structure for wms_purchase
-- ----------------------------
DROP TABLE IF EXISTS `wms_purchase`;
CREATE TABLE `wms_purchase`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `assignee_id` bigint(0) NULL DEFAULT NULL,
  `assignee_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `priority` int(0) NULL DEFAULT NULL,
  `status` int(0) NULL DEFAULT NULL,
  `ware_id` bigint(0) NULL DEFAULT NULL,
  `amount` decimal(18, 4) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_purchase
-- ----------------------------
INSERT INTO `wms_purchase` VALUES (1, 3, 'shf', '13433333333', 1, 3, NULL, NULL, '2022-06-02 08:50:28', '2022-06-02 09:04:25');
INSERT INTO `wms_purchase` VALUES (2, 3, 'shf', '13433333333', 1, 3, NULL, NULL, '2022-06-09 19:44:46', '2022-06-09 19:46:32');
INSERT INTO `wms_purchase` VALUES (4, 3, 'shf', '13433333333', 1, 3, NULL, NULL, '2022-06-13 08:35:14', '2022-06-13 08:50:51');
INSERT INTO `wms_purchase` VALUES (5, 3, 'shf', '13433333333', 1, 3, NULL, NULL, '2022-06-13 09:25:54', '2022-06-13 09:27:18');
INSERT INTO `wms_purchase` VALUES (6, 3, 'shf', '13433333333', 1, 3, NULL, NULL, '2022-06-13 10:44:10', '2022-06-13 10:45:29');

-- ----------------------------
-- Table structure for wms_purchase_detail
-- ----------------------------
DROP TABLE IF EXISTS `wms_purchase_detail`;
CREATE TABLE `wms_purchase_detail`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT,
  `purchase_id` bigint(0) NULL DEFAULT NULL COMMENT '?????????id',
  `sku_id` bigint(0) NULL DEFAULT NULL COMMENT '????????????id',
  `sku_num` int(0) NULL DEFAULT NULL COMMENT '????????????',
  `sku_price` decimal(18, 4) NULL DEFAULT NULL COMMENT '????????????',
  `ware_id` bigint(0) NULL DEFAULT NULL COMMENT '??????id',
  `status` int(0) NULL DEFAULT NULL COMMENT '??????[0?????????1????????????2???????????????3????????????4????????????]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_purchase_detail
-- ----------------------------
INSERT INTO `wms_purchase_detail` VALUES (1, 1, 27, 100, NULL, 1, 3);
INSERT INTO `wms_purchase_detail` VALUES (2, 1, 30, 150, NULL, 1, 3);
INSERT INTO `wms_purchase_detail` VALUES (3, 2, 45, 100, NULL, 1, 3);
INSERT INTO `wms_purchase_detail` VALUES (4, 2, 45, 150, NULL, 1, 3);
INSERT INTO `wms_purchase_detail` VALUES (7, 4, 55, 100, NULL, 1, 3);
INSERT INTO `wms_purchase_detail` VALUES (8, 5, 57, 120, NULL, 1, 3);
INSERT INTO `wms_purchase_detail` VALUES (9, 5, 58, 130, NULL, 1, 3);
INSERT INTO `wms_purchase_detail` VALUES (10, 6, 61, 120, NULL, 1, 3);
INSERT INTO `wms_purchase_detail` VALUES (11, 6, 62, 150, NULL, 1, 3);

-- ----------------------------
-- Table structure for wms_ware_info
-- ----------------------------
DROP TABLE IF EXISTS `wms_ware_info`;
CREATE TABLE `wms_ware_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '?????????',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
  `areacode` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_ware_info
-- ----------------------------
INSERT INTO `wms_ware_info` VALUES (1, '????????????', '????????????', '430000');
INSERT INTO `wms_ware_info` VALUES (2, '????????????', '??????', '0001');
INSERT INTO `wms_ware_info` VALUES (3, '????????????', '??????', '0002');

-- ----------------------------
-- Table structure for wms_ware_order_task
-- ----------------------------
DROP TABLE IF EXISTS `wms_ware_order_task`;
CREATE TABLE `wms_ware_order_task`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(0) NULL DEFAULT NULL COMMENT 'order_id',
  `order_sn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'order_sn',
  `consignee` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '?????????',
  `consignee_tel` char(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '???????????????',
  `delivery_address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
  `order_comment` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
  `payment_way` tinyint(1) NULL DEFAULT NULL COMMENT '??????????????? 1:???????????? 2:???????????????',
  `task_status` tinyint(0) NULL DEFAULT NULL COMMENT '????????????',
  `order_body` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
  `tracking_no` char(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '????????????',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT 'create_time',
  `ware_id` bigint(0) NULL DEFAULT NULL COMMENT '??????id',
  `task_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '???????????????',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '???????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_ware_order_task
-- ----------------------------
INSERT INTO `wms_ware_order_task` VALUES (1, NULL, '202206051912154101533406339932356610', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-05 19:12:16', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (3, NULL, '202206061508000041533707258570006529', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-06 15:08:00', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (4, NULL, '202206061511058151533708037922021378', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-06 15:11:06', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (5, NULL, '202206061519493781533710233942114305', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-06 15:19:50', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (6, NULL, '202206061523210031533711121549176834', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-06 15:23:21', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (7, NULL, '202206090900057411534701836013989889', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-09 09:00:06', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (8, NULL, '202206091606325101534809154701537282', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-09 16:06:33', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (10, NULL, '202206091612057741534810552465928193', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-09 16:12:06', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (11, NULL, '202206091628116581534814603723169794', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-09 16:28:12', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (13, NULL, '202206092002208631534868497144741889', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-09 20:02:21', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (15, NULL, '202206130855334491536150245354893313', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-13 08:55:34', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (18, NULL, '202206130932229921536159512833048577', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-13 09:32:23', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (20, NULL, '202206131050465081536179240834187266', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-13 10:50:47', NULL, NULL);
INSERT INTO `wms_ware_order_task` VALUES (21, NULL, '202206141628409741536626666015633410', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-14 16:28:42', NULL, NULL);

-- ----------------------------
-- Table structure for wms_ware_order_task_detail
-- ----------------------------
DROP TABLE IF EXISTS `wms_ware_order_task_detail`;
CREATE TABLE `wms_ware_order_task_detail`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(0) NULL DEFAULT NULL COMMENT 'sku_id',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'sku_name',
  `sku_num` int(0) NULL DEFAULT NULL COMMENT '????????????',
  `task_id` bigint(0) NULL DEFAULT NULL COMMENT '?????????id',
  `ware_id` bigint(0) NULL DEFAULT NULL COMMENT '??????id',
  `lock_status` int(0) NULL DEFAULT NULL COMMENT '1-?????????  2-?????????  3-??????',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '???????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_ware_order_task_detail
-- ----------------------------
INSERT INTO `wms_ware_order_task_detail` VALUES (1, 30, '', 3, 1, 1, 2);
INSERT INTO `wms_ware_order_task_detail` VALUES (2, 30, '', 1, 3, 1, 2);
INSERT INTO `wms_ware_order_task_detail` VALUES (3, 30, '', 1, 4, 1, 2);
INSERT INTO `wms_ware_order_task_detail` VALUES (4, 27, '', 1, 5, 1, 2);
INSERT INTO `wms_ware_order_task_detail` VALUES (5, 30, '', 1, 6, 1, 1);
INSERT INTO `wms_ware_order_task_detail` VALUES (6, 27, '', 2, 7, 1, 2);
INSERT INTO `wms_ware_order_task_detail` VALUES (7, 27, '', 1, 8, 1, 2);
INSERT INTO `wms_ware_order_task_detail` VALUES (9, 27, '', 1, 10, 1, 2);
INSERT INTO `wms_ware_order_task_detail` VALUES (10, 27, '', 1, 11, 1, 1);
INSERT INTO `wms_ware_order_task_detail` VALUES (12, 45, '', 1, 13, 1, 1);
INSERT INTO `wms_ware_order_task_detail` VALUES (14, 55, '', 2, 15, 1, 1);
INSERT INTO `wms_ware_order_task_detail` VALUES (15, 58, '', 1, 18, 1, 1);
INSERT INTO `wms_ware_order_task_detail` VALUES (16, 61, '', 2, 20, 1, 1);
INSERT INTO `wms_ware_order_task_detail` VALUES (17, 27, '', 1, 21, 1, 2);

-- ----------------------------
-- Table structure for wms_ware_sku
-- ----------------------------
DROP TABLE IF EXISTS `wms_ware_sku`;
CREATE TABLE `wms_ware_sku`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` bigint(0) NULL DEFAULT NULL COMMENT 'sku_id',
  `ware_id` bigint(0) NULL DEFAULT NULL COMMENT '??????id',
  `stock` int(0) NULL DEFAULT NULL COMMENT '?????????',
  `sku_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'sku_name',
  `stock_locked` int(0) NULL DEFAULT 0 COMMENT '????????????',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sku_id`(`sku_id`) USING BTREE,
  INDEX `ware_id`(`ware_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '????????????' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wms_ware_sku
-- ----------------------------
INSERT INTO `wms_ware_sku` VALUES (1, 27, 1, 100, 'Apple iPhone 13 (A2634) ????????? 4GB 128G', 1);
INSERT INTO `wms_ware_sku` VALUES (2, 30, 1, 150, 'Apple iPhone 13 (A2634) ????????? 4GB 128G', 1);
INSERT INTO `wms_ware_sku` VALUES (3, 45, 1, 250, ' vivo iQOO Neo5 SE ????????? 8GB 128G ?????? 8G+256G ?????????', 1);
INSERT INTO `wms_ware_sku` VALUES (4, 55, 1, 100, 'OPPO Reno8 ????????? 80W???????????? 5000????????????????????? 3200????????????????????? ???????????? 5G?????? ????????? 12GB 8+128 ??????  12GB  8+128', 2);
INSERT INTO `wms_ware_sku` VALUES (5, 57, 1, 120, 'Redmi Note 11 Pro 5G ??????AMOLED????????? 1????????? 67W?????? VC???????????? ???????????? 6GB 128G ??????  ????????????  6GB 128G', 0);
INSERT INTO `wms_ware_sku` VALUES (6, 58, 1, 130, 'Redmi Note 11 Pro 5G ??????AMOLED????????? 1????????? 67W?????? VC???????????? ???????????? 8GB 128G ??????  ????????????  8GB  128G', 1);
INSERT INTO `wms_ware_sku` VALUES (7, 61, 1, 120, '??????X30 ??????6nm??????5G??? 66W???????????? 120Hz????????? ???????????? ?????? 8GB 128G ??????  ??????  8GB  128G', 2);
INSERT INTO `wms_ware_sku` VALUES (8, 62, 1, 150, '??????X30 ??????6nm??????5G??? 66W???????????? 120Hz????????? ???????????? ?????? 8GB 128G ??????  ??????  8GB  128G', 0);

SET FOREIGN_KEY_CHECKS = 1;
