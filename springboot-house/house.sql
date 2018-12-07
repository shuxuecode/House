/*
Navicat MySQL Data Transfer

Source Server Version : 50721

Source Database       : house

Target Server Type    : MYSQL
Target Server Version : 50721
File Encoding         : 65001


*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for rent_city
-- ----------------------------
DROP TABLE IF EXISTS `rent_city`;
CREATE TABLE `rent_city` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `area_code` int(4) NOT NULL COMMENT '区号',
  `city_name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '城市名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='城市代码表';

-- ----------------------------
-- Table structure for rent_district
-- ----------------------------
DROP TABLE IF EXISTS `rent_district`;
CREATE TABLE `rent_district` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `city_code` bigint(20) NOT NULL COMMENT '城市代码',
  `district_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地区名称',
  `sort` int(2) NOT NULL DEFAULT '0' COMMENT '顺序',
  `del` int(2) NOT NULL DEFAULT '0' COMMENT '是否删除，0否，1是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人id',
  `creator_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人名称',
  `updater_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人id',
  `updater_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='城市行政区表';

-- ----------------------------
-- Table structure for rent_favorite
-- ----------------------------
DROP TABLE IF EXISTS `rent_favorite`;
CREATE TABLE `rent_favorite` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `wechat_code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '客户微信id',
  `house_id` bigint(19) unsigned NOT NULL DEFAULT '0' COMMENT '房间id',
  `del` int(2) NOT NULL DEFAULT '0' COMMENT '是否删除，0否，1是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人id',
  `creator_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人名称',
  `updater_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人id',
  `updater_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='客户收藏房屋信息表';

-- ----------------------------
-- Table structure for rent_furnitures
-- ----------------------------
DROP TABLE IF EXISTS `rent_furnitures`;
CREATE TABLE `rent_furnitures` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `names` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置',
  `sort` int(2) NOT NULL DEFAULT '0' COMMENT '顺序',
  `del` int(2) NOT NULL DEFAULT '0' COMMENT '是否删除，0否，1是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人id',
  `creator_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人名称',
  `updater_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人id',
  `updater_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='房屋家具配置表';

-- ----------------------------
-- Table structure for rent_house
-- ----------------------------
DROP TABLE IF EXISTS `rent_house`;
CREATE TABLE `rent_house` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `area_code` int(4) NOT NULL COMMENT '区号',
  `district_id` bigint(19) unsigned NOT NULL DEFAULT '0' COMMENT '区id',
  `summary` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '简介',
  `village` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '小区名称',
  `rental` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT '租金 元每月',
  `longitude` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '地图坐标经度',
  `latitude` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '地图坐标纬度',
  `status` int(2) NOT NULL DEFAULT '0' COMMENT '房屋状态：0：未发布  1：发布中  2：已出租  3：删除',
  `person_name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '联系人',
  `telephone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '联系电话',
  `wechat_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '微信号',
  `wechat_image` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '微信二维码',
  `look_num` int(5) NOT NULL DEFAULT '0' COMMENT '浏览次数',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人id',
  `creator_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人名称',
  `updater_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人id',
  `updater_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2020 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='房屋主体表';

-- ----------------------------
-- Table structure for rent_house_details
-- ----------------------------
DROP TABLE IF EXISTS `rent_house_details`;
CREATE TABLE `rent_house_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `house_id` bigint(19) unsigned NOT NULL DEFAULT '0' COMMENT '房间id',
  `house_type` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '户型，2室1厅1卫',
  `house_area` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '面积，100m2',
  `house_floor` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '楼层 3/18层',
  `direction` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '朝向 南北 、 东西',
  `decoration` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '装修  精装修  毛坯',
  `pay_mode` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '付款方式  押一付三  押一付一',
  `address` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '详细地址',
  `furnitures` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '家具列表，逗号分隔',
  `detail` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人id',
  `creator_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人名称',
  `updater_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人id',
  `updater_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1020 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='房屋详细表';

-- ----------------------------
-- Table structure for rent_images
-- ----------------------------
DROP TABLE IF EXISTS `rent_images`;
CREATE TABLE `rent_images` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `house_id` bigint(19) unsigned NOT NULL DEFAULT '0' COMMENT '房间id',
  `sort` int(2) NOT NULL DEFAULT '0' COMMENT '顺序',
  `img_url` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '图片地址',
  `del` int(2) NOT NULL DEFAULT '0' COMMENT '是否删除，0否，1是',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人id',
  `creator_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建人名称',
  `updater_id` varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人id',
  `updater_name` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '更新人名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8000028 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='租房图片表';
