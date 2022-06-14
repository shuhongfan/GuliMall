/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.120.20
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 192.168.120.20:3306
 Source Schema         : gulimall_ums

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 14/06/2022 18:09:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ums_growth_change_history
-- ----------------------------
DROP TABLE IF EXISTS `ums_growth_change_history`;
CREATE TABLE `ums_growth_change_history`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(0) NULL DEFAULT NULL COMMENT 'member_id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT 'create_time',
  `change_count` int(0) NULL DEFAULT NULL COMMENT '改变的值（正负计数）',
  `note` varchar(0) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `source_type` tinyint(0) NULL DEFAULT NULL COMMENT '积分来源[0-购物，1-管理员修改]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '成长值变化历史记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_growth_change_history
-- ----------------------------

-- ----------------------------
-- Table structure for ums_integration_change_history
-- ----------------------------
DROP TABLE IF EXISTS `ums_integration_change_history`;
CREATE TABLE `ums_integration_change_history`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(0) NULL DEFAULT NULL COMMENT 'member_id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT 'create_time',
  `change_count` int(0) NULL DEFAULT NULL COMMENT '变化的值',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `source_tyoe` tinyint(0) NULL DEFAULT NULL COMMENT '来源[0->购物；1->管理员修改;2->活动]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '积分变化历史记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_integration_change_history
-- ----------------------------

-- ----------------------------
-- Table structure for ums_member
-- ----------------------------
DROP TABLE IF EXISTS `ums_member`;
CREATE TABLE `ums_member`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `level_id` bigint(0) NULL DEFAULT NULL COMMENT '会员等级id',
  `username` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `mobile` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号码',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `header` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` tinyint(0) NULL DEFAULT NULL COMMENT '性别',
  `birth` date NULL DEFAULT NULL COMMENT '生日',
  `city` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所在城市',
  `job` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职业',
  `sign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个性签名',
  `source_type` tinyint(0) NULL DEFAULT NULL COMMENT '用户来源',
  `integration` int(0) NULL DEFAULT NULL COMMENT '积分',
  `growth` int(0) NULL DEFAULT NULL COMMENT '成长值',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '启用状态',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '注册时间',
  `social_uid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '社交用户的唯一id',
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '访问令牌',
  `expires_in` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '访问令牌的时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member
