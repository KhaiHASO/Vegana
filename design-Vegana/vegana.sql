/*
 Navicat Premium Data Transfer

 Source Server         : khaihaso
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : vegana_store

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 04/05/2023 20:23:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `categoryId` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`categoryId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of categories
-- ----------------------------
BEGIN;
INSERT INTO `categories` (`categoryId`, `name`) VALUES (1, 'Snack'), (2, 'Cookies'), (3, 'Milk'), (4, 'Drinks'), (5, 'Candy'), (8, 'demo cate');
COMMIT;

-- ----------------------------
-- Table structure for customers
-- ----------------------------
DROP TABLE IF EXISTS `customers`;
CREATE TABLE `customers`  (
  `customerId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `enabled` bit(1) NULL DEFAULT NULL,
  `fullname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `photo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `roleId` int NULL DEFAULT NULL,
  PRIMARY KEY (`customerId`) USING BTREE,
  INDEX `roleID`(`roleId` ASC) USING BTREE,
  CONSTRAINT `roleID` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of customers
-- ----------------------------
BEGIN;
INSERT INTO `customers` (`customerId`, `email`, `enabled`, `fullname`, `password`, `photo`, `roleId`) VALUES ('admin', 'adminvegana@gmail.com', b'1', 'Tôi là admin', '$2a$10$1iPiIh9Mw/8jFkmrTzVhs.CrY8rBMn1hWHVSw2NPn92hRTK4kYwHu', '', 1), ('khai00', 'khaikhai331@gmail.com', b'1', 'Phan Hoàng Khải ', '$2a$10$oWaNI1BQGGorhbTU84/o6uTI4Qje.f0puyL6iJ1QUzTch0Zxzr9J.', '', 0);
COMMIT;

-- ----------------------------
-- Table structure for hibernate_sequence
-- ----------------------------
DROP TABLE IF EXISTS `hibernate_sequence`;
CREATE TABLE `hibernate_sequence`  (
  `next_val` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of hibernate_sequence
-- ----------------------------
BEGIN;
INSERT INTO `hibernate_sequence` (`next_val`) VALUES (1);
COMMIT;

-- ----------------------------
-- Table structure for orderdetails
-- ----------------------------
DROP TABLE IF EXISTS `orderdetails`;
CREATE TABLE `orderdetails`  (
  `orderDetailId` int NOT NULL AUTO_INCREMENT,
  `discount` double NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total_price` double NULL DEFAULT NULL,
  `orderId` int NULL DEFAULT NULL,
  `productId` int NULL DEFAULT NULL,
  PRIMARY KEY (`orderDetailId`) USING BTREE,
  INDEX `FK3ohml2o6a85wh1nn65snnaind`(`orderId` ASC) USING BTREE,
  INDEX `FK5pie1uapfd704usnm2loi3tex`(`productId` ASC) USING BTREE,
  CONSTRAINT `FK5pie1uapfd704usnm2loi3tex` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `orderDetailId` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of orderdetails
-- ----------------------------
BEGIN;
INSERT INTO `orderdetails` (`orderDetailId`, `discount`, `price`, `quantity`, `status`, `total_price`, `orderId`, `productId`) VALUES (42, NULL, 50, 1, 'Đã Thanh Toán', 45, 35, 3);
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `amount` double NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `orderDate` date NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `receiver` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `requireDate` date NULL DEFAULT NULL,
  `total_price` double NULL DEFAULT NULL,
  `customerId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `orderDetailId` int NULL DEFAULT NULL,
  PRIMARY KEY (`orderId`) USING BTREE,
  INDEX `FK1bpj2iini89gbon333nm7tvht`(`customerId` ASC) USING BTREE,
  INDEX `FK1gy3b3hqr3p2p1y5i8xuj6l5h`(`orderDetailId` ASC) USING BTREE,
  CONSTRAINT `oderDetail` FOREIGN KEY (`orderDetailId`) REFERENCES `orderdetails` (`orderDetailId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `customerID` FOREIGN KEY (`customerId`) REFERENCES `customers` (`customerId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` (`orderId`, `address`, `amount`, `description`, `orderDate`, `phone`, `receiver`, `requireDate`, `total_price`, `customerId`, `orderDetailId`) VALUES (35, '01 Vo Van Ngan Street', 0, 'Giao lẹ dùm', '2023-05-04', '0367151727', 'Khai Phan', NULL, 45, 'khai00', NULL);
COMMIT;

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `productId` int NOT NULL AUTO_INCREMENT,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `discount` double NULL DEFAULT NULL,
  `enteredDate` date NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  `categoryId` int NULL DEFAULT NULL,
  `supplierId` int NULL DEFAULT NULL,
  PRIMARY KEY (`productId`) USING BTREE,
  INDEX `FKej2ob3ifydf846t2a2tntna4e`(`categoryId` ASC) USING BTREE,
  INDEX `FKs2xbxi7wmu948op6qiho9yr8d`(`supplierId` ASC) USING BTREE,
  CONSTRAINT `FKej2ob3ifydf846t2a2tntna4e` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKs2xbxi7wmu948op6qiho9yr8d` FOREIGN KEY (`supplierId`) REFERENCES `suppliers` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of products
-- ----------------------------
BEGIN;
INSERT INTO `products` (`productId`, `description`, `discount`, `enteredDate`, `image`, `name`, `price`, `quantity`, `categoryId`, `supplierId`) VALUES (2, 'Snack bí đỏ vị bò nướng Oishi (45g/gói)', 10, '2021-09-02', 'snack-bi-do.jpg', 'Snack bí đỏ Oishi', 20, 30, 1, 3), (3, 'Snack bắp vị phô mai Oishi Tom Toms (45g/gói)', 10, '2021-09-02', 'snack-oishi-toms.jpg', 'Snack Oishi Tom Toms', 50, 30, 1, 3), (4, 'Snack bắp ngọt Oishi (45g/gói)', 5, '2021-09-02', 'snack-bap-ngot.jpg', 'Snack bắp ngọt Oishi', 40, 300, 1, 3), (5, 'Snack nhân sô cô la Oishi Pillows (100g) ', 10, '2021-09-01', 'snack-pillows.jpg', 'Snack Oishi Pillows', 60, 60, 1, 3), (6, 'Snack khoai tây vị muối Oishi Flutes (40g)', 5, '2021-09-02', 'snack-flutes.jpg', 'Snack Oishi Flutes', 40, 60, 1, 3), (7, 'Snack nhân sữa dừa Oishi Pillows (100g)', 10, '2021-09-01', 'snack-nhan-pillows.jpg', 'Snack sữa dừa Oishi Pillows', 80, 80, 1, 3), (8, 'Snack khoai tây poca (30) gr', 0, '2021-09-02', 'snack-poca.jpg', 'Snack khoai tây Poca', 50, 300, 1, 3), (9, 'Snack cua vị sốt chua ngọt Oishi Crab Me! (45g/gói)', 10, '2021-09-02', 'snack-crabme.jpg', 'Snack Oishi Crab Me', 60, 40, 1, 3), (10, 'Snack vị bò bít tết poca steack (40g)', 10, '2021-09-02', 'snack-poca-cay.jpg', 'Snack Poca Steack', 80, 60, 1, 3), (11, 'Snack bim bim thái (40g)', 5, '2021-09-02', 'snack-martys.jpg', 'Snack Thái Martys', 60, 40, 1, 3), (12, 'Yến mạch hạnh nhân Dan-D Pak (350g) ', 0, '2021-09-02', 'Yến-mạch-hạnh-nhân-Dan-D-Pak-350g.jpg', 'Dan-D Pak', 100, 50, 2, 4), (13, 'Bánh Quy Viên Sô Cô La Misura 290g', 5, '2021-09-03', 'banh-mizura.jpg', 'Sô Cô La Misura', 110, 30, 2, 4), (14, 'Bánh quy Cosy nhân mứt vị táo hộp 240g', 10, '2021-09-02', 'banh-tik.jpg', 'Cookies Tik ', 120, 10, 2, 4), (15, 'Bánh gạo nướng An vị cá Nhật thượng hạng Orion gói 117.6g', 0, '2021-09-02', 'banh-orion.jpg', 'Bánh Orion', 90, 60, 2, 4), (16, 'Bánh ăn sáng C’est Bon sợi thịt gà là lựa chọn hoàn hảo cho bữa ăn sáng hàng ngày của cả nhà', 5, '2021-09-02', 'banh-orion-bon.jpg', 'Bánh C’est Bon', 150, 50, 2, 4), (17, 'Bánh quy mini kem socola Oreo (23g)', 0, '2021-09-03', 'banh-mini-oreo.jpg', 'Bánh quy socola Oreo', 20, 10, 2, 4), (18, 'Bánh quy cacao nhân kem hạnh nhân YBC 18 cái (115.2g)', 10, '2021-09-07', 'banh-noir.jpg', 'Bánh quy cacao', 120, 30, 2, 3), (19, 'Bánh quy dinh dưỡng hạt Mắc ca kết hợp Nghệ - Hộp 12 bánh 45g', 5, '2021-09-04', 'banh-mac-ca.jpg', 'Bánh quy hạt Mắc ca', 200, 10, 2, 4), (20, 'Bánh quy Danisa được sản xuất từ công thức chính gốc của Đan Mạch, với nguyên liệu được lựa chọn kỹ càng, tinh túy nhất, sử dụng loại bơ thượng hạng giàu hương vị góp phần tạo nên sự khác biệt độc đáo so với các dòng bánh quy bơ khác.', 5, '2021-09-05', 'banh-danisa.jpg', 'Bánh Danisa', 300, 50, 2, 4), (21, 'Kẹo dẻo Jellyc Hải Hà kotobuki 100g', 0, '2021-09-03', 'chip-chip-panda.jpg', 'Chip Chip HAIHA', 40, 100, 5, 6), (22, 'Kẹo AnyTime Hàn Quốc 60 gram ( vị sữa và bạc hà) thanh mát.', 0, '2021-09-14', 'keo-anytime.jpg', 'Kẹo AnyTime', 50, 200, 5, 6), (23, 'Kẹo Cao Su Doublemint Vị Bạc Hà', 10, '2021-09-01', 'keo-doublemint.jpg', 'Kẹo Doublemint', 60, 100, 5, 6), (24, 'Hộp Hạt Hạnh Nhân Dinh Dưỡng Cho Mẹ REAL FOOD STORE (250g) ', 10, '2021-09-15', 'hat-hanh-nhan.jpg', 'Hạt Hạnh Nhân', 200, 200, 5, 6), (25, 'Hạt hạnh nhân nguyên chất Kirkland Almonds Mỹ 1.36kg', 10, '2021-09-10', 'hat-almonds.jpg', 'Hạt hạnh nhân Kirkland', 300, 100, 5, 6), (26, 'Túi Hạt Macca Dinh Dưỡng Cho Mẹ Real Food Store (500g)', 0, '2021-09-08', 'hat-nuts.jpg', 'Hạt Macca Dinh Dưỡng', 200, 100, 5, 6), (27, 'Nhân Hạt Óc Chó Sunrise (120gr) Hạt Dinh Dưỡng Đã Tách Vỏ Quả Óc Chó.Nhập Khẩu Mỹ', 10, '2021-09-10', 'hat-oc-cho.jpg', 'Nhân Hạt Óc Chó Sunrise', 400, 300, 5, 6), (28, 'Lốc 3 Hộp Sữa Hạt Hạnh Nhân Nguyên Chất 137 180ml', 0, '2021-09-03', 'sua-hanh-nhan.jpg', 'Sữa Hạt Hạnh Nhân ', 60, 100, 3, 2), (29, 'Nước ngọt Mirinda hương cam chai 1.5 lít', 10, '2021-09-10', 'nuoc-mirinda-cam.jpg', 'Mirinda vị cam', 100, 60, 4, 5), (30, 'Nước ngọt Mountain Dew 390 ml', 0, '2021-09-16', 'nuoc-mountain.jpg', 'Mountain Dew', 80, 300, 4, 5), (31, 'Trà ô long TEA 350ml', 5, '2021-09-11', 'tra-o-long.jpg', 'Trà TEA+', 45, 50, 4, 5), (32, 'Nước uống Isotonic vị chanh muối', 0, '2021-09-17', 'nuoc-revive.jpg', 'Nước Revive', 65, 200, 4, 5), (33, 'Nước uống đóng chai Aquafina (500ml)', 0, '2021-09-09', 'nuoc-aquafina.jpg', 'Aquafina', 20, 300, 4, 5), (34, 'Nước ngọt 7Up', 0, '2021-09-08', 'nuoc-7-up.jpg', '7Up', 35, 200, 4, 5), (35, 'Trà Lipton ICE Tea', 20, '2021-09-06', 'lipton-tea.jpg', 'Lipton Tea', 85, 300, 4, 5), (36, 'Nước giải khát Coca-Cola Plus (330ml)', 0, '2021-09-11', 'coca-cola-plus.jpg', 'Coca-Cola Plus', 100, 100, 4, 5), (37, 'Nước Giải Khát Coca-Cola vị Nguyên Bản Original 320mlx6 | Nước có gas', 5, '2021-09-19', 'coca-cola-original.jpg', ' Coca-Cola vị  Original', 120, 200, 4, 5), (38, 'Nước Giải Khát Coca-Cola | Nước có gas', 5, '2021-09-17', 'coca-cola.jpg', 'Coca-Cola', 125, 300, 4, 5), (39, 'Sữa Dielac Grow Plus 1+ Màu Xanh Tăng Cân, 1-2 tuổi, Vinamilk', 10, '2021-09-11', 'sua-dielac-grow-plus.jpg', 'Sữa Dielac Grow Plus', 500, 300, 3, 1), (40, 'SỮA BỘT GOLD YOKO 1 VINAMILK 850G DÀNH CHO BÉ TỪ 0 - 1 Tuổi | Sữa cho bé dưới 24 tháng', 10, '2021-09-09', 'sua-bot-yoko.jpg', 'SỮA BỘT GOLD YOKO', 700, 100, 3, 1), (41, 'HỘP SỮA BỘT VINAMILK DIELAC ALPHA GOLD IQ 1 (400G) (CHO TRẺ TỪ 0 - 6 THÁNG TUỔI) ', 5, '2021-09-12', 'sua-alpha.jpg', 'DIELAC ALPHA GOLD', 600, 300, 3, 1), (42, 'Sữa bột Vinamilk Dielac Optimum số 2 - hộp thiếc 900g (dành cho trẻ từ 6-12 tháng tuổi)', 15, '2021-09-11', 'sua-optimum.jpg', 'Dielac Optimum', 500, 100, 3, 1), (43, 'Sữa dielac grow plus 1+ 900g dành cho trẻ từ 1-2 tuổi', 10, '2021-09-08', 'sua-grow-plus.jpg', 'Sữa Dielac Grow Plus-Red', 650, 300, 3, 1), (44, 'Sữa tươi tiệt trùng Vinamilk 100% có đường 180ml (1 hộp)', 5, '2021-09-11', 'sua-tuoi-vinamilk.jpg', 'Sữa Tươi Vinamilk', 35, 200, 3, 1), (45, 'Sữa Nestle Milo nước (Lon 240ml)', 0, '2021-09-09', 'nestle-milo.jpg', ' Sữa Nestle Milo', 25, 200, 3, 2), (46, 'Sữa Lúa Mạch Nestlé MILO Lon Thùng 24 Lon x 240 ml (4x6x240ml) | Sữa Tươi', 0, '2021-09-11', 'milo-thung.jpg', 'Sữa Lúa Mạch Nestlé MILO', 300, 200, 3, 2), (47, 'THÙNG SỮA ĐẬU NÀNH VINAMILK HẠT ÓC CHÓ -48 HỘP 180ML | Sữa Tươi', 0, '2021-09-11', 'sua-oc-cho.jpg', 'Sữa Hạt Óc Chó', 45, 200, 3, 1), (48, 'Túi Nhân Hạt Óc Chó Dinh Dưỡng Cho Mẹ Real Food (200g) | Dinh dưỡng cho mẹ', 10, '2021-09-12', 'hat-occho.jpg', 'Túi Nhân Hạt Óc Chó', 250, 300, 1, 3), (49, 'Combo 3 hộp sữa hạt dẻ 1L 137 Degrees Thái Lan', 5, '2021-09-05', 'sua-pistachio.jpg', 'Sữa Hạt Dẻ', 45, 100, 3, 2), (54, 'mô tả', 5, '2021-09-09', 'den_mk052_1_0ddcbcb5ca3d4d3e8bb6ac99fcb7c23f_grande.jpg', 'test', 1000000, 20, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int NOT NULL,
  `roleName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `customerId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKcotftqap7by5m4ibph3ss3xvo`(`customerId` ASC) USING BTREE,
  CONSTRAINT `FKcotftqap7by5m4ibph3ss3xvo` FOREIGN KEY (`customerId`) REFERENCES `customers` (`customerId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` (`id`, `roleName`, `customerId`) VALUES (0, 'ROLE_CUSTOMER', NULL), (1, 'ROLE_ADMIN', NULL);
COMMIT;

-- ----------------------------
-- Table structure for suppliers
-- ----------------------------
DROP TABLE IF EXISTS `suppliers`;
CREATE TABLE `suppliers`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of suppliers
-- ----------------------------
BEGIN;
INSERT INTO `suppliers` (`id`, `email`, `name`, `phone`) VALUES (1, 'vinamilk@gmail.com', 'Vinamilk', '0915999999'), (2, 'nestle@gmail.com', 'Nestle', '0915999988'), (3, 'snack@gmail.com', 'Snack', '0915999966'), (4, 'cookies@gmail.com', 'Cookies', '0915999666'), (5, 'pepsicola@gmail.com', 'Pepsi Cola', '0915998888'), (6, 'bibica@gmail.com', 'Bibica', '0915998668');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;