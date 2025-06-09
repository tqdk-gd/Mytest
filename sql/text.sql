/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80040 (8.0.40)
 Source Host           : localhost:3306
 Source Schema         : text

 Target Server Type    : MySQL
 Target Server Version : 80040 (8.0.40)
 File Encoding         : 65001

 Date: 04/06/2025 16:10:34
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for app
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app`  (
  `app_id` int NOT NULL,
  `class_id` int NULL DEFAULT NULL,
  `app_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`app_id`) USING BTREE,
  INDEX `class_id`(`class_id` ASC) USING BTREE,
  CONSTRAINT `app_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `web_app` (`web_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of app
-- ----------------------------
INSERT INTO `app` VALUES (1, 1, '蓝凌OA');
INSERT INTO `app` VALUES (2, 1, '泛微OA');
INSERT INTO `app` VALUES (3, 3, '用友U8');
INSERT INTO `app` VALUES (4, 1, '致远OA');
INSERT INTO `app` VALUES (5, 2, '速达软件');
INSERT INTO `app` VALUES (6, 2, 'dedecms');
INSERT INTO `app` VALUES (7, 2, 'ZZCMS');
INSERT INTO `app` VALUES (8, 2, 'WordPress');
INSERT INTO `app` VALUES (9, 4, 'NUUO网络视频录像机');
INSERT INTO `app` VALUES (10, 5, '万能门店小程序管理系统');
INSERT INTO `app` VALUES (11, 6, 'PAN-OS');
INSERT INTO `app` VALUES (12, 7, 'H3C http服务器');
INSERT INTO `app` VALUES (13, 8, 'Next.Js');
INSERT INTO `app` VALUES (14, 9, '青铜器RDM平台');
INSERT INTO `app` VALUES (15, 10, 'MajorDoMo DIY智能家居自动化平台');
INSERT INTO `app` VALUES (16, 5, '深科特LEAN MES系统');
INSERT INTO `app` VALUES (17, 12, '锐明Crocus系统');
INSERT INTO `app` VALUES (18, 11, '医院一站式后勤管理系统');
INSERT INTO `app` VALUES (19, 13, '网康科技NS-ASG 应用安全网关');
INSERT INTO `app` VALUES (20, 5, '广州图创图书馆集群管理系统');
INSERT INTO `app` VALUES (21, 3, '魔方网表ERP');
INSERT INTO `app` VALUES (22, 2, 'UNACMS');
INSERT INTO `app` VALUES (23, 14, 'CentreStack');
INSERT INTO `app` VALUES (24, 2, 'CmsEasy');
INSERT INTO `app` VALUES (25, 2, 'iceCMS');
INSERT INTO `app` VALUES (26, 2, 'jizhiCMS');
INSERT INTO `app` VALUES (27, 15, '其他');
INSERT INTO `app` VALUES (28, 16, 'adobe');

