/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : python

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 16/06/2022 18:20:44
*/
CREATE DATABASE python;
USE python;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id` ASC, `codename` ASC) USING BTREE,
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 2, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 3, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add user', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change user', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete user', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view user', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add books', 7, 'add_books');
INSERT INTO `auth_permission` VALUES (26, 'Can change books', 7, 'change_books');
INSERT INTO `auth_permission` VALUES (27, 'Can delete books', 7, 'delete_books');
INSERT INTO `auth_permission` VALUES (28, 'Can view books', 7, 'view_books');
INSERT INTO `auth_permission` VALUES (29, 'Can add read book', 8, 'add_readbook');
INSERT INTO `auth_permission` VALUES (30, 'Can change read book', 8, 'change_readbook');
INSERT INTO `auth_permission` VALUES (31, 'Can delete read book', 8, 'delete_readbook');
INSERT INTO `auth_permission` VALUES (32, 'Can view read book', 8, 'view_readbook');

-- ----------------------------
-- Table structure for book_books
-- ----------------------------
DROP TABLE IF EXISTS `book_books`;
CREATE TABLE `book_books`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `bookname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '图书名称',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '类型',
  `isbn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'ISBN码',
  `author` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '作者',
  `press` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '出版社',
  `time` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '出版时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `book_books_isbn_uindex`(`isbn` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 462 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_books
-- ----------------------------
INSERT INTO `book_books` VALUES (1, 'Java核心技术 卷I 基础知识（原书第11版）', '计算机', '9787111636663', '[美],凯·S.霍斯特曼（Cay,S.,Horstmann）', '机械工业出版社', '2019年12月');
INSERT INTO `book_books` VALUES (6, '零基础学Java', '计算机', '9787569205688', '[中国]明日科技(Mingri Soft)', '吉林大学出版社', '2020年02月');
INSERT INTO `book_books` VALUES (7, 'Python编程', '计算机', '9787115546081', '[美]埃里克·马瑟斯（Eric Matthes）', '人民邮电出版社', '2022年05月');
INSERT INTO `book_books` VALUES (8, 'Java从入门到精通（第6版）', '计算机', '9787302581260', '明日科技', '清华大学出版社', '2021年07月');
INSERT INTO `book_books` VALUES (9, '三体：全三册', '科幻', '23579654', '刘慈欣', '重庆出版社', '2010年11月');
INSERT INTO `book_books` VALUES (10, '斗破苍穹1', '玄幻', '9787514517675', '任翔，JOE，天蚕土豆', '中国致公出版社', '2022年12月');
INSERT INTO `book_books` VALUES (431, '情绪认知', '情商与情绪', '9787550031586', '尹惟楚', '百花洲文艺出版社', '2019年2月');
INSERT INTO `book_books` VALUES (432, '心理学与情商', '情商与情绪', '9787545541083', '张小宁', '天地出版社', '2018年10月');
INSERT INTO `book_books` VALUES (433, '痴迷法则', '时间管理', '9787122391933', ' 格兰特·卡尔登（Grant Cardone）', '化学工业出版社', '2021年10月');
INSERT INTO `book_books` VALUES (434, '掌握24小时', '时间管理', '9787115550026', '尹慕言', '人民邮电出版社', '2021年1月');
INSERT INTO `book_books` VALUES (435, '如何成为最好的演员', '人文社科', 'B09G9929HD', '达蒙·迪马克、威廉·艾斯珀、乔丹·戈德曼、等', '华中科技大学出版社有限责任公司', '2021年9月');
INSERT INTO `book_books` VALUES (436, '脑效率科学', '技能提升', '9787115579713', '[美]戴维•罗克（David Rock）', '图灵、人民邮电出版社', '2022年1月');
INSERT INTO `book_books` VALUES (437, '像高手一样发言', '技能提升', '9787111663850', '久久', '机械工业出版社', '2021年10月');
INSERT INTO `book_books` VALUES (438, '本事', '技能提升', '9787515359489', '基兰·弗拉纳根 ', '中国青年出版社', '2020年5月');
INSERT INTO `book_books` VALUES (439, '巴黎式魅力', '休闲娱乐', '9787521722505', ' 杰米·卡特·卡伦', ' 中信出版社', '2021年6月');
INSERT INTO `book_books` VALUES (440, '地球的天空', '科学新知', '9787545564662', 'L.S.福伯 (L. S. Fauber)', '天地出版社', '2021年11月');
INSERT INTO `book_books` VALUES (441, '科幻世界', '中外文学', 'B09TR8LMB8', '科幻世界', '科幻世界杂志社', '2022年3月');
INSERT INTO `book_books` VALUES (442, '生活的哲学心理学', '人文社科', 'B09T9GLKQK', '乔丹·彼得森、斯科特·亚当斯等', '湛庐文化', '2022年2月');
INSERT INTO `book_books` VALUES (443, '今宵欢乐多', '中外文学', '9787540263348', '冯唐', '北京燕山出版社', '2022年1月');
INSERT INTO `book_books` VALUES (444, '帝國', '人文社科', '9789867247803', 'Ryszard Kapuściński（瑞斯札德．卡普欽斯基）', '馬可孛羅文化事業股份有限公司', '2008年10月');
INSERT INTO `book_books` VALUES (445, '军事里的中国史', '人文社科', '9787510473777', '冷兵器研究所', '新世界出版社', '2022年2月');
INSERT INTO `book_books` VALUES (446, '马斯洛经典心理学', '人文社科', 'B09RZLQJJC', '亚伯拉罕·马斯洛', '江苏人民出版社', '2022年2月');
INSERT INTO `book_books` VALUES (447, '美国人的性格', '人文社科', '9787572601507', '(美) 乔恩·米查姆 (Jon Meacham)', '湖南文艺出版社', '2022年2月');
INSERT INTO `book_books` VALUES (448, '努力的意义', '人文社科', '9787300284583', '[美] 卡罗尔·德韦克', '中国人民大学出版社', '2021年3月');
INSERT INTO `book_books` VALUES (449, '大地的细节', '中外文学', '9787559842923', ' 聂作平', '广西师范大学出版社·诗想者', '2021年11月');
INSERT INTO `book_books` VALUES (450, '每个人的新生', '人文社科', ' 9787521735352', '[美] 洛伦佐·科恩 / [美] 艾利森·杰弗里斯', '中信出版社', '2022年1月');
INSERT INTO `book_books` VALUES (451, '成为一颗星', '中外文学', '9787532790029', '[意] 萨曼莎·克里斯托弗雷蒂', '上海译文出版社', '2022年3月');
INSERT INTO `book_books` VALUES (452, '聊出来的三国', '人文社科', '9787122395252', '锋云', '化学工业出版社', '2022年2月');
INSERT INTO `book_books` VALUES (453, '星之子', '中外文学', '9787541159220', ' [日] 今村夏子', '四川文艺出版社', '2022年3月');
INSERT INTO `book_books` VALUES (454, '如何停止胡思乱想', '人文社科', '9787313258984', '【美】卡罗尔·克肖 【美】比尔·韦德', '上海交通大学出版社', '2022年2月');
INSERT INTO `book_books` VALUES (455, '善的历程', '人文社科', '9787208169722', '杨国荣', '上海人民出版社', '2021年11月');
INSERT INTO `book_books` VALUES (456, '看不够的中国史', '人文社科', '9787220124846', '国家人文历史', '四川人民出版社', '2021年12月');
INSERT INTO `book_books` VALUES (457, '乘风破浪', '中外文学', '9787541162107', '[挪威]托尔·海尔达尔', '四川文艺出版社', '2022年3月');
INSERT INTO `book_books` VALUES (458, '甲骨文·帝国的荣耀与衰败', '人文社科', 'B09TSC26Y1', '河内春人、宫崎市定、檀上宽、阿德里安·戈兹沃西、艾莉森·威尔、克斯汀·唐尼、克里斯托弗·希伯特', '社会科学文献出版社', '2022年3月');
INSERT INTO `book_books` VALUES (459, '双重冲击', '人文社科', '9787111701545', '李晓', ' 机械工业出版社', '2022年3月');
INSERT INTO `book_books` VALUES (460, '假面人', '中外文学', '44531.0', '磨剑少爷', '江苏凤凰文艺出版社', '2021年12月');

-- ----------------------------
-- Table structure for book_read
-- ----------------------------
DROP TABLE IF EXISTS `book_read`;
CREATE TABLE `book_read`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `readname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `bookid` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图书ID',
  `bookname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图书名称',
  `readtime` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '借阅时间',
  `returntime` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '归还时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_read
-- ----------------------------
INSERT INTO `book_read` VALUES (16, 'rf', '367', '1946现代世界的形成', '2022年06月13日 19:49:06', '2022年06月13日 19:49:16');
INSERT INTO `book_read` VALUES (17, 'rf', '367', '1946现代世界的形成', '2022年06月13日 19:49:32', '2022年06月13日 19:55:10');
INSERT INTO `book_read` VALUES (18, 'zl', '367', '1946现代世界的形成', '2022年06月13日 19:54:52', '');
INSERT INTO `book_read` VALUES (19, 'rf', '334', '斗罗大陆', '2022年06月13日 23:09:04', '2022年06月14日 08:40:53');
INSERT INTO `book_read` VALUES (20, 'rf', '334', '斗罗大陆', '2022年06月13日 23:09:45', '');
INSERT INTO `book_read` VALUES (21, 'rf', '334', '斗罗大陆', '2022年06月14日 08:40:32', '');
INSERT INTO `book_read` VALUES (22, 'rf', '334', '斗罗大陆', '2022年06月14日 08:40:53', '');
INSERT INTO `book_read` VALUES (23, 'rf', '430', '1946现代世界的形成', '2022年06月15日 09:08:21', '2022年06月15日 09:08:31');
INSERT INTO `book_read` VALUES (24, 'rf11', '430', '1946现代世界的形成', '2022年06月15日 09:09:18', '2022年06月15日 09:09:26');
INSERT INTO `book_read` VALUES (25, 'rf', '460', '假面人', '2022年06月15日 17:50:42', '2022年06月15日 17:50:49');
INSERT INTO `book_read` VALUES (26, 'rf1', '460', '假面人', '2022年06月15日 17:51:02', '2022年06月15日 17:51:09');
INSERT INTO `book_read` VALUES (27, 'admin', '460', '假面人', '2022年06月16日 18:05:58', '');

-- ----------------------------
-- Table structure for book_user
-- ----------------------------
DROP TABLE IF EXISTS `book_user`;
CREATE TABLE `book_user`  (
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '登录名',
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usertype` int UNSIGNED NULL DEFAULT 2 COMMENT '用户类型 1教师 2学生',
  `realname` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '真实姓名',
  `studentno` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学号',
  `desc` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '专业',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `book_user_realname_7657d684`(`realname` ASC) USING BTREE,
  INDEX `book_user_studentno_d40edc74`(`studentno` ASC) USING BTREE,
  CONSTRAINT `book_user_chk_1` CHECK (`usertype` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_user
-- ----------------------------
INSERT INTO `book_user` VALUES ('pbkdf2_sha256$320000$XTMS23iGM3xKjrOJV5mogn$dR3Wb9jzUIYrtrIMGoSeottkSCzPCzDWZKYU2pspDvE=', '2022-06-10 09:00:35.793941', 0, 'zs', '', '', '', 0, 1, '2022-06-09 01:28:37.242360', 11, 2, '张三', '1002', '软件工程');
INSERT INTO `book_user` VALUES ('pbkdf2_sha256$320000$74foGbb7xziutGS7abx6GG$Z8Iye/pEkLl+JYw2VnBlpYIFSiqfx9wLPhskLVf/3Kc=', '2022-06-11 09:34:26.354992', 0, 'ls', '', '', '', 0, 1, '2022-06-09 01:42:40.984482', 12, 2, '李四', '1003', '应用化学');
INSERT INTO `book_user` VALUES ('pbkdf2_sha256$320000$ZkirGxqLSwu1OJaO6Z76B3$saZztyTcqGipvn0UCxfh5U/raz4ck+DLn4RQhzMy+nM=', '2022-06-13 11:27:43.612460', 0, 'zl', '', '', '', 0, 1, '2022-06-13 05:47:27.808818', 34, 2, '赵六', '1005', '计算机科学与技术');
INSERT INTO `book_user` VALUES ('pbkdf2_sha256$320000$Uu4E50eHs08sc5cMzWWadt$VnT5Z7SXD4OdaK1F56aVhbhw7jXuMF7cpxvgvdQkEOo=', '2022-06-16 10:04:47.318829', 0, 'admin', '', '', '', 0, 1, '2022-06-16 09:55:32.216139', 56, 1, 'admin', '1006', '计算机科学与技术');

-- ----------------------------
-- Table structure for book_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `book_user_groups`;
CREATE TABLE `book_user_groups`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `book_user_groups_user_id_group_id_215796e1_uniq`(`user_id` ASC, `group_id` ASC) USING BTREE,
  INDEX `book_user_groups_group_id_42a87701_fk_auth_group_id`(`group_id` ASC) USING BTREE,
  CONSTRAINT `book_user_groups_group_id_42a87701_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `book_user_groups_user_id_b7d49bd2_fk_book_user_id` FOREIGN KEY (`user_id`) REFERENCES `book_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for book_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `book_user_user_permissions`;
CREATE TABLE `book_user_user_permissions`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `book_user_user_permissions_user_id_permission_id_c0874424_uniq`(`user_id` ASC, `permission_id` ASC) USING BTREE,
  INDEX `book_user_user_permi_permission_id_7cb10e82_fk_auth_perm`(`permission_id` ASC) USING BTREE,
  CONSTRAINT `book_user_user_permi_permission_id_7cb10e82_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `book_user_user_permissions_user_id_0a2af966_fk_book_user_id` FOREIGN KEY (`user_id`) REFERENCES `book_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of book_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `content_type_id` int NULL DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb_fk_django_co`(`content_type_id` ASC) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6_fk_book_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_book_user_id` FOREIGN KEY (`user_id`) REFERENCES `book_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `django_admin_log_chk_1` CHECK (`action_flag` >= 0)
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label` ASC, `model` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (7, 'booksManage', 'books');
INSERT INTO `django_content_type` VALUES (8, 'booksManage', 'readbook');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (6, 'main', 'user');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2022-06-08 02:18:19.989541');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2022-06-08 02:18:20.043540');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2022-06-08 02:18:20.259414');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2022-06-08 02:18:20.309412');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2022-06-08 02:18:20.316412');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2022-06-08 02:18:20.323412');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2022-06-08 02:18:20.330412');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2022-06-08 02:18:20.333412');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2022-06-08 02:18:20.339412');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2022-06-08 02:18:20.345413');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2022-06-08 02:18:20.353412');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2022-06-08 02:18:20.367412');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2022-06-08 02:18:20.373412');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2022-06-08 02:18:20.380413');
INSERT INTO `django_migrations` VALUES (15, 'main', '0001_initial', '2022-06-08 02:18:20.671025');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0001_initial', '2022-06-08 02:18:20.785025');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0002_logentry_remove_auto_add', '2022-06-08 02:18:20.793026');
INSERT INTO `django_migrations` VALUES (18, 'admin', '0003_logentry_add_action_flag_choices', '2022-06-08 02:18:20.800164');
INSERT INTO `django_migrations` VALUES (19, 'sessions', '0001_initial', '2022-06-08 02:18:20.834991');
INSERT INTO `django_migrations` VALUES (20, 'booksManage', '0001_initial', '2022-06-09 03:13:28.031281');
INSERT INTO `django_migrations` VALUES (21, 'booksManage', '0002_readbook', '2022-06-10 00:29:26.955725');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0xtcycufaackh0x9qkhz4ki7vdcfh31k', '.eJxVjMsOwiAQRf-FtSE8Bigu3fsNhM5MpWogKe3K-O_apAvd3nPOfYmUt7WkrfOSZhJnAU6cfscx44PrTuie661JbHVd5lHuijxol9dG_Lwc7t9Byb18a54ArPKKQGt0hqdgyBD74EdrFGv0yBitJm8jDQgOtIXgtHMQh8BBvD_59jci:1o1HWw:gsgVeeYG4qy1hjfN5PHfMEMy9tvdu9Cp1KqA0h08kYQ', '2022-06-29 01:09:10.029833');
INSERT INTO `django_session` VALUES ('1tm8wuzm6206tcivxa9w8xm3dck4zrui', 'e30:1nzBeG:xZXpzxe-d5YRhxzYhHVLv0wL2wrrySZsXjf29h4BMC4', '2022-06-23 06:28:04.669543');
INSERT INTO `django_session` VALUES ('3g6g840ozvj24ssksdwn6u22qrkr6pmv', '.eJxVjEEOgjAQRe_StWlKgZnWpXvO0Ew7U4saSCisjHcXEha6_e-9_1aBtrWErcoSRlZXZVFdfsdI6SnTQfhB033WaZ7WZYz6UPRJqx5mltftdP8OCtWy1z7bmCL4RlzvexZyCBmAm4wJhLPzQNlgskl4V8R1iGTQtByho9yqzxctnzj0:1o0lQP:hGEX_26UJ2TGMkOofJhljF0xUecl86BzhgjryHXtQQo', '2022-06-27 14:52:17.985994');
INSERT INTO `django_session` VALUES ('a3z7xqe45efr1jsjhz7ircspetnzfnf7', '.eJxVjEsOwjAMBe-SNYrcpnUdluw5Q2XHMS2gVOpnhbg7VOoCtm9m3sv1vK1Dvy157kd1Z1eBO_2OwumRy070zuU2-TSVdR7F74o_6OKvk-bn5XD_DgZehm9tYCwdaAvUmqSQrI6NUIMSOiKjKnKFVCuJAhnkNiRCRBKMHVqo3fsDD4o3xA:1nzDqv:-iyM78ti4o806OvcrfVNYTQsKdmQaRAVxddgP-y25Jk', '2022-06-23 08:49:17.609474');
INSERT INTO `django_session` VALUES ('c5lymfzr92i4zju8mmf0qejt4lnik05z', 'e30:1nzBeE:Spvc8ydJyC0a-fm611rzA0gPPehOtO7nr2OyFUdiBMc', '2022-06-23 06:28:02.322812');
INSERT INTO `django_session` VALUES ('ig8vgp61g0v5jyavf0u2q0w0mcc2mkcy', '.eJxVjEsOwjAMBe-SNYrcpnUdluw5Q2XHMS2gVOpnhbg7VOoCtm9m3sv1vK1Dvy157kd1Z1eBO_2OwumRy070zuU2-TSVdR7F74o_6OKvk-bn5XD_DgZehm9tYCwdaAvUmqSQrI6NUIMSOiKjKnKFVCuJAhnkNiRCRBKMHVqo3fsDD4o3xA:1nzBeh:N_DjCSrTE0L6gBJUzeSRReTOGoZZGfhDF-dAhwHAJiA', '2022-06-23 06:28:31.400451');
INSERT INTO `django_session` VALUES ('kzvpi2ku2my6uf1ras0y5rdc25ip43qu', '.eJxVjEEOwiAQRe_C2hCmlAIu3XsGMswMUjVtUtqV8e7apAvd_vfef6mE21rT1mRJI6uzAnX63TLSQ6Yd8B2n26xpntZlzHpX9EGbvs4sz8vh_h1UbPVbh5KpJ8PcCw0ExF1w2YdOACyhzWQRYokGIhXjJRh0jtHzEKwXiKjeHwqjOIs:1nylw9:8k8ZLS-gvV6hG3ffouxnnEOnsvepuw-11ENAsGovvMw', '2022-06-22 03:00:49.593298');
INSERT INTO `django_session` VALUES ('ucmgwm0yajbur6ws622mno1a9g0o6z5l', '.eJxVjEsOwjAMBe-SNYrcpnUdluw5Q2XHMS2gVOpnhbg7VOoCtm9m3sv1vK1Dvy157kd1Z1eBO_2OwumRy070zuU2-TSVdR7F74o_6OKvk-bn5XD_DgZehm9tYCwdaAvUmqSQrI6NUIMSOiKjKnKFVCuJAhnkNiRCRBKMHVqo3fsDD4o3xA:1nzDSJ:RR9KKTdOGtRxdsWGAE05wVegu6UqVg7CLa4USr5hcNE', '2022-06-23 08:23:51.310708');
INSERT INTO `django_session` VALUES ('xw7v5uszbsj0mt3iyamfrlz7a6ql9uau', '.eJxVjEEOwiAQRe_C2hBoB5hx6b5nIFAGqRqalHZlvLtt0oVu33v_v4UP21r81njxUxJXYay4_MIYxifXw6RHqPdZjnNdlynKI5GnbXKYE79uZ_t3UEIr-1pbJEQHnTaoNChlnVOkMmHS2UStoTehI9p5ZoBIkNEimwS9DSaz-HwBrGU2Tw:1o1mMp:GoJ1o7Lm7jowBvz_b9kbhvrfA5yXl2Jnt7rj-61Zqp0', '2022-06-30 10:04:47.329315');

SET FOREIGN_KEY_CHECKS = 1;
