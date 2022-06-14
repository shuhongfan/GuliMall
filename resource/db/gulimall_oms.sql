/*
 Navicat Premium Data Transfer

 Source Server         : 192.168.120.20
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 192.168.120.20:3306
 Source Schema         : gulimall_oms

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 14/06/2022 18:08:39
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for mq_message
-- ----------------------------
DROP TABLE IF EXISTS `mq_message`;
CREATE TABLE `mq_message`  (
  `message_id` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `to_exchane` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `routing_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `class_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `message_status` int(0) NULL DEFAULT 0 COMMENT '0-新建 1-已发送 2-错误抵达 3-已抵达',
  `create_time` datetime(0) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mq_message
-- ----------------------------

-- ----------------------------
-- Table structure for oms_order
-- ----------------------------
DROP TABLE IF EXISTS `oms_order`;
CREATE TABLE `oms_order`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `member_id` bigint(0) NULL DEFAULT NULL COMMENT 'member_id',
  `order_sn` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单号',
  `coupon_id` bigint(0) NULL DEFAULT NULL COMMENT '使用的优惠券',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT 'create_time',
  `member_username` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `total_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '订单总额',
  `pay_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '应付总额',
  `freight_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '运费金额',
  `promotion_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '促销优化金额（促销价、满减、阶梯价）',
  `integration_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '积分抵扣金额',
  `coupon_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '优惠券抵扣金额',
  `discount_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '后台调整订单使用的折扣金额',
  `pay_type` tinyint(0) NULL DEFAULT NULL COMMENT '支付方式【1->支付宝；2->微信；3->银联； 4->货到付款；】',
  `source_type` tinyint(0) NULL DEFAULT NULL COMMENT '订单来源[0->PC订单；1->app订单]',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '订单状态【0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单】',
  `delivery_company` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流公司(配送方式)',
  `delivery_sn` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物流单号',
  `auto_confirm_day` int(0) NULL DEFAULT NULL COMMENT '自动确认时间（天）',
  `integration` int(0) NULL DEFAULT NULL COMMENT '可以获得的积分',
  `growth` int(0) NULL DEFAULT NULL COMMENT '可以获得的成长值',
  `bill_type` tinyint(0) NULL DEFAULT NULL COMMENT '发票类型[0->不开发票；1->电子发票；2->纸质发票]',
  `bill_header` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发票抬头',
  `bill_content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发票内容',
  `bill_receiver_phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收票人电话',
  `bill_receiver_email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收票人邮箱',
  `receiver_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货人姓名',
  `receiver_phone` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货人电话',
  `receiver_post_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货人邮编',
  `receiver_province` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省份/直辖市',
  `receiver_city` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '城市',
  `receiver_region` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '区',
  `receiver_detail_address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址',
  `note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单备注',
  `confirm_status` tinyint(0) NULL DEFAULT NULL COMMENT '确认收货状态[0->未确认；1->已确认]',
  `delete_status` tinyint(0) NULL DEFAULT NULL COMMENT '删除状态【0->未删除；1->已删除】',
  `use_integration` int(0) NULL DEFAULT NULL COMMENT '下单时使用的积分',
  `payment_time` datetime(0) NULL DEFAULT NULL COMMENT '支付时间',
  `delivery_time` datetime(0) NULL DEFAULT NULL COMMENT '发货时间',
  `receive_time` datetime(0) NULL DEFAULT NULL COMMENT '确认收货时间',
  `comment_time` datetime(0) NULL DEFAULT NULL COMMENT '评价时间',
  `modify_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_sn`(`order_sn`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 138824 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order
-- ----------------------------
INSERT INTO `oms_order` VALUES (1, 1, '202206051912154101533406339932356610', NULL, '2022-06-05 19:12:16', 'shuhongfan', 17397.0000, 17431.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, 4, NULL, NULL, 7, 17397, 17397, NULL, NULL, NULL, NULL, NULL, '舒洪凡 学校', '13433366999', NULL, '湖北省', '武汉市', '武昌区', '徐东大街1号', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, '2022-06-05 19:12:16');
INSERT INTO `oms_order` VALUES (3, 1, '202206061508000041533707258570006529', NULL, '2022-06-06 15:08:00', 'shuhongfan', 5799.0000, 5833.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, 4, NULL, NULL, 7, 5799, 5799, NULL, NULL, NULL, NULL, NULL, '舒洪凡 学校', '13433366999', NULL, '湖北省', '武汉市', '武昌区', '徐东大街1号', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, '2022-06-06 15:08:00');
INSERT INTO `oms_order` VALUES (4, 1, '202206061511058151533708037922021378', NULL, '2022-06-06 15:11:06', 'shuhongfan', 5799.0000, 5833.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, 4, NULL, NULL, 7, 5799, 5799, NULL, NULL, NULL, NULL, NULL, '舒洪凡 学校', '13433366999', NULL, '湖北省', '武汉市', '武昌区', '徐东大街1号', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, '2022-06-06 15:11:06');
INSERT INTO `oms_order` VALUES (5, 1, '202206061519493781533710233942114305', NULL, '2022-06-06 15:19:50', 'shuhongfan', 5799.0000, 5833.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, 4, NULL, NULL, 7, 5799, 5799, NULL, NULL, NULL, NULL, NULL, '舒洪凡 学校', '13433366999', NULL, '湖北省', '武汉市', '武昌区', '徐东大街1号', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, '2022-06-06 15:19:50');
INSERT INTO `oms_order` VALUES (6, 1, '202206061523210031533711121549176834', NULL, '2022-06-06 15:23:21', 'shuhongfan', 5799.0000, 5833.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, 1, NULL, 1, NULL, NULL, 7, 5799, 5799, NULL, NULL, NULL, NULL, NULL, '舒洪凡 家庭', '13437111111', NULL, '湖北省', '武汉市', '洪山区', '关山大道500号', NULL, 0, 0, NULL, '2022-06-06 07:23:39', NULL, NULL, NULL, '2022-06-06 07:23:39');
INSERT INTO `oms_order` VALUES (8, 2, '202206090900057411534701836013989889', NULL, '2022-06-09 09:00:06', NULL, 11598.0000, 11632.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, 4, NULL, NULL, 7, 11598, 11598, NULL, NULL, NULL, NULL, NULL, '舒洪凡 学校', '13433366999', NULL, '湖北省', '武汉市', '武昌区', '徐东大街1号', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, '2022-06-09 09:00:06');
INSERT INTO `oms_order` VALUES (9, 2, '202206091606325101534809154701537282', NULL, '2022-06-09 16:06:33', NULL, 5799.0000, 5833.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, 4, NULL, NULL, 7, 5799, 5799, NULL, NULL, NULL, NULL, NULL, '张三', '13433333333', NULL, '广东省', '惠州市', '罗阳镇', '委员会', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, '2022-06-09 16:06:33');
INSERT INTO `oms_order` VALUES (11, 2, '202206091612057741534810552465928193', NULL, '2022-06-09 16:12:06', NULL, 5799.0000, 5833.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, 4, NULL, NULL, 7, 5799, 5799, NULL, NULL, NULL, NULL, NULL, '张三', '13433333333', NULL, '山东省', '威海市', '环翠区', '委员会', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, '2022-06-09 16:12:06');
INSERT INTO `oms_order` VALUES (12, 2, '202206091628116581534814603723169794', NULL, '2022-06-09 16:28:12', NULL, 5799.0000, 5833.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, 1, NULL, 1, NULL, NULL, 7, 5799, 5799, NULL, NULL, NULL, NULL, NULL, '舒洪凡 学校', '13433366999', NULL, '湖北省', '武汉市', '武昌区', '徐东大街1号', NULL, 0, 0, NULL, '2022-06-09 08:28:55', NULL, NULL, NULL, '2022-06-09 08:28:55');
INSERT INTO `oms_order` VALUES (120484, 3, '202206092002208631534868497144741889', NULL, '2022-06-09 20:02:21', 'ceshi001', 2299.0000, 2333.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, 1, NULL, 1, NULL, NULL, 7, 2299, 2299, NULL, NULL, NULL, NULL, NULL, '张三', '13433333333', NULL, '湖北省', '武汉市', '洪山区', '委员会', NULL, 0, 0, NULL, '2022-06-09 12:03:07', NULL, NULL, NULL, '2022-06-09 12:03:07');
INSERT INTO `oms_order` VALUES (138809, 2, '202206092059356331534882903618510850', NULL, '2022-06-09 20:59:36', NULL, NULL, 2199.0000, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2022-06-09 13:00:07', NULL, NULL, NULL, '2022-06-09 13:00:07');
INSERT INTO `oms_order` VALUES (138810, 2, '202206092111510811534885988327776257', NULL, '2022-06-09 21:11:51', NULL, NULL, 2199.0000, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '舒洪凡 学校', '13433366999', NULL, '湖北省', '武汉市', '武昌区', '徐东大街1号', NULL, NULL, NULL, NULL, '2022-06-09 13:12:10', NULL, NULL, NULL, '2022-06-09 13:12:10');
INSERT INTO `oms_order` VALUES (138812, 4, '202206130855334491536150245354893313', NULL, '2022-06-13 08:55:34', 'ceshi002', 5998.0000, 6032.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, 1, NULL, 1, NULL, NULL, 7, 5998, 5998, NULL, NULL, NULL, NULL, NULL, '张三', '13433333333', NULL, '湖北省', '武汉市', '武昌区', '委员会', NULL, 0, 0, NULL, '2022-06-13 00:56:05', NULL, NULL, NULL, '2022-06-13 00:56:05');
INSERT INTO `oms_order` VALUES (138813, 2, '202206130902416211536152041284472833', NULL, '2022-06-13 09:02:42', NULL, NULL, 5599.0000, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '舒洪凡 学校', '13433366999', NULL, '湖北省', '武汉市', '武昌区', '徐东大街1号', NULL, NULL, NULL, NULL, '2022-06-13 01:03:10', NULL, NULL, NULL, '2022-06-13 01:03:10');
INSERT INTO `oms_order` VALUES (138814, 4, '202206130908473641536153575271469057', NULL, '2022-06-13 09:08:47', NULL, NULL, 5599.0000, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '张三', '13433333333', NULL, '湖北省', '武汉市', '武昌区', '委员会', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `oms_order` VALUES (138816, 5, '202206130911497021536154340086026242', NULL, '2022-06-13 09:11:50', NULL, NULL, 5599.0000, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '张三', '13433333333', NULL, '湖北省', '武汉市', '硚口区', '委员会', NULL, NULL, NULL, NULL, '2022-06-13 01:12:16', NULL, NULL, NULL, '2022-06-13 01:12:16');
INSERT INTO `oms_order` VALUES (138818, 6, '202206130932229921536159512833048577', NULL, '2022-06-13 09:32:23', 'ceshi004', 1699.0000, 1733.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, 1, NULL, 1, NULL, NULL, 7, 1699, 1699, NULL, NULL, NULL, NULL, NULL, '张三', '13433333333', NULL, '湖北省', '武汉市', '江岸区', '测试地址', NULL, 0, 0, NULL, '2022-06-13 01:32:46', NULL, NULL, NULL, '2022-06-13 01:32:46');
INSERT INTO `oms_order` VALUES (138819, 6, '202206131006371621536168128701042689', NULL, '2022-06-13 10:06:37', NULL, NULL, 2199.0000, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '张三', '13433333333', NULL, '湖北省', '武汉市', '江岸区', '测试地址', NULL, NULL, NULL, NULL, '2022-06-13 02:07:05', NULL, NULL, NULL, '2022-06-13 02:07:05');
INSERT INTO `oms_order` VALUES (138821, 7, '202206131050465081536179240834187266', NULL, '2022-06-13 10:50:47', 'ceshi006', 3398.0000, 3432.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, 1, NULL, 1, NULL, NULL, 7, 3398, 3398, NULL, NULL, NULL, NULL, NULL, '张三', '13433333333', NULL, '湖北省', '武汉市', '蔡甸区', '测试地址', NULL, 0, 0, NULL, '2022-06-13 02:51:24', NULL, NULL, NULL, '2022-06-13 02:51:24');
INSERT INTO `oms_order` VALUES (138822, 7, '202206131052281561536179667176820737', NULL, '2022-06-13 10:52:28', NULL, NULL, 5599.0000, NULL, NULL, NULL, NULL, NULL, 1, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '张三', '13433333333', NULL, '湖北省', '武汉市', '蔡甸区', '测试地址', NULL, NULL, NULL, NULL, '2022-06-13 02:52:55', NULL, NULL, NULL, '2022-06-13 02:52:55');
INSERT INTO `oms_order` VALUES (138823, 1, '202206141628409741536626666015633410', NULL, '2022-06-14 16:28:41', 'shf', 5799.0000, 5833.0000, 34.0000, 0.0000, 0.0000, 0.0000, NULL, NULL, NULL, 4, NULL, NULL, 7, 5799, 5799, NULL, NULL, NULL, NULL, NULL, '舒洪凡 学校', '13433366999', NULL, '湖北省', '武汉市', '武昌区', '徐东大街1号', NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, '2022-06-14 16:28:41');

-- ----------------------------
-- Table structure for oms_order_item
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_item`;
CREATE TABLE `oms_order_item`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(0) NULL DEFAULT NULL COMMENT 'order_id',
  `order_sn` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'order_sn',
  `spu_id` bigint(0) NULL DEFAULT NULL COMMENT 'spu_id',
  `spu_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spu_name',
  `spu_pic` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'spu_pic',
  `spu_brand` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '品牌',
  `category_id` bigint(0) NULL DEFAULT NULL COMMENT '商品分类id',
  `sku_id` bigint(0) NULL DEFAULT NULL COMMENT '商品sku编号',
  `sku_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品sku名字',
  `sku_pic` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品sku图片',
  `sku_price` decimal(18, 4) NULL DEFAULT NULL COMMENT '商品sku价格',
  `sku_quantity` int(0) NULL DEFAULT NULL COMMENT '商品购买的数量',
  `sku_attrs_vals` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品销售属性组合（JSON）',
  `promotion_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '商品促销分解金额',
  `coupon_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '优惠券优惠分解金额',
  `integration_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '积分优惠分解金额',
  `real_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '该商品经过优惠后的分解金额',
  `gift_integration` int(0) NULL DEFAULT NULL COMMENT '赠送积分',
  `gift_growth` int(0) NULL DEFAULT NULL COMMENT '赠送成长值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 43 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单项信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_item
-- ----------------------------
INSERT INTO `oms_order_item` VALUES (1, NULL, '202206051912154101533406339932356610', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, 30, 'Apple iPhone 13 (A2634) 午夜色 4GB 128G  支持移动联通电信5G 双卡双待手机', 'http://rcsucl8tn.hn-bkt.clouddn.com/4c0e78cb-909d-46d5-86e6-f0dcdec742b7_0782f9531d22fd99.jpg', 5799.0000, 3, '颜色：午夜色;内存：4GB;版本：128G', 0.0000, 0.0000, 0.0000, 17397.0000, 17397, 17397);
INSERT INTO `oms_order_item` VALUES (3, NULL, '202206061508000041533707258570006529', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, 30, 'Apple iPhone 13 (A2634) 午夜色 4GB 128G  支持移动联通电信5G 双卡双待手机', 'http://rcsucl8tn.hn-bkt.clouddn.com/4c0e78cb-909d-46d5-86e6-f0dcdec742b7_0782f9531d22fd99.jpg', 5799.0000, 1, '颜色：午夜色;内存：4GB;版本：128G', 0.0000, 0.0000, 0.0000, 5799.0000, 5799, 5799);
INSERT INTO `oms_order_item` VALUES (4, NULL, '202206061511058151533708037922021378', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, 30, 'Apple iPhone 13 (A2634) 午夜色 4GB 128G  支持移动联通电信5G 双卡双待手机', 'http://rcsucl8tn.hn-bkt.clouddn.com/4c0e78cb-909d-46d5-86e6-f0dcdec742b7_0782f9531d22fd99.jpg', 5799.0000, 1, '颜色：午夜色;内存：4GB;版本：128G', 0.0000, 0.0000, 0.0000, 5799.0000, 5799, 5799);
INSERT INTO `oms_order_item` VALUES (5, NULL, '202206061519493781533710233942114305', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, 27, 'Apple iPhone 13 (A2634) 星光色 4GB 128G 支持移动联通电信5G 双卡双待手机', 'http://rcsucl8tn.hn-bkt.clouddn.com/58d3f557-4a23-42cd-84d6-d391e1851f8a_b6b32191c26d161b.jpg', 5799.0000, 1, '颜色：星光色;内存：4GB;版本：128G', 0.0000, 0.0000, 0.0000, 5799.0000, 5799, 5799);
INSERT INTO `oms_order_item` VALUES (6, NULL, '202206061523210031533711121549176834', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, 30, 'Apple iPhone 13 (A2634) 午夜色 4GB 128G  支持移动联通电信5G 双卡双待手机', 'http://rcsucl8tn.hn-bkt.clouddn.com/4c0e78cb-909d-46d5-86e6-f0dcdec742b7_0782f9531d22fd99.jpg', 5799.0000, 1, '颜色：午夜色;内存：4GB;版本：128G', 0.0000, 0.0000, 0.0000, 5799.0000, 5799, 5799);
INSERT INTO `oms_order_item` VALUES (7, NULL, '202206071916253021534132163820236802', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 5599.0000, NULL, NULL);
INSERT INTO `oms_order_item` VALUES (8, NULL, '202206090900057411534701836013989889', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, 27, 'Apple iPhone 13 (A2634) 星光色 4GB 128G 支持移动联通电信5G 双卡双待手机', 'http://rcsucl8tn.hn-bkt.clouddn.com/58d3f557-4a23-42cd-84d6-d391e1851f8a_b6b32191c26d161b.jpg', 5799.0000, 2, '颜色：星光色;内存：4GB;版本：128G', 0.0000, 0.0000, 0.0000, 11598.0000, 11598, 11598);
INSERT INTO `oms_order_item` VALUES (9, NULL, '202206091606325101534809154701537282', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, 27, 'Apple iPhone 13 (A2634) 星光色 4GB 128G 支持移动联通电信5G 双卡双待手机', 'http://rcsucl8tn.hn-bkt.clouddn.com/58d3f557-4a23-42cd-84d6-d391e1851f8a_b6b32191c26d161b.jpg', 5799.0000, 1, '颜色：星光色;内存：4GB;版本：128G', 0.0000, 0.0000, 0.0000, 5799.0000, 5799, 5799);
INSERT INTO `oms_order_item` VALUES (12, NULL, '202206091612057741534810552465928193', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, 27, 'Apple iPhone 13 (A2634) 星光色 4GB 128G 支持移动联通电信5G 双卡双待手机', 'http://rcsucl8tn.hn-bkt.clouddn.com/58d3f557-4a23-42cd-84d6-d391e1851f8a_b6b32191c26d161b.jpg', 5799.0000, 1, '颜色：星光色;内存：4GB;版本：128G', 0.0000, 0.0000, 0.0000, 5799.0000, 5799, 5799);
INSERT INTO `oms_order_item` VALUES (13, NULL, '202206091628116581534814603723169794', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, 27, 'Apple iPhone 13 (A2634) 星光色 4GB 128G 支持移动联通电信5G 双卡双待手机', 'http://rcsucl8tn.hn-bkt.clouddn.com/58d3f557-4a23-42cd-84d6-d391e1851f8a_b6b32191c26d161b.jpg', 5799.0000, 1, '颜色：星光色;内存：4GB;版本：128G', 0.0000, 0.0000, 0.0000, 5799.0000, 5799, 5799);
INSERT INTO `oms_order_item` VALUES (14, NULL, '202206091629298341534814931612868610', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 5499.0000, NULL, NULL);
INSERT INTO `oms_order_item` VALUES (15, NULL, '202206091758539121534837430195109889', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 5599.0000, NULL, NULL);
INSERT INTO `oms_order_item` VALUES (16, NULL, '202206091818459121534842429801259009', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 5599.0000, NULL, NULL);
INSERT INTO `oms_order_item` VALUES (17, NULL, '202206091827386181534844664144736258', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 5599.0000, NULL, NULL);
INSERT INTO `oms_order_item` VALUES (18, NULL, '202206091830513881534845472617803777', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 5599.0000, NULL, NULL);
INSERT INTO `oms_order_item` VALUES (19, NULL, '202206091833110971534846058633375745', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 5599.0000, NULL, NULL);
INSERT INTO `oms_order_item` VALUES (20, NULL, '202206091837157281534847084652408833', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 5599.0000, NULL, NULL);
INSERT INTO `oms_order_item` VALUES (23, NULL, '202206092002208631534868497144741889', 15, ' vivo iQOO Neo5 SE', NULL, 'VIVO', 225, 45, ' vivo iQOO Neo5 SE 极夜黑 8GB 128G 八核 8G+256G 极夜黑', 'http://rcsucl8tn.hn-bkt.clouddn.com/11022f1c-a7f4-45bb-8210-d7a7192abee2_c639a72bb645be6b.jpg', 2299.0000, 1, '颜色：极夜黑;内存：8GB;版本：256G;CPU核心数：八核', 0.0000, 0.0000, 0.0000, 2299.0000, 2299, 2299);
INSERT INTO `oms_order_item` VALUES (24, NULL, '202206092005039891534869181403521026', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 5599.0000, NULL, NULL);
INSERT INTO `oms_order_item` VALUES (25, NULL, '202206092013555551534871410894200833', 15, ' vivo iQOO Neo5 SE', NULL, 'VIVO', 225, NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, 2199.0000, NULL, NULL);
INSERT INTO `oms_order_item` VALUES (26, NULL, '202206092059356331534882903618510850', 15, ' vivo iQOO Neo5 SE', NULL, 'VIVO', 225, NULL, ' vivo iQOO Neo5 SE 极夜黑 8GB 128G 八核 8G+256G 极夜黑', 'http://rcsucl8tn.hn-bkt.clouddn.com/11022f1c-a7f4-45bb-8210-d7a7192abee2_c639a72bb645be6b.jpg', 2299.0000, 1, NULL, 0.0000, 0.0000, 0.0000, 2199.0000, 2199, 2199);
INSERT INTO `oms_order_item` VALUES (27, NULL, '202206092111510811534885988327776257', 15, ' vivo iQOO Neo5 SE', NULL, 'VIVO', 225, NULL, ' vivo iQOO Neo5 SE 极夜黑 8GB 128G 八核 8G+256G 极夜黑', 'http://rcsucl8tn.hn-bkt.clouddn.com/11022f1c-a7f4-45bb-8210-d7a7192abee2_c639a72bb645be6b.jpg', 2299.0000, 1, NULL, 0.0000, 0.0000, 0.0000, 2199.0000, 2199, 2199);
INSERT INTO `oms_order_item` VALUES (30, NULL, '202206130855334491536150245354893313', 16, 'OPPO Reno8 80W超级闪充 5000万水光人像三摄 3200万前置索尼镜头 轻薄机身 5G手机', NULL, 'oppo', 225, 55, 'OPPO Reno8 晴空蓝 80W超级闪充 5000万水光人像三摄 3200万前置索尼镜头 轻薄机身 5G手机 晴空蓝 12GB 8+128 八核  12GB  8+128', 'http://rcsucl8tn.hn-bkt.clouddn.com/4fd2a464-aa79-4559-8f91-d7465b081499_c5a77b55062c3faa.jpg', 2999.0000, 2, '颜色：晴空蓝;内存：12GB;版本：8+128;CPU核心数：八核', 0.0000, 0.0000, 0.0000, 5998.0000, 5998, 5998);
INSERT INTO `oms_order_item` VALUES (31, NULL, '202206130902416211536152041284472833', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, 'Apple iPhone 13 (A2634) 午夜色 4GB 128G', 'http://rcsucl8tn.hn-bkt.clouddn.com/4c0e78cb-909d-46d5-86e6-f0dcdec742b7_0782f9531d22fd99.jpg', 5799.0000, 1, NULL, 0.0000, 0.0000, 0.0000, 5599.0000, 5599, 5599);
INSERT INTO `oms_order_item` VALUES (32, NULL, '202206130908473641536153575271469057', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, 'Apple iPhone 13 (A2634) 午夜色 4GB 128G', 'http://rcsucl8tn.hn-bkt.clouddn.com/4c0e78cb-909d-46d5-86e6-f0dcdec742b7_0782f9531d22fd99.jpg', 5799.0000, 1, NULL, 0.0000, 0.0000, 0.0000, 5599.0000, 5599, 5599);
INSERT INTO `oms_order_item` VALUES (34, NULL, '202206130911497021536154340086026242', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, 'Apple iPhone 13 (A2634) 午夜色 4GB 128G', 'http://rcsucl8tn.hn-bkt.clouddn.com/4c0e78cb-909d-46d5-86e6-f0dcdec742b7_0782f9531d22fd99.jpg', 5799.0000, 1, NULL, 0.0000, 0.0000, 0.0000, 5599.0000, 5599, 5599);
INSERT INTO `oms_order_item` VALUES (37, NULL, '202206130932229921536159512833048577', 17, 'Redmi Note 11 Pro 5G 三星AMOLED高刷屏 1亿像素 67W快充 VC液冷散热', NULL, '小米', 225, 58, 'Redmi Note 11 Pro 5G 三星AMOLED高刷屏 1亿像素 67W快充 VC液冷散热 迷雾森林 8GB 128G 八核  迷雾森林  8GB  128G', 'http://rcsucl8tn.hn-bkt.clouddn.com/263ec1b4-3d50-4f46-8f1c-543f4f9656fb_6cec3dc235efc6be.jpg', 1699.0000, 1, '颜色：迷雾森林;内存：8GB;版本：128G;CPU核心数：八核', 0.0000, 0.0000, 0.0000, 1699.0000, 1699, 1699);
INSERT INTO `oms_order_item` VALUES (38, NULL, '202206131006371621536168128701042689', 15, ' vivo iQOO Neo5 SE', NULL, 'VIVO', 225, NULL, ' vivo iQOO Neo5 SE 极夜黑 8GB 128G 八核 8G+256G 极夜黑', 'http://rcsucl8tn.hn-bkt.clouddn.com/11022f1c-a7f4-45bb-8210-d7a7192abee2_c639a72bb645be6b.jpg', 2299.0000, 1, NULL, 0.0000, 0.0000, 0.0000, 2199.0000, 2199, 2199);
INSERT INTO `oms_order_item` VALUES (40, NULL, '202206131050465081536179240834187266', 18, '荣耀X30 骁龙6nm疾速5G芯 66W超级快充 120Hz全视屏 全网通版', NULL, '荣耀', 225, 61, '荣耀X30 骁龙6nm疾速5G芯 66W超级快充 120Hz全视屏 全网通版 白色 8GB 128G 八核  白色  8GB  128G', 'http://rcsucl8tn.hn-bkt.clouddn.com/bb5a51a6-e732-4829-874e-0dcc7eabbb06_8d1d2282989c0311.jpg', 1699.0000, 2, '颜色：白色;内存：8GB;版本：128G;CPU核心数：八核', 0.0000, 0.0000, 0.0000, 3398.0000, 3398, 3398);
INSERT INTO `oms_order_item` VALUES (41, NULL, '202206131052281561536179667176820737', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, NULL, 'Apple iPhone 13 (A2634) 午夜色 4GB 128G', 'http://rcsucl8tn.hn-bkt.clouddn.com/4c0e78cb-909d-46d5-86e6-f0dcdec742b7_0782f9531d22fd99.jpg', 5799.0000, 1, NULL, 0.0000, 0.0000, 0.0000, 5599.0000, 5599, 5599);
INSERT INTO `oms_order_item` VALUES (42, NULL, '202206141628409741536626666015633410', 14, 'Apple iPhone 13 (A2634)', NULL, 'Apple', 225, 27, 'Apple iPhone 13 (A2634) 星光色 4GB 128G 支持移动联通电信5G 双卡双待手机', 'http://rcsucl8tn.hn-bkt.clouddn.com/58d3f557-4a23-42cd-84d6-d391e1851f8a_b6b32191c26d161b.jpg', 5799.0000, 1, '颜色：星光色;内存：4GB;版本：128G', 0.0000, 0.0000, 0.0000, 5799.0000, 5799, 5799);

-- ----------------------------
-- Table structure for oms_order_operate_history
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_operate_history`;
CREATE TABLE `oms_order_operate_history`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(0) NULL DEFAULT NULL COMMENT '订单id',
  `operate_man` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作人[用户；系统；后台管理员]',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '操作时间',
  `order_status` tinyint(0) NULL DEFAULT NULL COMMENT '订单状态【0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单】',
  `note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单操作历史记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_operate_history
-- ----------------------------

-- ----------------------------
-- Table structure for oms_order_return_apply
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_return_apply`;
CREATE TABLE `oms_order_return_apply`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(0) NULL DEFAULT NULL COMMENT 'order_id',
  `sku_id` bigint(0) NULL DEFAULT NULL COMMENT '退货商品id',
  `order_sn` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单编号',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '申请时间',
  `member_username` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会员用户名',
  `return_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '退款金额',
  `return_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退货人姓名',
  `return_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退货人电话',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '申请状态[0->待处理；1->退货中；2->已完成；3->已拒绝]',
  `handle_time` datetime(0) NULL DEFAULT NULL COMMENT '处理时间',
  `sku_img` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品图片',
  `sku_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品名称',
  `sku_brand` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品品牌',
  `sku_attrs_vals` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '商品销售属性(JSON)',
  `sku_count` int(0) NULL DEFAULT NULL COMMENT '退货数量',
  `sku_price` decimal(18, 4) NULL DEFAULT NULL COMMENT '商品单价',
  `sku_real_price` decimal(18, 4) NULL DEFAULT NULL COMMENT '商品实际支付单价',
  `reason` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '原因',
  `description述` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `desc_pics` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '凭证图片，以逗号隔开',
  `handle_note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理备注',
  `handle_man` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '处理人员',
  `receive_man` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货人',
  `receive_time` datetime(0) NULL DEFAULT NULL COMMENT '收货时间',
  `receive_note` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货备注',
  `receive_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '收货电话',
  `company_address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '公司收货地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单退货申请' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_return_apply
-- ----------------------------

-- ----------------------------
-- Table structure for oms_order_return_reason
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_return_reason`;
CREATE TABLE `oms_order_return_reason`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退货原因名',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '启用状态',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT 'create_time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '退货原因' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_return_reason
-- ----------------------------

-- ----------------------------
-- Table structure for oms_order_setting
-- ----------------------------
DROP TABLE IF EXISTS `oms_order_setting`;
CREATE TABLE `oms_order_setting`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `flash_order_overtime` int(0) NULL DEFAULT NULL COMMENT '秒杀订单超时关闭时间(分)',
  `normal_order_overtime` int(0) NULL DEFAULT NULL COMMENT '正常订单超时时间(分)',
  `confirm_overtime` int(0) NULL DEFAULT NULL COMMENT '发货后自动确认收货时间（天）',
  `finish_overtime` int(0) NULL DEFAULT NULL COMMENT '自动完成交易时间，不能申请退货（天）',
  `comment_overtime` int(0) NULL DEFAULT NULL COMMENT '订单完成后自动好评时间（天）',
  `member_level` tinyint(0) NULL DEFAULT NULL COMMENT '会员等级【0-不限会员等级，全部通用；其他-对应的其他会员等级】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单配置信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_order_setting
-- ----------------------------

-- ----------------------------
-- Table structure for oms_payment_info
-- ----------------------------
DROP TABLE IF EXISTS `oms_payment_info`;
CREATE TABLE `oms_payment_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_sn` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单号（对外业务号）',
  `order_id` bigint(0) NULL DEFAULT NULL COMMENT '订单id',
  `alipay_trade_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '支付宝交易流水号',
  `total_amount` decimal(18, 4) NULL DEFAULT NULL COMMENT '支付总金额',
  `subject` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '交易内容',
  `payment_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '支付状态',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `confirm_time` datetime(0) NULL DEFAULT NULL COMMENT '确认时间',
  `callback_content` varchar(4000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '回调内容',
  `callback_time` datetime(0) NULL DEFAULT NULL COMMENT '回调时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_sn`(`order_sn`) USING BTREE,
  UNIQUE INDEX `alipay_trade_no`(`alipay_trade_no`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '支付信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_payment_info
-- ----------------------------
INSERT INTO `oms_payment_info` VALUES (1, '202206061523210031533711121549176834', NULL, '2022060622001498350505577416', 5833.0000, '颜色：午夜色;内存：4GB;版本：128G', 'TRADE_SUCCESS', '2022-06-06 15:23:39', NULL, NULL, '2022-06-06 15:23:38');
INSERT INTO `oms_payment_info` VALUES (2, '202206071916253021534132163820236802', NULL, '2022060722001498350505578100', 5599.0000, 'null', 'TRADE_SUCCESS', '2022-06-07 19:18:13', NULL, NULL, '2022-06-07 19:18:12');
INSERT INTO `oms_payment_info` VALUES (3, '202206091628116581534814603723169794', NULL, '2022060922001498350505578551', 5833.0000, '颜色：星光色;内存：4GB;版本：128G', 'TRADE_SUCCESS', '2022-06-09 16:28:55', NULL, NULL, '2022-06-09 16:28:53');
INSERT INTO `oms_payment_info` VALUES (4, '202206091629298341534814931612868610', NULL, '2022060922001498350505578423', 5499.0000, 'null', 'TRADE_SUCCESS', '2022-06-09 16:30:12', NULL, NULL, '2022-06-09 16:30:12');
INSERT INTO `oms_payment_info` VALUES (5, '202206091827386181534844664144736258', NULL, '2022060922001498350505578552', 5599.0000, 'null', 'TRADE_SUCCESS', '2022-06-09 18:28:01', NULL, NULL, '2022-06-09 18:28:00');
INSERT INTO `oms_payment_info` VALUES (6, '202206092002208631534868497144741889', NULL, '2022060922001498350505578427', 2333.0000, '颜色：极夜黑;内存：8GB;版本：256G;CPU核心数：八核', 'TRADE_SUCCESS', '2022-06-09 20:03:07', NULL, NULL, '2022-06-09 20:03:06');
INSERT INTO `oms_payment_info` VALUES (7, '202206092005039891534869181403521026', NULL, '2022060922001498350505578736', 5599.0000, 'null', 'TRADE_SUCCESS', '2022-06-09 20:05:29', NULL, NULL, '2022-06-09 20:05:28');
INSERT INTO `oms_payment_info` VALUES (8, '202206092013555551534871410894200833', NULL, '2022060922001498350505578553', 2199.0000, 'null', 'TRADE_SUCCESS', '2022-06-09 20:14:17', NULL, NULL, '2022-06-09 20:14:16');
INSERT INTO `oms_payment_info` VALUES (9, '202206092059356331534882903618510850', NULL, '2022060922001498350505578737', 2199.0000, 'null', 'TRADE_SUCCESS', '2022-06-09 21:00:07', NULL, NULL, '2022-06-09 21:00:05');
INSERT INTO `oms_payment_info` VALUES (10, '202206092111510811534885988327776257', NULL, '2022060922001498350505578738', 2199.0000, 'null', 'TRADE_SUCCESS', '2022-06-09 21:12:10', NULL, NULL, '2022-06-09 21:12:10');
INSERT INTO `oms_payment_info` VALUES (11, '202206130855334491536150245354893313', NULL, '2022061322001498350505579564', 6032.0000, '颜色：晴空蓝;内存：12GB;版本：8+128;CPU核心数：八核', 'TRADE_SUCCESS', '2022-06-13 08:56:05', NULL, NULL, '2022-06-13 08:56:04');
INSERT INTO `oms_payment_info` VALUES (12, '202206130902416211536152041284472833', NULL, '2022061322001498350505579565', 5599.0000, 'null', 'TRADE_SUCCESS', '2022-06-13 09:03:10', NULL, NULL, '2022-06-13 09:03:09');
INSERT INTO `oms_payment_info` VALUES (13, '202206130911497021536154340086026242', NULL, '2022061322001498350505579429', 5599.0000, 'null', 'TRADE_SUCCESS', '2022-06-13 09:12:16', NULL, NULL, '2022-06-13 09:12:16');
INSERT INTO `oms_payment_info` VALUES (14, '202206130932229921536159512833048577', NULL, '2022061322001498350505579430', 1733.0000, '颜色：迷雾森林;内存：8GB;版本：128G;CPU核心数：八核', 'TRADE_SUCCESS', '2022-06-13 09:32:46', NULL, NULL, '2022-06-13 09:32:46');
INSERT INTO `oms_payment_info` VALUES (15, '202206131006371621536168128701042689', NULL, '2022061322001498350505579574', 2199.0000, 'null', 'TRADE_SUCCESS', '2022-06-13 10:07:05', NULL, NULL, '2022-06-13 10:07:04');
INSERT INTO `oms_payment_info` VALUES (16, '202206131050465081536179240834187266', NULL, '2022061322001498350505579575', 3432.0000, '颜色：白色;内存：8GB;版本：128G;CPU核心数：八核', 'TRADE_SUCCESS', '2022-06-13 10:51:24', NULL, NULL, '2022-06-13 10:51:24');
INSERT INTO `oms_payment_info` VALUES (17, '202206131052281561536179667176820737', NULL, '2022061322001498350505579443', 5599.0000, 'null', 'TRADE_SUCCESS', '2022-06-13 10:52:55', NULL, NULL, '2022-06-13 10:52:54');

-- ----------------------------
-- Table structure for oms_refund_info
-- ----------------------------
DROP TABLE IF EXISTS `oms_refund_info`;
CREATE TABLE `oms_refund_info`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_return_id` bigint(0) NULL DEFAULT NULL COMMENT '退款的订单',
  `refund` decimal(18, 4) NULL DEFAULT NULL COMMENT '退款金额',
  `refund_sn` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款交易流水号',
  `refund_status` tinyint(1) NULL DEFAULT NULL COMMENT '退款状态',
  `refund_channel` tinyint(0) NULL DEFAULT NULL COMMENT '退款渠道[1-支付宝，2-微信，3-银联，4-汇款]',
  `refund_content` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '退款信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oms_refund_info
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