-- ----------------------------
-- Table structure for payload
-- ----------------------------
DROP TABLE IF EXISTS `payload`;
CREATE TABLE `payload`  (
  `payload_id` int NOT NULL,
  `app_id` int NULL DEFAULT NULL,
  `payload_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `payload_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `payload_sample` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `payload_param` bigint NULL DEFAULT NULL,
  `payload_dangerous` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '危险程度',
  `payload_repair` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '修复建议',
  PRIMARY KEY (`payload_id`) USING BTREE,
  INDEX `app_id`(`app_id` ASC) USING BTREE,
  CONSTRAINT `payload_ibfk_1` FOREIGN KEY (`app_id`) REFERENCES `app` (`app_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of payload
-- ----------------------------
INSERT INTO `payload` VALUES (1, 1, '蓝凌OA wechatLoginHelper.do SQL注入漏洞', './poc/payload.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (2, 1, '蓝凌OA admin.do SSRF+JNDI远程命令执行漏洞', './poc/payload2.py', '-u http://example.com -c [cookie] -d rmi://xxxxx:xxxx/exp', 2, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (3, 1, '蓝凌OA custom.jsp 任意文件读取漏洞', './poc/payload1.py', '-u http://example.com:9090', 0, '中危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (4, 2, '泛微OA E-Office do_excel.php 任意文件写入漏洞', './poc/payload3.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (5, 2, '泛微OA Bsh 远程代码执行漏洞', './poc/payload4.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (6, 2, '泛微OA V8 getdata.jsp SQL注入漏洞', './poc/payload5.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (7, 2, '泛微OA EOffice 信息泄露漏洞', './poc/payload6.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (8, 2, '泛微OA E-Cology portalTsLogin 文件读取漏洞', './poc/payload7.py', '-u http://example.com:9090', 0, '中危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (9, 2, '泛微OA WorkflowCenterTreeData接口 SQL注入漏洞', './poc/payload8.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (10, 2, '泛微OA  UploadFile.php 任意文件上传漏洞', './poc/payload9.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (11, 2, '泛微OA E-cology user.data 敏感信息泄露漏洞', './poc/payload10.py', '-u http://example.com:9090', 0, '低危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (12, 3, '用友U8-Cloud api/hr接口SQL注入漏洞', './poc/payload11.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (13, 3, '用友GRPU8 dialog_moreUser_check.jsp SQL注入漏洞', './poc/payload12.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (14, 3, '用友U8 Cloud RegisterServlet接口 SQL注入漏洞', './poc/payload13.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (15, 3, '用友GPR-U8 slbmbygr SQL注入漏洞', './poc/payload14.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (16, 3, '用友U8 Cloud FileServlet 任意文件读取漏洞', './poc/payload15.py', '-u http://example.com:9090', 0, '中危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (17, 3, '用友GRP-U8-FileUpload任意文件上传漏洞', './poc/payload16.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (18, 3, '用友 U8 CRM getemaildata.php 任意文件上传漏洞', './poc/payload17.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (19, 4, '致远OA ajax.do 任意文件上传漏洞', './poc/payload18.py', '-u http://example.com:9090 -c [cookie]', 1, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (20, 4, '致远OA前台任意用户密码重置漏洞', './poc/payload19.py', '-u http://example.com:9090', 0, '中危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (21, 4, '致远OA webmail.do 任意文件下载', './poc/payload20.py', '-u http://example.com:9090', 0, '低危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (22, 4, '致远OA getSessionList.jsp session泄露漏洞', './poc/payload21.py', '-u http://example.com:9090', 0, '低危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (23, 4, '致远OA 登录框处 Log4j2漏洞', './poc/payload22.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (24, 4, '致远OA A6 存在数据库敏感信息泄露', './poc/payload23.py', '-u http://example.com:9090', 0, '低危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (25, 4, '致远OA DownExcelBeanServlet接口 敏感信息泄露', './poc/payload24.py', '-u http://example.com:9090', 0, '低危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (26, 4, '致远OA initDataAssess.jsp 敏感信息泄露', './poc/payload25.py', '-u http://example.com:9090', 0, '低危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (27, 4, '致远OA test.jsp sql注入漏洞', './poc/payload26.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (28, 4, '致远OA setextno.jsp sql注入漏洞', './poc/payload27.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (29, 8, 'WordPress R+L Carrier Edition sql注入漏洞', './poc/payload28.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (30, 8, 'WordPress ltl-freight-quotes-estes-edition sql注入', './poc/payload29.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (31, 5, '速达软件 doSavePrintTpl sql注入漏洞', './poc/payload30.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (32, 9, 'NUUO网络视频录像机 handle_config.php 远程命令执行漏洞', './poc/payload31.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、关注厂商官网动态，及时更新补丁信息。');
INSERT INTO `payload` VALUES (33, 10, '万能门店小程序管理系统 dopagefxcount SQL注入漏洞', './poc/payload32.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至安全版本');
INSERT INTO `payload` VALUES (34, 6, 'dedecms 开放重定向漏洞', './poc/payload33.py', '-u http://example.com:9090 -d DNSlogurl', 1, '中危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、对低版本的dedecms进行更新或升级补丁https://www.dedecms.com/download#changelog（DedeCMS V5.7.65）');
INSERT INTO `payload` VALUES (35, 11, 'Palo Alto Networks PAN-OS 身份验证绕过漏洞', './poc/payload34.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、目前官方已发布安全更新，建议用户尽快升级至最新版本：https://security.paloaltonetworks.com/CVE-2025-0108');
INSERT INTO `payload` VALUES (36, 10, '万能门店小程序管理系统 doPageGuiz SQL注入漏洞', './poc/payload35.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至安全版本');
INSERT INTO `payload` VALUES (37, 12, 'H3C http服务器 /web/login SQL注入漏洞', './poc/payload36.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、下载官方补丁');
INSERT INTO `payload` VALUES (38, 13, 'Next.Js SSRF 漏洞(CVE-2024-34351)', './poc/payload37.py', '-u http://example.com:9090', 1, '中危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、下载官方补丁');
INSERT INTO `payload` VALUES (39, 14, '青铜器RDM研发管理平台 upload 任意文件上传漏洞', './poc/payload38.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至最新版本');
INSERT INTO `payload` VALUES (40, 15, 'MajorDoMo thumb.php 未授权RCE漏洞', './poc/payload39.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至最新版本');
INSERT INTO `payload` VALUES (41, 16, '深科特LEAN MES系统SMTLoadingMaterial SQL注入漏洞', './poc/payload40.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至最新版本');
INSERT INTO `payload` VALUES (42, 17, '锐明Crocus系统 DOWNLOAD 任意文件读取漏洞\r\n', './poc/payload41.py', '-u http://example.com:9090', 0, '低危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至最新版本https://www.streamax.com/');
INSERT INTO `payload` VALUES (43, 7, 'ZZCMS index.php SQL注入漏洞', './poc/payload42.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至安全版本');
INSERT INTO `payload` VALUES (44, 18, '医院一站式后勤管理系统 processApkUpload.upload 任意文件上传漏洞', './poc/payload43.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至安全版本');
INSERT INTO `payload` VALUES (45, 19, '网康科技 NS-ASG 应用安全网关 config_Anticrack.php SQL注入漏洞', './poc/payload44.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、目前官方已发布漏洞修复版本，建议用户升级到安全版本：https://www.netentsec.com/');
INSERT INTO `payload` VALUES (46, 19, '网康科技 NS-ASG 应用安全网关 add_postlogin.php SQL注入漏洞', './poc/payload45.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、目前官方已发布漏洞修复版本，建议用户升级到安全版本：https://www.netentsec.com/');
INSERT INTO `payload` VALUES (47, 19, '网康科技NS-ASG应用安全网关 config_ISCGroupNoCache.php SQL注入', './poc/payload46.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、目前官方已发布漏洞修复版本，建议用户升级到安全版本：https://www.netentsec.com/');
INSERT INTO `payload` VALUES (48, 19, '网康科技 NS-ASG 应用安全网关 add_ikev2.php SQL注入漏洞', './poc/payload47.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、目前官方已发布漏洞修复版本，建议用户升级到安全版本：https://www.netentsec.com/');
INSERT INTO `payload` VALUES (49, 20, '广州图创 图书馆集群管理系统 updOpuserPw SQL注入漏洞', './poc/payload48.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至安全版本');
INSERT INTO `payload` VALUES (50, 21, '魔方网表ERP mailupdate.jsp 任意文件上传漏洞', './poc/payload49.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至安全版本');
INSERT INTO `payload` VALUES (51, 22, 'UNACMS PHP对象注入漏洞', './poc/payload50.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至安全版本');
INSERT INTO `payload` VALUES (52, 23, 'CentreStack 反序列化漏洞', './poc/payload51.py', '-u http://example.com:9090', 0, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、更新至 16.4.10315.56368 并轮换machineKey作为零时缓解措施');
INSERT INTO `payload` VALUES (53, 24, 'CmsEasy-7.7.7.9-文件包含', './poc/payload52.py', '-u http://example.com:9090 -c cookie', 1, '中危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至安全版本');
INSERT INTO `payload` VALUES (54, 25, 'iceCMS-2.2.0-不正确的访问控制', './poc/payload53.py', '-u http://example.com:9090 -i 用户id', 1, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至安全版本');
INSERT INTO `payload` VALUES (55, 26, 'jizhiCMS-1.7.0-访问控制不当', './poc/payload54.py', '-u http://example.com:9090 -c cookie', 1, '高危漏洞', '1、关闭互联网暴露面或接口设置访问权限2、升级至安全版本');
INSERT INTO `payload` VALUES (56, 28, 'Adobe Client ID 泄露漏洞', './poc/payload55.py', '-u http://example.com:9090', 0, '低危漏洞', '1、及时更新软件：将 Adobe 相关产品更新到最新版本，以获取官方发布的漏洞修复补丁2、检查访问权限：仔细检查应用程序和系统中对 Client ID 的访问权限设置，确保只有授权的用户和进程能够访问。');
INSERT INTO `payload` VALUES (57, 28, '检测 Adobe ColdFusion 管理登录界面', './poc/payload56.py', '-u http://example.com:9090', 0, '低危漏洞', '1、及时更新软件：将 Adobe 相关产品更新到最新版本，以获取官方发布的漏洞修复补丁2、检查访问权限：仔细检查应用程序和系统中对 Client ID 的访问权限设置，确保只有授权的用户和进程能够访问。');
INSERT INTO `payload` VALUES (58, 28, '徽标检测 Adobe ColdFusion 实例的版本号', './poc/payload57.py', '-u http://example.com:9090', 0, '低危漏洞', '1、及时更新软件：将 Adobe 相关产品更新到最新版本，以获取官方发布的漏洞修复补丁2、检查访问权限：仔细检查应用程序和系统中对 Client ID 的访问权限设置，确保只有授权的用户和进程能够访问。');
INSERT INTO `payload` VALUES (59, 28, '通过错误页面检测运行中的 Adobe ColdFusion 实例', './poc/payload58.py', '-u http://example.com:9090', 0, '低危漏洞', '1、及时更新软件：将 Adobe 相关产品更新到最新版本，以获取官方发布的漏洞修复补丁2、检查访问权限：仔细检查应用程序和系统中对 Client ID 的访问权限设置，确保只有授权的用户和进程能够访问。');

-- ----------------------------
-- Table structure for poc
-- ----------------------------
DROP TABLE IF EXISTS `poc`;
CREATE TABLE `poc`  (
  `id` int NOT NULL,
  `class_id` int NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `class_id`(`class_id` ASC) USING BTREE,
  CONSTRAINT `class_id` FOREIGN KEY (`class_id`) REFERENCES `poc_class` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of poc
-- ----------------------------
INSERT INTO `poc` VALUES (1, 1, 'adobe-client-id', './poc/adobe/adobe-client-id.yaml');
INSERT INTO `poc` VALUES (2, 1, 'adobe-client-id_1', './poc/adobe/adobe-client-id_1.yaml');
INSERT INTO `poc` VALUES (3, 1, 'adobe-client-id_2', './poc/adobe/adobe-client-id_2.yaml');
INSERT INTO `poc` VALUES (4, 1, 'adobe-coldfusion-admin-interface', './poc/adobe/adobe-coldfusion-admin-interface.yaml');
INSERT INTO `poc` VALUES (5, 1, 'adobe-coldfusion-detect-82', './poc/adobe/adobe-coldfusion-detect-82.yaml');
INSERT INTO `poc` VALUES (6, 1, 'adobe-coldfusion-detect-83', './poc/adobe/adobe-coldfusion-detect-83.yaml');
INSERT INTO `poc` VALUES (7, 1, 'adobe-coldfusion-detect-84', './poc/adobe/adobe-coldfusion-detect-84.yaml');
INSERT INTO `poc` VALUES (8, 1, 'adobe-coldfusion-detect-84_1', './poc/adobe/adobe-coldfusion-detect-84_1.yaml');
INSERT INTO `poc` VALUES (9, 1, 'adobe-coldfusion-detect', './poc/adobe/adobe-coldfusion-detect.yaml');
INSERT INTO `poc` VALUES (10, 1, 'adobe-coldfusion-detector-error', './poc/adobe/adobe-coldfusion-detector-error.yaml');
INSERT INTO `poc` VALUES (11, 1, 'adobe-coldfusion-error-detect-86', './poc/adobe/adobe-coldfusion-error-detect-86.yaml');
INSERT INTO `poc` VALUES (12, 1, 'adobe-coldfusion-error-detect-87', './poc/adobe/adobe-coldfusion-error-detect-87.yaml');
INSERT INTO `poc` VALUES (13, 1, 'adobe-coldfusion-error-detect-88', './poc/adobe/adobe-coldfusion-error-detect-88.yaml');
INSERT INTO `poc` VALUES (14, 1, 'adobe-coldfusion-error-detect', './poc/adobe/adobe-coldfusion-error-detect.yaml');
INSERT INTO `poc` VALUES (15, 1, 'adobe-component-login-1', './poc/adobe/adobe-component-login-1.yaml');
INSERT INTO `poc` VALUES (16, 1, 'adobe-component-login-2', './poc/adobe/adobe-component-login-2.yaml');
INSERT INTO `poc` VALUES (17, 1, 'adobe-component-login-92', './poc/adobe/adobe-component-login-92.yaml');
INSERT INTO `poc` VALUES (18, 1, 'adobe-connect-central-login-97', './poc/adobe/adobe-connect-central-login-97.yaml');
INSERT INTO `poc` VALUES (19, 1, 'adobe-connect-central-login', './poc/adobe/adobe-connect-central-login.yaml');
INSERT INTO `poc` VALUES (20, 1, 'adobe-connect-username-exposure-100', './poc/adobe/adobe-connect-username-exposure-100.yaml');
INSERT INTO `poc` VALUES (21, 1, 'adobe-connect-username-exposure-101', './poc/adobe/adobe-connect-username-exposure-101.yaml');
INSERT INTO `poc` VALUES (22, 1, 'adobe-connect-username-exposure-98', './poc/adobe/adobe-connect-username-exposure-98.yaml');
INSERT INTO `poc` VALUES (23, 1, 'adobe-connect-username-exposure', './poc/adobe/adobe-connect-username-exposure.yaml');
INSERT INTO `poc` VALUES (24, 1, 'adobe-connect-version-104', './poc/adobe/adobe-connect-version-104.yaml');
INSERT INTO `poc` VALUES (25, 1, 'adobe-connect-version-104_1', './poc/adobe/adobe-connect-version-104_1.yaml');
INSERT INTO `poc` VALUES (26, 1, 'adobe-connect-version', './poc/adobe/adobe-connect-version.yaml');
INSERT INTO `poc` VALUES (27, 1, 'adobe-connect-version_1', './poc/adobe/adobe-connect-version_1.yaml');
INSERT INTO `poc` VALUES (28, 1, 'adobe-connect-version_2', './poc/adobe/adobe-connect-version_2.yaml');
INSERT INTO `poc` VALUES (29, 1, 'adobe-connect-version_3', './poc/adobe/adobe-connect-version_3.yaml');
INSERT INTO `poc` VALUES (30, 1, 'adobe-cq5', './poc/adobe/adobe-cq5.yaml');
INSERT INTO `poc` VALUES (31, 1, 'adobe-experience-manager-login', './poc/adobe/adobe-experience-manager-login.yaml');
INSERT INTO `poc` VALUES (32, 1, 'adobe-flex', './poc/adobe/adobe-flex.yaml');
INSERT INTO `poc` VALUES (33, 1, 'adobe-golive', './poc/adobe/adobe-golive.yaml');
INSERT INTO `poc` VALUES (34, 1, 'adobe-media-server-110', './poc/adobe/adobe-media-server-110.yaml');
INSERT INTO `poc` VALUES (35, 1, 'adobe-media-server-112', './poc/adobe/adobe-media-server-112.yaml');
INSERT INTO `poc` VALUES (36, 1, 'adobe-media-server-113', './poc/adobe/adobe-media-server-113.yaml');
INSERT INTO `poc` VALUES (37, 1, 'adobe-media-server-114', './poc/adobe/adobe-media-server-114.yaml');
INSERT INTO `poc` VALUES (38, 1, 'adobe-media-server-115', './poc/adobe/adobe-media-server-115.yaml');
INSERT INTO `poc` VALUES (39, 1, 'adobe-media-server', './poc/adobe/adobe-media-server.yaml');
INSERT INTO `poc` VALUES (40, 1, 'adobe-media-server_1', './poc/adobe/adobe-media-server_1.yaml');
INSERT INTO `poc` VALUES (41, 1, 'adobe-phish', './poc/adobe/adobe-phish.yaml');
INSERT INTO `poc` VALUES (42, 1, 'adobe-phish_1', './poc/adobe/adobe-phish_1.yaml');
INSERT INTO `poc` VALUES (43, 1, 'adobe-phish_1_1', './poc/adobe/adobe-phish_1_1.yaml');
INSERT INTO `poc` VALUES (44, 1, 'adobe-phish_2', './poc/adobe/adobe-phish_2.yaml');
INSERT INTO `poc` VALUES (45, 1, 'adobe-phish_3', './poc/adobe/adobe-phish_3.yaml');
INSERT INTO `poc` VALUES (46, 1, 'adobe-robohelp', './poc/adobe/adobe-robohelp.yaml');
INSERT INTO `poc` VALUES (47, 1, 'aem-acs-common', './poc/adobe/aem-acs-common.yaml');
INSERT INTO `poc` VALUES (48, 1, 'aem-acs-common_1', './poc/adobe/aem-acs-common_1.yaml');
INSERT INTO `poc` VALUES (49, 1, 'aem-acs-common_1_1', './poc/adobe/aem-acs-common_1_1.yaml');
INSERT INTO `poc` VALUES (50, 1, 'aem-acs-common_1_2', './poc/adobe/aem-acs-common_1_2.yaml');
INSERT INTO `poc` VALUES (51, 1, 'aem-bg-servlet-127', './poc/adobe/aem-bg-servlet-127.yaml');
INSERT INTO `poc` VALUES (52, 1, 'aem-bg-servlet-129', './poc/adobe/aem-bg-servlet-129.yaml');
INSERT INTO `poc` VALUES (53, 1, 'aem-bg-servlet', './poc/adobe/aem-bg-servlet.yaml');
INSERT INTO `poc` VALUES (54, 1, 'aem-bg-servlet_1', './poc/adobe/aem-bg-servlet_1.yaml');
INSERT INTO `poc` VALUES (55, 1, 'aem-bulkeditor', './poc/adobe/aem-bulkeditor.yaml');
INSERT INTO `poc` VALUES (56, 1, 'aem-bulkeditor_1', './poc/adobe/aem-bulkeditor_1.yaml');
INSERT INTO `poc` VALUES (57, 1, 'aem-bulkeditor_2', './poc/adobe/aem-bulkeditor_2.yaml');
INSERT INTO `poc` VALUES (58, 1, 'aem-bulkeditor_3', './poc/adobe/aem-bulkeditor_3.yaml');
INSERT INTO `poc` VALUES (59, 1, 'aem-cached-pages-130', './poc/adobe/aem-cached-pages-130.yaml');
INSERT INTO `poc` VALUES (60, 1, 'aem-cached-pages', './poc/adobe/aem-cached-pages.yaml');
INSERT INTO `poc` VALUES (61, 1, 'aem-cached-pages_1', './poc/adobe/aem-cached-pages_1.yaml');
INSERT INTO `poc` VALUES (62, 1, 'aem-cached-pages_2', './poc/adobe/aem-cached-pages_2.yaml');
INSERT INTO `poc` VALUES (63, 1, 'aem-cached-pages_3', './poc/adobe/aem-cached-pages_3.yaml');
INSERT INTO `poc` VALUES (64, 1, 'aem-cached-pages_4', './poc/adobe/aem-cached-pages_4.yaml');
INSERT INTO `poc` VALUES (65, 1, 'aem-cached-pages_4_1', './poc/adobe/aem-cached-pages_4_1.yaml');
INSERT INTO `poc` VALUES (66, 1, 'aem-cached-pages_5', './poc/adobe/aem-cached-pages_5.yaml');
INSERT INTO `poc` VALUES (67, 1, 'aem-cached-pages_6', './poc/adobe/aem-cached-pages_6.yaml');
INSERT INTO `poc` VALUES (68, 1, 'aem-childrenlist-xss', './poc/adobe/aem-childrenlist-xss.yaml');
INSERT INTO `poc` VALUES (69, 1, 'aem-cms-finder', './poc/adobe/aem-cms-finder.yaml');
INSERT INTO `poc` VALUES (70, 1, 'aem-cms-finder_1', './poc/adobe/aem-cms-finder_1.yaml');
INSERT INTO `poc` VALUES (71, 1, 'aem-cms', './poc/adobe/aem-cms.yaml');
INSERT INTO `poc` VALUES (72, 1, 'aem-cms_1', './poc/adobe/aem-cms_1.yaml');
INSERT INTO `poc` VALUES (73, 1, 'aem-cms_2', './poc/adobe/aem-cms_2.yaml');
INSERT INTO `poc` VALUES (74, 1, 'aem-crx-browser', './poc/adobe/aem-crx-browser.yaml');
INSERT INTO `poc` VALUES (75, 1, 'aem-crx-browser_1', './poc/adobe/aem-crx-browser_1.yaml');
INSERT INTO `poc` VALUES (76, 1, 'aem-crx-browser_2', './poc/adobe/aem-crx-browser_2.yaml');
INSERT INTO `poc` VALUES (77, 1, 'aem-crx-browser_3', './poc/adobe/aem-crx-browser_3.yaml');
INSERT INTO `poc` VALUES (78, 1, 'aem-crx-bypass-1', './poc/adobe/aem-crx-bypass-1.yaml');
INSERT INTO `poc` VALUES (79, 1, 'aem-crx-bypass-132', './poc/adobe/aem-crx-bypass-132.yaml');
INSERT INTO `poc` VALUES (80, 1, 'aem-crx-bypass-133', './poc/adobe/aem-crx-bypass-133.yaml');
INSERT INTO `poc` VALUES (81, 1, 'aem-crx-bypass-133_1', './poc/adobe/aem-crx-bypass-133_1.yaml');
INSERT INTO `poc` VALUES (82, 1, 'aem-crx-bypass-134', './poc/adobe/aem-crx-bypass-134.yaml');
INSERT INTO `poc` VALUES (83, 1, 'aem-crx-bypass-134_1', './poc/adobe/aem-crx-bypass-134_1.yaml');
INSERT INTO `poc` VALUES (84, 1, 'aem-crx-bypass-2', './poc/adobe/aem-crx-bypass-2.yaml');
INSERT INTO `poc` VALUES (85, 1, 'aem-crx-bypass', './poc/adobe/aem-crx-bypass.yaml');
INSERT INTO `poc` VALUES (86, 1, 'aem-crx-bypass_1', './poc/adobe/aem-crx-bypass_1.yaml');
INSERT INTO `poc` VALUES (87, 1, 'aem-crx-bypass_2', './poc/adobe/aem-crx-bypass_2.yaml');
INSERT INTO `poc` VALUES (88, 1, 'aem-crx-namespace', './poc/adobe/aem-crx-namespace.yaml');
INSERT INTO `poc` VALUES (89, 1, 'aem-crx-namespace_1', './poc/adobe/aem-crx-namespace_1.yaml');
INSERT INTO `poc` VALUES (90, 1, 'aem-crx-namespace_1_1', './poc/adobe/aem-crx-namespace_1_1.yaml');
INSERT INTO `poc` VALUES (91, 1, 'aem-crx-namespace_2', './poc/adobe/aem-crx-namespace_2.yaml');
INSERT INTO `poc` VALUES (92, 1, 'aem-crx-package-manager', './poc/adobe/aem-crx-package-manager.yaml');
INSERT INTO `poc` VALUES (93, 1, 'aem-crx-package-manager_1', './poc/adobe/aem-crx-package-manager_1.yaml');
INSERT INTO `poc` VALUES (94, 1, 'aem-crx-package-manager_2', './poc/adobe/aem-crx-package-manager_2.yaml');
INSERT INTO `poc` VALUES (95, 1, 'aem-crx-search', './poc/adobe/aem-crx-search.yaml');
INSERT INTO `poc` VALUES (96, 1, 'aem-crx-search_1', './poc/adobe/aem-crx-search_1.yaml');
INSERT INTO `poc` VALUES (97, 1, 'aem-crx-search_2', './poc/adobe/aem-crx-search_2.yaml');
INSERT INTO `poc` VALUES (98, 1, 'aem-custom-script', './poc/adobe/aem-custom-script.yaml');
INSERT INTO `poc` VALUES (99, 1, 'aem-custom-script_1', './poc/adobe/aem-custom-script_1.yaml');
INSERT INTO `poc` VALUES (100, 1, 'aem-custom-script_2', './poc/adobe/aem-custom-script_2.yaml');
INSERT INTO `poc` VALUES (101, 1, 'aem-custom-script_3', './poc/adobe/aem-custom-script_3.yaml');
INSERT INTO `poc` VALUES (102, 1, 'aem-debugging-libraries', './poc/adobe/aem-debugging-libraries.yaml');
INSERT INTO `poc` VALUES (103, 1, 'aem-debugging-libraries_1', './poc/adobe/aem-debugging-libraries_1.yaml');
INSERT INTO `poc` VALUES (104, 1, 'aem-debugging-libraries_2', './poc/adobe/aem-debugging-libraries_2.yaml');
INSERT INTO `poc` VALUES (105, 1, 'aem-debugging-libraries_3', './poc/adobe/aem-debugging-libraries_3.yaml');
INSERT INTO `poc` VALUES (106, 1, 'aem-default-get-servlet-1', './poc/adobe/aem-default-get-servlet-1.yaml');
INSERT INTO `poc` VALUES (107, 1, 'aem-default-get-servlet-10', './poc/adobe/aem-default-get-servlet-10.yaml');
INSERT INTO `poc` VALUES (108, 1, 'aem-default-get-servlet-11', './poc/adobe/aem-default-get-servlet-11.yaml');
INSERT INTO `poc` VALUES (109, 1, 'aem-default-get-servlet-12', './poc/adobe/aem-default-get-servlet-12.yaml');
INSERT INTO `poc` VALUES (110, 1, 'aem-default-get-servlet-13', './poc/adobe/aem-default-get-servlet-13.yaml');
INSERT INTO `poc` VALUES (111, 1, 'aem-default-get-servlet-135', './poc/adobe/aem-default-get-servlet-135.yaml');
INSERT INTO `poc` VALUES (112, 1, 'aem-default-get-servlet-136', './poc/adobe/aem-default-get-servlet-136.yaml');
INSERT INTO `poc` VALUES (113, 1, 'aem-default-get-servlet-137', './poc/adobe/aem-default-get-servlet-137.yaml');
INSERT INTO `poc` VALUES (114, 1, 'aem-default-get-servlet-138', './poc/adobe/aem-default-get-servlet-138.yaml');
INSERT INTO `poc` VALUES (115, 1, 'aem-default-get-servlet-139', './poc/adobe/aem-default-get-servlet-139.yaml');
INSERT INTO `poc` VALUES (116, 1, 'aem-default-get-servlet-14', './poc/adobe/aem-default-get-servlet-14.yaml');
INSERT INTO `poc` VALUES (117, 1, 'aem-default-get-servlet-15', './poc/adobe/aem-default-get-servlet-15.yaml');
INSERT INTO `poc` VALUES (118, 1, 'aem-default-get-servlet-16', './poc/adobe/aem-default-get-servlet-16.yaml');
INSERT INTO `poc` VALUES (119, 1, 'aem-default-get-servlet-17', './poc/adobe/aem-default-get-servlet-17.yaml');
INSERT INTO `poc` VALUES (120, 1, 'aem-default-get-servlet-18', './poc/adobe/aem-default-get-servlet-18.yaml');
INSERT INTO `poc` VALUES (121, 1, 'aem-default-get-servlet-19', './poc/adobe/aem-default-get-servlet-19.yaml');
INSERT INTO `poc` VALUES (122, 1, 'aem-default-get-servlet-2', './poc/adobe/aem-default-get-servlet-2.yaml');
INSERT INTO `poc` VALUES (123, 1, 'aem-default-get-servlet-20', './poc/adobe/aem-default-get-servlet-20.yaml');
INSERT INTO `poc` VALUES (124, 1, 'aem-default-get-servlet-21', './poc/adobe/aem-default-get-servlet-21.yaml');
INSERT INTO `poc` VALUES (125, 1, 'aem-default-get-servlet-22', './poc/adobe/aem-default-get-servlet-22.yaml');
INSERT INTO `poc` VALUES (126, 1, 'aem-default-get-servlet-23', './poc/adobe/aem-default-get-servlet-23.yaml');
INSERT INTO `poc` VALUES (127, 1, 'aem-default-get-servlet-24', './poc/adobe/aem-default-get-servlet-24.yaml');
INSERT INTO `poc` VALUES (128, 1, 'aem-default-get-servlet-25', './poc/adobe/aem-default-get-servlet-25.yaml');
INSERT INTO `poc` VALUES (129, 1, 'aem-default-get-servlet-26', './poc/adobe/aem-default-get-servlet-26.yaml');
INSERT INTO `poc` VALUES (130, 1, 'aem-default-get-servlet-27', './poc/adobe/aem-default-get-servlet-27.yaml');
INSERT INTO `poc` VALUES (131, 1, 'aem-default-get-servlet-28', './poc/adobe/aem-default-get-servlet-28.yaml');
INSERT INTO `poc` VALUES (132, 1, 'aem-default-get-servlet-29', './poc/adobe/aem-default-get-servlet-29.yaml');
INSERT INTO `poc` VALUES (133, 1, 'aem-default-get-servlet-3', './poc/adobe/aem-default-get-servlet-3.yaml');
INSERT INTO `poc` VALUES (134, 1, 'aem-default-get-servlet-30', './poc/adobe/aem-default-get-servlet-30.yaml');
INSERT INTO `poc` VALUES (135, 1, 'aem-default-get-servlet-31', './poc/adobe/aem-default-get-servlet-31.yaml');
INSERT INTO `poc` VALUES (136, 1, 'aem-default-get-servlet-32', './poc/adobe/aem-default-get-servlet-32.yaml');
INSERT INTO `poc` VALUES (137, 1, 'aem-default-get-servlet-33', './poc/adobe/aem-default-get-servlet-33.yaml');
INSERT INTO `poc` VALUES (138, 1, 'aem-default-get-servlet-34', './poc/adobe/aem-default-get-servlet-34.yaml');
INSERT INTO `poc` VALUES (139, 1, 'aem-default-get-servlet-35', './poc/adobe/aem-default-get-servlet-35.yaml');
INSERT INTO `poc` VALUES (140, 1, 'aem-default-get-servlet-36', './poc/adobe/aem-default-get-servlet-36.yaml');
INSERT INTO `poc` VALUES (141, 1, 'aem-default-get-servlet-37', './poc/adobe/aem-default-get-servlet-37.yaml');
INSERT INTO `poc` VALUES (142, 1, 'aem-default-get-servlet-38', './poc/adobe/aem-default-get-servlet-38.yaml');
INSERT INTO `poc` VALUES (143, 1, 'aem-default-get-servlet-39', './poc/adobe/aem-default-get-servlet-39.yaml');
INSERT INTO `poc` VALUES (144, 1, 'aem-default-get-servlet-4', './poc/adobe/aem-default-get-servlet-4.yaml');
INSERT INTO `poc` VALUES (145, 1, 'aem-default-get-servlet-40', './poc/adobe/aem-default-get-servlet-40.yaml');
INSERT INTO `poc` VALUES (146, 1, 'aem-default-get-servlet-41', './poc/adobe/aem-default-get-servlet-41.yaml');
INSERT INTO `poc` VALUES (147, 1, 'aem-default-get-servlet-42', './poc/adobe/aem-default-get-servlet-42.yaml');
INSERT INTO `poc` VALUES (148, 1, 'aem-default-get-servlet-43', './poc/adobe/aem-default-get-servlet-43.yaml');
INSERT INTO `poc` VALUES (149, 1, 'aem-default-get-servlet-44', './poc/adobe/aem-default-get-servlet-44.yaml');
INSERT INTO `poc` VALUES (150, 1, 'aem-default-get-servlet-45', './poc/adobe/aem-default-get-servlet-45.yaml');
INSERT INTO `poc` VALUES (151, 1, 'aem-default-get-servlet-46', './poc/adobe/aem-default-get-servlet-46.yaml');
INSERT INTO `poc` VALUES (152, 1, 'aem-default-get-servlet-47', './poc/adobe/aem-default-get-servlet-47.yaml');
INSERT INTO `poc` VALUES (153, 1, 'aem-default-get-servlet-48', './poc/adobe/aem-default-get-servlet-48.yaml');
INSERT INTO `poc` VALUES (154, 1, 'aem-default-get-servlet-49', './poc/adobe/aem-default-get-servlet-49.yaml');
INSERT INTO `poc` VALUES (155, 1, 'aem-default-get-servlet-5', './poc/adobe/aem-default-get-servlet-5.yaml');
INSERT INTO `poc` VALUES (156, 1, 'aem-default-get-servlet-50', './poc/adobe/aem-default-get-servlet-50.yaml');
INSERT INTO `poc` VALUES (157, 1, 'aem-default-get-servlet-51', './poc/adobe/aem-default-get-servlet-51.yaml');
INSERT INTO `poc` VALUES (158, 1, 'aem-default-get-servlet-52', './poc/adobe/aem-default-get-servlet-52.yaml');
INSERT INTO `poc` VALUES (159, 1, 'aem-default-get-servlet-53', './poc/adobe/aem-default-get-servlet-53.yaml');
INSERT INTO `poc` VALUES (160, 1, 'aem-default-get-servlet-54', './poc/adobe/aem-default-get-servlet-54.yaml');
INSERT INTO `poc` VALUES (161, 1, 'aem-default-get-servlet-55', './poc/adobe/aem-default-get-servlet-55.yaml');
INSERT INTO `poc` VALUES (162, 1, 'aem-default-get-servlet-56', './poc/adobe/aem-default-get-servlet-56.yaml');
INSERT INTO `poc` VALUES (163, 1, 'aem-default-get-servlet-6', './poc/adobe/aem-default-get-servlet-6.yaml');
INSERT INTO `poc` VALUES (164, 1, 'aem-default-get-servlet-7', './poc/adobe/aem-default-get-servlet-7.yaml');
INSERT INTO `poc` VALUES (165, 1, 'aem-default-get-servlet-8', './poc/adobe/aem-default-get-servlet-8.yaml');
INSERT INTO `poc` VALUES (166, 1, 'aem-default-get-servlet-9', './poc/adobe/aem-default-get-servlet-9.yaml');
INSERT INTO `poc` VALUES (167, 1, 'aem-default-get-servlet', './poc/adobe/aem-default-get-servlet.yaml');
INSERT INTO `poc` VALUES (168, 1, 'aem-detaction', './poc/adobe/aem-detaction.yaml');
INSERT INTO `poc` VALUES (169, 1, 'aem-detect', './poc/adobe/aem-detect.yaml');
INSERT INTO `poc` VALUES (170, 1, 'aem-detection-144', './poc/adobe/aem-detection-144.yaml');
INSERT INTO `poc` VALUES (171, 1, 'aem-detection-145', './poc/adobe/aem-detection-145.yaml');
INSERT INTO `poc` VALUES (172, 1, 'aem-detection-146', './poc/adobe/aem-detection-146.yaml');
INSERT INTO `poc` VALUES (173, 1, 'aem-detection', './poc/adobe/aem-detection.yaml');
INSERT INTO `poc` VALUES (174, 1, 'aem-disk-usage', './poc/adobe/aem-disk-usage.yaml');
INSERT INTO `poc` VALUES (175, 1, 'aem-disk-usage_1', './poc/adobe/aem-disk-usage_1.yaml');
INSERT INTO `poc` VALUES (176, 1, 'aem-disk-usage_1_1', './poc/adobe/aem-disk-usage_1_1.yaml');
INSERT INTO `poc` VALUES (177, 1, 'aem-disk-usage_1_2', './poc/adobe/aem-disk-usage_1_2.yaml');
INSERT INTO `poc` VALUES (178, 1, 'aem-dump-contentnode', './poc/adobe/aem-dump-contentnode.yaml');
INSERT INTO `poc` VALUES (179, 1, 'aem-dump-contentnode_1', './poc/adobe/aem-dump-contentnode_1.yaml');
INSERT INTO `poc` VALUES (180, 1, 'aem-explorer-nodetypes', './poc/adobe/aem-explorer-nodetypes.yaml');
INSERT INTO `poc` VALUES (181, 1, 'aem-explorer-nodetypes_1', './poc/adobe/aem-explorer-nodetypes_1.yaml');
INSERT INTO `poc` VALUES (182, 1, 'aem-explorer-nodetypes_1_1', './poc/adobe/aem-explorer-nodetypes_1_1.yaml');
INSERT INTO `poc` VALUES (183, 1, 'aem-external-link-checker', './poc/adobe/aem-external-link-checker.yaml');
INSERT INTO `poc` VALUES (184, 1, 'aem-external-link-checker_1', './poc/adobe/aem-external-link-checker_1.yaml');
INSERT INTO `poc` VALUES (185, 1, 'aem-external-link-checker_2', './poc/adobe/aem-external-link-checker_2.yaml');
INSERT INTO `poc` VALUES (186, 1, 'aem-external-link-checker_3', './poc/adobe/aem-external-link-checker_3.yaml');
INSERT INTO `poc` VALUES (187, 1, 'aem-felix-console', './poc/adobe/aem-felix-console.yaml');
INSERT INTO `poc` VALUES (188, 1, 'aem-felix-console_1', './poc/adobe/aem-felix-console_1.yaml');
INSERT INTO `poc` VALUES (189, 1, 'aem-felix-console_2', './poc/adobe/aem-felix-console_2.yaml');
INSERT INTO `poc` VALUES (190, 1, 'aem-felix-console_3', './poc/adobe/aem-felix-console_3.yaml');
INSERT INTO `poc` VALUES (191, 1, 'aem-felix-console_4', './poc/adobe/aem-felix-console_4.yaml');
INSERT INTO `poc` VALUES (192, 1, 'aem-felix-console_5', './poc/adobe/aem-felix-console_5.yaml');
INSERT INTO `poc` VALUES (193, 1, 'aem-gql-servlet-147', './poc/adobe/aem-gql-servlet-147.yaml');
INSERT INTO `poc` VALUES (194, 1, 'aem-gql-servlet-149', './poc/adobe/aem-gql-servlet-149.yaml');
INSERT INTO `poc` VALUES (195, 1, 'aem-gql-servlet-149_1', './poc/adobe/aem-gql-servlet-149_1.yaml');
INSERT INTO `poc` VALUES (196, 1, 'aem-gql-servlet-150', './poc/adobe/aem-gql-servlet-150.yaml');
INSERT INTO `poc` VALUES (197, 1, 'aem-gql-servlet', './poc/adobe/aem-gql-servlet.yaml');
INSERT INTO `poc` VALUES (198, 1, 'aem-gql-servlet_1', './poc/adobe/aem-gql-servlet_1.yaml');
INSERT INTO `poc` VALUES (199, 1, 'aem-groovy-console', './poc/adobe/aem-groovy-console.yaml');
INSERT INTO `poc` VALUES (200, 1, 'aem-groovyconsole-151', './poc/adobe/aem-groovyconsole-151.yaml');
INSERT INTO `poc` VALUES (201, 1, 'aem-groovyconsole-153', './poc/adobe/aem-groovyconsole-153.yaml');
INSERT INTO `poc` VALUES (202, 1, 'aem-groovyconsole-154', './poc/adobe/aem-groovyconsole-154.yaml');
INSERT INTO `poc` VALUES (203, 1, 'aem-groovyconsole-155', './poc/adobe/aem-groovyconsole-155.yaml');
INSERT INTO `poc` VALUES (204, 1, 'aem-groovyconsole-156', './poc/adobe/aem-groovyconsole-156.yaml');
INSERT INTO `poc` VALUES (205, 1, 'aem-groovyconsole', './poc/adobe/aem-groovyconsole.yaml');
INSERT INTO `poc` VALUES (206, 1, 'aem-groovyconsole_1', './poc/adobe/aem-groovyconsole_1.yaml');
INSERT INTO `poc` VALUES (207, 1, 'aem-groovyconsole_2', './poc/adobe/aem-groovyconsole_2.yaml');
INSERT INTO `poc` VALUES (208, 1, 'aem-hash-querybuilder-157', './poc/adobe/aem-hash-querybuilder-157.yaml');
INSERT INTO `poc` VALUES (209, 1, 'aem-hash-querybuilder-159', './poc/adobe/aem-hash-querybuilder-159.yaml');
INSERT INTO `poc` VALUES (210, 1, 'aem-hash-querybuilder-160', './poc/adobe/aem-hash-querybuilder-160.yaml');
INSERT INTO `poc` VALUES (211, 1, 'aem-hash-querybuilder-160_1', './poc/adobe/aem-hash-querybuilder-160_1.yaml');
INSERT INTO `poc` VALUES (212, 1, 'aem-hash-querybuilder-161', './poc/adobe/aem-hash-querybuilder-161.yaml');
INSERT INTO `poc` VALUES (213, 1, 'aem-hash-querybuilder', './poc/adobe/aem-hash-querybuilder.yaml');
INSERT INTO `poc` VALUES (214, 1, 'aem-hash-querybuilder_1', './poc/adobe/aem-hash-querybuilder_1.yaml');
INSERT INTO `poc` VALUES (215, 1, 'aem-hash-querybuilder_2', './poc/adobe/aem-hash-querybuilder_2.yaml');
INSERT INTO `poc` VALUES (216, 1, 'aem-jcr-querybuilder-162', './poc/adobe/aem-jcr-querybuilder-162.yaml');
INSERT INTO `poc` VALUES (217, 1, 'aem-jcr-querybuilder-165', './poc/adobe/aem-jcr-querybuilder-165.yaml');
INSERT INTO `poc` VALUES (218, 1, 'aem-jcr-querybuilder-165_1', './poc/adobe/aem-jcr-querybuilder-165_1.yaml');
INSERT INTO `poc` VALUES (219, 1, 'aem-jcr-querybuilder-166', './poc/adobe/aem-jcr-querybuilder-166.yaml');
INSERT INTO `poc` VALUES (220, 1, 'aem-jcr-querybuilder', './poc/adobe/aem-jcr-querybuilder.yaml');
INSERT INTO `poc` VALUES (221, 1, 'aem-jcr-querybuilder_1', './poc/adobe/aem-jcr-querybuilder_1.yaml');
INSERT INTO `poc` VALUES (222, 1, 'aem-list-custom', './poc/adobe/aem-list-custom.yaml');
INSERT INTO `poc` VALUES (223, 1, 'aem-list-custom_1', './poc/adobe/aem-list-custom_1.yaml');
INSERT INTO `poc` VALUES (224, 1, 'aem-login-status', './poc/adobe/aem-login-status.yaml');
INSERT INTO `poc` VALUES (225, 1, 'aem-merge-metadata-servlet-172', './poc/adobe/aem-merge-metadata-servlet-172.yaml');
INSERT INTO `poc` VALUES (226, 1, 'aem-merge-metadata-servlet-174', './poc/adobe/aem-merge-metadata-servlet-174.yaml');
INSERT INTO `poc` VALUES (227, 1, 'aem-merge-metadata-servlet', './poc/adobe/aem-merge-metadata-servlet.yaml');
INSERT INTO `poc` VALUES (228, 1, 'aem-merge-metadata-servlet_1', './poc/adobe/aem-merge-metadata-servlet_1.yaml');
INSERT INTO `poc` VALUES (229, 1, 'aem-misc-admin', './poc/adobe/aem-misc-admin.yaml');
INSERT INTO `poc` VALUES (230, 1, 'aem-misc-admin_1', './poc/adobe/aem-misc-admin_1.yaml');
INSERT INTO `poc` VALUES (231, 1, 'aem-misc-admin_1_1', './poc/adobe/aem-misc-admin_1_1.yaml');
INSERT INTO `poc` VALUES (232, 1, 'aem-misc-admin_1_2', './poc/adobe/aem-misc-admin_1_2.yaml');
INSERT INTO `poc` VALUES (233, 1, 'aem-misconfig', './poc/adobe/aem-misconfig.yaml');
INSERT INTO `poc` VALUES (234, 1, 'aem-offloading-browser', './poc/adobe/aem-offloading-browser.yaml');
INSERT INTO `poc` VALUES (235, 1, 'aem-offloading-browser_1', './poc/adobe/aem-offloading-browser_1.yaml');
INSERT INTO `poc` VALUES (236, 1, 'aem-offloading-browser_1_1', './poc/adobe/aem-offloading-browser_1_1.yaml');
INSERT INTO `poc` VALUES (237, 1, 'aem-offloading-browser_2', './poc/adobe/aem-offloading-browser_2.yaml');
INSERT INTO `poc` VALUES (238, 1, 'aem-osgi-bundles', './poc/adobe/aem-osgi-bundles.yaml');
INSERT INTO `poc` VALUES (239, 1, 'aem-osgi-bundles_1', './poc/adobe/aem-osgi-bundles_1.yaml');
INSERT INTO `poc` VALUES (240, 1, 'aem-osgi-bundles_1_1', './poc/adobe/aem-osgi-bundles_1_1.yaml');
INSERT INTO `poc` VALUES (241, 1, 'aem-osgi-bundles_1_2', './poc/adobe/aem-osgi-bundles_1_2.yaml');
INSERT INTO `poc` VALUES (242, 1, 'aem-querybuilder-feed-servlet-175', './poc/adobe/aem-querybuilder-feed-servlet-175.yaml');
INSERT INTO `poc` VALUES (243, 1, 'aem-querybuilder-feed-servlet-177', './poc/adobe/aem-querybuilder-feed-servlet-177.yaml');
INSERT INTO `poc` VALUES (244, 1, 'aem-querybuilder-feed-servlet', './poc/adobe/aem-querybuilder-feed-servlet.yaml');
INSERT INTO `poc` VALUES (245, 1, 'aem-querybuilder-feed-servlet_1', './poc/adobe/aem-querybuilder-feed-servlet_1.yaml');
INSERT INTO `poc` VALUES (246, 1, 'aem-querybuilder-internal-path-read-1', './poc/adobe/aem-querybuilder-internal-path-read-1.yaml');
INSERT INTO `poc` VALUES (247, 1, 'aem-querybuilder-internal-path-read-178', './poc/adobe/aem-querybuilder-internal-path-read-178.yaml');
INSERT INTO `poc` VALUES (248, 1, 'aem-querybuilder-internal-path-read-179', './poc/adobe/aem-querybuilder-internal-path-read-179.yaml');
INSERT INTO `poc` VALUES (249, 1, 'aem-querybuilder-internal-path-read-180', './poc/adobe/aem-querybuilder-internal-path-read-180.yaml');
INSERT INTO `poc` VALUES (250, 1, 'aem-querybuilder-internal-path-read-180_1', './poc/adobe/aem-querybuilder-internal-path-read-180_1.yaml');
INSERT INTO `poc` VALUES (251, 1, 'aem-querybuilder-internal-path-read-181', './poc/adobe/aem-querybuilder-internal-path-read-181.yaml');
INSERT INTO `poc` VALUES (252, 1, 'aem-querybuilder-internal-path-read-2', './poc/adobe/aem-querybuilder-internal-path-read-2.yaml');
INSERT INTO `poc` VALUES (253, 1, 'aem-querybuilder-internal-path-read-3', './poc/adobe/aem-querybuilder-internal-path-read-3.yaml');
INSERT INTO `poc` VALUES (254, 1, 'aem-querybuilder-internal-path-read-4', './poc/adobe/aem-querybuilder-internal-path-read-4.yaml');
INSERT INTO `poc` VALUES (255, 1, 'aem-querybuilder-internal-path-read', './poc/adobe/aem-querybuilder-internal-path-read.yaml');
INSERT INTO `poc` VALUES (256, 1, 'aem-querybuilder-internal-path-read_1', './poc/adobe/aem-querybuilder-internal-path-read_1.yaml');
INSERT INTO `poc` VALUES (257, 1, 'aem-querybuilder-internal-path-read_1_1', './poc/adobe/aem-querybuilder-internal-path-read_1_1.yaml');
INSERT INTO `poc` VALUES (258, 1, 'aem-querybuilder-internal-path-read_2', './poc/adobe/aem-querybuilder-internal-path-read_2.yaml');
INSERT INTO `poc` VALUES (259, 1, 'aem-querybuilder-internal-path-read_3', './poc/adobe/aem-querybuilder-internal-path-read_3.yaml');
INSERT INTO `poc` VALUES (260, 1, 'aem-querybuilder-json-servlet-182', './poc/adobe/aem-querybuilder-json-servlet-182.yaml');
INSERT INTO `poc` VALUES (261, 1, 'aem-querybuilder-json-servlet-184', './poc/adobe/aem-querybuilder-json-servlet-184.yaml');
INSERT INTO `poc` VALUES (262, 1, 'aem-querybuilder-json-servlet-185', './poc/adobe/aem-querybuilder-json-servlet-185.yaml');
INSERT INTO `poc` VALUES (263, 1, 'aem-querybuilder-json-servlet-186', './poc/adobe/aem-querybuilder-json-servlet-186.yaml');
INSERT INTO `poc` VALUES (264, 1, 'aem-querybuilder-json-servlet-187', './poc/adobe/aem-querybuilder-json-servlet-187.yaml');
INSERT INTO `poc` VALUES (265, 1, 'aem-querybuilder-json-servlet', './poc/adobe/aem-querybuilder-json-servlet.yaml');
INSERT INTO `poc` VALUES (266, 1, 'aem-querybuilder-json-servlet_1', './poc/adobe/aem-querybuilder-json-servlet_1.yaml');
INSERT INTO `poc` VALUES (267, 1, 'aem-security-users', './poc/adobe/aem-security-users.yaml');
INSERT INTO `poc` VALUES (268, 1, 'aem-security-users_1', './poc/adobe/aem-security-users_1.yaml');
INSERT INTO `poc` VALUES (269, 1, 'aem-setpreferences-xss-189', './poc/adobe/aem-setpreferences-xss-189.yaml');
INSERT INTO `poc` VALUES (270, 1, 'aem-setpreferences-xss', './poc/adobe/aem-setpreferences-xss.yaml');
INSERT INTO `poc` VALUES (271, 1, 'aem-sling-login', './poc/adobe/aem-sling-login.yaml');
INSERT INTO `poc` VALUES (272, 1, 'aem-sling-login_1', './poc/adobe/aem-sling-login_1.yaml');
INSERT INTO `poc` VALUES (273, 1, 'aem-sling-userinfo', './poc/adobe/aem-sling-userinfo.yaml');
INSERT INTO `poc` VALUES (274, 1, 'aem-sling-userinfo_1', './poc/adobe/aem-sling-userinfo_1.yaml');
INSERT INTO `poc` VALUES (275, 1, 'aem-sling-userinfo_2', './poc/adobe/aem-sling-userinfo_2.yaml');
INSERT INTO `poc` VALUES (276, 1, 'aem-sling-userinfo_3', './poc/adobe/aem-sling-userinfo_3.yaml');
INSERT INTO `poc` VALUES (277, 1, 'aem-userinfo-servlet-193', './poc/adobe/aem-userinfo-servlet-193.yaml');
INSERT INTO `poc` VALUES (278, 1, 'aem-userinfo-servlet', './poc/adobe/aem-userinfo-servlet.yaml');
INSERT INTO `poc` VALUES (279, 1, 'aem-wcm-suggestions-servlet-194', './poc/adobe/aem-wcm-suggestions-servlet-194.yaml');
INSERT INTO `poc` VALUES (280, 1, 'aem-wcm-suggestions-servlet-196', './poc/adobe/aem-wcm-suggestions-servlet-196.yaml');
INSERT INTO `poc` VALUES (281, 1, 'aem-wcm-suggestions-servlet', './poc/adobe/aem-wcm-suggestions-servlet.yaml');
INSERT INTO `poc` VALUES (282, 1, 'aem-wcm-suggestions-servlet_1', './poc/adobe/aem-wcm-suggestions-servlet_1.yaml');
INSERT INTO `poc` VALUES (283, 1, 'aem-wcm-suggestions-servlet_1_1', './poc/adobe/aem-wcm-suggestions-servlet_1_1.yaml');
INSERT INTO `poc` VALUES (284, 1, 'aem-xss-childlist-selector', './poc/adobe/aem-xss-childlist-selector.yaml');
INSERT INTO `poc` VALUES (285, 1, 'aem-xss-childlist', './poc/adobe/aem-xss-childlist.yaml');
INSERT INTO `poc` VALUES (286, 1, 'cached-aem-pages', './poc/adobe/cached-aem-pages.yaml');
INSERT INTO `poc` VALUES (287, 1, 'cached-aem-pages_1', './poc/adobe/cached-aem-pages_1.yaml');
INSERT INTO `poc` VALUES (288, 1, 'cached-aem-pages_2', './poc/adobe/cached-aem-pages_2.yaml');
INSERT INTO `poc` VALUES (289, 1, 'cached-aem-pages_3', './poc/adobe/cached-aem-pages_3.yaml');
INSERT INTO `poc` VALUES (290, 1, 'custom-aem-ACPV-detect', './poc/adobe/custom-aem-ACPV-detect.yaml');
INSERT INTO `poc` VALUES (291, 1, 'custom-aem-xss', './poc/adobe/custom-aem-xss.yaml');
INSERT INTO `poc` VALUES (292, 1, 'erlang-daemon', './poc/adobe/erlang-daemon.yaml');
INSERT INTO `poc` VALUES (293, 1, 'erlang-daemon_1', './poc/adobe/erlang-daemon_1.yaml');
INSERT INTO `poc` VALUES (294, 1, 'erlang-daemon_2', './poc/adobe/erlang-daemon_2.yaml');
INSERT INTO `poc` VALUES (295, 1, 'erlang-daemon_3', './poc/adobe/erlang-daemon_3.yaml');
INSERT INTO `poc` VALUES (296, 1, 'mdaemon-email-server', './poc/adobe/mdaemon-email-server.yaml');
INSERT INTO `poc` VALUES (297, 1, 'possible-AEM-secrets', './poc/adobe/possible-AEM-secrets.yaml');
INSERT INTO `poc` VALUES (298, 1, 'servudaemon-ini', './poc/adobe/servudaemon-ini.yaml');
INSERT INTO `poc` VALUES (299, 1, 'servudaemon-ini_1', './poc/adobe/servudaemon-ini_1.yaml');
INSERT INTO `poc` VALUES (300, 1, 'SSRF-AEM-2018-12809', './poc/adobe/SSRF-AEM-2018-12809.yaml');
INSERT INTO `poc` VALUES (301, 1, 'ultraembed-advanced-iframe-fa4f89e20e8d18716200f9490864ea6f', './poc/adobe/ultraembed-advanced-iframe-fa4f89e20e8d18716200f9490864ea6f.yaml');
INSERT INTO `poc` VALUES (302, 1, 'ultraembed-advanced-iframe', './poc/adobe/ultraembed-advanced-iframe.yaml');
INSERT INTO `poc` VALUES (303, 2, 'airflow-api-exposure', './poc/airflow/airflow-api-exposure.yaml');
INSERT INTO `poc` VALUES (304, 2, 'airflow-api-exposure_1', './poc/airflow/airflow-api-exposure_1.yaml');
INSERT INTO `poc` VALUES (305, 2, 'airflow-configuration-exposure', './poc/airflow/airflow-configuration-exposure.yaml');
INSERT INTO `poc` VALUES (306, 2, 'airflow-debug-231', './poc/airflow/airflow-debug-231.yaml');
INSERT INTO `poc` VALUES (307, 2, 'airflow-debug-233', './poc/airflow/airflow-debug-233.yaml');
INSERT INTO `poc` VALUES (308, 2, 'airflow-debug', './poc/airflow/airflow-debug.yaml');
INSERT INTO `poc` VALUES (309, 2, 'airflow-debug_1', './poc/airflow/airflow-debug_1.yaml');
INSERT INTO `poc` VALUES (310, 2, 'airflow-debug_1_1', './poc/airflow/airflow-debug_1_1.yaml');
INSERT INTO `poc` VALUES (311, 2, 'airflow-debug_2', './poc/airflow/airflow-debug_2.yaml');
INSERT INTO `poc` VALUES (312, 2, 'airflow-debug_3', './poc/airflow/airflow-debug_3.yaml');
INSERT INTO `poc` VALUES (313, 2, 'airflow-debug_4', './poc/airflow/airflow-debug_4.yaml');
INSERT INTO `poc` VALUES (314, 2, 'airflow-debug_5', './poc/airflow/airflow-debug_5.yaml');
INSERT INTO `poc` VALUES (315, 2, 'airflow-default-credentials', './poc/airflow/airflow-default-credentials.yaml');
INSERT INTO `poc` VALUES (316, 2, 'airflow-default-login-234', './poc/airflow/airflow-default-login-234.yaml');
INSERT INTO `poc` VALUES (317, 2, 'airflow-default-login', './poc/airflow/airflow-default-login.yaml');
INSERT INTO `poc` VALUES (318, 2, 'airflow-default-login_2', './poc/airflow/airflow-default-login_2.yaml');
INSERT INTO `poc` VALUES (319, 2, 'airflow-detect-238', './poc/airflow/airflow-detect-238.yaml');
INSERT INTO `poc` VALUES (320, 2, 'airflow-detect-239', './poc/airflow/airflow-detect-239.yaml');
INSERT INTO `poc` VALUES (321, 2, 'airflow-detect-240', './poc/airflow/airflow-detect-240.yaml');
INSERT INTO `poc` VALUES (322, 2, 'airflow-detect', './poc/airflow/airflow-detect.yaml');
INSERT INTO `poc` VALUES (323, 2, 'airflow-exposure', './poc/airflow/airflow-exposure.yaml');
INSERT INTO `poc` VALUES (324, 2, 'airflow-panel-241', './poc/airflow/airflow-panel-241.yaml');
INSERT INTO `poc` VALUES (325, 2, 'airflow-panel-242', './poc/airflow/airflow-panel-242.yaml');
INSERT INTO `poc` VALUES (326, 2, 'airflow-panel-244', './poc/airflow/airflow-panel-244.yaml');
INSERT INTO `poc` VALUES (327, 2, 'airflow-panel-245', './poc/airflow/airflow-panel-245.yaml');
INSERT INTO `poc` VALUES (328, 2, 'airflow-panel', './poc/airflow/airflow-panel.yaml');
INSERT INTO `poc` VALUES (329, 2, 'airflow-panel_1', './poc/airflow/airflow-panel_1.yaml');
INSERT INTO `poc` VALUES (330, 2, 'airflow-panel_2', './poc/airflow/airflow-panel_2.yaml');
INSERT INTO `poc` VALUES (331, 2, 'airflow', './poc/airflow/airflow.yaml');
INSERT INTO `poc` VALUES (332, 2, 'unauthenticated-airflow-10884', './poc/airflow/unauthenticated-airflow-10884.yaml');
INSERT INTO `poc` VALUES (333, 2, 'unauthenticated-airflow-10884_1', './poc/airflow/unauthenticated-airflow-10884_1.yaml');
INSERT INTO `poc` VALUES (334, 2, 'unauthenticated-airflow-10886', './poc/airflow/unauthenticated-airflow-10886.yaml');
INSERT INTO `poc` VALUES (335, 2, 'unauthenticated-airflow-10887', './poc/airflow/unauthenticated-airflow-10887.yaml');
INSERT INTO `poc` VALUES (336, 2, 'unauthenticated-airflow', './poc/airflow/unauthenticated-airflow.yaml');
INSERT INTO `poc` VALUES (337, 3, 'apache-activemq-artemis-detect', './poc/apache/apache-activemq-artemis-detect.yaml');
INSERT INTO `poc` VALUES (338, 3, 'apache-activemq-detect', './poc/apache/apache-activemq-detect.yaml');
INSERT INTO `poc` VALUES (339, 3, 'APACHE-Ambari-weakPass', './poc/apache/APACHE-Ambari-weakPass.yaml');
INSERT INTO `poc` VALUES (340, 3, 'apache-apollo-panel', './poc/apache/apache-apollo-panel.yaml');
INSERT INTO `poc` VALUES (341, 3, 'apache-apollo-panel_1', './poc/apache/apache-apollo-panel_1.yaml');
INSERT INTO `poc` VALUES (342, 3, 'apache-archiva', './poc/apache/apache-archiva.yaml');
INSERT INTO `poc` VALUES (343, 3, 'apache-axis', './poc/apache/apache-axis.yaml');
INSERT INTO `poc` VALUES (344, 3, 'apache-buffer-overflow', './poc/apache/apache-buffer-overflow.yaml');
INSERT INTO `poc` VALUES (345, 3, 'apache-cloudstack-detect', './poc/apache/apache-cloudstack-detect.yaml');
INSERT INTO `poc` VALUES (346, 3, 'apache-detect-347', './poc/apache/apache-detect-347.yaml');
INSERT INTO `poc` VALUES (347, 3, 'apache-drill-exposure', './poc/apache/apache-drill-exposure.yaml');
INSERT INTO `poc` VALUES (348, 3, 'apache-drill-exposure_1', './poc/apache/apache-drill-exposure_1.yaml');
INSERT INTO `poc` VALUES (349, 3, 'apache-druid-detect', './poc/apache/apache-druid-detect.yaml');
INSERT INTO `poc` VALUES (350, 3, 'apache-druid-kafka-connect-rce', './poc/apache/apache-druid-kafka-connect-rce.yaml');
INSERT INTO `poc` VALUES (351, 3, 'apache-druid-log4j', './poc/apache/apache-druid-log4j.yaml');
INSERT INTO `poc` VALUES (352, 3, 'apache-druid-log4j_1', './poc/apache/apache-druid-log4j_1.yaml');
INSERT INTO `poc` VALUES (353, 3, 'apache-druid-log4j_2', './poc/apache/apache-druid-log4j_2.yaml');
INSERT INTO `poc` VALUES (354, 3, 'apache-druid-unauth', './poc/apache/apache-druid-unauth.yaml');
INSERT INTO `poc` VALUES (355, 3, 'apache-dubbo', './poc/apache/apache-dubbo.yaml');
INSERT INTO `poc` VALUES (356, 3, 'apache-filename-brute-force-352', './poc/apache/apache-filename-brute-force-352.yaml');
INSERT INTO `poc` VALUES (357, 3, 'apache-filename-brute-force', './poc/apache/apache-filename-brute-force.yaml');
INSERT INTO `poc` VALUES (358, 3, 'apache-filename-enum-354', './poc/apache/apache-filename-enum-354.yaml');
INSERT INTO `poc` VALUES (359, 3, 'apache-filename-enum-354_1', './poc/apache/apache-filename-enum-354_1.yaml');
INSERT INTO `poc` VALUES (360, 3, 'apache-filename-enum', './poc/apache/apache-filename-enum.yaml');
INSERT INTO `poc` VALUES (361, 3, 'apache-filename-enum_1', './poc/apache/apache-filename-enum_1.yaml');
INSERT INTO `poc` VALUES (362, 3, 'apache-filename-enum_2', './poc/apache/apache-filename-enum_2.yaml');
INSERT INTO `poc` VALUES (363, 3, 'apache-filename-enum_3', './poc/apache/apache-filename-enum_3.yaml');
INSERT INTO `poc` VALUES (364, 3, 'apache-flink-unauth-rce-359', './poc/apache/apache-flink-unauth-rce-359.yaml');
INSERT INTO `poc` VALUES (365, 3, 'apache-flink-unauth-rce', './poc/apache/apache-flink-unauth-rce.yaml');
INSERT INTO `poc` VALUES (366, 3, 'apache-forrest', './poc/apache/apache-forrest.yaml');
INSERT INTO `poc` VALUES (367, 3, 'apache-guacamole-361', './poc/apache/apache-guacamole-361.yaml');
INSERT INTO `poc` VALUES (368, 3, 'apache-guacamole', './poc/apache/apache-guacamole.yaml');
INSERT INTO `poc` VALUES (369, 3, 'apache-hadoop-yarn', './poc/apache/apache-hadoop-yarn.yaml');
INSERT INTO `poc` VALUES (370, 3, 'apache-haus', './poc/apache/apache-haus.yaml');
INSERT INTO `poc` VALUES (371, 3, 'apache-hbase-unauth', './poc/apache/apache-hbase-unauth.yaml');
INSERT INTO `poc` VALUES (372, 3, 'apache-hertzbeat-detect', './poc/apache/apache-hertzbeat-detect.yaml');
INSERT INTO `poc` VALUES (373, 3, 'apache-host-static-code-disclosure', './poc/apache/apache-host-static-code-disclosure.yaml');
INSERT INTO `poc` VALUES (374, 3, 'apache-httpd-rce-362', './poc/apache/apache-httpd-rce-362.yaml');
INSERT INTO `poc` VALUES (375, 3, 'apache-impala', './poc/apache/apache-impala.yaml');
INSERT INTO `poc` VALUES (376, 3, 'apache-impala_1', './poc/apache/apache-impala_1.yaml');
INSERT INTO `poc` VALUES (377, 3, 'apache-jmeter-dashboard', './poc/apache/apache-jmeter-dashboard.yaml');
INSERT INTO `poc` VALUES (378, 3, 'apache-jmeter-dashboard_1', './poc/apache/apache-jmeter-dashboard_1.yaml');
INSERT INTO `poc` VALUES (379, 3, 'apache-karaf-panel', './poc/apache/apache-karaf-panel.yaml');
INSERT INTO `poc` VALUES (380, 3, 'apache-karaf-panel_1', './poc/apache/apache-karaf-panel_1.yaml');
INSERT INTO `poc` VALUES (381, 3, 'apache-karaf-panel_2', './poc/apache/apache-karaf-panel_2.yaml');
INSERT INTO `poc` VALUES (382, 3, 'apache-karaf-panel_3', './poc/apache/apache-karaf-panel_3.yaml');
INSERT INTO `poc` VALUES (383, 3, 'apache-licenserc', './poc/apache/apache-licenserc.yaml');
INSERT INTO `poc` VALUES (384, 3, 'apache-licenserc_1', './poc/apache/apache-licenserc_1.yaml');
INSERT INTO `poc` VALUES (385, 3, 'apache-licenserc_2', './poc/apache/apache-licenserc_2.yaml');
INSERT INTO `poc` VALUES (386, 3, 'apache-licenserc_3', './poc/apache/apache-licenserc_3.yaml');
INSERT INTO `poc` VALUES (387, 3, 'apache-licenserc_4', './poc/apache/apache-licenserc_4.yaml');
INSERT INTO `poc` VALUES (388, 3, 'apache-loadbalancer-365', './poc/apache/apache-loadbalancer-365.yaml');
INSERT INTO `poc` VALUES (389, 3, 'apache-loadbalancer', './poc/apache/apache-loadbalancer.yaml');
INSERT INTO `poc` VALUES (390, 3, 'apache-local-gadget-lfr', './poc/apache/apache-local-gadget-lfr.yaml');
INSERT INTO `poc` VALUES (391, 3, 'apache-mesos-panel', './poc/apache/apache-mesos-panel.yaml');
INSERT INTO `poc` VALUES (392, 3, 'apache-mesos-panel_1', './poc/apache/apache-mesos-panel_1.yaml');
INSERT INTO `poc` VALUES (393, 3, 'apache-mesos-panel_2', './poc/apache/apache-mesos-panel_2.yaml');
INSERT INTO `poc` VALUES (394, 3, 'Apache-NiFi-rce', './poc/apache/Apache-NiFi-rce.yaml');
INSERT INTO `poc` VALUES (395, 3, 'apache-nifi-rce_1', './poc/apache/apache-nifi-rce_1.yaml');
INSERT INTO `poc` VALUES (396, 3, 'apache-nifi', './poc/apache/apache-nifi.yaml');
INSERT INTO `poc` VALUES (397, 3, 'apache-ofbiz-log4j-rce-366', './poc/apache/apache-ofbiz-log4j-rce-366.yaml');
INSERT INTO `poc` VALUES (398, 3, 'apache-ofbiz-log4j-rce', './poc/apache/apache-ofbiz-log4j-rce.yaml');
INSERT INTO `poc` VALUES (399, 3, 'Apache-Ofbiz-XML-RPC-RCE', './poc/apache/Apache-Ofbiz-XML-RPC-RCE.yaml');
INSERT INTO `poc` VALUES (400, 3, 'apache-ranger', './poc/apache/apache-ranger.yaml');
INSERT INTO `poc` VALUES (401, 3, 'apache-redmine-rce', './poc/apache/apache-redmine-rce.yaml');
INSERT INTO `poc` VALUES (402, 3, 'apache-rocketmq-broker-unauth', './poc/apache/apache-rocketmq-broker-unauth.yaml');
INSERT INTO `poc` VALUES (403, 3, 'apache-rocketmq-broker-unauth_1', './poc/apache/apache-rocketmq-broker-unauth_1.yaml');
INSERT INTO `poc` VALUES (404, 3, 'apache-server-info-disclosure_', './poc/apache/apache-server-info-disclosure_.yaml');
INSERT INTO `poc` VALUES (405, 3, 'apache-server-info-disclosure__1', './poc/apache/apache-server-info-disclosure__1.yaml');
INSERT INTO `poc` VALUES (406, 3, 'apache-server-info', './poc/apache/apache-server-info.yaml');
INSERT INTO `poc` VALUES (407, 3, 'apache-server-info_1', './poc/apache/apache-server-info_1.yaml');
INSERT INTO `poc` VALUES (408, 3, 'apache-server-status-check', './poc/apache/apache-server-status-check.yaml');
INSERT INTO `poc` VALUES (409, 3, 'apache-server-status-check_1', './poc/apache/apache-server-status-check_1.yaml');
INSERT INTO `poc` VALUES (410, 3, 'apache-server-status-localhost', './poc/apache/apache-server-status-localhost.yaml');
INSERT INTO `poc` VALUES (411, 3, 'apache-server-status-localhost_1', './poc/apache/apache-server-status-localhost_1.yaml');
INSERT INTO `poc` VALUES (412, 3, 'apache-server-status', './poc/apache/apache-server-status.yaml');
INSERT INTO `poc` VALUES (413, 3, 'apache-serverstatus', './poc/apache/apache-serverstatus.yaml');
INSERT INTO `poc` VALUES (414, 3, 'apache-serverstatus_1', './poc/apache/apache-serverstatus_1.yaml');
INSERT INTO `poc` VALUES (415, 3, 'apache-serverstatus_1_1', './poc/apache/apache-serverstatus_1_1.yaml');
INSERT INTO `poc` VALUES (416, 3, 'apache-solr-91-rce', './poc/apache/apache-solr-91-rce.yaml');
INSERT INTO `poc` VALUES (417, 3, 'apache-solr-91-rce_1', './poc/apache/apache-solr-91-rce_1.yaml');
INSERT INTO `poc` VALUES (418, 3, 'apache-solr-file-read-367', './poc/apache/apache-solr-file-read-367.yaml');
INSERT INTO `poc` VALUES (419, 3, 'apache-solr-file-read-368', './poc/apache/apache-solr-file-read-368.yaml');
INSERT INTO `poc` VALUES (420, 3, 'apache-solr-file-read-368_1', './poc/apache/apache-solr-file-read-368_1.yaml');
INSERT INTO `poc` VALUES (421, 3, 'apache-solr-file-read-369', './poc/apache/apache-solr-file-read-369.yaml');
INSERT INTO `poc` VALUES (422, 3, 'apache-solr-file-read-369_1', './poc/apache/apache-solr-file-read-369_1.yaml');
INSERT INTO `poc` VALUES (423, 3, 'apache-solr-file-read-370', './poc/apache/apache-solr-file-read-370.yaml');
INSERT INTO `poc` VALUES (424, 3, 'apache-solr-file-read-371', './poc/apache/apache-solr-file-read-371.yaml');
INSERT INTO `poc` VALUES (425, 3, 'apache-solr-file-read', './poc/apache/apache-solr-file-read.yaml');
INSERT INTO `poc` VALUES (426, 3, 'apache-solr-file-read_1', './poc/apache/apache-solr-file-read_1.yaml');
INSERT INTO `poc` VALUES (427, 3, 'apache-solr-file-read_1_1', './poc/apache/apache-solr-file-read_1_1.yaml');
INSERT INTO `poc` VALUES (428, 3, 'apache-solr-file-read_2', './poc/apache/apache-solr-file-read_2.yaml');
INSERT INTO `poc` VALUES (429, 3, 'apache-solr-file-read_3', './poc/apache/apache-solr-file-read_3.yaml');
INSERT INTO `poc` VALUES (430, 3, 'apache-solr-log4j-CVE-2021-44228', './poc/apache/apache-solr-log4j-CVE-2021-44228.yaml');
INSERT INTO `poc` VALUES (431, 3, 'apache-solr-log4j-CVE-2021-44228_1', './poc/apache/apache-solr-log4j-CVE-2021-44228_1.yaml');
INSERT INTO `poc` VALUES (432, 3, 'apache-solr-log4j-rce-372', './poc/apache/apache-solr-log4j-rce-372.yaml');
INSERT INTO `poc` VALUES (433, 3, 'apache-solr-log4j-rce', './poc/apache/apache-solr-log4j-rce.yaml');
INSERT INTO `poc` VALUES (434, 3, 'apache-solr-rce', './poc/apache/apache-solr-rce.yaml');
INSERT INTO `poc` VALUES (435, 3, 'apache-solr-rce_1', './poc/apache/apache-solr-rce_1.yaml');
INSERT INTO `poc` VALUES (436, 3, 'apache-solr-rce_2', './poc/apache/apache-solr-rce_2.yaml');
INSERT INTO `poc` VALUES (437, 3, 'apache-solr-ssrf', './poc/apache/apache-solr-ssrf.yaml');
INSERT INTO `poc` VALUES (438, 3, 'apache-source-code-disclosure', './poc/apache/apache-source-code-disclosure.yaml');
INSERT INTO `poc` VALUES (439, 3, 'apache-spark-rce', './poc/apache/apache-spark-rce.yaml');
INSERT INTO `poc` VALUES (440, 3, 'apache-spark-shell-rce', './poc/apache/apache-spark-shell-rce.yaml');
INSERT INTO `poc` VALUES (441, 3, 'apache-storm', './poc/apache/apache-storm.yaml');
INSERT INTO `poc` VALUES (442, 3, 'apache-streampipes-detect', './poc/apache/apache-streampipes-detect.yaml');
INSERT INTO `poc` VALUES (443, 3, 'apache-wicket', './poc/apache/apache-wicket.yaml');
INSERT INTO `poc` VALUES (444, 3, 'apache2-ubuntu默认页面', './poc/apache/apache2-ubuntu默认页面.yaml');
INSERT INTO `poc` VALUES (445, 3, 'ApacheNifi-Api-UnauthorizedAccess', './poc/apache/ApacheNifi-Api-UnauthorizedAccess.yaml');
INSERT INTO `poc` VALUES (446, 3, 'ApacheSolr-SSRF-1', './poc/apache/ApacheSolr-SSRF-1.yaml');
INSERT INTO `poc` VALUES (447, 3, 'ApacheSolr-SSRF-2', './poc/apache/ApacheSolr-SSRF-2.yaml');
INSERT INTO `poc` VALUES (448, 3, 'ApacheSolr-SSRF-3', './poc/apache/ApacheSolr-SSRF-3.yaml');
INSERT INTO `poc` VALUES (449, 3, 'ApacheSolr-SSRF-4', './poc/apache/ApacheSolr-SSRF-4.yaml');
INSERT INTO `poc` VALUES (450, 3, 'ApacheSolr-SSRF-5', './poc/apache/ApacheSolr-SSRF-5.yaml');
INSERT INTO `poc` VALUES (451, 3, 'ApacheSolr-SSRF-6', './poc/apache/ApacheSolr-SSRF-6.yaml');
INSERT INTO `poc` VALUES (452, 3, 'apachesolrlfissrf', './poc/apache/apachesolrlfissrf.yaml');
INSERT INTO `poc` VALUES (453, 3, 'askapache-firefox-adsense-f97340f5d88b3c5e1859d992075304c3', './poc/apache/askapache-firefox-adsense-f97340f5d88b3c5e1859d992075304c3.yaml');
INSERT INTO `poc` VALUES (454, 3, 'askapache-firefox-adsense', './poc/apache/askapache-firefox-adsense.yaml');
INSERT INTO `poc` VALUES (455, 3, 'askapache-firefox-adsense_1', './poc/apache/askapache-firefox-adsense_1.yaml');
INSERT INTO `poc` VALUES (456, 3, 'default-apache-test-all-6813', './poc/apache/default-apache-test-all-6813.yaml');
INSERT INTO `poc` VALUES (457, 3, 'default-apache-test-all-6814', './poc/apache/default-apache-test-all-6814.yaml');
INSERT INTO `poc` VALUES (458, 3, 'default-apache-test-all-6815', './poc/apache/default-apache-test-all-6815.yaml');
INSERT INTO `poc` VALUES (459, 3, 'default-apache-test-page-6816', './poc/apache/default-apache-test-page-6816.yaml');
INSERT INTO `poc` VALUES (460, 3, 'default-apache-test-page-6817', './poc/apache/default-apache-test-page-6817.yaml');
INSERT INTO `poc` VALUES (461, 3, 'default-apache-test-page-6818', './poc/apache/default-apache-test-page-6818.yaml');
INSERT INTO `poc` VALUES (462, 3, 'default-apache2-page-6804', './poc/apache/default-apache2-page-6804.yaml');
INSERT INTO `poc` VALUES (463, 3, 'default-apache2-page-6805', './poc/apache/default-apache2-page-6805.yaml');
INSERT INTO `poc` VALUES (464, 3, 'default-apache2-page-6806', './poc/apache/default-apache2-page-6806.yaml');
INSERT INTO `poc` VALUES (465, 3, 'default-apache2-ubuntu-page-6808', './poc/apache/default-apache2-ubuntu-page-6808.yaml');
INSERT INTO `poc` VALUES (466, 3, 'default-apache2-ubuntu-page-6809', './poc/apache/default-apache2-ubuntu-page-6809.yaml');
INSERT INTO `poc` VALUES (467, 3, 'default-apache2-ubuntu-page-6810', './poc/apache/default-apache2-ubuntu-page-6810.yaml');
INSERT INTO `poc` VALUES (468, 3, 'unauth-apache-kafka-ui', './poc/apache/unauth-apache-kafka-ui.yaml');
INSERT INTO `poc` VALUES (469, 4, 'acf-to-rest-api-4bbba3dd4e03145d3aef1d6f7c065aa9', './poc/api/acf-to-rest-api-4bbba3dd4e03145d3aef1d6f7c065aa9.yaml');
INSERT INTO `poc` VALUES (470, 4, 'acf-to-rest-api', './poc/api/acf-to-rest-api.yaml');
INSERT INTO `poc` VALUES (471, 4, 'acf-to-rest-api_1', './poc/api/acf-to-rest-api_1.yaml');
INSERT INTO `poc` VALUES (472, 4, 'acnoo-flutter-api-0db5a4163b008c986fbaf13b6362bb49', './poc/api/acnoo-flutter-api-0db5a4163b008c986fbaf13b6362bb49.yaml');
INSERT INTO `poc` VALUES (473, 4, 'acnoo-flutter-api', './poc/api/acnoo-flutter-api.yaml');
INSERT INTO `poc` VALUES (474, 4, 'address-autocomplete-using-google-place-api-5dc0b72cb07e4116d6703d68bd5a486d', './poc/api/address-autocomplete-using-google-place-api-5dc0b72cb07e4116d6703d68bd5a486d.yaml');
INSERT INTO `poc` VALUES (475, 4, 'address-autocomplete-using-google-place-api-5ff4bed2f268b8356cd030aa3accceaa', './poc/api/address-autocomplete-using-google-place-api-5ff4bed2f268b8356cd030aa3accceaa.yaml');
INSERT INTO `poc` VALUES (476, 4, 'address-autocomplete-using-google-place-api-c569854476447fb54df1a934195332ea', './poc/api/address-autocomplete-using-google-place-api-c569854476447fb54df1a934195332ea.yaml');
INSERT INTO `poc` VALUES (477, 4, 'address-autocomplete-using-google-place-api-d41d8cd98f00b204e9800998ecf8427e', './poc/api/address-autocomplete-using-google-place-api-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (478, 4, 'address-autocomplete-using-google-place-api-plugin-d41d8cd98f00b204e9800998ecf8427e', './poc/api/address-autocomplete-using-google-place-api-plugin-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (479, 4, 'address-autocomplete-using-google-place-api-plugin', './poc/api/address-autocomplete-using-google-place-api-plugin.yaml');
INSERT INTO `poc` VALUES (480, 4, 'address-autocomplete-using-google-place-api-plugin_1', './poc/api/address-autocomplete-using-google-place-api-plugin_1.yaml');
INSERT INTO `poc` VALUES (481, 4, 'address-autocomplete-using-google-place-api', './poc/api/address-autocomplete-using-google-place-api.yaml');
INSERT INTO `poc` VALUES (482, 4, 'address-autocomplete-using-google-place-api_1', './poc/api/address-autocomplete-using-google-place-api_1.yaml');
INSERT INTO `poc` VALUES (483, 4, 'airflow-api-exposure', './poc/api/airflow-api-exposure.yaml');
INSERT INTO `poc` VALUES (484, 4, 'alfacgiapi-wordpress-1', './poc/api/alfacgiapi-wordpress-1.yaml');
INSERT INTO `poc` VALUES (485, 4, 'alfacgiapi-wordpress-2', './poc/api/alfacgiapi-wordpress-2.yaml');
INSERT INTO `poc` VALUES (486, 4, 'alfacgiapi-wordpress-255', './poc/api/alfacgiapi-wordpress-255.yaml');
INSERT INTO `poc` VALUES (487, 4, 'alfacgiapi-wordpress-256', './poc/api/alfacgiapi-wordpress-256.yaml');
INSERT INTO `poc` VALUES (488, 4, 'alfacgiapi-wordpress-257', './poc/api/alfacgiapi-wordpress-257.yaml');
INSERT INTO `poc` VALUES (489, 4, 'alfacgiapi-wordpress-257_1', './poc/api/alfacgiapi-wordpress-257_1.yaml');
INSERT INTO `poc` VALUES (490, 4, 'alfacgiapi-wordpress-257_1_1', './poc/api/alfacgiapi-wordpress-257_1_1.yaml');
INSERT INTO `poc` VALUES (491, 4, 'alfacgiapi-wordpress-3', './poc/api/alfacgiapi-wordpress-3.yaml');
INSERT INTO `poc` VALUES (492, 4, 'alfacgiapi-wordpress-4', './poc/api/alfacgiapi-wordpress-4.yaml');
INSERT INTO `poc` VALUES (493, 4, 'alfacgiapi-wordpress', './poc/api/alfacgiapi-wordpress.yaml');
INSERT INTO `poc` VALUES (494, 4, 'alfacgiapi-wordpress_1', './poc/api/alfacgiapi-wordpress_1.yaml');
INSERT INTO `poc` VALUES (495, 4, 'alfacgiapi-wordpress_2', './poc/api/alfacgiapi-wordpress_2.yaml');
INSERT INTO `poc` VALUES (496, 4, 'apache-apisix-panel-336', './poc/api/apache-apisix-panel-336.yaml');
INSERT INTO `poc` VALUES (497, 4, 'apache-apisix-panel-337', './poc/api/apache-apisix-panel-337.yaml');
INSERT INTO `poc` VALUES (498, 4, 'apache-apisix-panel-338', './poc/api/apache-apisix-panel-338.yaml');
INSERT INTO `poc` VALUES (499, 4, 'apache-apisix-panel', './poc/api/apache-apisix-panel.yaml');
INSERT INTO `poc` VALUES (500, 4, 'ApacheNifi-Api-UnauthorizedAccess', './poc/api/ApacheNifi-Api-UnauthorizedAccess.yaml');
INSERT INTO `poc` VALUES (501, 4, 'api-bing-map-2018-bdd86a2dc395718687e612b89b6cd720', './poc/api/api-bing-map-2018-bdd86a2dc395718687e612b89b6cd720.yaml');
INSERT INTO `poc` VALUES (502, 4, 'api-bing-map-2018', './poc/api/api-bing-map-2018.yaml');
INSERT INTO `poc` VALUES (503, 4, 'api-bing-map-2018_1', './poc/api/api-bing-map-2018_1.yaml');
INSERT INTO `poc` VALUES (504, 4, 'api-circleci-405', './poc/api/api-circleci-405.yaml');
INSERT INTO `poc` VALUES (505, 4, 'api-dropbox', './poc/api/api-dropbox.yaml');
INSERT INTO `poc` VALUES (506, 4, 'api-endpoints', './poc/api/api-endpoints.yaml');
INSERT INTO `poc` VALUES (507, 4, 'api-exposures', './poc/api/api-exposures.yaml');
INSERT INTO `poc` VALUES (508, 4, 'api-hubspot', './poc/api/api-hubspot.yaml');
INSERT INTO `poc` VALUES (509, 4, 'api-info-themes-plugins-wp-org-66caa0b56de1f5b395ccb9edd74d127d', './poc/api/api-info-themes-plugins-wp-org-66caa0b56de1f5b395ccb9edd74d127d.yaml');
INSERT INTO `poc` VALUES (510, 4, 'api-info-themes-plugins-wp-org-a5ba91db466ae424f41944b08096d121', './poc/api/api-info-themes-plugins-wp-org-a5ba91db466ae424f41944b08096d121.yaml');
INSERT INTO `poc` VALUES (511, 4, 'api-info-themes-plugins-wp-org-b2b4c6858b9f9bf1ce417b44adf44c1b', './poc/api/api-info-themes-plugins-wp-org-b2b4c6858b9f9bf1ce417b44adf44c1b.yaml');
INSERT INTO `poc` VALUES (512, 4, 'api-info-themes-plugins-wp-org-d41d8cd98f00b204e9800998ecf8427e', './poc/api/api-info-themes-plugins-wp-org-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (513, 4, 'api-info-themes-plugins-wp-org-plugin-d41d8cd98f00b204e9800998ecf8427e', './poc/api/api-info-themes-plugins-wp-org-plugin-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (514, 4, 'api-info-themes-plugins-wp-org-plugin', './poc/api/api-info-themes-plugins-wp-org-plugin.yaml');
INSERT INTO `poc` VALUES (515, 4, 'api-info-themes-plugins-wp-org', './poc/api/api-info-themes-plugins-wp-org.yaml');
INSERT INTO `poc` VALUES (516, 4, 'API-Linkfinder', './poc/api/API-Linkfinder.yaml');
INSERT INTO `poc` VALUES (517, 4, 'API-Linkfinder_1', './poc/api/API-Linkfinder_1.yaml');
INSERT INTO `poc` VALUES (518, 4, 'api-users-exposed', './poc/api/api-users-exposed.yaml');
INSERT INTO `poc` VALUES (519, 4, 'api-visualstudio-513', './poc/api/api-visualstudio-513.yaml');
INSERT INTO `poc` VALUES (520, 4, 'api2cart-bridge-connector-7f28d21ce1d1423f08ff3303e97fdcda', './poc/api/api2cart-bridge-connector-7f28d21ce1d1423f08ff3303e97fdcda.yaml');
INSERT INTO `poc` VALUES (521, 4, 'api2cart-bridge-connector', './poc/api/api2cart-bridge-connector.yaml');
INSERT INTO `poc` VALUES (522, 4, 'api2cart-bridge-connector_1', './poc/api/api2cart-bridge-connector_1.yaml');
INSERT INTO `poc` VALUES (523, 4, 'apigee-panel', './poc/api/apigee-panel.yaml');
INSERT INTO `poc` VALUES (524, 4, 'apigee-panel_1', './poc/api/apigee-panel_1.yaml');
INSERT INTO `poc` VALUES (525, 4, 'apigee-panel_2', './poc/api/apigee-panel_2.yaml');
INSERT INTO `poc` VALUES (526, 4, 'apilayer-caddy', './poc/api/apilayer-caddy.yaml');
INSERT INTO `poc` VALUES (527, 4, 'apiman-panel-460', './poc/api/apiman-panel-460.yaml');
INSERT INTO `poc` VALUES (528, 4, 'apiman-panel-462', './poc/api/apiman-panel-462.yaml');
INSERT INTO `poc` VALUES (529, 4, 'apiman-panel-463', './poc/api/apiman-panel-463.yaml');
INSERT INTO `poc` VALUES (530, 4, 'apiman-panel-464', './poc/api/apiman-panel-464.yaml');
INSERT INTO `poc` VALUES (531, 4, 'apiman-panel', './poc/api/apiman-panel.yaml');
INSERT INTO `poc` VALUES (532, 4, 'apiman-panel_1', './poc/api/apiman-panel_1.yaml');
INSERT INTO `poc` VALUES (533, 4, 'apimo-91c06e935fbefa53738c9ea05f6c2960', './poc/api/apimo-91c06e935fbefa53738c9ea05f6c2960.yaml');
INSERT INTO `poc` VALUES (534, 4, 'apisix-default-login-490', './poc/api/apisix-default-login-490.yaml');
INSERT INTO `poc` VALUES (535, 4, 'apisix-default-login-490_1', './poc/api/apisix-default-login-490_1.yaml');
INSERT INTO `poc` VALUES (536, 4, 'apisix-default-login', './poc/api/apisix-default-login.yaml');
INSERT INTO `poc` VALUES (537, 4, 'apisix', './poc/api/apisix.yaml');
INSERT INTO `poc` VALUES (538, 4, 'api_endpoints', './poc/api/api_endpoints.yaml');
INSERT INTO `poc` VALUES (539, 4, 'api_endpoints_1', './poc/api/api_endpoints_1.yaml');
INSERT INTO `poc` VALUES (540, 4, 'arcgis-rest-api-532', './poc/api/arcgis-rest-api-532.yaml');
INSERT INTO `poc` VALUES (541, 4, 'arcgis-rest-api-533', './poc/api/arcgis-rest-api-533.yaml');
INSERT INTO `poc` VALUES (542, 4, 'arcgis-rest-api', './poc/api/arcgis-rest-api.yaml');
INSERT INTO `poc` VALUES (543, 4, 'arcgis-rest-api_1', './poc/api/arcgis-rest-api_1.yaml');
INSERT INTO `poc` VALUES (544, 4, 'arcgis-rest-api_2', './poc/api/arcgis-rest-api_2.yaml');
INSERT INTO `poc` VALUES (545, 4, 'aws-api-key', './poc/api/aws-api-key.yaml');
INSERT INTO `poc` VALUES (546, 4, 'axway-api-manager-panel', './poc/api/axway-api-manager-panel.yaml');
INSERT INTO `poc` VALUES (547, 4, 'axway-api-manager-panel_1', './poc/api/axway-api-manager-panel_1.yaml');
INSERT INTO `poc` VALUES (548, 4, 'bems-api-lfi-707', './poc/api/bems-api-lfi-707.yaml');
INSERT INTO `poc` VALUES (549, 4, 'bems-api-lfi-709', './poc/api/bems-api-lfi-709.yaml');
INSERT INTO `poc` VALUES (550, 4, 'bems-api-lfi-709_1', './poc/api/bems-api-lfi-709_1.yaml');
INSERT INTO `poc` VALUES (551, 4, 'bems-api-lfi-709_2', './poc/api/bems-api-lfi-709_2.yaml');
INSERT INTO `poc` VALUES (552, 4, 'bems-api-lfi-710', './poc/api/bems-api-lfi-710.yaml');
INSERT INTO `poc` VALUES (553, 4, 'bems-api-lfi-710_1', './poc/api/bems-api-lfi-710_1.yaml');
INSERT INTO `poc` VALUES (554, 4, 'bems-api-lfi-711', './poc/api/bems-api-lfi-711.yaml');
INSERT INTO `poc` VALUES (555, 4, 'bems-api-lfi-711_1', './poc/api/bems-api-lfi-711_1.yaml');
INSERT INTO `poc` VALUES (556, 4, 'bems-api-lfi-712', './poc/api/bems-api-lfi-712.yaml');
INSERT INTO `poc` VALUES (557, 4, 'bems-api-lfi', './poc/api/bems-api-lfi.yaml');
INSERT INTO `poc` VALUES (558, 4, 'better-wlm-api-d17ef0ad24b52f70636fd517b2729624', './poc/api/better-wlm-api-d17ef0ad24b52f70636fd517b2729624.yaml');
INSERT INTO `poc` VALUES (559, 4, 'better-wlm-api-e28e1a9e2794af051a988c3e2e2f9299', './poc/api/better-wlm-api-e28e1a9e2794af051a988c3e2e2f9299.yaml');
INSERT INTO `poc` VALUES (560, 4, 'better-wlm-api', './poc/api/better-wlm-api.yaml');
INSERT INTO `poc` VALUES (561, 4, 'burp-api-detect-809', './poc/api/burp-api-detect-809.yaml');
INSERT INTO `poc` VALUES (562, 4, 'burp-api-detect-810', './poc/api/burp-api-detect-810.yaml');
INSERT INTO `poc` VALUES (563, 4, 'burp-api-detect-811', './poc/api/burp-api-detect-811.yaml');
INSERT INTO `poc` VALUES (564, 4, 'burp-api-detect-812', './poc/api/burp-api-detect-812.yaml');
INSERT INTO `poc` VALUES (565, 4, 'burp-api-detect', './poc/api/burp-api-detect.yaml');
INSERT INTO `poc` VALUES (566, 4, 'burp-api-detect_1', './poc/api/burp-api-detect_1.yaml');
INSERT INTO `poc` VALUES (567, 4, 'capitalize-my-title', './poc/api/capitalize-my-title.yaml');
INSERT INTO `poc` VALUES (568, 4, 'cart-rest-api-for-woocommerce-863e46252f4619353ac6e316726d18cc', './poc/api/cart-rest-api-for-woocommerce-863e46252f4619353ac6e316726d18cc.yaml');
INSERT INTO `poc` VALUES (569, 4, 'cart-rest-api-for-woocommerce', './poc/api/cart-rest-api-for-woocommerce.yaml');
INSERT INTO `poc` VALUES (570, 4, 'cart-rest-api-for-woocommerce_1', './poc/api/cart-rest-api-for-woocommerce_1.yaml');
INSERT INTO `poc` VALUES (571, 4, 'command-api-explorer', './poc/api/command-api-explorer.yaml');
INSERT INTO `poc` VALUES (572, 4, 'command-api-explorer_1', './poc/api/command-api-explorer_1.yaml');
INSERT INTO `poc` VALUES (573, 4, 'command-api-explorer_1_1', './poc/api/command-api-explorer_1_1.yaml');
INSERT INTO `poc` VALUES (574, 4, 'command-api-explorer_2', './poc/api/command-api-explorer_2.yaml');
INSERT INTO `poc` VALUES (575, 4, 'command-api-explorer_3', './poc/api/command-api-explorer_3.yaml');
INSERT INTO `poc` VALUES (576, 4, 'command-api-explorer_4', './poc/api/command-api-explorer_4.yaml');
INSERT INTO `poc` VALUES (577, 4, 'contact-form-to-any-api-1877006e90ef1d0aa134135caf42d112', './poc/api/contact-form-to-any-api-1877006e90ef1d0aa134135caf42d112.yaml');
INSERT INTO `poc` VALUES (578, 4, 'contact-form-to-any-api-4d4897bf8a0f9c34c940af752d24e07f', './poc/api/contact-form-to-any-api-4d4897bf8a0f9c34c940af752d24e07f.yaml');
INSERT INTO `poc` VALUES (579, 4, 'contact-form-to-any-api-6587c20028fb973fc8f5a275499ef8dc', './poc/api/contact-form-to-any-api-6587c20028fb973fc8f5a275499ef8dc.yaml');
INSERT INTO `poc` VALUES (580, 4, 'contact-form-to-any-api-7f2464fa8a66776a00093c1a9ee3c329', './poc/api/contact-form-to-any-api-7f2464fa8a66776a00093c1a9ee3c329.yaml');
INSERT INTO `poc` VALUES (581, 4, 'contact-form-to-any-api', './poc/api/contact-form-to-any-api.yaml');
INSERT INTO `poc` VALUES (582, 4, 'contact-form-to-any-api_1', './poc/api/contact-form-to-any-api_1.yaml');
INSERT INTO `poc` VALUES (583, 4, 'couchbase-buckets-api-1232', './poc/api/couchbase-buckets-api-1232.yaml');
INSERT INTO `poc` VALUES (584, 4, 'couchbase-buckets-api-1233', './poc/api/couchbase-buckets-api-1233.yaml');
INSERT INTO `poc` VALUES (585, 4, 'couchbase-buckets-api', './poc/api/couchbase-buckets-api.yaml');
INSERT INTO `poc` VALUES (586, 4, 'couchbase-buckets-api_1', './poc/api/couchbase-buckets-api_1.yaml');
INSERT INTO `poc` VALUES (587, 4, 'couchbase-buckets-api_2', './poc/api/couchbase-buckets-api_2.yaml');
INSERT INTO `poc` VALUES (588, 4, 'couchbase-buckets-rest-api', './poc/api/couchbase-buckets-rest-api.yaml');
INSERT INTO `poc` VALUES (589, 4, 'cpanel-api-codes', './poc/api/cpanel-api-codes.yaml');
INSERT INTO `poc` VALUES (590, 4, 'cpanel-api-codes_1', './poc/api/cpanel-api-codes_1.yaml');
INSERT INTO `poc` VALUES (591, 4, 'cpanel-api-codes_2', './poc/api/cpanel-api-codes_2.yaml');
INSERT INTO `poc` VALUES (592, 4, 'crates-api-key', './poc/api/crates-api-key.yaml');
INSERT INTO `poc` VALUES (593, 4, 'custom-api-server-detect', './poc/api/custom-api-server-detect.yaml');
INSERT INTO `poc` VALUES (594, 4, 'custom-logapi-log-detect', './poc/api/custom-logapi-log-detect.yaml');
INSERT INTO `poc` VALUES (595, 4, 'custom-logapi-log-detect_1', './poc/api/custom-logapi-log-detect_1.yaml');
INSERT INTO `poc` VALUES (596, 4, 'custom-wp-rest-api-b22251258da618e4dc65c7c1d1772f23', './poc/api/custom-wp-rest-api-b22251258da618e4dc65c7c1d1772f23.yaml');
INSERT INTO `poc` VALUES (597, 4, 'dependency-track-api', './poc/api/dependency-track-api.yaml');
INSERT INTO `poc` VALUES (598, 4, 'discuz-api-pathinfo', './poc/api/discuz-api-pathinfo.yaml');
INSERT INTO `poc` VALUES (599, 4, 'discuz-api-pathinfo_1', './poc/api/discuz-api-pathinfo_1.yaml');
INSERT INTO `poc` VALUES (600, 4, 'Discuz-info-api', './poc/api/Discuz-info-api.yaml');
INSERT INTO `poc` VALUES (601, 4, 'Discuz-info-api_1', './poc/api/Discuz-info-api_1.yaml');
INSERT INTO `poc` VALUES (602, 4, 'drupal-jsonapi-user-listing', './poc/api/drupal-jsonapi-user-listing.yaml');
INSERT INTO `poc` VALUES (603, 4, 'drupal-jsonapi-user-listing_1', './poc/api/drupal-jsonapi-user-listing_1.yaml');
INSERT INTO `poc` VALUES (604, 4, 'drupal-jsonapi-user-listing_2', './poc/api/drupal-jsonapi-user-listing_2.yaml');
INSERT INTO `poc` VALUES (605, 4, 'drupal-jsonapi-user-listing_3', './poc/api/drupal-jsonapi-user-listing_3.yaml');
INSERT INTO `poc` VALUES (606, 4, 'drupal_module-apigee_edge-access-bypass', './poc/api/drupal_module-apigee_edge-access-bypass.yaml');
INSERT INTO `poc` VALUES (607, 4, 'drupal_module-apigee_edge-access-bypass_1', './poc/api/drupal_module-apigee_edge-access-bypass_1.yaml');
INSERT INTO `poc` VALUES (608, 4, 'drupal_module-apigee_edge-access-bypass_2', './poc/api/drupal_module-apigee_edge-access-bypass_2.yaml');
INSERT INTO `poc` VALUES (609, 4, 'drupal_module-apigee_edge-access-bypass_3', './poc/api/drupal_module-apigee_edge-access-bypass_3.yaml');
INSERT INTO `poc` VALUES (610, 4, 'drupal_module-apigee_edge-access-bypass_4', './poc/api/drupal_module-apigee_edge-access-bypass_4.yaml');
INSERT INTO `poc` VALUES (611, 4, 'drupal_module-apigee_edge-access-bypass_5', './poc/api/drupal_module-apigee_edge-access-bypass_5.yaml');
INSERT INTO `poc` VALUES (612, 4, 'drupal_module-bing_autosuggest_api-cross-site-scripting', './poc/api/drupal_module-bing_autosuggest_api-cross-site-scripting.yaml');
INSERT INTO `poc` VALUES (613, 4, 'drupal_module-bing_autosuggest_api-cross-site-scripting_1', './poc/api/drupal_module-bing_autosuggest_api-cross-site-scripting_1.yaml');
INSERT INTO `poc` VALUES (614, 4, 'drupal_module-jsonapi-access-bypass', './poc/api/drupal_module-jsonapi-access-bypass.yaml');
INSERT INTO `poc` VALUES (615, 4, 'drupal_module-jsonapi-access-bypass_1', './poc/api/drupal_module-jsonapi-access-bypass_1.yaml');
INSERT INTO `poc` VALUES (616, 4, 'drupal_module-jsonapi-cross-site-request-forgery', './poc/api/drupal_module-jsonapi-cross-site-request-forgery.yaml');
INSERT INTO `poc` VALUES (617, 4, 'drupal_module-jsonapi-cross-site-request-forgery_1', './poc/api/drupal_module-jsonapi-cross-site-request-forgery_1.yaml');
INSERT INTO `poc` VALUES (618, 4, 'drupal_module-jsonapi-multiple-vulnerabilities', './poc/api/drupal_module-jsonapi-multiple-vulnerabilities.yaml');
INSERT INTO `poc` VALUES (619, 4, 'drupal_module-jsonapi-multiple-vulnerabilities_1', './poc/api/drupal_module-jsonapi-multiple-vulnerabilities_1.yaml');
INSERT INTO `poc` VALUES (620, 4, 'drupal_module-jsonapi-remote-code-execution', './poc/api/drupal_module-jsonapi-remote-code-execution.yaml');
INSERT INTO `poc` VALUES (621, 4, 'drupal_module-jsonapi-remote-code-execution_1', './poc/api/drupal_module-jsonapi-remote-code-execution_1.yaml');
INSERT INTO `poc` VALUES (622, 4, 'drupal_module-jsonapi-remote-code-execution_2', './poc/api/drupal_module-jsonapi-remote-code-execution_2.yaml');
INSERT INTO `poc` VALUES (623, 4, 'drupal_module-jsonapi-unsupported', './poc/api/drupal_module-jsonapi-unsupported.yaml');
INSERT INTO `poc` VALUES (624, 4, 'drupal_module-jsonapi-unsupported_1', './poc/api/drupal_module-jsonapi-unsupported_1.yaml');
INSERT INTO `poc` VALUES (625, 4, 'drupal_module-pdf_api-remote-code-execution', './poc/api/drupal_module-pdf_api-remote-code-execution.yaml');
INSERT INTO `poc` VALUES (626, 4, 'drupal_module-pdf_api-remote-code-execution_1', './poc/api/drupal_module-pdf_api-remote-code-execution_1.yaml');
INSERT INTO `poc` VALUES (627, 4, 'drupal_module-rest_api_authentication-access-bypass', './poc/api/drupal_module-rest_api_authentication-access-bypass.yaml');
INSERT INTO `poc` VALUES (628, 4, 'drupal_module-search_api-information-disclosure', './poc/api/drupal_module-search_api-information-disclosure.yaml');
INSERT INTO `poc` VALUES (629, 4, 'drupal_module-search_api_attachments-arbitrary-php-code-execution', './poc/api/drupal_module-search_api_attachments-arbitrary-php-code-execution.yaml');
INSERT INTO `poc` VALUES (630, 4, 'drupal_module-search_api_attachments-arbitrary-php-code-execution_1', './poc/api/drupal_module-search_api_attachments-arbitrary-php-code-execution_1.yaml');
INSERT INTO `poc` VALUES (631, 4, 'drupal_module-search_api_page-cross-site-scripting', './poc/api/drupal_module-search_api_page-cross-site-scripting.yaml');
INSERT INTO `poc` VALUES (632, 4, 'drupal_module-search_api_page-cross-site-scripting_1', './poc/api/drupal_module-search_api_page-cross-site-scripting_1.yaml');
INSERT INTO `poc` VALUES (633, 4, 'drupal_module-search_api_page-cross-site-scripting_2', './poc/api/drupal_module-search_api_page-cross-site-scripting_2.yaml');
INSERT INTO `poc` VALUES (634, 4, 'drupal_module-search_api_solr-access-bypass', './poc/api/drupal_module-search_api_solr-access-bypass.yaml');
INSERT INTO `poc` VALUES (635, 4, 'drupal_module-search_api_solr-access-bypass_1', './poc/api/drupal_module-search_api_solr-access-bypass_1.yaml');
INSERT INTO `poc` VALUES (636, 4, 'dynatrace-api-token', './poc/api/dynatrace-api-token.yaml');
INSERT INTO `poc` VALUES (637, 4, 'easily-generate-rest-api-url-1ac3b2c6c83e547402a7b5ec512b456e', './poc/api/easily-generate-rest-api-url-1ac3b2c6c83e547402a7b5ec512b456e.yaml');
INSERT INTO `poc` VALUES (638, 4, 'easily-generate-rest-api-url', './poc/api/easily-generate-rest-api-url.yaml');
INSERT INTO `poc` VALUES (639, 4, 'easily-generate-rest-api-url_1', './poc/api/easily-generate-rest-api-url_1.yaml');
INSERT INTO `poc` VALUES (640, 4, 'etcd-unauthenticated-api', './poc/api/etcd-unauthenticated-api.yaml');
INSERT INTO `poc` VALUES (641, 4, 'etcd-unauthenticated-api_1', './poc/api/etcd-unauthenticated-api_1.yaml');
INSERT INTO `poc` VALUES (642, 4, 'exposed-api-env-variables', './poc/api/exposed-api-env-variables.yaml');
INSERT INTO `poc` VALUES (643, 4, 'exposed-glances-api-7308', './poc/api/exposed-glances-api-7308.yaml');
INSERT INTO `poc` VALUES (644, 4, 'exposed-glances-api-7309', './poc/api/exposed-glances-api-7309.yaml');
INSERT INTO `poc` VALUES (645, 4, 'exposed-glances-api', './poc/api/exposed-glances-api.yaml');
INSERT INTO `poc` VALUES (646, 4, 'exposed-glances-api_1', './poc/api/exposed-glances-api_1.yaml');
INSERT INTO `poc` VALUES (647, 4, 'facebook-page-feed-graph-api-124428fc6a79b3aa2b4be454d33a013a', './poc/api/facebook-page-feed-graph-api-124428fc6a79b3aa2b4be454d33a013a.yaml');
INSERT INTO `poc` VALUES (648, 4, 'facebook-page-feed-graph-api', './poc/api/facebook-page-feed-graph-api.yaml');
INSERT INTO `poc` VALUES (649, 4, 'facebook-page-feed-graph-api_1', './poc/api/facebook-page-feed-graph-api_1.yaml');
INSERT INTO `poc` VALUES (650, 4, 'fast-indexing-api', './poc/api/fast-indexing-api.yaml');
INSERT INTO `poc` VALUES (651, 4, 'fast-indexing-api_1', './poc/api/fast-indexing-api_1.yaml');
INSERT INTO `poc` VALUES (652, 4, 'fast-indexing-api_2', './poc/api/fast-indexing-api_2.yaml');
INSERT INTO `poc` VALUES (653, 4, 'fast-indexing-api_3', './poc/api/fast-indexing-api_3.yaml');
INSERT INTO `poc` VALUES (654, 4, 'fastAPI-1', './poc/api/fastAPI-1.yaml');
INSERT INTO `poc` VALUES (655, 4, 'fastAPI-2', './poc/api/fastAPI-2.yaml');
INSERT INTO `poc` VALUES (656, 4, 'fastAPI-3', './poc/api/fastAPI-3.yaml');
INSERT INTO `poc` VALUES (657, 4, 'fastAPI-4', './poc/api/fastAPI-4.yaml');
INSERT INTO `poc` VALUES (658, 4, 'fastAPI-5', './poc/api/fastAPI-5.yaml');
INSERT INTO `poc` VALUES (659, 4, 'fastapi-docs-7398', './poc/api/fastapi-docs-7398.yaml');
INSERT INTO `poc` VALUES (660, 4, 'fastapi-docs-7399', './poc/api/fastapi-docs-7399.yaml');
INSERT INTO `poc` VALUES (661, 4, 'fastapi-docs', './poc/api/fastapi-docs.yaml');
INSERT INTO `poc` VALUES (662, 4, 'fastapi-docs_1', './poc/api/fastapi-docs_1.yaml');
INSERT INTO `poc` VALUES (663, 4, 'forms-to-zapier-80a7de1e0d3c99a25261851a366ce867', './poc/api/forms-to-zapier-80a7de1e0d3c99a25261851a366ce867.yaml');
INSERT INTO `poc` VALUES (664, 4, 'forms-to-zapier-898f58813d09c54f767816191b8eea06', './poc/api/forms-to-zapier-898f58813d09c54f767816191b8eea06.yaml');
INSERT INTO `poc` VALUES (665, 4, 'forms-to-zapier-d41d8cd98f00b204e9800998ecf8427e', './poc/api/forms-to-zapier-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (666, 4, 'forms-to-zapier-plugin-d41d8cd98f00b204e9800998ecf8427e', './poc/api/forms-to-zapier-plugin-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (667, 4, 'forms-to-zapier-plugin', './poc/api/forms-to-zapier-plugin.yaml');
INSERT INTO `poc` VALUES (668, 4, 'forms-to-zapier-plugin_1', './poc/api/forms-to-zapier-plugin_1.yaml');
INSERT INTO `poc` VALUES (669, 4, 'forms-to-zapier', './poc/api/forms-to-zapier.yaml');
INSERT INTO `poc` VALUES (670, 4, 'forms-to-zapier_1', './poc/api/forms-to-zapier_1.yaml');
INSERT INTO `poc` VALUES (671, 4, 'forms-to-zapier_2', './poc/api/forms-to-zapier_2.yaml');
INSERT INTO `poc` VALUES (672, 4, 'gitlab-api-user-enum-7667', './poc/api/gitlab-api-user-enum-7667.yaml');
INSERT INTO `poc` VALUES (673, 4, 'gitlab-api-user-enum-7667_1', './poc/api/gitlab-api-user-enum-7667_1.yaml');
INSERT INTO `poc` VALUES (674, 4, 'gitlab-api-user-enum-7667_2', './poc/api/gitlab-api-user-enum-7667_2.yaml');
INSERT INTO `poc` VALUES (675, 4, 'gitlab-api-user-enum-7668', './poc/api/gitlab-api-user-enum-7668.yaml');
INSERT INTO `poc` VALUES (676, 4, 'gitlab-api-user-enum-7668_1', './poc/api/gitlab-api-user-enum-7668_1.yaml');
INSERT INTO `poc` VALUES (677, 4, 'gitlab-api-user-enum-7669', './poc/api/gitlab-api-user-enum-7669.yaml');
INSERT INTO `poc` VALUES (678, 4, 'gitlab-api-user-enum-7669_1', './poc/api/gitlab-api-user-enum-7669_1.yaml');
INSERT INTO `poc` VALUES (679, 4, 'gitlab-api-user-enum', './poc/api/gitlab-api-user-enum.yaml');
INSERT INTO `poc` VALUES (680, 4, 'gitlab-api-user-enum_1', './poc/api/gitlab-api-user-enum_1.yaml');
INSERT INTO `poc` VALUES (681, 4, 'gitlab-api-user-enum_2', './poc/api/gitlab-api-user-enum_2.yaml');
INSERT INTO `poc` VALUES (682, 4, 'gitlab-api-user-enum_3', './poc/api/gitlab-api-user-enum_3.yaml');
INSERT INTO `poc` VALUES (683, 4, 'gitlab-user-open-api-7702', './poc/api/gitlab-user-open-api-7702.yaml');
INSERT INTO `poc` VALUES (684, 4, 'gitlab-user-open-api-7702_1', './poc/api/gitlab-user-open-api-7702_1.yaml');
INSERT INTO `poc` VALUES (685, 4, 'gitlab-user-open-api', './poc/api/gitlab-user-open-api.yaml');
INSERT INTO `poc` VALUES (686, 4, 'gitlab-user-open-api_1', './poc/api/gitlab-user-open-api_1.yaml');
INSERT INTO `poc` VALUES (687, 4, 'gmail-api-client-secrets', './poc/api/gmail-api-client-secrets.yaml');
INSERT INTO `poc` VALUES (688, 4, 'google-api-private-key', './poc/api/google-api-private-key.yaml');
INSERT INTO `poc` VALUES (689, 4, 'google-api-private-key_1', './poc/api/google-api-private-key_1.yaml');
INSERT INTO `poc` VALUES (690, 4, 'google-api-private-key_2', './poc/api/google-api-private-key_2.yaml');
INSERT INTO `poc` VALUES (691, 4, 'google-cloud-api-key', './poc/api/google-cloud-api-key.yaml');
INSERT INTO `poc` VALUES (692, 4, 'goSwaggerAPI', './poc/api/goSwaggerAPI.yaml');
INSERT INTO `poc` VALUES (693, 4, 'goSwaggerAPI_1', './poc/api/goSwaggerAPI_1.yaml');
INSERT INTO `poc` VALUES (694, 4, 'grafana_with_prometheus_api_proxy', './poc/api/grafana_with_prometheus_api_proxy.yaml');
INSERT INTO `poc` VALUES (695, 4, 'grafana_with_prometheus_api_proxy_1', './poc/api/grafana_with_prometheus_api_proxy_1.yaml');
INSERT INTO `poc` VALUES (696, 4, 'graphql-apiforwp-detect', './poc/api/graphql-apiforwp-detect.yaml');
INSERT INTO `poc` VALUES (697, 4, 'graph_api', './poc/api/graph_api.yaml');
INSERT INTO `poc` VALUES (698, 4, 'graylog-api-browser-7846', './poc/api/graylog-api-browser-7846.yaml');
INSERT INTO `poc` VALUES (699, 4, 'graylog-api-browser-7847', './poc/api/graylog-api-browser-7847.yaml');
INSERT INTO `poc` VALUES (700, 4, 'graylog-api-browser-7847_1', './poc/api/graylog-api-browser-7847_1.yaml');
INSERT INTO `poc` VALUES (701, 4, 'graylog-api-browser', './poc/api/graylog-api-browser.yaml');
INSERT INTO `poc` VALUES (702, 4, 'graylog-api-browser_1', './poc/api/graylog-api-browser_1.yaml');
INSERT INTO `poc` VALUES (703, 4, 'h5pxapikatchu-4a84925c52ca173b70f2474da529a133', './poc/api/h5pxapikatchu-4a84925c52ca173b70f2474da529a133.yaml');
INSERT INTO `poc` VALUES (704, 4, 'heroku-api-key', './poc/api/heroku-api-key.yaml');
INSERT INTO `poc` VALUES (705, 4, 'ibm-api-connect-developer-portal-detect', './poc/api/ibm-api-connect-developer-portal-detect.yaml');
INSERT INTO `poc` VALUES (706, 4, 'ibm-api-connect-panel', './poc/api/ibm-api-connect-panel.yaml');
INSERT INTO `poc` VALUES (707, 4, 'iis-enum-httpapi', './poc/api/iis-enum-httpapi.yaml');
INSERT INTO `poc` VALUES (708, 4, 'indeed-api-5dd766636e9a5eefdd52627bcffa8873', './poc/api/indeed-api-5dd766636e9a5eefdd52627bcffa8873.yaml');
INSERT INTO `poc` VALUES (709, 4, 'indeed-api', './poc/api/indeed-api.yaml');
INSERT INTO `poc` VALUES (710, 4, 'jenkins-api-panel-8261', './poc/api/jenkins-api-panel-8261.yaml');
INSERT INTO `poc` VALUES (711, 4, 'jenkins-api-panel-8261_1', './poc/api/jenkins-api-panel-8261_1.yaml');
INSERT INTO `poc` VALUES (712, 4, 'jenkins-api-panel-8263', './poc/api/jenkins-api-panel-8263.yaml');
INSERT INTO `poc` VALUES (713, 4, 'jenkins-api-panel', './poc/api/jenkins-api-panel.yaml');
INSERT INTO `poc` VALUES (714, 4, 'jenkins-api-panel_1', './poc/api/jenkins-api-panel_1.yaml');
INSERT INTO `poc` VALUES (715, 4, 'jsapi-ticket-json', './poc/api/jsapi-ticket-json.yaml');
INSERT INTO `poc` VALUES (716, 4, 'jsapi-ticket-json_3', './poc/api/jsapi-ticket-json_3.yaml');
INSERT INTO `poc` VALUES (717, 4, 'json-api-user-f16cf82a0bff766957f5ffe30cf56da5', './poc/api/json-api-user-f16cf82a0bff766957f5ffe30cf56da5.yaml');
INSERT INTO `poc` VALUES (718, 4, 'json-api-user', './poc/api/json-api-user.yaml');
INSERT INTO `poc` VALUES (719, 4, 'json-rest-api-31c9d035c4d3fc5d6caff4ae5faad462', './poc/api/json-rest-api-31c9d035c4d3fc5d6caff4ae5faad462.yaml');
INSERT INTO `poc` VALUES (720, 4, 'json-rest-api-3dd5f6c2ef85279c6ee30af7fc5abc9f', './poc/api/json-rest-api-3dd5f6c2ef85279c6ee30af7fc5abc9f.yaml');
INSERT INTO `poc` VALUES (721, 4, 'json-rest-api-51a664d5e756a621ddf01cb744c6394a', './poc/api/json-rest-api-51a664d5e756a621ddf01cb744c6394a.yaml');
INSERT INTO `poc` VALUES (722, 4, 'json-rest-api-5b6bca2f8215c2c418ec8a6cb9e0d322', './poc/api/json-rest-api-5b6bca2f8215c2c418ec8a6cb9e0d322.yaml');
INSERT INTO `poc` VALUES (723, 4, 'json-rest-api-d41d8cd98f00b204e9800998ecf8427e', './poc/api/json-rest-api-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (724, 4, 'json-rest-api-d94e25b5af95ed09bf5738f4fb61303f', './poc/api/json-rest-api-d94e25b5af95ed09bf5738f4fb61303f.yaml');
INSERT INTO `poc` VALUES (725, 4, 'json-rest-api-f708470e7b43ec105b43e24ad5f0bc72', './poc/api/json-rest-api-f708470e7b43ec105b43e24ad5f0bc72.yaml');
INSERT INTO `poc` VALUES (726, 4, 'json-rest-api-fc28cca0b2ef770cc362dad7afd90463', './poc/api/json-rest-api-fc28cca0b2ef770cc362dad7afd90463.yaml');
INSERT INTO `poc` VALUES (727, 4, 'json-rest-api-plugin-d41d8cd98f00b204e9800998ecf8427e', './poc/api/json-rest-api-plugin-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (728, 4, 'json-rest-api-plugin', './poc/api/json-rest-api-plugin.yaml');
INSERT INTO `poc` VALUES (729, 4, 'json-rest-api-plugin_1', './poc/api/json-rest-api-plugin_1.yaml');
INSERT INTO `poc` VALUES (730, 4, 'json-rest-api', './poc/api/json-rest-api.yaml');
INSERT INTO `poc` VALUES (731, 4, 'json-rest-api_1', './poc/api/json-rest-api_1.yaml');
INSERT INTO `poc` VALUES (732, 4, 'json-rest-api_2', './poc/api/json-rest-api_2.yaml');
INSERT INTO `poc` VALUES (733, 4, 'k8s-apiserver-unauthorized', './poc/api/k8s-apiserver-unauthorized.yaml');
INSERT INTO `poc` VALUES (734, 4, 'kube-api-deployments-8503', './poc/api/kube-api-deployments-8503.yaml');
INSERT INTO `poc` VALUES (735, 4, 'kube-api-deployments-8503_1', './poc/api/kube-api-deployments-8503_1.yaml');
INSERT INTO `poc` VALUES (736, 4, 'kube-api-deployments-8504', './poc/api/kube-api-deployments-8504.yaml');
INSERT INTO `poc` VALUES (737, 4, 'kube-api-deployments-8504_1', './poc/api/kube-api-deployments-8504_1.yaml');
INSERT INTO `poc` VALUES (738, 4, 'kube-api-deployments-8504_2', './poc/api/kube-api-deployments-8504_2.yaml');
INSERT INTO `poc` VALUES (739, 4, 'kube-api-deployments', './poc/api/kube-api-deployments.yaml');
INSERT INTO `poc` VALUES (740, 4, 'kube-api-namespaces-8505', './poc/api/kube-api-namespaces-8505.yaml');
INSERT INTO `poc` VALUES (741, 4, 'kube-api-namespaces-8505_1', './poc/api/kube-api-namespaces-8505_1.yaml');
INSERT INTO `poc` VALUES (742, 4, 'kube-api-namespaces-8506', './poc/api/kube-api-namespaces-8506.yaml');
INSERT INTO `poc` VALUES (743, 4, 'kube-api-namespaces-8506_1', './poc/api/kube-api-namespaces-8506_1.yaml');
INSERT INTO `poc` VALUES (744, 4, 'kube-api-namespaces', './poc/api/kube-api-namespaces.yaml');
INSERT INTO `poc` VALUES (745, 4, 'kube-api-namespaces_1', './poc/api/kube-api-namespaces_1.yaml');
INSERT INTO `poc` VALUES (746, 4, 'kube-api-nodes-8507', './poc/api/kube-api-nodes-8507.yaml');
INSERT INTO `poc` VALUES (747, 4, 'kube-api-nodes-8507_1', './poc/api/kube-api-nodes-8507_1.yaml');
INSERT INTO `poc` VALUES (748, 4, 'kube-api-nodes-8508', './poc/api/kube-api-nodes-8508.yaml');
INSERT INTO `poc` VALUES (749, 4, 'kube-api-nodes-8508_1', './poc/api/kube-api-nodes-8508_1.yaml');
INSERT INTO `poc` VALUES (750, 4, 'kube-api-nodes-8508_2', './poc/api/kube-api-nodes-8508_2.yaml');
INSERT INTO `poc` VALUES (751, 4, 'kube-api-nodes', './poc/api/kube-api-nodes.yaml');
INSERT INTO `poc` VALUES (752, 4, 'kube-api-nodes_1', './poc/api/kube-api-nodes_1.yaml');
INSERT INTO `poc` VALUES (753, 4, 'kube-api-nodes_2', './poc/api/kube-api-nodes_2.yaml');
INSERT INTO `poc` VALUES (754, 4, 'kube-api-nodes_3', './poc/api/kube-api-nodes_3.yaml');
INSERT INTO `poc` VALUES (755, 4, 'kube-api-pods-8509', './poc/api/kube-api-pods-8509.yaml');
INSERT INTO `poc` VALUES (756, 4, 'kube-api-pods-8509_1', './poc/api/kube-api-pods-8509_1.yaml');
INSERT INTO `poc` VALUES (757, 4, 'kube-api-pods-8510', './poc/api/kube-api-pods-8510.yaml');
INSERT INTO `poc` VALUES (758, 4, 'kube-api-pods-8510_1', './poc/api/kube-api-pods-8510_1.yaml');
INSERT INTO `poc` VALUES (759, 4, 'kube-api-pods', './poc/api/kube-api-pods.yaml');
INSERT INTO `poc` VALUES (760, 4, 'kube-api-pods_1', './poc/api/kube-api-pods_1.yaml');
INSERT INTO `poc` VALUES (761, 4, 'kube-api-pods_2', './poc/api/kube-api-pods_2.yaml');
INSERT INTO `poc` VALUES (762, 4, 'kube-api-roles', './poc/api/kube-api-roles.yaml');
INSERT INTO `poc` VALUES (763, 4, 'kube-api-scan', './poc/api/kube-api-scan.yaml');
INSERT INTO `poc` VALUES (764, 4, 'kube-api-scan_1', './poc/api/kube-api-scan_1.yaml');
INSERT INTO `poc` VALUES (765, 4, 'kube-api-secrets-8511', './poc/api/kube-api-secrets-8511.yaml');
INSERT INTO `poc` VALUES (766, 4, 'kube-api-services-8513', './poc/api/kube-api-services-8513.yaml');
INSERT INTO `poc` VALUES (767, 4, 'kube-api-services-8513_1', './poc/api/kube-api-services-8513_1.yaml');
INSERT INTO `poc` VALUES (768, 4, 'kube-api-services-8514', './poc/api/kube-api-services-8514.yaml');
INSERT INTO `poc` VALUES (769, 4, 'kube-api-services-8514_1', './poc/api/kube-api-services-8514_1.yaml');
INSERT INTO `poc` VALUES (770, 4, 'kube-api-services', './poc/api/kube-api-services.yaml');
INSERT INTO `poc` VALUES (771, 4, 'kube-api-services_1', './poc/api/kube-api-services_1.yaml');
INSERT INTO `poc` VALUES (772, 4, 'kube-api-services_2', './poc/api/kube-api-services_2.yaml');
INSERT INTO `poc` VALUES (773, 4, 'kube-api-version', './poc/api/kube-api-version.yaml');
INSERT INTO `poc` VALUES (774, 4, 'kube-api-version_1', './poc/api/kube-api-version_1.yaml');
INSERT INTO `poc` VALUES (775, 4, 'kube-api-version_2', './poc/api/kube-api-version_2.yaml');
INSERT INTO `poc` VALUES (776, 4, 'liferay-api', './poc/api/liferay-api.yaml');
INSERT INTO `poc` VALUES (777, 4, 'liferay-api_1', './poc/api/liferay-api_1.yaml');
INSERT INTO `poc` VALUES (778, 4, 'liferay-api_2', './poc/api/liferay-api_2.yaml');
INSERT INTO `poc` VALUES (779, 4, 'liferay-api_3', './poc/api/liferay-api_3.yaml');
INSERT INTO `poc` VALUES (780, 4, 'maanstore-api-708b0410a0040de520d9c33d4656f0ed', './poc/api/maanstore-api-708b0410a0040de520d9c33d4656f0ed.yaml');
INSERT INTO `poc` VALUES (781, 4, 'maanstore-api', './poc/api/maanstore-api.yaml');
INSERT INTO `poc` VALUES (782, 4, 'magento-2-exposed-api-1', './poc/api/magento-2-exposed-api-1.yaml');
INSERT INTO `poc` VALUES (783, 4, 'magento-2-exposed-api-2', './poc/api/magento-2-exposed-api-2.yaml');
INSERT INTO `poc` VALUES (784, 4, 'magento-2-exposed-api-3', './poc/api/magento-2-exposed-api-3.yaml');
INSERT INTO `poc` VALUES (785, 4, 'magento-2-exposed-api-8687', './poc/api/magento-2-exposed-api-8687.yaml');
INSERT INTO `poc` VALUES (786, 4, 'magento-2-exposed-api-8688', './poc/api/magento-2-exposed-api-8688.yaml');
INSERT INTO `poc` VALUES (787, 4, 'magento-2-exposed-api-8689', './poc/api/magento-2-exposed-api-8689.yaml');
INSERT INTO `poc` VALUES (788, 4, 'magento-2-exposed-api-8689_1', './poc/api/magento-2-exposed-api-8689_1.yaml');
INSERT INTO `poc` VALUES (789, 4, 'magento-2-exposed-api', './poc/api/magento-2-exposed-api.yaml');
INSERT INTO `poc` VALUES (790, 4, 'magento-2-exposed-api_1', './poc/api/magento-2-exposed-api_1.yaml');
INSERT INTO `poc` VALUES (791, 4, 'mailgun-api-token', './poc/api/mailgun-api-token.yaml');
INSERT INTO `poc` VALUES (792, 4, 'mapifylite-0f50434af4d25993907702f024089573', './poc/api/mapifylite-0f50434af4d25993907702f024089573.yaml');
INSERT INTO `poc` VALUES (793, 4, 'mapifylite-5337e2d76eda361e94ff056a55642367', './poc/api/mapifylite-5337e2d76eda361e94ff056a55642367.yaml');
INSERT INTO `poc` VALUES (794, 4, 'mapifylite-8305549774676e8829e05033205b2dc6', './poc/api/mapifylite-8305549774676e8829e05033205b2dc6.yaml');
INSERT INTO `poc` VALUES (795, 4, 'mapifylite-d41d8cd98f00b204e9800998ecf8427e', './poc/api/mapifylite-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (796, 4, 'mapifylite-plugin-d41d8cd98f00b204e9800998ecf8427e', './poc/api/mapifylite-plugin-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (797, 4, 'mapifylite-plugin', './poc/api/mapifylite-plugin.yaml');
INSERT INTO `poc` VALUES (798, 4, 'mapifylite-plugin_1', './poc/api/mapifylite-plugin_1.yaml');
INSERT INTO `poc` VALUES (799, 4, 'mapifylite', './poc/api/mapifylite.yaml');
INSERT INTO `poc` VALUES (800, 4, 'mapifylite_1', './poc/api/mapifylite_1.yaml');
INSERT INTO `poc` VALUES (801, 4, 'mikrotik-routeros-api-detect', './poc/api/mikrotik-routeros-api-detect.yaml');
INSERT INTO `poc` VALUES (802, 4, 'mikrotik-routeros-api', './poc/api/mikrotik-routeros-api.yaml');
INSERT INTO `poc` VALUES (803, 4, 'mikrotik-routeros-api_1', './poc/api/mikrotik-routeros-api_1.yaml');
INSERT INTO `poc` VALUES (804, 4, 'mingyuanyun-erp-apiupdate-ashx-fileupload', './poc/api/mingyuanyun-erp-apiupdate-ashx-fileupload.yaml');
INSERT INTO `poc` VALUES (805, 4, 'mingyuanyun-erp-apiupdate-ashx-fileupload_1', './poc/api/mingyuanyun-erp-apiupdate-ashx-fileupload_1.yaml');
INSERT INTO `poc` VALUES (806, 4, 'mingyuanyun-ERP-upload-ApiUpdate', './poc/api/mingyuanyun-ERP-upload-ApiUpdate.yaml');
INSERT INTO `poc` VALUES (807, 4, 'mstore-api-02402a5deb8680f475ccb8226636819a', './poc/api/mstore-api-02402a5deb8680f475ccb8226636819a.yaml');
INSERT INTO `poc` VALUES (808, 4, 'mstore-api-0eb1bb0f484da3d8212ba34bc125bacb', './poc/api/mstore-api-0eb1bb0f484da3d8212ba34bc125bacb.yaml');
INSERT INTO `poc` VALUES (809, 4, 'mstore-api-105ed18ef2da652c329af90470918787', './poc/api/mstore-api-105ed18ef2da652c329af90470918787.yaml');
INSERT INTO `poc` VALUES (810, 4, 'mstore-api-1a041b08697154e12520bec89a768810', './poc/api/mstore-api-1a041b08697154e12520bec89a768810.yaml');
INSERT INTO `poc` VALUES (811, 4, 'mstore-api-1c2cd9ed5c2d1dcf576fe7aecb5ca226', './poc/api/mstore-api-1c2cd9ed5c2d1dcf576fe7aecb5ca226.yaml');
INSERT INTO `poc` VALUES (812, 4, 'mstore-api-319cdcd8aefa6dfb47435662ea3be489', './poc/api/mstore-api-319cdcd8aefa6dfb47435662ea3be489.yaml');
INSERT INTO `poc` VALUES (813, 4, 'mstore-api-3678a5cbd624bf906b9f1499b42e328d', './poc/api/mstore-api-3678a5cbd624bf906b9f1499b42e328d.yaml');
INSERT INTO `poc` VALUES (814, 4, 'mstore-api-38ba49601a425b3e76ea50d7fcb5c3bf', './poc/api/mstore-api-38ba49601a425b3e76ea50d7fcb5c3bf.yaml');
INSERT INTO `poc` VALUES (815, 4, 'mstore-api-3bbe1e9b2827123550346928e2f78aea', './poc/api/mstore-api-3bbe1e9b2827123550346928e2f78aea.yaml');
INSERT INTO `poc` VALUES (816, 4, 'mstore-api-47e384bbd4951ebb4d217ea16a357447', './poc/api/mstore-api-47e384bbd4951ebb4d217ea16a357447.yaml');
INSERT INTO `poc` VALUES (817, 4, 'mstore-api-55f292e317ef01e9a7de7f394a022210', './poc/api/mstore-api-55f292e317ef01e9a7de7f394a022210.yaml');
INSERT INTO `poc` VALUES (818, 4, 'mstore-api-5aa30296a4f0ae648270a4e74d17b635', './poc/api/mstore-api-5aa30296a4f0ae648270a4e74d17b635.yaml');
INSERT INTO `poc` VALUES (819, 4, 'mstore-api-6455a4c18e211ec9c979086a333e3980', './poc/api/mstore-api-6455a4c18e211ec9c979086a333e3980.yaml');
INSERT INTO `poc` VALUES (820, 4, 'mstore-api-6a7c29035944a1901b23ef2195208fe3', './poc/api/mstore-api-6a7c29035944a1901b23ef2195208fe3.yaml');
INSERT INTO `poc` VALUES (821, 4, 'mstore-api-79265025e2ae87c5e5adf65c0d03eeec', './poc/api/mstore-api-79265025e2ae87c5e5adf65c0d03eeec.yaml');
INSERT INTO `poc` VALUES (822, 4, 'mstore-api-93fdae516730f70ba98c55ad66f91e37', './poc/api/mstore-api-93fdae516730f70ba98c55ad66f91e37.yaml');
INSERT INTO `poc` VALUES (823, 4, 'mstore-api-942f8083e86bbabecdf5f62605975f90', './poc/api/mstore-api-942f8083e86bbabecdf5f62605975f90.yaml');
INSERT INTO `poc` VALUES (824, 4, 'mstore-api-98530e564c40e06cb08336bf83b26985', './poc/api/mstore-api-98530e564c40e06cb08336bf83b26985.yaml');
INSERT INTO `poc` VALUES (825, 4, 'mstore-api-988407c33f7581ffe7f693625812374d', './poc/api/mstore-api-988407c33f7581ffe7f693625812374d.yaml');
INSERT INTO `poc` VALUES (826, 4, 'mstore-api-a1fd15e9b76a3b82e1c25ef611ae13f2', './poc/api/mstore-api-a1fd15e9b76a3b82e1c25ef611ae13f2.yaml');
INSERT INTO `poc` VALUES (827, 4, 'mstore-api-a57c8c0705eb9b80f8f4283e89729950', './poc/api/mstore-api-a57c8c0705eb9b80f8f4283e89729950.yaml');
INSERT INTO `poc` VALUES (828, 4, 'mstore-api-b04821f92bc1fa09ad4daf81d27d02ea', './poc/api/mstore-api-b04821f92bc1fa09ad4daf81d27d02ea.yaml');
INSERT INTO `poc` VALUES (829, 4, 'mstore-api-cbc5f2dade7ffd73dc94047427495160', './poc/api/mstore-api-cbc5f2dade7ffd73dc94047427495160.yaml');
INSERT INTO `poc` VALUES (830, 4, 'mstore-api-d2b388339242c720f46cbe77baee82e9', './poc/api/mstore-api-d2b388339242c720f46cbe77baee82e9.yaml');
INSERT INTO `poc` VALUES (831, 4, 'mstore-api-d41d8cd98f00b204e9800998ecf8427e', './poc/api/mstore-api-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (832, 4, 'mstore-api-d910e01b3d593541d815218ceecc939c', './poc/api/mstore-api-d910e01b3d593541d815218ceecc939c.yaml');
INSERT INTO `poc` VALUES (833, 4, 'mstore-api-e4ec9913d1bb92387e5617f1a9154fbf', './poc/api/mstore-api-e4ec9913d1bb92387e5617f1a9154fbf.yaml');
INSERT INTO `poc` VALUES (834, 4, 'mstore-api-e4ef9806cec7ccd2f80285c1d7ff358b', './poc/api/mstore-api-e4ef9806cec7ccd2f80285c1d7ff358b.yaml');
INSERT INTO `poc` VALUES (835, 4, 'mstore-api-f49bee9dc34bbcc46c27d950b1ad9f49', './poc/api/mstore-api-f49bee9dc34bbcc46c27d950b1ad9f49.yaml');
INSERT INTO `poc` VALUES (836, 4, 'mstore-api-fcf575731390b94d640824227bb01949', './poc/api/mstore-api-fcf575731390b94d640824227bb01949.yaml');
INSERT INTO `poc` VALUES (837, 4, 'mstore-api-plugin-d41d8cd98f00b204e9800998ecf8427e', './poc/api/mstore-api-plugin-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (838, 4, 'mstore-api-plugin', './poc/api/mstore-api-plugin.yaml');
INSERT INTO `poc` VALUES (839, 4, 'mstore-api-plugin_1', './poc/api/mstore-api-plugin_1.yaml');
INSERT INTO `poc` VALUES (840, 4, 'mstore-api', './poc/api/mstore-api.yaml');
INSERT INTO `poc` VALUES (841, 4, 'mstore-api_1', './poc/api/mstore-api_1.yaml');
INSERT INTO `poc` VALUES (842, 4, 'mstore-api_2', './poc/api/mstore-api_2.yaml');
INSERT INTO `poc` VALUES (843, 4, 'mz-mindbody-api-2eb1612914ec185c0d11cc1160959412', './poc/api/mz-mindbody-api-2eb1612914ec185c0d11cc1160959412.yaml');
INSERT INTO `poc` VALUES (844, 4, 'mz-mindbody-api-62de33dd2146692efb2926dd7e3fdad9', './poc/api/mz-mindbody-api-62de33dd2146692efb2926dd7e3fdad9.yaml');
INSERT INTO `poc` VALUES (845, 4, 'mz-mindbody-api-d41d8cd98f00b204e9800998ecf8427e', './poc/api/mz-mindbody-api-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (846, 4, 'mz-mindbody-api-fca0be0e46f35ce98ffc349ba57e202a', './poc/api/mz-mindbody-api-fca0be0e46f35ce98ffc349ba57e202a.yaml');
INSERT INTO `poc` VALUES (847, 4, 'mz-mindbody-api-plugin-d41d8cd98f00b204e9800998ecf8427e', './poc/api/mz-mindbody-api-plugin-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (848, 4, 'mz-mindbody-api-plugin', './poc/api/mz-mindbody-api-plugin.yaml');
INSERT INTO `poc` VALUES (849, 4, 'mz-mindbody-api', './poc/api/mz-mindbody-api.yaml');
INSERT INTO `poc` VALUES (850, 4, 'naver-blog-api-dfc888956fb4ba18c9f34639db139ac7', './poc/api/naver-blog-api-dfc888956fb4ba18c9f34639db139ac7.yaml');
INSERT INTO `poc` VALUES (851, 4, 'naver-blog-api', './poc/api/naver-blog-api.yaml');
INSERT INTO `poc` VALUES (852, 4, 'navigation-du-lapin-blanc-090c207ac35a813b3f6a81f89f0c3bb8', './poc/api/navigation-du-lapin-blanc-090c207ac35a813b3f6a81f89f0c3bb8.yaml');
INSERT INTO `poc` VALUES (853, 4, 'navigation-du-lapin-blanc', './poc/api/navigation-du-lapin-blanc.yaml');
INSERT INTO `poc` VALUES (854, 4, 'newrelic-pixie-api-key', './poc/api/newrelic-pixie-api-key.yaml');
INSERT INTO `poc` VALUES (855, 4, 'newsletter-api-c7dfaf715662642b2a17cb2727061e72', './poc/api/newsletter-api-c7dfaf715662642b2a17cb2727061e72.yaml');
INSERT INTO `poc` VALUES (856, 4, 'newsletter-api', './poc/api/newsletter-api.yaml');
INSERT INTO `poc` VALUES (857, 4, 'newsletter-api_1', './poc/api/newsletter-api_1.yaml');
INSERT INTO `poc` VALUES (858, 4, 'no-api-amazon-affiliate-5b9f2d469b9a77ec2105c4205d54c33b', './poc/api/no-api-amazon-affiliate-5b9f2d469b9a77ec2105c4205d54c33b.yaml');
INSERT INTO `poc` VALUES (859, 4, 'no-api-amazon-affiliate', './poc/api/no-api-amazon-affiliate.yaml');
INSERT INTO `poc` VALUES (860, 4, 'no-api-amazon-affiliate_1', './poc/api/no-api-amazon-affiliate_1.yaml');
INSERT INTO `poc` VALUES (861, 4, 'nuget-api-key', './poc/api/nuget-api-key.yaml');
INSERT INTO `poc` VALUES (862, 4, 'open-api-docs', './poc/api/open-api-docs.yaml');
INSERT INTO `poc` VALUES (863, 4, 'open-api-docs_1', './poc/api/open-api-docs_1.yaml');
INSERT INTO `poc` VALUES (864, 4, 'openai-api-key', './poc/api/openai-api-key.yaml');
INSERT INTO `poc` VALUES (865, 4, 'openapi-1', './poc/api/openapi-1.yaml');
INSERT INTO `poc` VALUES (866, 4, 'openapi-2', './poc/api/openapi-2.yaml');
INSERT INTO `poc` VALUES (867, 4, 'openapi', './poc/api/openapi.yaml');
INSERT INTO `poc` VALUES (868, 4, 'openapi_1', './poc/api/openapi_1.yaml');
INSERT INTO `poc` VALUES (869, 4, 'planaday-api', './poc/api/planaday-api.yaml');
INSERT INTO `poc` VALUES (870, 4, 'planaday-api_1', './poc/api/planaday-api_1.yaml');
INSERT INTO `poc` VALUES (871, 4, 'public-jamf-api', './poc/api/public-jamf-api.yaml');
INSERT INTO `poc` VALUES (872, 4, 'public-jamf-api_1', './poc/api/public-jamf-api_1.yaml');
INSERT INTO `poc` VALUES (873, 4, 'rapid-browser', './poc/api/rapid-browser.yaml');
INSERT INTO `poc` VALUES (874, 4, 'rapid-cache-48d8b39b1330fbde627625bef5622d8a', './poc/api/rapid-cache-48d8b39b1330fbde627625bef5622d8a.yaml');
INSERT INTO `poc` VALUES (875, 4, 'rapid-cache', './poc/api/rapid-cache.yaml');
INSERT INTO `poc` VALUES (876, 4, 'rapidexpcart-48b624f275d2332e2585c5bd22f960ff', './poc/api/rapidexpcart-48b624f275d2332e2585c5bd22f960ff.yaml');
INSERT INTO `poc` VALUES (877, 4, 'rapidexpcart-d9e4b9d5846e118b214690dd712f2b8e', './poc/api/rapidexpcart-d9e4b9d5846e118b214690dd712f2b8e.yaml');
INSERT INTO `poc` VALUES (878, 4, 'rapidexpcart', './poc/api/rapidexpcart.yaml');
INSERT INTO `poc` VALUES (879, 4, 'rapidexpcart_1', './poc/api/rapidexpcart_1.yaml');
INSERT INTO `poc` VALUES (880, 4, 'realor_console_external_api_sqli', './poc/api/realor_console_external_api_sqli.yaml');
INSERT INTO `poc` VALUES (881, 4, 'redfish-api-detect', './poc/api/redfish-api-detect.yaml');
INSERT INTO `poc` VALUES (882, 4, 'redfish-api-service-detect', './poc/api/redfish-api-service-detect.yaml');
INSERT INTO `poc` VALUES (883, 4, 'redfish-api', './poc/api/redfish-api.yaml');
INSERT INTO `poc` VALUES (884, 4, 'rest-api-fns-0ac67ad6cc48d67bc9bc2e2178d4edb8', './poc/api/rest-api-fns-0ac67ad6cc48d67bc9bc2e2178d4edb8.yaml');
INSERT INTO `poc` VALUES (885, 4, 'rest-api-fns-8ea4eff280da549249ca1b90503dab5f', './poc/api/rest-api-fns-8ea4eff280da549249ca1b90503dab5f.yaml');
INSERT INTO `poc` VALUES (886, 4, 'rest-api-fns', './poc/api/rest-api-fns.yaml');
INSERT INTO `poc` VALUES (887, 4, 'rest-api-fns_1', './poc/api/rest-api-fns_1.yaml');
INSERT INTO `poc` VALUES (888, 4, 'rest-api-to-miniprogram-3af58009d5d915e0ad27454f1ec69b70', './poc/api/rest-api-to-miniprogram-3af58009d5d915e0ad27454f1ec69b70.yaml');
INSERT INTO `poc` VALUES (889, 4, 'rest-api-to-miniprogram-b29fe1ce3c1860896bc94bfeda6615c4', './poc/api/rest-api-to-miniprogram-b29fe1ce3c1860896bc94bfeda6615c4.yaml');
INSERT INTO `poc` VALUES (890, 4, 'rest-api-to-miniprogram-c1855a35b6e62b6366e7318ce1fcb0cd', './poc/api/rest-api-to-miniprogram-c1855a35b6e62b6366e7318ce1fcb0cd.yaml');
INSERT INTO `poc` VALUES (891, 4, 'rest-api-to-miniprogram-e48c8f78c71c24aa3d3b03a8f2e2ddb8', './poc/api/rest-api-to-miniprogram-e48c8f78c71c24aa3d3b03a8f2e2ddb8.yaml');
INSERT INTO `poc` VALUES (892, 4, 'rest-api-to-miniprogram', './poc/api/rest-api-to-miniprogram.yaml');
INSERT INTO `poc` VALUES (893, 4, 'rest-api-to-miniprogram_1', './poc/api/rest-api-to-miniprogram_1.yaml');
INSERT INTO `poc` VALUES (894, 4, 's3-sensitive-api', './poc/api/s3-sensitive-api.yaml');
INSERT INTO `poc` VALUES (895, 4, 'seafile-api', './poc/api/seafile-api.yaml');
INSERT INTO `poc` VALUES (896, 4, 'seafile-api_1', './poc/api/seafile-api_1.yaml');
INSERT INTO `poc` VALUES (897, 4, 'sema-api-9ec9b6547592027bf7806a9137a21610', './poc/api/sema-api-9ec9b6547592027bf7806a9137a21610.yaml');
INSERT INTO `poc` VALUES (898, 4, 'sema-api-b9fc11c70eceb7a7923754c656c28f17', './poc/api/sema-api-b9fc11c70eceb7a7923754c656c28f17.yaml');
INSERT INTO `poc` VALUES (899, 4, 'sema-api', './poc/api/sema-api.yaml');
INSERT INTO `poc` VALUES (900, 4, 'sema-api_1', './poc/api/sema-api_1.yaml');
INSERT INTO `poc` VALUES (901, 4, 'simple-map-no-api-668746bb281d78ca153c4a289f85ed63', './poc/api/simple-map-no-api-668746bb281d78ca153c4a289f85ed63.yaml');
INSERT INTO `poc` VALUES (902, 4, 'simple-map-no-api-ca4c875f1fd61e800f9fb0b3dac11355', './poc/api/simple-map-no-api-ca4c875f1fd61e800f9fb0b3dac11355.yaml');
INSERT INTO `poc` VALUES (903, 4, 'simple-map-no-api', './poc/api/simple-map-no-api.yaml');
INSERT INTO `poc` VALUES (904, 4, 'smm-api-e9a43a403ccd193acc219d881c340eaa', './poc/api/smm-api-e9a43a403ccd193acc219d881c340eaa.yaml');
INSERT INTO `poc` VALUES (905, 4, 'splunk-mgmt-api', './poc/api/splunk-mgmt-api.yaml');
INSERT INTO `poc` VALUES (906, 4, 'sprapid-45ba464412c6ae4b94e80349ccf8b660', './poc/api/sprapid-45ba464412c6ae4b94e80349ccf8b660.yaml');
INSERT INTO `poc` VALUES (907, 4, 'sprapid', './poc/api/sprapid.yaml');
INSERT INTO `poc` VALUES (908, 4, 'sprapid_1', './poc/api/sprapid_1.yaml');
INSERT INTO `poc` VALUES (909, 4, 'stackhawk-api', './poc/api/stackhawk-api.yaml');
INSERT INTO `poc` VALUES (910, 4, 'stackhawk-api_1', './poc/api/stackhawk-api_1.yaml');
INSERT INTO `poc` VALUES (911, 4, 'stackhawk-api_2', './poc/api/stackhawk-api_2.yaml');
INSERT INTO `poc` VALUES (912, 4, 'stackhawk-api_3', './poc/api/stackhawk-api_3.yaml');
INSERT INTO `poc` VALUES (913, 4, 'strapi-admin-exposure', './poc/api/strapi-admin-exposure.yaml');
INSERT INTO `poc` VALUES (914, 4, 'strapi-admin-installer', './poc/api/strapi-admin-installer.yaml');
INSERT INTO `poc` VALUES (915, 4, 'strapi-cms-detect-10538', './poc/api/strapi-cms-detect-10538.yaml');
INSERT INTO `poc` VALUES (916, 4, 'strapi-cms-detect-10539', './poc/api/strapi-cms-detect-10539.yaml');
INSERT INTO `poc` VALUES (917, 4, 'strapi-cms-detect-10540', './poc/api/strapi-cms-detect-10540.yaml');
INSERT INTO `poc` VALUES (918, 4, 'strapi-cms-detect', './poc/api/strapi-cms-detect.yaml');
INSERT INTO `poc` VALUES (919, 4, 'strapi-documentation-10542', './poc/api/strapi-documentation-10542.yaml');
INSERT INTO `poc` VALUES (920, 4, 'strapi-documentation-10542_1', './poc/api/strapi-documentation-10542_1.yaml');
INSERT INTO `poc` VALUES (921, 4, 'strapi-documentation-10542_2', './poc/api/strapi-documentation-10542_2.yaml');
INSERT INTO `poc` VALUES (922, 4, 'strapi-documentation-10543', './poc/api/strapi-documentation-10543.yaml');
INSERT INTO `poc` VALUES (923, 4, 'strapi-documentation-10543_1', './poc/api/strapi-documentation-10543_1.yaml');
INSERT INTO `poc` VALUES (924, 4, 'strapi-documentation', './poc/api/strapi-documentation.yaml');
INSERT INTO `poc` VALUES (925, 4, 'strapi-documentation_1', './poc/api/strapi-documentation_1.yaml');
INSERT INTO `poc` VALUES (926, 4, 'strapi-page-1', './poc/api/strapi-page-1.yaml');
INSERT INTO `poc` VALUES (927, 4, 'strapi-page-10544', './poc/api/strapi-page-10544.yaml');
INSERT INTO `poc` VALUES (928, 4, 'strapi-page-10544_1', './poc/api/strapi-page-10544_1.yaml');
INSERT INTO `poc` VALUES (929, 4, 'strapi-page-10544_2', './poc/api/strapi-page-10544_2.yaml');
INSERT INTO `poc` VALUES (930, 4, 'strapi-page-10545', './poc/api/strapi-page-10545.yaml');
INSERT INTO `poc` VALUES (931, 4, 'strapi-page-10545_1', './poc/api/strapi-page-10545_1.yaml');
INSERT INTO `poc` VALUES (932, 4, 'strapi-page-10546', './poc/api/strapi-page-10546.yaml');
INSERT INTO `poc` VALUES (933, 4, 'strapi-page-10546_1', './poc/api/strapi-page-10546_1.yaml');
INSERT INTO `poc` VALUES (934, 4, 'strapi-page-10546_2', './poc/api/strapi-page-10546_2.yaml');
INSERT INTO `poc` VALUES (935, 4, 'strapi-page-10547', './poc/api/strapi-page-10547.yaml');
INSERT INTO `poc` VALUES (936, 4, 'strapi-page-2', './poc/api/strapi-page-2.yaml');
INSERT INTO `poc` VALUES (937, 4, 'strapi-page', './poc/api/strapi-page.yaml');
INSERT INTO `poc` VALUES (938, 4, 'strapi-page_1', './poc/api/strapi-page_1.yaml');
INSERT INTO `poc` VALUES (939, 4, 'strapi-panel', './poc/api/strapi-panel.yaml');
INSERT INTO `poc` VALUES (940, 4, 'strapi-panel_1', './poc/api/strapi-panel_1.yaml');
INSERT INTO `poc` VALUES (941, 4, 'strapi', './poc/api/strapi.yaml');
INSERT INTO `poc` VALUES (942, 4, 'swagger-api-1', './poc/api/swagger-api-1.yaml');
INSERT INTO `poc` VALUES (943, 4, 'swagger-api-10', './poc/api/swagger-api-10.yaml');
INSERT INTO `poc` VALUES (944, 4, 'swagger-api-10591', './poc/api/swagger-api-10591.yaml');
INSERT INTO `poc` VALUES (945, 4, 'swagger-api-10591_1', './poc/api/swagger-api-10591_1.yaml');
INSERT INTO `poc` VALUES (946, 4, 'swagger-api-10592', './poc/api/swagger-api-10592.yaml');
INSERT INTO `poc` VALUES (947, 4, 'swagger-api-10592_1', './poc/api/swagger-api-10592_1.yaml');
INSERT INTO `poc` VALUES (948, 4, 'swagger-api-10593', './poc/api/swagger-api-10593.yaml');
INSERT INTO `poc` VALUES (949, 4, 'swagger-api-10593_1', './poc/api/swagger-api-10593_1.yaml');
INSERT INTO `poc` VALUES (950, 4, 'swagger-api-10594', './poc/api/swagger-api-10594.yaml');
INSERT INTO `poc` VALUES (951, 4, 'swagger-api-10595', './poc/api/swagger-api-10595.yaml');
INSERT INTO `poc` VALUES (952, 4, 'swagger-api-10595_1', './poc/api/swagger-api-10595_1.yaml');
INSERT INTO `poc` VALUES (953, 4, 'swagger-api-11', './poc/api/swagger-api-11.yaml');
INSERT INTO `poc` VALUES (954, 4, 'swagger-api-12', './poc/api/swagger-api-12.yaml');
INSERT INTO `poc` VALUES (955, 4, 'swagger-api-13', './poc/api/swagger-api-13.yaml');
INSERT INTO `poc` VALUES (956, 4, 'swagger-api-14', './poc/api/swagger-api-14.yaml');
INSERT INTO `poc` VALUES (957, 4, 'swagger-api-15', './poc/api/swagger-api-15.yaml');
INSERT INTO `poc` VALUES (958, 4, 'swagger-api-16', './poc/api/swagger-api-16.yaml');
INSERT INTO `poc` VALUES (959, 4, 'swagger-api-17', './poc/api/swagger-api-17.yaml');
INSERT INTO `poc` VALUES (960, 4, 'swagger-api-18', './poc/api/swagger-api-18.yaml');
INSERT INTO `poc` VALUES (961, 4, 'swagger-api-19', './poc/api/swagger-api-19.yaml');
INSERT INTO `poc` VALUES (962, 4, 'swagger-api-2', './poc/api/swagger-api-2.yaml');
INSERT INTO `poc` VALUES (963, 4, 'swagger-api-20', './poc/api/swagger-api-20.yaml');
INSERT INTO `poc` VALUES (964, 4, 'swagger-api-21', './poc/api/swagger-api-21.yaml');
INSERT INTO `poc` VALUES (965, 4, 'swagger-api-22', './poc/api/swagger-api-22.yaml');
INSERT INTO `poc` VALUES (966, 4, 'swagger-api-23', './poc/api/swagger-api-23.yaml');
INSERT INTO `poc` VALUES (967, 4, 'swagger-api-24', './poc/api/swagger-api-24.yaml');
INSERT INTO `poc` VALUES (968, 4, 'swagger-api-25', './poc/api/swagger-api-25.yaml');
INSERT INTO `poc` VALUES (969, 4, 'swagger-api-26', './poc/api/swagger-api-26.yaml');
INSERT INTO `poc` VALUES (970, 4, 'swagger-api-27', './poc/api/swagger-api-27.yaml');
INSERT INTO `poc` VALUES (971, 4, 'swagger-api-28', './poc/api/swagger-api-28.yaml');
INSERT INTO `poc` VALUES (972, 4, 'swagger-api-29', './poc/api/swagger-api-29.yaml');
INSERT INTO `poc` VALUES (973, 4, 'swagger-api-3', './poc/api/swagger-api-3.yaml');
INSERT INTO `poc` VALUES (974, 4, 'swagger-api-30', './poc/api/swagger-api-30.yaml');
INSERT INTO `poc` VALUES (975, 4, 'swagger-api-31', './poc/api/swagger-api-31.yaml');
INSERT INTO `poc` VALUES (976, 4, 'swagger-api-32', './poc/api/swagger-api-32.yaml');
INSERT INTO `poc` VALUES (977, 4, 'swagger-api-33', './poc/api/swagger-api-33.yaml');
INSERT INTO `poc` VALUES (978, 4, 'swagger-api-34', './poc/api/swagger-api-34.yaml');
INSERT INTO `poc` VALUES (979, 4, 'swagger-api-35', './poc/api/swagger-api-35.yaml');
INSERT INTO `poc` VALUES (980, 4, 'swagger-api-36', './poc/api/swagger-api-36.yaml');
INSERT INTO `poc` VALUES (981, 4, 'swagger-api-37', './poc/api/swagger-api-37.yaml');
INSERT INTO `poc` VALUES (982, 4, 'swagger-api-38', './poc/api/swagger-api-38.yaml');
INSERT INTO `poc` VALUES (983, 4, 'swagger-api-39', './poc/api/swagger-api-39.yaml');
INSERT INTO `poc` VALUES (984, 4, 'swagger-api-4', './poc/api/swagger-api-4.yaml');
INSERT INTO `poc` VALUES (985, 4, 'swagger-api-40', './poc/api/swagger-api-40.yaml');
INSERT INTO `poc` VALUES (986, 4, 'swagger-api-41', './poc/api/swagger-api-41.yaml');
INSERT INTO `poc` VALUES (987, 4, 'swagger-api-42', './poc/api/swagger-api-42.yaml');
INSERT INTO `poc` VALUES (988, 4, 'swagger-api-43', './poc/api/swagger-api-43.yaml');
INSERT INTO `poc` VALUES (989, 4, 'swagger-api-44', './poc/api/swagger-api-44.yaml');
INSERT INTO `poc` VALUES (990, 4, 'swagger-api-45', './poc/api/swagger-api-45.yaml');
INSERT INTO `poc` VALUES (991, 4, 'swagger-api-46', './poc/api/swagger-api-46.yaml');
INSERT INTO `poc` VALUES (992, 4, 'swagger-api-47', './poc/api/swagger-api-47.yaml');
INSERT INTO `poc` VALUES (993, 4, 'swagger-api-48', './poc/api/swagger-api-48.yaml');
INSERT INTO `poc` VALUES (994, 4, 'swagger-api-49', './poc/api/swagger-api-49.yaml');
INSERT INTO `poc` VALUES (995, 4, 'swagger-api-5', './poc/api/swagger-api-5.yaml');
INSERT INTO `poc` VALUES (996, 4, 'swagger-api-50', './poc/api/swagger-api-50.yaml');
INSERT INTO `poc` VALUES (997, 4, 'swagger-api-51', './poc/api/swagger-api-51.yaml');
INSERT INTO `poc` VALUES (998, 4, 'swagger-api-52', './poc/api/swagger-api-52.yaml');
INSERT INTO `poc` VALUES (999, 4, 'swagger-api-53', './poc/api/swagger-api-53.yaml');
INSERT INTO `poc` VALUES (1000, 4, 'swagger-api-54', './poc/api/swagger-api-54.yaml');
INSERT INTO `poc` VALUES (1001, 4, 'swagger-api-55', './poc/api/swagger-api-55.yaml');
INSERT INTO `poc` VALUES (1002, 4, 'swagger-api-56', './poc/api/swagger-api-56.yaml');
INSERT INTO `poc` VALUES (1003, 4, 'swagger-api-57', './poc/api/swagger-api-57.yaml');
INSERT INTO `poc` VALUES (1004, 4, 'swagger-api-58', './poc/api/swagger-api-58.yaml');
INSERT INTO `poc` VALUES (1005, 4, 'swagger-api-59', './poc/api/swagger-api-59.yaml');
INSERT INTO `poc` VALUES (1006, 4, 'swagger-api-6', './poc/api/swagger-api-6.yaml');
INSERT INTO `poc` VALUES (1007, 4, 'swagger-api-60', './poc/api/swagger-api-60.yaml');
INSERT INTO `poc` VALUES (1008, 4, 'swagger-api-61', './poc/api/swagger-api-61.yaml');
INSERT INTO `poc` VALUES (1009, 4, 'swagger-api-62', './poc/api/swagger-api-62.yaml');
INSERT INTO `poc` VALUES (1010, 4, 'swagger-api-63', './poc/api/swagger-api-63.yaml');
INSERT INTO `poc` VALUES (1011, 4, 'swagger-api-64', './poc/api/swagger-api-64.yaml');
INSERT INTO `poc` VALUES (1012, 4, 'swagger-api-65', './poc/api/swagger-api-65.yaml');
INSERT INTO `poc` VALUES (1013, 4, 'swagger-api-66', './poc/api/swagger-api-66.yaml');
INSERT INTO `poc` VALUES (1014, 4, 'swagger-api-67', './poc/api/swagger-api-67.yaml');
INSERT INTO `poc` VALUES (1015, 4, 'swagger-api-68', './poc/api/swagger-api-68.yaml');
INSERT INTO `poc` VALUES (1016, 4, 'swagger-api-69', './poc/api/swagger-api-69.yaml');
INSERT INTO `poc` VALUES (1017, 4, 'swagger-api-7', './poc/api/swagger-api-7.yaml');
INSERT INTO `poc` VALUES (1018, 4, 'swagger-api-70', './poc/api/swagger-api-70.yaml');
INSERT INTO `poc` VALUES (1019, 4, 'swagger-api-71', './poc/api/swagger-api-71.yaml');
INSERT INTO `poc` VALUES (1020, 4, 'swagger-api-72', './poc/api/swagger-api-72.yaml');
INSERT INTO `poc` VALUES (1021, 4, 'swagger-api-8', './poc/api/swagger-api-8.yaml');
INSERT INTO `poc` VALUES (1022, 4, 'swagger-api-9', './poc/api/swagger-api-9.yaml');
INSERT INTO `poc` VALUES (1023, 4, 'swagger-api-v2', './poc/api/swagger-api-v2.yaml');
INSERT INTO `poc` VALUES (1024, 4, 'swagger-api', './poc/api/swagger-api.yaml');
INSERT INTO `poc` VALUES (1025, 4, 'swagger-api_1', './poc/api/swagger-api_1.yaml');
INSERT INTO `poc` VALUES (1026, 4, 'swagger-api_2', './poc/api/swagger-api_2.yaml');
INSERT INTO `poc` VALUES (1027, 4, 'swagger-api_3', './poc/api/swagger-api_3.yaml');
INSERT INTO `poc` VALUES (1028, 4, 'swagger-api_4', './poc/api/swagger-api_4.yaml');
INSERT INTO `poc` VALUES (1029, 4, 'tongda-api-ali-fileupload', './poc/api/tongda-api-ali-fileupload.yaml');
INSERT INTO `poc` VALUES (1030, 4, 'tongda-api-ali-fileupload_1', './poc/api/tongda-api-ali-fileupload_1.yaml');
INSERT INTO `poc` VALUES (1031, 4, 'tongda-api-file-upload', './poc/api/tongda-api-file-upload.yaml');
INSERT INTO `poc` VALUES (1032, 4, 'umbraco-delivery-api', './poc/api/umbraco-delivery-api.yaml');
INSERT INTO `poc` VALUES (1033, 4, 'unauth-spark-api-10961', './poc/api/unauth-spark-api-10961.yaml');
INSERT INTO `poc` VALUES (1034, 4, 'unauth-spark-api-10965', './poc/api/unauth-spark-api-10965.yaml');
INSERT INTO `poc` VALUES (1035, 4, 'versa-director-api-detect', './poc/api/versa-director-api-detect.yaml');
INSERT INTO `poc` VALUES (1036, 4, 'versa-director-api', './poc/api/versa-director-api.yaml');
INSERT INTO `poc` VALUES (1037, 4, 'versa-director-api_1', './poc/api/versa-director-api_1.yaml');
INSERT INTO `poc` VALUES (1038, 4, 'versa-director-api_2', './poc/api/versa-director-api_2.yaml');
INSERT INTO `poc` VALUES (1039, 4, 'versa-director-api_3', './poc/api/versa-director-api_3.yaml');
INSERT INTO `poc` VALUES (1040, 4, 'video-conferencing-with-zoom-api-plugin', './poc/api/video-conferencing-with-zoom-api-plugin.yaml');
INSERT INTO `poc` VALUES (1041, 4, 'video-conferencing-with-zoom-api', './poc/api/video-conferencing-with-zoom-api.yaml');
INSERT INTO `poc` VALUES (1042, 4, 'wadl-api-1', './poc/api/wadl-api-1.yaml');
INSERT INTO `poc` VALUES (1043, 4, 'wadl-api-11082', './poc/api/wadl-api-11082.yaml');
INSERT INTO `poc` VALUES (1044, 4, 'wadl-api-11082_1', './poc/api/wadl-api-11082_1.yaml');
INSERT INTO `poc` VALUES (1045, 4, 'wadl-api-11083', './poc/api/wadl-api-11083.yaml');
INSERT INTO `poc` VALUES (1046, 4, 'wadl-api-11083_1', './poc/api/wadl-api-11083_1.yaml');
INSERT INTO `poc` VALUES (1047, 4, 'wadl-api-11084', './poc/api/wadl-api-11084.yaml');
INSERT INTO `poc` VALUES (1048, 4, 'wadl-api-11084_1', './poc/api/wadl-api-11084_1.yaml');
INSERT INTO `poc` VALUES (1049, 4, 'wadl-api-11085', './poc/api/wadl-api-11085.yaml');
INSERT INTO `poc` VALUES (1050, 4, 'wadl-api-2', './poc/api/wadl-api-2.yaml');
INSERT INTO `poc` VALUES (1051, 4, 'wadl-api-3', './poc/api/wadl-api-3.yaml');
INSERT INTO `poc` VALUES (1052, 4, 'wadl-api-4', './poc/api/wadl-api-4.yaml');
INSERT INTO `poc` VALUES (1053, 4, 'wadl-api-5', './poc/api/wadl-api-5.yaml');
INSERT INTO `poc` VALUES (1054, 4, 'wadl-api-6', './poc/api/wadl-api-6.yaml');
INSERT INTO `poc` VALUES (1055, 4, 'wadl-api-7', './poc/api/wadl-api-7.yaml');
INSERT INTO `poc` VALUES (1056, 4, 'wadl-api', './poc/api/wadl-api.yaml');
INSERT INTO `poc` VALUES (1057, 4, 'wadl-api_1', './poc/api/wadl-api_1.yaml');
INSERT INTO `poc` VALUES (1058, 4, 'wcfm-marketplace-rest-api-551fa2e180a0fcc0d20542edf0a7e96d', './poc/api/wcfm-marketplace-rest-api-551fa2e180a0fcc0d20542edf0a7e96d.yaml');
INSERT INTO `poc` VALUES (1059, 4, 'wcfm-marketplace-rest-api-83211a697400a39f3ef0aefc82922e72', './poc/api/wcfm-marketplace-rest-api-83211a697400a39f3ef0aefc82922e72.yaml');
INSERT INTO `poc` VALUES (1060, 4, 'wcfm-marketplace-rest-api', './poc/api/wcfm-marketplace-rest-api.yaml');
INSERT INTO `poc` VALUES (1061, 4, 'wcfm-marketplace-rest-api_1', './poc/api/wcfm-marketplace-rest-api_1.yaml');
INSERT INTO `poc` VALUES (1062, 4, 'whmpress_client_area_api-9ce24a7434bb54d6d9b9aca73af1fd4c', './poc/api/whmpress_client_area_api-9ce24a7434bb54d6d9b9aca73af1fd4c.yaml');
INSERT INTO `poc` VALUES (1063, 4, 'whmpress_client_area_api', './poc/api/whmpress_client_area_api.yaml');
INSERT INTO `poc` VALUES (1064, 4, 'widget-for-eventbrite-api-8481b3bab657a969f5b60ffb5c74c4cd', './poc/api/widget-for-eventbrite-api-8481b3bab657a969f5b60ffb5c74c4cd.yaml');
INSERT INTO `poc` VALUES (1065, 4, 'widget-for-eventbrite-api', './poc/api/widget-for-eventbrite-api.yaml');
INSERT INTO `poc` VALUES (1066, 4, 'widget-for-eventbrite-api_1', './poc/api/widget-for-eventbrite-api_1.yaml');
INSERT INTO `poc` VALUES (1067, 4, 'woocommerce-legacy-rest-api', './poc/api/woocommerce-legacy-rest-api.yaml');
INSERT INTO `poc` VALUES (1068, 4, 'woocommerce-legacy-rest-api_1', './poc/api/woocommerce-legacy-rest-api_1.yaml');
INSERT INTO `poc` VALUES (1069, 4, 'wp-mapit-2b7abff28c48fb1a7c273c1f4fcddc53', './poc/api/wp-mapit-2b7abff28c48fb1a7c273c1f4fcddc53.yaml');
INSERT INTO `poc` VALUES (1070, 4, 'wp-mapit', './poc/api/wp-mapit.yaml');
INSERT INTO `poc` VALUES (1071, 4, 'wpgetapi-5cec0bd09fc8ba218dcda5c9a92d3f28', './poc/api/wpgetapi-5cec0bd09fc8ba218dcda5c9a92d3f28.yaml');
INSERT INTO `poc` VALUES (1072, 4, 'wpgetapi-9199e4580380562683f231ebf6308c26', './poc/api/wpgetapi-9199e4580380562683f231ebf6308c26.yaml');
INSERT INTO `poc` VALUES (1073, 4, 'wpgetapi-plugin-d41d8cd98f00b204e9800998ecf8427e', './poc/api/wpgetapi-plugin-d41d8cd98f00b204e9800998ecf8427e.yaml');
INSERT INTO `poc` VALUES (1074, 4, 'wpgetapi-plugin', './poc/api/wpgetapi-plugin.yaml');
INSERT INTO `poc` VALUES (1075, 4, 'wpgetapi', './poc/api/wpgetapi.yaml');
INSERT INTO `poc` VALUES (1076, 4, 'wpm-news-api-7af1223af36a65fb310cf5a108cd2999', './poc/api/wpm-news-api-7af1223af36a65fb310cf5a108cd2999.yaml');
INSERT INTO `poc` VALUES (1077, 4, 'wsdl-api-11632', './poc/api/wsdl-api-11632.yaml');
INSERT INTO `poc` VALUES (1078, 4, 'wsdl-api-11632_1', './poc/api/wsdl-api-11632_1.yaml');
INSERT INTO `poc` VALUES (1079, 4, 'wsdl-api-11634', './poc/api/wsdl-api-11634.yaml');
INSERT INTO `poc` VALUES (1080, 4, 'wsdl-api-11634_1', './poc/api/wsdl-api-11634_1.yaml');
INSERT INTO `poc` VALUES (1081, 4, 'wsdl-api', './poc/api/wsdl-api.yaml');
INSERT INTO `poc` VALUES (1082, 4, 'wso2-apimanager-detect-11638', './poc/api/wso2-apimanager-detect-11638.yaml');
INSERT INTO `poc` VALUES (1083, 4, 'wso2-apimanager-detect-11639', './poc/api/wso2-apimanager-detect-11639.yaml');
INSERT INTO `poc` VALUES (1084, 4, 'wso2-apimanager-detect', './poc/api/wso2-apimanager-detect.yaml');
INSERT INTO `poc` VALUES (1085, 4, 'yapi-detect-11719', './poc/api/yapi-detect-11719.yaml');
INSERT INTO `poc` VALUES (1086, 4, 'yapi-detect-11720', './poc/api/yapi-detect-11720.yaml');
INSERT INTO `poc` VALUES (1087, 4, 'yapi-detect-11721', './poc/api/yapi-detect-11721.yaml');
INSERT INTO `poc` VALUES (1088, 4, 'yapi-detect', './poc/api/yapi-detect.yaml');
INSERT INTO `poc` VALUES (1089, 4, 'yapi-detect_1', './poc/api/yapi-detect_1.yaml');
INSERT INTO `poc` VALUES (1090, 4, 'yapi-rce-11724', './poc/api/yapi-rce-11724.yaml');
INSERT INTO `poc` VALUES (1091, 4, 'yapi-rce-11724_1', './poc/api/yapi-rce-11724_1.yaml');
INSERT INTO `poc` VALUES (1092, 4, 'yapi-rce-11725', './poc/api/yapi-rce-11725.yaml');
INSERT INTO `poc` VALUES (1093, 4, 'yapi-rce-11725_1', './poc/api/yapi-rce-11725_1.yaml');
INSERT INTO `poc` VALUES (1094, 4, 'yapi-rce-11726', './poc/api/yapi-rce-11726.yaml');
INSERT INTO `poc` VALUES (1095, 4, 'yapi-rce-11726_1', './poc/api/yapi-rce-11726_1.yaml');
INSERT INTO `poc` VALUES (1096, 4, 'yapi-rce', './poc/api/yapi-rce.yaml');
INSERT INTO `poc` VALUES (1097, 4, 'yapi-rce_1', './poc/api/yapi-rce_1.yaml');
INSERT INTO `poc` VALUES (1098, 4, 'yapi', './poc/api/yapi.yaml');
INSERT INTO `poc` VALUES (1099, 4, 'yonyou-u8-cloud-api-hr-sqli', './poc/api/yonyou-u8-cloud-api-hr-sqli.yaml');
INSERT INTO `poc` VALUES (1100, 4, 'zap-api-detect', './poc/api/zap-api-detect.yaml');
INSERT INTO `poc` VALUES (1101, 4, 'zapier-b708d5b2893011553bfc18bd8506c540', './poc/api/zapier-b708d5b2893011553bfc18bd8506c540.yaml');

-- ----------------------------
-- Table structure for poc_class
-- ----------------------------
DROP TABLE IF EXISTS `poc_class`;
CREATE TABLE `poc_class`  (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of poc_class
-- ----------------------------
INSERT INTO `poc_class` VALUES (1, 'adobe', 'web');
INSERT INTO `poc_class` VALUES (2, 'airflow', 'web');
INSERT INTO `poc_class` VALUES (3, 'apache', 'web');
INSERT INTO `poc_class` VALUES (4, 'api', 'web');

-- ----------------------------
-- Table structure for program
-- ----------------------------
DROP TABLE IF EXISTS `program`;
CREATE TABLE `program`  (
  `program_id` int NOT NULL,
  `program_class_id` int NULL DEFAULT NULL,
  `program_function` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `program_ds` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`program_id`) USING BTREE,
  INDEX `program_class_id`(`program_class_id` ASC) USING BTREE,
  CONSTRAINT `program_class_id` FOREIGN KEY (`program_class_id`) REFERENCES `program_class` (`class_id`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of program
-- ----------------------------
INSERT INTO `program` VALUES (1, 1, 'java\\\\.nio\\\\.file\\\\.FileStore\\\\.getUsableSpace', '返回此 Java 虚拟机在文件存储中可用的字节数，如果未正确保护，可能泄露有关文件系统的敏感信息。');
INSERT INTO `program` VALUES (2, 1, 'java\\\\.nio\\\\.file\\\\.FileStore\\\\.getUnallocatedSpace', '返回此 Java 虚拟机在文件存储中未使用的字节数，如果未正确保护，可能泄露有关文件系统的敏感信息。');
INSERT INTO `program` VALUES (3, 1, 'java\\\\.nio\\\\.file\\\\.FileStore\\\\.supportsFileAttributeView', '告知此文件存储是否支持给定文件属性视图识别的文件属性，如果未正确保护，可能泄露有关文件系统的敏感信息。');
INSERT INTO `program` VALUES (4, 1, 'java\\\\.nio\\\\.file\\\\.FileStore\\\\.isReadOnly', '告知此文件存储是否为只读，如果未正确保护，可能导致未经授权的文件修改。');
INSERT INTO `program` VALUES (5, 1, 'java\\\\.nio\\\\.file\\\\.FileStore\\\\.name', '返回此文件存储的名称，如果未正确保护，可能泄露有关文件系统的敏感信息。');
INSERT INTO `program` VALUES (6, 1, 'java\\\\.nio\\\\.file\\\\.FileStore\\\\.type', '返回此文件存储的类型，如果未正确保护，可能泄露有关文件系统的敏感信息。');
INSERT INTO `program` VALUES (7, 1, 'java\\\\.nio\\\\.file\\\\.FileStore\\\\.toString', '返回表示对象的字符串，如果未正确保护，可能泄露有关文件系统的敏感信息。');
INSERT INTO `program` VALUES (8, 2, 'eval', '允许执行字符串作为 PHP 代码，可能导致代码注入漏洞。');
INSERT INTO `program` VALUES (9, 2, 'system', '执行外部系统命令，可能导致命令注入漏洞。');
INSERT INTO `program` VALUES (10, 2, 'exec', '与system()类似，也是用于执行外部系统命令，存在命令注入漏洞。');
INSERT INTO `program` VALUES (11, 2, 'popen', '打开一个进程，并返回一个文件指针，可能导致命令注入漏洞。');
INSERT INTO `program` VALUES (12, 2, 'shell_exec', '执行外部系统命令，并返回输出，可能导致命令注入漏洞。');
INSERT INTO `program` VALUES (13, 1, 'Runtime\\\\.exec', '允许执行外部命令，可能导致命令注入漏洞。');
INSERT INTO `program` VALUES (14, 1, 'ProcessBuilder', '类似于 Runtime.exec，可执行外部命令。');
INSERT INTO `program` VALUES (15, 1, 'ObjectInputStream\\\\.readObject', '从不受信任的来源反序列化对象，可能导致反序列化漏洞。');
INSERT INTO `program` VALUES (16, 1, 'javax\\\\.xml\\\\.transform\\\\.Transformer', '允许 XSLT 转换，可能导致 XML 外部实体 (XXE) 攻击。');
INSERT INTO `program` VALUES (17, 1, 'java\\\\.sql\\\\.PreparedStatement', '通过预编译语句执行的 SQL 查询，如果未正确参数化，可能会受到 SQL 注入的影响。');
INSERT INTO `program` VALUES (18, 1, 'java\\\\.io\\\\.File\\\\.delete', '删除文件或目录，如果使用不当，可能导致任意文件删除。');
INSERT INTO `program` VALUES (19, 1, 'java\\\\.lang\\\\.Runtime\\\\.loadLibrary', '加载本地库，如果库不受信任，可能导致任意代码执行。');
INSERT INTO `program` VALUES (20, 1, 'java\\\\.lang\\\\.reflect\\\\.Method\\\\.invoke', '动态调用方法，如果未正确保护，可能导致基于反射的攻击。');
INSERT INTO `program` VALUES (21, 1, 'javax\\\\.script\\\\.ScriptEngineManager', '允许执行脚本，如果未正确验证，可能导致脚本注入。');
INSERT INTO `program` VALUES (22, 1, 'java\\\\.util\\\\.zip\\\\.ZipInputStream', '处理 ZIP 文件，如果未正确清理，可能导致目录遍历或任意文件写入。');
INSERT INTO `program` VALUES (23, 1, 'java\\\\.net\\\\.URL\\\\.openConnection', '打开到 URL 的连接，可能被用于 SSRF (Server-Side Request Forgery) 攻击。');
INSERT INTO `program` VALUES (24, 1, 'java\\\\.util\\\\.Scanner\\\\.next', '读取用户输入，如果未正确清理，可能导致各种注入攻击。');
INSERT INTO `program` VALUES (25, 1, 'java\\\\.util\\\\.Runtime\\\\.getRuntime', '检索当前运行时，可能被滥用以执行任意命令。');
INSERT INTO `program` VALUES (26, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.write', '向文件写入字节，如果未正确清理，可能导致任意文件写入。');
INSERT INTO `program` VALUES (27, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.delete', '删除文件或目录，如果使用不当，可能导致任意文件删除。');
INSERT INTO `program` VALUES (28, 1, 'java\\\\.awt\\\\.Robot', '允许控制鼠标和键盘，可能导致 UI 篡改或自动化攻击。');
INSERT INTO `program` VALUES (29, 1, 'java\\\\.lang\\\\.Runtime\\\\.exec', '执行系统命令，如果用户输入未经适当验证，容易受到命令注入攻击。');
INSERT INTO `program` VALUES (30, 1, 'javax\\\\.management\\\\.MBeanServer', '允许管理 MBean (托管 Bean)，如果未适当保护，可能导致未经授权的访问或控制。');
INSERT INTO `program` VALUES (31, 1, 'java\\\\.lang\\\\.ProcessBuilder', '类似于 Runtime.exec，可执行外部命令。');
INSERT INTO `program` VALUES (32, 1, 'java\\\\.lang\\\\.System\\\\.loadLibrary', '加载本地库，如果库不受信任，可能导致任意代码执行。');
INSERT INTO `program` VALUES (33, 1, 'java\\\\.rmi\\\\.Naming\\\\.lookup', '允许查找 RMI (远程方法调用) 对象，可能被用于未经授权的访问。');
INSERT INTO `program` VALUES (34, 1, 'javax\\\\.management\\\\.remote\\\\.JMXConnectorFactory', '创建 JMX 连接器，可能被用于未经授权访问 JMX (Java 管理扩展) 服务。');
INSERT INTO `program` VALUES (35, 1, 'java\\\\.net\\\\.Socket', '创建套接字连接，如果未适当保护，可能被用于基于网络的攻击。');
INSERT INTO `program` VALUES (36, 1, 'java\\\\.net\\\\.DatagramSocket', '创建 UDP 套接字，如果未适当保护，可能被用于基于网络的攻击。');
INSERT INTO `program` VALUES (37, 1, 'java\\\\.util\\\\.logging\\\\.LogManager', '管理日志配置，可能被滥用以记录敏感信息或禁用日志记录。');
INSERT INTO `program` VALUES (38, 1, 'java\\\\.io\\\\.FileInputStream', '从文件读取，如果未正确清理，可能导致任意文件读取。');
INSERT INTO `program` VALUES (39, 1, 'java\\\\.io\\\\.FileOutputStream', '写入文件，如果未正确清理，可能导致任意文件写入。');
INSERT INTO `program` VALUES (40, 1, 'java\\\\.util\\\\.logging\\\\.Logger\\\\.log', '记录消息，如果未适当保护，可能被滥用以记录敏感信息。');
INSERT INTO `program` VALUES (41, 1, 'java\\\\.util\\\\.zip\\\\.ZipOutputStream', '写入 ZIP 文件，如果未正确清理，可能导致 ZIP 文件提取漏洞。');
INSERT INTO `program` VALUES (42, 1, 'java\\\\.security\\\\.KeyStore', '管理加密密钥和证书，如果未适当保护，可能导致密钥管理漏洞。');
INSERT INTO `program` VALUES (43, 1, 'java\\\\.security\\\\.SecureRandom', '生成密码学安全的随机数，如果未正确初始化，可能导致可预测的随机数。');
INSERT INTO `program` VALUES (44, 1, 'java\\\\.text\\\\.SimpleDateFormat', '格式化日期，如果未正确使用，可能导致日期解析漏洞，例如 SQL 注入或 XSS。');
INSERT INTO `program` VALUES (45, 1, 'java\\\\.sql\\\\.Connection', '管理数据库连接，如果未适当保护，可能导致 SQL 注入或其他数据库漏洞。');
INSERT INTO `program` VALUES (46, 1, 'java\\\\.sql\\\\.Statement', '执行 SQL 查询，如果未正确参数化，可能导致 SQL 注入漏洞。');
INSERT INTO `program` VALUES (47, 1, 'java\\\\.sql\\\\.ResultSet', '表示数据库查询的结果集，如果未正确清理，可能导致数据泄漏或篡改。');
INSERT INTO `program` VALUES (48, 1, 'java\\\\.sql\\\\.DatabaseMetaData', '检索有关数据库的元数据，如果未适当保护，可能泄漏有关数据库结构的敏感信息。');
INSERT INTO `program` VALUES (49, 1, 'java\\\\.sql\\\\.DatabaseMetaData\\\\.getTables', '检索数据库中表的信息，如果未适当保护，可能泄漏敏感信息。');
INSERT INTO `program` VALUES (50, 1, 'java\\\\.sql\\\\.DatabaseMetaData\\\\.getColumns', '检索表中列的信息，如果未适当保护，可能泄漏敏感信息。');
INSERT INTO `program` VALUES (51, 1, 'java\\\\.util\\\\.zip\\\\.ZipFile', '读取 ZIP 文件，如果未正确清理，可能导致 ZIP 文件提取漏洞。');
INSERT INTO `program` VALUES (52, 1, 'java\\\\.nio\\\\.file\\\\.Paths\\\\.get', '检索 Path 对象，如果未正确清理，可能导致目录遍历漏洞。');
INSERT INTO `program` VALUES (53, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.createDirectory', '创建目录，如果未正确清理，可能导致目录遍历漏洞。');
INSERT INTO `program` VALUES (54, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.createFile', '创建文件，如果未正确清理，可能导致任意文件创建漏洞。');
INSERT INTO `program` VALUES (55, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.deleteIfExists', '如果存在则删除文件，如果未适当保护，可能导致任意文件删除漏洞。');
INSERT INTO `program` VALUES (56, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.createLink', '创建硬链接，如果未适当保护，可能导致目录遍历或符号链接漏洞。');
INSERT INTO `program` VALUES (57, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.createSymbolicLink', '创建符号链接，如果未适当保护，可能导致符号链接漏洞。');
INSERT INTO `program` VALUES (58, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.move', '移动或重命名文件或目录，如果未适当保护，可能导致目录遍历或任意文件操作。');
INSERT INTO `program` VALUES (59, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.walkFileTree', '遍历文件树，如果未正确保护，可能导致意外的文件访问或操作。');
INSERT INTO `program` VALUES (60, 1, 'java\\\\.nio\\\\.file\\\\.FileVisitor', '文件树遍历的访问者接口，如果未正确实现，可能导致意外的文件访问或操作。');
INSERT INTO `program` VALUES (61, 1, 'java\\\\.nio\\\\.file\\\\.FileVisitor\\\\.visitFile', '在文件树遍历期间访问文件，如果未正确实现，可能导致意外的文件访问或操作。');
INSERT INTO `program` VALUES (62, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.walk', '返回一个 Stream，通过遍历文件树懒加载 Path，如果未正确保护，可能导致意外的文件访问或操作。');
INSERT INTO `program` VALUES (63, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.list', '列出目录中的条目，如果未正确保护，可能导致信息泄露或意外的文件访问。');
INSERT INTO `program` VALUES (64, 1, 'java\\\\.nio\\\\.file\\\\.Files\\\\.find', '在目录层次结构中查找文件，如果未正确保护，可能导致意外的文件访问或遍历。');
INSERT INTO `program` VALUES (65, 1, 'java\\\\.nio\\\\.file\\\\.FileSystem', '表示文件系统，如果未正确保护，可能导致未经授权的访问或操纵文件系统。');
INSERT INTO `program` VALUES (66, 1, 'java\\\\.nio\\\\.file\\\\.FileSystem\\\\.getPath', '通过转换路径字符串或 URI 返回 Path，如果未正确清理，可能导致目录遍历漏洞。');
INSERT INTO `program` VALUES (67, 1, 'java\\\\.nio\\\\.file\\\\.FileSystems', '提供对默认文件系统和其他文件系统的访问，如果未正确保护，可能导致未经授权的访问或操纵。');
INSERT INTO `program` VALUES (68, 1, 'java\\\\.nio\\\\.file\\\\.FileSystems\\\\.getDefault', '返回默认文件系统，如果未正确保护，可能导致未经授权的访问或操纵。');
INSERT INTO `program` VALUES (69, 1, 'java\\\\.nio\\\\.file\\\\.FileSystems\\\\.getFileSystem', '返回 URI 方案的文件系统，如果未正确保护，可能导致未经授权的访问或操纵。');
INSERT INTO `program` VALUES (70, 1, 'java\\\\.nio\\\\.file\\\\.FileStore', '表示存储池、设备、分区、卷、具体文件系统或其他实现特定的文件存储方式，如果未正确保护，可能导致未经授权的访问或操纵。');
INSERT INTO `program` VALUES (71, 1, 'java\\\\.nio\\\\.file\\\\.FileStore\\\\.getAttribute', '返回文件存储属性，如果未正确保护，可能泄露有关文件系统的敏感信息。');
INSERT INTO `program` VALUES (72, 1, 'java\\\\.nio\\\\.file\\\\.FileStore\\\\.getTotalSpace', '返回文件存储中的总字节数，如果未正确保护，可能泄露有关文件系统的敏感信息。');
INSERT INTO `program` VALUES (73, 2, 'passthru', '执行外部系统命令并直接将输出打印到标准输出，可能导致命令注入漏洞。');
INSERT INTO `program` VALUES (74, 2, 'include', '包含并执行指定文件，可能导致文件包含漏洞。');
INSERT INTO `program` VALUES (75, 2, 'require', '与include()类似，也可能导致文件包含漏洞。');
INSERT INTO `program` VALUES (76, 2, 'serialize', 'serialize()函数将 PHP 变量转换为字符串表示形式，而unserialize()函数则将其反序列化回 PHP 值。恶意用户可能构造恶意序列化数据，导致对象注入、代码执行等漏洞。');
INSERT INTO `program` VALUES (77, 2, 'unserialize', 'serialize()函数将 PHP 变量转换为字符串表示形式，而unserialize()函数则将其反序列化回 PHP 值。恶意用户可能构造恶意序列化数据，导致对象注入、代码执行等漏洞。');
INSERT INTO `program` VALUES (78, 2, 'extract', '将数组中的键名作为变量名，对应的键值作为变量值导入到符号表中，可能导致变量覆盖或执行未授权的操作。');
INSERT INTO `program` VALUES (79, 2, 'parse_str', '解析查询字符串为变量，并将其存储在符号表中，可能导致变量覆盖或执行未授权的操作。');
INSERT INTO `program` VALUES (80, 2, 'file_get_contents', '用于读取文件内容，如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞。');
INSERT INTO `program` VALUES (81, 2, 'file', '用于读取文件内容，如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞。');
INSERT INTO `program` VALUES (82, 2, 'assert', '用于执行字符串作为 PHP 代码。如果字符串是由用户提供的数据构成，可能导致代码注入漏洞。');
INSERT INTO `program` VALUES (83, 2, 'proc_open', '打开进程，并返回一个进程标识符。与 popen() 函数类似，可能导致命令注入漏洞。');
INSERT INTO `program` VALUES (84, 2, 'pcntl_exec', '用于执行外部程序。如果执行的程序路径是由用户提供的数据构成，可能导致命令注入漏洞。');
INSERT INTO `program` VALUES (85, 2, 'pcntl_alarm', '设置在给定秒数后发送一个 SIGALRM 信号。如果信号处理程序不正确实现，可能导致拒绝服务（DoS）漏洞。');
INSERT INTO `program` VALUES (86, 2, 'move_uploaded_file', '用于将上传的文件移动到新位置。如果目标路径是由用户提供的数据构成，可能导致路径遍历漏洞或将恶意文件放置到服务器上。');
INSERT INTO `program` VALUES (87, 2, 'chmod', '用于更改文件的权限。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞或意外更改重要文件的权限。');
INSERT INTO `program` VALUES (88, 2, 'chown', '用于更改文件的所有者和组。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞或意外更改文件的所有者和组。');
INSERT INTO `program` VALUES (89, 2, 'chgrp', '用于更改文件的所有者和组。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞或意外更改文件的所有者和组。');
INSERT INTO `program` VALUES (90, 2, 'fwrite', '用于将数据写入文件。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞或写入恶意数据到文件中。');
INSERT INTO `program` VALUES (91, 2, 'fputs', '用于将数据写入文件。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞或写入恶意数据到文件中。');
INSERT INTO `program` VALUES (92, 2, 'header', '用于发送 HTTP 头。如果未正确验证用户提供的数据，可能导致 HTTP 头注入漏洞，进而导致跨站脚本（XSS）攻击或其他安全问题。');
INSERT INTO `program` VALUES (93, 2, 'session_start', '用于启动会话。如果会话 ID 是由用户提供的数据构成，可能导致会话固定攻击（Session Fixation）漏洞。');
INSERT INTO `program` VALUES (94, 2, 'include_once', '与 include() 和 require() 类似，但只包含文件一次。如果文件路径是由用户提供的数据构成，可能导致文件包含漏洞。');
INSERT INTO `program` VALUES (95, 2, 'require_once', '与 include() 和 require() 类似，但只包含文件一次。如果文件路径是由用户提供的数据构成，可能导致文件包含漏洞。');
INSERT INTO `program` VALUES (96, 2, 'rename', '用于重命名文件或目录。如果目标路径是由用户提供的数据构成，可能导致路径遍历漏洞或意外重命名重要文件或目录。');
INSERT INTO `program` VALUES (97, 2, 'mkdir', '用于创建目录。如果目录名称是由用户提供的数据构成，可能导致路径遍历漏洞或创建恶意目录。');
INSERT INTO `program` VALUES (98, 2, 'rmdir', '用于删除目录。如果目录路径是由用户提供的数据构成，可能导致路径遍历漏洞或意外删除重要目录。');
INSERT INTO `program` VALUES (99, 2, 'copy', '用于复制文件。如果源文件路径或目标路径是由用户提供的数据构成，可能导致路径遍历漏洞或意外复制文件到重要目录。');
INSERT INTO `program` VALUES (100, 2, 'file_put_contents', '用于将数据写入文件。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞或写入恶意数据到文件中。');
INSERT INTO `program` VALUES (101, 2, 'fopen', '用于打开文件或 URL。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞或意外打开恶意文件。');
INSERT INTO `program` VALUES (102, 2, 'fread', '用于从文件中读取数据。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞或读取敏感数据。');
INSERT INTO `program` VALUES (103, 2, 'fgets', '用于从文件中读取数据。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞或读取敏感数据。');
INSERT INTO `program` VALUES (104, 2, 'fgetc', '用于从文件中读取数据。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞或读取敏感数据。');
INSERT INTO `program` VALUES (105, 3, 'pickle\\\\.load', '反序列化pickle数据，可能导致远程代码执行漏洞。');
INSERT INTO `program` VALUES (106, 3, 'os\\\\.popen', '执行系统命令，可能导致命令注入漏洞。');
INSERT INTO `program` VALUES (107, 3, 'subprocess\\\\.run', '执行外部命令，可能导致命令注入漏洞。');
INSERT INTO `program` VALUES (108, 3, 'subprocess\\\\.Popen', '与 subprocess.run 类似，也可执行外部命令。');
INSERT INTO `program` VALUES (109, 3, 'xml\\\\.etree\\\\.parse', '解析XML数据，可能导致XML外部实体(XXE)攻击。');
INSERT INTO `program` VALUES (110, 3, 'xml\\\\.dom\\\\.minidom\\\\.parse', '解析XML数据，可能导致XML外部实体(XXE)攻击。');
INSERT INTO `program` VALUES (111, 3, 'xml\\\\.sax\\\\.make_parser', '解析XML数据，可能导致XML外部实体(XXE)攻击。');
INSERT INTO `program` VALUES (112, 4, 'os/exec\\\\.Command', '用于执行外部命令。如果未正确过滤用户输入，可能导致命令注入漏洞。');
INSERT INTO `program` VALUES (113, 4, 'os/exec\\\\.LookPath', '用于在 PATH 中搜索可执行文件。如果路径是由用户提供的数据构成，可能导致路径遍历漏洞。');
INSERT INTO `program` VALUES (114, 4, 'os/exec\\\\.Start', '用于启动命令。如果命令是由用户提供的数据构成，可能导致命令注入漏洞。');
INSERT INTO `program` VALUES (115, 4, 'html/template\\\\.ParseFiles', '用于解析模板文件。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞。');
INSERT INTO `program` VALUES (116, 4, 'html/template\\\\.ParseGlob', '类似于 ParseFiles，用于解析模板文件。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞。');
INSERT INTO `program` VALUES (117, 4, 'net/http\\\\.ServeFile', '用于提供文件服务。如果文件路径是由用户提供的数据构成，可能导致路径遍历漏洞。');
INSERT INTO `program` VALUES (118, 4, 'net/http\\\\.Get', '用于执行 HTTP GET 请求。如果 URL 是由用户提供的数据构成，可能导致请求劫持、跨站脚本（XSS）等安全问题。');
INSERT INTO `program` VALUES (119, 4, 'encoding/xml\\\\.Unmarshal', '用于将 XML 数据解析为 Go 结构体。如果 XML 数据是由不受信任的来源提供的，可能导致 XML 外部实体 (XXE) 攻击。');
INSERT INTO `program` VALUES (120, 4, 'database/sql\\\\.Query', '用于执行 SQL 查询。如果 SQL 查询是由用户提供的数据构成，可能导致 SQL 注入漏洞。');
INSERT INTO `program` VALUES (121, 4, 'database/sql\\\\.Exec', '用于执行 SQL 命令。如果 SQL 命令是由用户提供的数据构成，可能导致 SQL 注入漏洞。');
INSERT INTO `program` VALUES (122, 4, 'syscall\\\\.Syscall', '用于调用操作系统底层函数。如果未正确处理系统调用参数，可能导致操作系统层面的安全问题。');
INSERT INTO `program` VALUES (123, 4, 'crypto\\\\.Decrypter', '用于解密数据。如果密钥是由用户提供的数据构成，可能导致信息泄露或数据篡改漏洞。');
INSERT INTO `program` VALUES (124, 4, 'path/filepath\\\\.Join', '用于拼接文件路径。如果路径是由用户提供的数据构成，可能导致路径遍历漏洞。');

-- ----------------------------
-- Table structure for program_class
-- ----------------------------
DROP TABLE IF EXISTS `program_class`;
CREATE TABLE `program_class`  (
  `class_id` int NULL DEFAULT NULL,
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  INDEX `class_id`(`class_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of program_class
-- ----------------------------
INSERT INTO `program_class` VALUES (1, 'java');
INSERT INTO `program_class` VALUES (2, 'php');
INSERT INTO `program_class` VALUES (3, 'python');
INSERT INTO `program_class` VALUES (4, 'go');

-- ----------------------------
-- Table structure for tool
-- ----------------------------
DROP TABLE IF EXISTS `tool`;
CREATE TABLE `tool`  (
  `tool_id` int NOT NULL,
  `class_id` int NULL DEFAULT NULL,
  `tool_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tool_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tool_sample` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tool_cmd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `tool_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`tool_id`) USING BTREE,
  INDEX `class`(`class_id` ASC) USING BTREE,
  CONSTRAINT `class` FOREIGN KEY (`class_id`) REFERENCES `tool_class` (`class_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tool
-- ----------------------------
INSERT INTO `tool` VALUES (1, 1, 'sqlmap', 'E:\\shentou\\sqlmap-1.8\\sqlmap.py', 'sqlmap.py -h', 'python', 'sqlmap 是一款开源的自动化 SQL 注入工具，用于检测和利用数据库中的 SQL 注入漏洞。它支持多种数据库系统（如 MySQL、Oracle、PostgreSQL 等），能够自动识别漏洞并执行攻击，获取敏感数据或完全控制目标系统。');
INSERT INTO `tool` VALUES (2, 2, 'nc', 'E:\\shentou\\netcat-win32-1.12\\nc64.exe', 'nc -h', 'exec', 'nc（Netcat）是一款功能强大的网络工具，常被称为 “网络瑞士军刀”。它可以直接操作 TCP 或 UDP 协议，用于创建网络连接、传输数据、端口扫描等多种网络任务。');
INSERT INTO `tool` VALUES (3, 3, 'nuclei', 'D:\\nuclei_3.3.5_windows_amd64\\nuclei.exe', 'nuclei -h', 'exec', 'nuclei 是一款由 ProjectDiscovery 开发的开源漏洞扫描工具，用于快速识别目标系统中的安全漏洞、配置错误、敏感信息泄露等问题。它通过模板驱动的方式工作，支持多种协议（HTTP、DNS、TCP 等），适用于大规模资产扫描和漏洞检测。');
INSERT INTO `tool` VALUES (4, 4, 'P1finger', 'E:\\python\\bishe\\tools\\P1finger64.exe', 'P1finger64.exe -h', 'exec', 'P1finger 是一款红队行动下的重点资产指纹识别工具。');
INSERT INTO `tool` VALUES (5, 4, 'opensca', 'E:\\python\\bishe\\tools\\opensca\\opensca-cli.exe', 'opensca-cli.exe -h', 'exec', 'OpenSCA 是一款开源的软件成分分析（SCA）工具，用于识别项目中的开源组件及其依赖关系，帮助团队管理安全风险、合规性和版本更新。');
INSERT INTO `tool` VALUES (6, 5, 'URLFinder', 'E:\\python\\bishe\\tools\\URLFinder\\URLFinder.exe', 'URLFinder.exe -h', 'exec', 'URLFinder 是一款用于收集和提取 URL 的工具，主要用于在渗透测试、信息收集或安全审计中发现目标系统中隐藏或未公开的 URL 路径。');
INSERT INTO `tool` VALUES (7, 5, 'JSFinderPlus', 'E:\\python\\bishe\\tools\\JSFinderPlus-main\\JSFinderPlus.py', 'JSFinderPlus.py -h', 'python', 'JSFinderPlus 是一款基于 Python 的 JavaScript 文件分析工具，主要用于在渗透测试和漏洞挖掘中从 JavaScript 代码里提取敏感信息、URL、API 密钥等内容。');
INSERT INTO `tool` VALUES (8, 6, 'cdncheck', 'E:\\python\\bishe\\tools\\cdncheck_1.1.8_windows_386\\', 'cdncheck.exe -h', 'exec', 'cdncheck 是一款用于检测目标网站是否使用 CDN（内容分发网络），并分析其 CDN 配置信息的工具。主要功能包括识别 CDN 提供商、检测 CDN 节点分布、分析 CDN 配置安全性等。');
INSERT INTO `tool` VALUES (9, 7, 'fscan', 'E:\\shentou\\fscanDC-main\\fscan.exe', 'fscan.exe -h', 'exec', 'Fscan 是一款功能强大且开源的网络扫描工具，主要用在网络安全领域，具备漏洞检测、资产发现等多种功能。它基于 Go 语言开发，凭借其出色的性能和丰富的功能，成为安全测试人员的得力助手。');
INSERT INTO `tool` VALUES (10, 7, 'wesng', 'E:\\python\\bishe\\tools\\wesng-master\\wes.py', 'wes.py -h', 'python', 'WES-NG（Windows Exploit Suggester - Next Generation）是一款用于评估 Windows 系统漏洞利用风险的工具，它基于 Microsoft 官方漏洞公告数据库，通过分析目标系统的补丁状态，推荐可能适用的漏洞利用程序。');
INSERT INTO `tool` VALUES (11, 8, 'python', 'D:\\Python\\Python310\\python.exe', 'python -h', 'exec', 'Python 是一种高级、通用、解释型的编程语言，由 Guido van Rossum 于 1991 年创建。因其简洁易读的语法和强大的功能，Python 已成为数据科学、人工智能、Web 开发、自动化脚本等领域的主流语言。');
INSERT INTO `tool` VALUES (12, 7, 'addcomputer', 'E:\\python\\bishe\\tools\\impacket-0.12.0\\examples\\addcomputer.py', 'addcomputer.py -h', 'python', '主要功能是通过SAMR 协议或LDAPS 协议在 Windows 域中管理计算机账户（添加、设置密码或删除）。');
INSERT INTO `tool` VALUES (13, 7, 'atexec', 'E:\\python\\bishe\\tools\\impacket-0.12.0\\examples\\atexec.py', 'atexec.py -h', 'python', '这段代码是基于 Python 的 Impacket 库开发的脚本，主要利用 Windows 任务计划程序服务（Task Scheduler，ATSVC）在目标系统上执行命令，并返回命令输出。');
INSERT INTO `tool` VALUES (14, 7, 'changepasswd', 'E:\\python\\bishe\\tools\\impacket-0.12.0\\examples\\changepasswd.py', 'changepasswd.py -h', 'python', '这段代码是基于 Python 的 Impacket 库开发的密码修改 / 重置工具，支持通过多种协议（如 SAMR、Kerberos、LDAP）修改或重置用户密码。');

-- ----------------------------
-- Table structure for tool_class
-- ----------------------------
DROP TABLE IF EXISTS `tool_class`;
CREATE TABLE `tool_class`  (
  `class_id` int NULL DEFAULT NULL,
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  INDEX `class_id`(`class_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tool_class
-- ----------------------------
INSERT INTO `tool_class` VALUES (1, '注入工具');
INSERT INTO `tool_class` VALUES (2, '远程连接');
INSERT INTO `tool_class` VALUES (3, '漏扫工具');
INSERT INTO `tool_class` VALUES (4, '指纹识别工具');
INSERT INTO `tool_class` VALUES (5, '敏感信息收集工具');
INSERT INTO `tool_class` VALUES (6, '信息收集工具');
INSERT INTO `tool_class` VALUES (7, '内网工具');
INSERT INTO `tool_class` VALUES (8, '编译工具');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int NOT NULL COMMENT 'id',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `user_password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (0, 'admin', '123456');

-- ----------------------------
-- Table structure for web_app
-- ----------------------------
DROP TABLE IF EXISTS `web_app`;
CREATE TABLE `web_app`  (
  `web_id` int NOT NULL,
  `class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`web_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of web_app
-- ----------------------------
INSERT INTO `web_app` VALUES (1, 'OA系统');
INSERT INTO `web_app` VALUES (2, 'CMS');
INSERT INTO `web_app` VALUES (3, 'ERP系统');
INSERT INTO `web_app` VALUES (4, 'NVR系统');
INSERT INTO `web_app` VALUES (5, '管理系统');
INSERT INTO `web_app` VALUES (6, '下一代防火墙');
INSERT INTO `web_app` VALUES (7, 'http服务器');
INSERT INTO `web_app` VALUES (8, 'web框架');
INSERT INTO `web_app` VALUES (9, 'RDM平台');
INSERT INTO `web_app` VALUES (10, 'DIY智能家居自动化平台');
INSERT INTO `web_app` VALUES (11, '业务系统');
INSERT INTO `web_app` VALUES (12, '智能视频监控与分析平台');
INSERT INTO `web_app` VALUES (13, '应用安全网关');
INSERT INTO `web_app` VALUES (14, '文件同步与共享类 Web 应用');
INSERT INTO `web_app` VALUES (15, '其他');
INSERT INTO `web_app` VALUES (16, 'Web 应用程序');

SET FOREIGN_KEY_CHECKS = 1;