-- ----------------------------
INSERT INTO `ums_member` VALUES (1, 1, 'shf', '$2a$10$XOE60ibwcd3K2CYjN8h29.n1PNzVgTHCotZWn4g6QPAEfUJZgWbg2', 'shf', '13437191068', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-03 20:52:11', NULL, NULL, '0');
INSERT INTO `ums_member` VALUES (2, NULL, NULL, NULL, 'shuhongfan', NULL, NULL, 'https://tvax4.sinaimg.cn/crop.0.0.896.896.50/d48f6d4dly8gy0objdeooj20ow0owwf2.jpg?KID=imgbed,tva&Expires=1654526744&ssig=N3UgetcJ9w', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-06 19:45:44', '3566169421', '2.00dZR2tDWcifWB3e70aa057e0lZcfb', '157679999');
INSERT INTO `ums_member` VALUES (3, 1, 'ceshi001', '$2a$10$F/9id5oIrbcVwmzakB0/GOVvAkbcMcDTnNdszIMvspmpqNNC6aHyy', 'ceshi001', '13437998988', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-09 19:50:52', NULL, NULL, '0');
INSERT INTO `ums_member` VALUES (4, 1, 'ceshi002', '$2a$10$nwNTwNsUATzbCZ3p38q7YOnJMq0eC.gtChNi2cV7RknidPghfHHb2', 'ceshi002', '13437575696', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-13 08:53:09', NULL, NULL, '0');
INSERT INTO `ums_member` VALUES (5, 1, 'ceshi003', '$2a$10$MK9BOTSv8jNu7VgiEq/UnebxDLTA4ywiCDESupSAtVcKy0cPhRSue', 'ceshi003', '13456565689', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-13 09:10:57', NULL, NULL, '0');
INSERT INTO `ums_member` VALUES (6, 1, 'ceshi004', '$2a$10$OwZgtjpoXdSYGLQ3NwBdlea5zue3O.fNw87k4eTY8tudhLf6/KtKC', 'ceshi004', '13437575698', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-13 09:30:52', NULL, NULL, '0');
INSERT INTO `ums_member` VALUES (7, 1, 'ceshi006', '$2a$10$uQ3keBY2vvfEPx0jMjcKouYwGTEpt82yOLeoR9fI9xGi8pp72Q29W', 'ceshi006', '13436659695', NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-13 10:49:18', NULL, NULL, '0');

-- ----------------------------
-- Table structure for ums_member_collect_spu
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_collect_spu`;
CREATE TABLE `ums_member_collect_spu`  (
  `id` bigint(0) NOT NULL COMMENT 'id',
  `member_id` bigint(0) NULL DEFAULT NULL COMMENT '会员id',
  `spu_id` bigint(0) NULL DEFAULT NULL COMMENT 'spu_id',
  `spu_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spu_name',
  `spu_img` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spu_img',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT 'create_time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员收藏的商品' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_collect_spu
-- ----------------------------

-- ----------------------------
-- Table structure for ums_member_collect_subject
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_collect_subject`;
CREATE TABLE `ums_member_collect_subject`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `subject_id` bigint(0) NULL DEFAULT NULL COMMENT 'subject_id',
  `subject_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'subject_name',
  `subject_img` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'subject_img',
  `subject_urll` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '活动url',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员收藏的专题活动' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_collect_subject
-- ----------------------------

-- ----------------------------
-- Table structure for ums_member_level
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_level`;
CREATE TABLE `ums_member_level`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '等级名称',
  `growth_point` int(0) NULL DEFAULT NULL COMMENT '等级需要的成长值',
  `default_status` tinyint(0) NULL DEFAULT NULL COMMENT '是否为默认等级[0->不是；1->是]',
  `free_freight_point` decimal(18, 4) NULL DEFAULT NULL COMMENT '免运费标准',
  `comment_growth_point` int(0) NULL DEFAULT NULL COMMENT '每次评价获取的成长值',
  `priviledge_free_freight` tinyint(0) NULL DEFAULT NULL COMMENT '是否有免邮特权',
  `priviledge_member_price` tinyint(0) NULL DEFAULT NULL COMMENT '是否有会员价格特权',
  `priviledge_birthday` tinyint(0) NULL DEFAULT NULL COMMENT '是否有生日特权',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员等级' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_level
-- ----------------------------
INSERT INTO `ums_member_level` VALUES (1, '普通会员', 0, 1, 299.0000, 10, 0, 0, 1, '初级会员');
INSERT INTO `ums_member_level` VALUES (2, '铜牌会员', 3000, 0, 279.0000, 30, 0, 1, 1, '铜牌会员');
INSERT INTO `ums_member_level` VALUES (3, '银牌会员', 5000, 0, 229.0000, 50, 0, 1, 1, '银牌会员');

-- ----------------------------
-- Table structure for ums_member_login_log
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_login_log`;
CREATE TABLE `ums_member_login_log`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(0) NULL DEFAULT NULL COMMENT 'member_id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip',
  `city` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'city',
  `login_type` tinyint(1) NULL DEFAULT NULL COMMENT '登录类型[1-web，2-app]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员登录记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_login_log
-- ----------------------------

-- ----------------------------
-- Table structure for ums_member_receive_address
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_receive_address`;
CREATE TABLE `ums_member_receive_address`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(0) NULL DEFAULT NULL COMMENT 'member_id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货人姓名',
  `phone` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮政编码',
  `province` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省份/直辖市',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '城市',
  `region` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区',
  `detail_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址(街道)',
  `areacode` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省市区代码',
  `default_status` tinyint(1) NULL DEFAULT NULL COMMENT '是否默认',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员收货地址' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_receive_address
-- ----------------------------
INSERT INTO `ums_member_receive_address` VALUES (1, 1, '舒洪凡 家庭', '13437111111', NULL, '湖北省', '武汉市', '洪山区', '关山大道500号', '43000000', NULL);
INSERT INTO `ums_member_receive_address` VALUES (2, 1, '舒洪凡 学校', '13433366999', NULL, '湖北省', '武汉市', '武昌区', '徐东大街1号', '43000000', 1);
INSERT INTO `ums_member_receive_address` VALUES (3, 2, '舒洪凡 家庭', '13437111111', NULL, '湖北省', '武汉市', '洪山区', '关山大道500号', '43000000', NULL);
INSERT INTO `ums_member_receive_address` VALUES (4, 2, '舒洪凡 学校', '13433366999', NULL, '湖北省', '武汉市', '武昌区', '徐东大街1号', '43000000', 1);
INSERT INTO `ums_member_receive_address` VALUES (7, 2, '张三', '13433333333', NULL, '山东省', '威海市', '环翠区', '委员会', NULL, NULL);
INSERT INTO `ums_member_receive_address` VALUES (8, 2, '张三', '13433333333', NULL, '广东省', '惠州市', '罗阳镇', '委员会', NULL, NULL);
INSERT INTO `ums_member_receive_address` VALUES (9, 3, '张三', '13433333333', NULL, '湖北省', '武汉市', '洪山区', '委员会', NULL, NULL);
INSERT INTO `ums_member_receive_address` VALUES (10, 4, '张三', '13433333333', NULL, '湖北省', '武汉市', '武昌区', '委员会', NULL, 1);
INSERT INTO `ums_member_receive_address` VALUES (11, 5, '张三', '13433333333', NULL, '湖北省', '武汉市', '硚口区', '委员会', NULL, 1);
INSERT INTO `ums_member_receive_address` VALUES (12, 6, '张三', '13433333333', NULL, '湖北省', '武汉市', '江岸区', '测试地址', NULL, 1);
INSERT INTO `ums_member_receive_address` VALUES (13, 7, '张三', '13433333333', NULL, '湖北省', '武汉市', '蔡甸区', '测试地址', NULL, 1);

-- ----------------------------
-- Table structure for ums_member_statistics_info
-- ----------------------------
DROP TABLE IF EXISTS `ums_member_statistics_info`;
CREATE TABLE `ums_member_statistics_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(0) NULL DEFAULT NULL COMMENT '会员id',
  `consume_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '累计消费金额',
  `coupon_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '累计优惠金额',
  `order_count` int(0) NULL DEFAULT NULL COMMENT '订单数量',
  `coupon_count` int(0) NULL DEFAULT NULL COMMENT '优惠券数量',
  `comment_count` int(0) NULL DEFAULT NULL COMMENT '评价数',
  `return_order_count` int(0) NULL DEFAULT NULL COMMENT '退货数量',
  `login_count` int(0) NULL DEFAULT NULL COMMENT '登录次数',
  `attend_count` int(0) NULL DEFAULT NULL COMMENT '关注数量',
  `fans_count` int(0) NULL DEFAULT NULL COMMENT '粉丝数量',
  `collect_product_count` int(0) NULL DEFAULT NULL COMMENT '收藏的商品数量',
  `collect_subject_count` int(0) NULL DEFAULT NULL COMMENT '收藏的专题活动数量',
  `collect_comment_count` int(0) NULL DEFAULT NULL COMMENT '收藏的评论数量',
  `invite_friend_count` int(0) NULL DEFAULT NULL COMMENT '邀请的朋友数量',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '会员统计信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ums_member_statistics_info
-- ----------------------------

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

SET FOREIGN_KEY_CHECKS = 1;
