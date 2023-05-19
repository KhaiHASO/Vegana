/*
 Navicat Premium Data Transfer

 Source Server         : metmoi
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : vegana_store

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 20/05/2023 01:03:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `cartId` int NOT NULL AUTO_INCREMENT,
  `customerId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `productId` int NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  `price` double NULL DEFAULT NULL,
  PRIMARY KEY (`cartId`) USING BTREE,
  INDEX `customerId_idx`(`customerId` ASC) USING BTREE,
  INDEX `productId_idx`(`productId` ASC) USING BTREE,
  CONSTRAINT `customerId_fk` FOREIGN KEY (`customerId`) REFERENCES `customers` (`customerId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `productId_fk` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of carts
-- ----------------------------
BEGIN;
INSERT INTO `carts` (`cartId`, `customerId`, `productId`, `quantity`, `price`) VALUES (122, 'khachhang00', NULL, NULL, NULL);
COMMIT;

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
  CONSTRAINT `roleID` FOREIGN KEY (`roleId`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of customers
-- ----------------------------
BEGIN;
INSERT INTO `customers` (`customerId`, `email`, `enabled`, `fullname`, `password`, `photo`, `roleId`) VALUES ('admin', 'adminvegana@gmail.com', b'1', 'Tôi là admin', '$2a$10$1iPiIh9Mw/8jFkmrTzVhs.CrY8rBMn1hWHVSw2NPn92hRTK4kYwHu', '', 1), ('khachhang00', 'vv@gg', b'1', 'Nguyễn Ngọc Nam', '$2a$10$f9sN7gLXdNaXYBs7nqroKeF0xf7B7DiMUBkIxJoVszQfb82nLrRWe', '', 0), ('khai00', 'khaikhai331@gmail.com', b'1', 'Phan Hoàng Khải ', '$2a$10$j.MEMT2MkdQTF8OJ59As2OTw4Nhaxg0cCBnscsxMpFwhHx1.72.6a', '', 0), ('khai11', 'khaixrkyz@gmail.com', b'1', 'phan hoang khai', '$2a$10$ITDgfCJRVqIMaXpxKL72rOZ/lLQg3.0jcMm3fypsxdIET2OKJGluK', '', 0), ('sonnika', 'sonnguyenhong382@gmail.com', b'1', 'nguyen hong son', '$2a$10$rFvjHR41HlhHgrk6zlrgX.x4fDJIRLi/9ufvb2AIFM4I23OqL7Xsa', '', 0);
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
  `price` double NULL DEFAULT NULL,
  `quantity` int NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total_price` double NULL DEFAULT NULL,
  `orderId` int NULL DEFAULT NULL,
  `productId` int NULL DEFAULT NULL,
  PRIMARY KEY (`orderDetailId`) USING BTREE,
  INDEX `FK3ohml2o6a85wh1nn65snnaind`(`orderId` ASC) USING BTREE,
  INDEX `FK5pie1uapfd704usnm2loi3tex`(`productId` ASC) USING BTREE,
  CONSTRAINT `FK5pie1uapfd704usnm2loi3tex` FOREIGN KEY (`productId`) REFERENCES `products` (`productId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orderDetailId` FOREIGN KEY (`orderId`) REFERENCES `orders` (`orderId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 63 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of orderdetails
-- ----------------------------
BEGIN;
INSERT INTO `orderdetails` (`orderDetailId`, `price`, `quantity`, `status`, `total_price`, `orderId`, `productId`) VALUES (56, 120, 1, 'Đang Chờ Xử Lý', 114, 42, 37), (57, 65, 1, 'Đang Chờ Xử Lý', 65, 43, 32), (58, 40, 1, 'Đang Chờ Xử Lý', 38, 43, 4), (59, 50, 1, 'Đang Chờ Xử Lý', 50, 43, 8), (60, 80, 1, 'Đang Chờ Xử Lý', 72, 43, 10), (61, 100, 1, 'Đang Chờ Xử Lý', 100, 43, 12), (62, 120, 1, 'Đang Chờ Xử Lý', 108, 43, 14), (71, 270, 1, 'Đang Chờ Xử Lý', 270, 46, 25), (72, 50, 2, 'Đang Chờ Xử Lý', 100, 46, 8), (73, 100, 1, 'Đang Chờ Xử Lý', 100, 46, 12), (74, 118.75, 4, 'Đang Chờ Xử Lý', 475, 46, 38), (75, 45, 29, 'Đã Thanh Toán', 1305, 47, 3);
COMMIT;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `orderId` int NOT NULL AUTO_INCREMENT,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `orderDate` date NULL DEFAULT NULL,
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `receiver` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `total_price` double NULL DEFAULT NULL,
  `customerId` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`orderId`) USING BTREE,
  INDEX `FK1bpj2iini89gbon333nm7tvht`(`customerId` ASC) USING BTREE,
  CONSTRAINT `customerID` FOREIGN KEY (`customerId`) REFERENCES `customers` (`customerId`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of orders
-- ----------------------------
BEGIN;
INSERT INTO `orders` (`orderId`, `address`, `description`, `orderDate`, `phone`, `receiver`, `total_price`, `customerId`) VALUES (42, '01 Vo Van Ngan Street', 'Giao lẹ dùm', '2023-05-11', '0367151727', 'Khai Phan', 114, 'khai00'), (43, '01 Vo Van Ngan Street', 'Giao lẹ dùm', '2023-05-11', '0367151727', 'Khai Phan', 433, 'khai00'), (46, '01 Vo Van Ngan Street', 'giao muộn là xuống địa ngục', '2023-05-20', '0367151727', 'Khai Phan', 945, 'khai00'), (47, '01 Vo Van Ngan Street', 'giao muộn là xuống địa ngục', '2023-05-20', '0367151727', 'Khai Phan', 1305, 'khai00');
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
  CONSTRAINT `FKej2ob3ifydf846t2a2tntna4e` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`categoryId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FKs2xbxi7wmu948op6qiho9yr8d` FOREIGN KEY (`supplierId`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 56 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of products
-- ----------------------------
BEGIN;
INSERT INTO `products` (`productId`, `description`, `discount`, `enteredDate`, `image`, `name`, `price`, `quantity`, `categoryId`, `supplierId`) VALUES (3, 'Snack bắp vị phô mai Oishi Tom Toms (45g/gói)', 10, '2021-09-02', 'snack-oishi-toms.jpg', 'Snack Oishi Tom Toms', 50, 100, 1, 3), (4, 'Snack bắp ngọt Oishi (45g/gói)', 5, '2021-09-02', 'snack-bap-ngot.jpg', 'Snack bắp ngọt Oishi', 40, 300, 1, 3), (5, 'Snack nhân sô cô la Oishi Pillows (100g) ', 10, '2021-09-01', 'snack-pillows.jpg', 'Snack Oishi Pillows', 60, 60, 1, 3), (6, 'Snack khoai tây vị muối Oishi Flutes (40g)', 5, '2021-09-02', 'snack-flutes.jpg', 'Snack Oishi Flutes', 40, 60, 1, 3), (7, 'Snack nhân sữa dừa Oishi Pillows (100g)', 10, '2021-09-01', 'snack-nhan-pillows.jpg', 'Snack sữa dừa Oishi Pillows', 80, 80, 1, 3), (8, 'Snack khoai tây poca (30) gr', 0, '2021-09-02', 'snack-poca.jpg', 'Snack khoai tây Poca', 50, 298, 1, 3), (9, 'Snack cua vị sốt chua ngọt Oishi Crab Me! (45g/gói)', 10, '2021-09-02', 'snack-crabme.jpg', 'Snack Oishi Crab Me', 60, 40, 1, 3), (10, 'Snack vị bò bít tết poca steack (40g)', 10, '2021-09-02', 'snack-poca-cay.jpg', 'Snack Poca Steack', 80, 60, 1, 3), (11, 'Snack bim bim thái (40g)', 5, '2021-09-02', 'snack-martys.jpg', 'Snack Thái Martys', 60, 40, 1, 3), (12, 'Yến mạch hạnh nhân Dan-D Pak (350g) ', 0, '2021-09-02', 'Yến-mạch-hạnh-nhân-Dan-D-Pak-350g.jpg', 'Dan-D Pak', 100, 49, 2, 4), (13, 'Bánh Quy Viên Sô Cô La Misura 290g', 5, '2021-09-03', 'banh-mizura.jpg', 'Sô Cô La Misura', 110, 30, 2, 4), (14, 'Bánh quy Cosy nhân mứt vị táo hộp 240g', 10, '2021-09-02', 'banh-tik.jpg', 'Cookies Tik ', 120, 10, 2, 4), (15, 'Bánh gạo nướng An vị cá Nhật thượng hạng Orion gói 117.6g', 0, '2021-09-02', 'banh-orion.jpg', 'Bánh Orion', 90, 60, 2, 4), (16, 'Bánh ăn sáng C’est Bon sợi thịt gà là lựa chọn hoàn hảo cho bữa ăn sáng hàng ngày của cả nhà', 5, '2021-09-02', 'banh-orion-bon.jpg', 'Bánh C’est Bon', 150, 50, 2, 4), (17, 'Bánh quy mini kem socola Oreo (23g)', 0, '2021-09-03', 'banh-mini-oreo.jpg', 'Bánh quy socola Oreo', 20, 10, 2, 4), (18, 'Bánh quy cacao nhân kem hạnh nhân YBC 18 cái (115.2g)', 10, '2021-09-07', 'banh-noir.jpg', 'Bánh quy cacao', 120, 30, 2, 3), (19, 'Bánh quy dinh dưỡng hạt Mắc ca kết hợp Nghệ - Hộp 12 bánh 45g', 5, '2021-09-04', 'banh-mac-ca.jpg', 'Bánh quy hạt Mắc ca', 200, 10, 2, 4), (20, 'Bánh quy Danisa được sản xuất từ công thức chính gốc của Đan Mạch, với nguyên liệu được lựa chọn kỹ càng, tinh túy nhất, sử dụng loại bơ thượng hạng giàu hương vị góp phần tạo nên sự khác biệt độc đáo so với các dòng bánh quy bơ khác.', 5, '2021-09-05', 'banh-danisa.jpg', 'Bánh Danisa', 300, 50, 2, 4), (21, 'Kẹo dẻo Jellyc Hải Hà kotobuki 100g', 0, '2021-09-03', 'chip-chip-panda.jpg', 'Chip Chip HAIHA', 40, 100, 5, 6), (22, 'Kẹo AnyTime Hàn Quốc 60 gram ( vị sữa và bạc hà) thanh mát.', 0, '2021-09-14', 'keo-anytime.jpg', 'Kẹo AnyTime', 50, 200, 5, 6), (23, 'Kẹo Cao Su Doublemint Vị Bạc Hà', 10, '2021-09-01', 'keo-doublemint.jpg', 'Kẹo Doublemint', 60, 100, 5, 6), (24, 'Hộp Hạt Hạnh Nhân Dinh Dưỡng Cho Mẹ REAL FOOD STORE (250g) ', 10, '2021-09-15', 'hat-hanh-nhan.jpg', 'Hạt Hạnh Nhân', 200, 200, 5, 6), (25, 'Hạt hạnh nhân nguyên chất Kirkland Almonds Mỹ 1.36kg', 10, '2021-09-10', 'hat-almonds.jpg', 'Hạt hạnh nhân Kirkland', 300, 99, 5, 6), (26, 'Túi Hạt Macca Dinh Dưỡng Cho Mẹ Real Food Store (500g)', 0, '2021-09-08', 'hat-nuts.jpg', 'Hạt Macca Dinh Dưỡng', 200, 100, 5, 6), (27, 'Nhân Hạt Óc Chó Sunrise (120gr) Hạt Dinh Dưỡng Đã Tách Vỏ Quả Óc Chó.Nhập Khẩu Mỹ', 10, '2021-09-10', 'hat-oc-cho.jpg', 'Nhân Hạt Óc Chó Sunrise', 400, 300, 5, 6), (28, 'Lốc 3 Hộp Sữa Hạt Hạnh Nhân Nguyên Chất 137 180ml', 0, '2021-09-03', 'sua-hanh-nhan.jpg', 'Sữa Hạt Hạnh Nhân ', 60, 100, 3, 2), (29, 'Nước ngọt Mirinda hương cam chai 1.5 lít', 10, '2021-09-10', 'nuoc-mirinda-cam.jpg', 'Mirinda vị cam', 100, 60, 4, 5), (30, 'Nước ngọt Mountain Dew 390 ml', 0, '2021-09-16', 'nuoc-mountain.jpg', 'Mountain Dew', 80, 300, 4, 5), (31, 'Trà ô long TEA 350ml', 5, '2021-09-11', 'tra-o-long.jpg', 'Trà TEA+', 45, 50, 4, 5), (32, 'Nước uống Isotonic vị chanh muối', 0, '2021-09-17', 'nuoc-revive.jpg', 'Nước Revive', 65, 200, 4, 5), (33, 'Nước uống đóng chai Aquafina (500ml)', 0, '2021-09-09', 'nuoc-aquafina.jpg', 'Aquafina', 20, 300, 4, 5), (34, 'Nước ngọt 7Up', 0, '2021-09-08', 'nuoc-7-up.jpg', '7Up', 35, 200, 4, 5), (35, 'Trà Lipton ICE Tea', 20, '2021-09-06', 'lipton-tea.jpg', 'Lipton Tea', 85, 300, 4, 5), (36, 'Nước giải khát Coca-Cola Plus (330ml)', 0, '2021-09-11', 'coca-cola-plus.jpg', 'Coca-Cola Plus', 100, 100, 4, 5), (37, 'Nước Giải Khát Coca-Cola vị Nguyên Bản Original 320mlx6 | Nước có gas', 5, '2021-09-19', 'coca-cola-original.jpg', ' Coca-Cola vị  Original', 120, 200, 4, 5), (38, 'Nước Giải Khát Coca-Cola | Nước có gas', 5, '2021-09-17', 'coca-cola.jpg', 'Coca-Cola', 125, 296, 4, 5), (39, 'Sữa Dielac Grow Plus 1+ Màu Xanh Tăng Cân, 1-2 tuổi, Vinamilk', 10, '2021-09-11', 'sua-dielac-grow-plus.jpg', 'Sữa Dielac Grow Plus', 500, 300, 3, 1), (40, 'SỮA BỘT GOLD YOKO 1 VINAMILK 850G DÀNH CHO BÉ TỪ 0 - 1 Tuổi | Sữa cho bé dưới 24 tháng', 10, '2021-09-09', 'sua-bot-yoko.jpg', 'SỮA BỘT GOLD YOKO', 700, 100, 3, 1), (41, 'HỘP SỮA BỘT VINAMILK DIELAC ALPHA GOLD IQ 1 (400G) (CHO TRẺ TỪ 0 - 6 THÁNG TUỔI) ', 5, '2021-09-12', 'sua-alpha.jpg', 'DIELAC ALPHA GOLD', 600, 300, 3, 1), (42, 'Sữa bột Vinamilk Dielac Optimum số 2 - hộp thiếc 900g (dành cho trẻ từ 6-12 tháng tuổi)', 15, '2021-09-11', 'sua-optimum.jpg', 'Dielac Optimum', 500, 100, 3, 1), (43, 'Sữa dielac grow plus 1+ 900g dành cho trẻ từ 1-2 tuổi', 10, '2021-09-08', 'sua-grow-plus.jpg', 'Sữa Dielac Grow Plus-Red', 650, 300, 3, 1), (44, 'Sữa tươi tiệt trùng Vinamilk 100% có đường 180ml (1 hộp)', 5, '2021-09-11', 'sua-tuoi-vinamilk.jpg', 'Sữa Tươi Vinamilk', 35, 200, 3, 1), (45, 'Sữa Nestle Milo nước (Lon 240ml)', 0, '2021-09-09', 'nestle-milo.jpg', ' Sữa Nestle Milo', 25, 200, 3, 2), (46, 'Sữa Lúa Mạch Nestlé MILO Lon Thùng 24 Lon x 240 ml (4x6x240ml) | Sữa Tươi', 0, '2021-09-11', 'milo-thung.jpg', 'Sữa Lúa Mạch Nestlé MILO', 300, 200, 3, 2), (47, 'THÙNG SỮA ĐẬU NÀNH VINAMILK HẠT ÓC CHÓ -48 HỘP 180ML | Sữa Tươi', 0, '2021-09-11', 'sua-oc-cho.jpg', 'Sữa Hạt Óc Chó', 45, 200, 3, 1), (48, 'Túi Nhân Hạt Óc Chó Dinh Dưỡng Cho Mẹ Real Food (200g) | Dinh dưỡng cho mẹ', 10, '2021-09-12', 'hat-occho.jpg', 'Túi Nhân Hạt Óc Chó', 250, 300, 1, 3), (49, 'Combo 3 hộp sữa hạt dẻ 1L 137 Degrees Thái Lan', 5, '2021-09-05', 'sua-pistachio.jpg', 'Sữa Hạt Dẻ', 45, 100, 3, 2), (54, 'mô tả', 5, '2021-09-09', 'den_mk052_1_0ddcbcb5ca3d4d3e8bb6ac99fcb7c23f_grande.jpg', 'test', 1000000, 20, 1, 1);
COMMIT;

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` int NOT NULL,
  `roleName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
BEGIN;
INSERT INTO `roles` (`id`, `roleName`) VALUES (0, 'ROLE_CUSTOMER'), (1, 'ROLE_ADMIN');
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

-- ----------------------------
-- View structure for bill_view
-- ----------------------------
DROP VIEW IF EXISTS `bill_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `bill_view` AS select `o`.`orderId` AS `orderId`,`o`.`customerId` AS `customerId`,`c`.`fullname` AS `fullname`,`o`.`phone` AS `phone`,`o`.`address` AS `address`,`o`.`orderDate` AS `orderDate`,group_concat(concat(`pr`.`name`,' (Giá: ',round((`pr`.`price` - ((`pr`.`price` * `pr`.`discount`) / 100)),3),', Số lượng: ',`od`.`quantity`,')') separator ', ') AS `product_list`,format(`o`.`total_price`,3) AS `total_price` from (((`orders` `o` join `customers` `c` on((`o`.`customerId` = `c`.`customerId`))) join `orderdetails` `od` on((`o`.`orderId` = `od`.`orderId`))) join `products` `pr` on((`od`.`productId` = `pr`.`productId`))) group by `o`.`orderId`,`o`.`customerId`,`c`.`fullname`,`o`.`phone`,`o`.`address`,`o`.`orderDate`,`o`.`total_price`;

-- ----------------------------
-- View structure for cart_product_view
-- ----------------------------
DROP VIEW IF EXISTS `cart_product_view`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `cart_product_view` AS select `c`.`cartId` AS `cartId`,`c`.`customerId` AS `customerId`,`p`.`name` AS `name`,`p`.`image` AS `image`,`c`.`productId` AS `productId`,`c`.`quantity` AS `quantity`,`p`.`discount` AS `discount`,(`p`.`price` - ((`p`.`price` * `p`.`discount`) / 100)) AS `price`,((`p`.`price` - ((`p`.`price` * `p`.`discount`) / 100)) * `c`.`quantity`) AS `totalPrice` from (`carts` `c` join `products` `p` on((`c`.`productId` = `p`.`productId`)));

-- ----------------------------
-- Procedure structure for UpdateOrInsertIntoCart
-- ----------------------------
DROP PROCEDURE IF EXISTS `UpdateOrInsertIntoCart`;
delimiter ;;
CREATE PROCEDURE `UpdateOrInsertIntoCart`(IN p_customerid VARCHAR(255), IN p_productid INT)
BEGIN
   DECLARE existing_quantity INT;
   DECLARE existing_price DECIMAL(10, 2);
   
   SELECT quantity, price INTO existing_quantity, existing_price
   FROM carts
   WHERE customerid = p_customerid AND productid = p_productid;

   IF existing_quantity IS NOT NULL THEN
      UPDATE carts
      SET quantity = existing_quantity + 1
      WHERE customerid = p_customerid AND productid = p_productid;
   ELSE
      INSERT INTO carts(customerid, productid, quantity, price)
      SELECT p_customerid, p_productid, 1, (p.price - (p.price * p.discount / 100)) * 1 -- Tính giá trị price từ số lượng, giá và khuyến mãi sản phẩm
      FROM products p
      WHERE p.productId = p_productid;
   END IF;
   
   IF existing_quantity IS NOT NULL THEN
      UPDATE carts
      SET price = (price / existing_quantity) * (existing_quantity + 1)
      WHERE customerid = p_customerid AND productid = p_productid;
   END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table carts
-- ----------------------------
DROP TRIGGER IF EXISTS `delete_cart_item`;
delimiter ;;
CREATE TRIGGER `delete_cart_item` AFTER UPDATE ON `carts` FOR EACH ROW BEGIN
  IF NEW.quantity = 0 THEN
    DELETE FROM carts WHERE cartId = NEW.cartId;
  END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table carts
-- ----------------------------
DROP TRIGGER IF EXISTS `check_product_quantity`;
delimiter ;;
CREATE TRIGGER `check_product_quantity` BEFORE UPDATE ON `carts` FOR EACH ROW BEGIN
  DECLARE product_quantity INT;

  SELECT quantity
  INTO product_quantity
  FROM products
  WHERE productId = NEW.productId;

  IF NEW.quantity > product_quantity THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Số lượng mặt hàng trong giỏ hàng không được vượt quá số lượng mặt hàng có trong bảng sản phẩm';
  END IF;

END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table customers
-- ----------------------------
DROP TRIGGER IF EXISTS `create_cart_for_new_customer`;
delimiter ;;
CREATE TRIGGER `create_cart_for_new_customer` AFTER INSERT ON `customers` FOR EACH ROW BEGIN
    INSERT INTO carts (customerId) VALUES (NEW.customerId);
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table orderdetails
-- ----------------------------
DROP TRIGGER IF EXISTS `decrease_quantity`;
delimiter ;;
CREATE TRIGGER `decrease_quantity` AFTER INSERT ON `orderdetails` FOR EACH ROW BEGIN
    -- Giảm số lượng sản phẩm khi có đơn hàng được tạo
    UPDATE products
    SET quantity = quantity - NEW.quantity
    WHERE productId = NEW.productId;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table orders
-- ----------------------------
DROP TRIGGER IF EXISTS `orders_before_insert`;
delimiter ;;
CREATE TRIGGER `orders_before_insert` BEFORE INSERT ON `orders` FOR EACH ROW BEGIN 
  IF NEW.orderDate IS NULL THEN 
    SET NEW.orderDate = NOW(); 
  END IF; 
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
