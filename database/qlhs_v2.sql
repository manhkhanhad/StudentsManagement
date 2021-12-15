-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Dec 05, 2021 at 01:52 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `student`
--

-- --------------------------------------------------------

--
-- Table structure for table `bangdiem`
--

DROP TABLE IF EXISTS `bangdiem`;
CREATE TABLE IF NOT EXISTS `bangdiem` (
  `MaBangDiem` int(11) NOT NULL AUTO_INCREMENT,
  `MaMon` varchar(3) NOT NULL,
  `MaLop` varchar(4) NOT NULL,
  `MaHK` varchar(3) NOT NULL,
  `SLDMon` int(11) NOT NULL DEFAULT '0',
  `TLDMon` decimal(5,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`MaBangDiem`),
  KEY `MaMon` (`MaMon`),
  KEY `MaLop` (`MaLop`),
  KEY `MaHK` (`MaHK`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bangdiem`
--

INSERT INTO `bangdiem` (`MaBangDiem`, `MaMon`, `MaLop`, `MaHK`, `SLDMon`, `TLDMon`) VALUES
(1, 'TOA', '10A1', 'HK1', 2, '1.00'),
(2, 'VLY', '10A2', 'HK1', 1, '0.50'),
(3, 'HOA', '11A1', 'HK2', 0, '0.00'),
(4, 'TOA', '10A2', 'HK1', 1, '0.50'),
(7, 'TOA', '10A1', 'HK1', 1, '0.50');

-- --------------------------------------------------------

--
-- Table structure for table `chitietbangdiem`
--

DROP TABLE IF EXISTS `chitietbangdiem`;
CREATE TABLE IF NOT EXISTS `chitietbangdiem` (
  `MaChiTietBangDiem` int(11) NOT NULL AUTO_INCREMENT,
  `MaBangDiem` int(11) NOT NULL,
  `MaHS` varchar(8) NOT NULL,
  `Diem15p` decimal(3,1) DEFAULT NULL,
  `Diem1Tiet` decimal(3,1) DEFAULT NULL,
  `DiemHK` decimal(3,1) DEFAULT NULL,
--  `DiemTB` decimal(3,1) GENERATED ALWAYS AS ((((`Diem15p` + (`Diem1Tiet` * 2)) + (`DiemHK` * 3)) / (((`Diem15p` is not null) + ((`Diem1Tiet` is not null) * 2)) + ((`DiemHK` is not null) * 3)))) STORED,
  KEY `MaBangDiem` (`MaBangDiem`),
  KEY `MaHS` (`MaHS`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `chitietbangdiem`
--

INSERT INTO `chitietbangdiem` (`MaChiTietBangDiem`, `MaBangDiem`, `MaHS`, `Diem15p`, `Diem1Tiet`, `DiemHK`) VALUES
(36, 7, '21240002', '9.0', '9.0', '10.0'),
(31, 3, '20230001', NULL, NULL, NULL),
(32, 3, '20230002', NULL, NULL, NULL),
(33, 4, '21240003', '9.0', '8.0', '6.5'),
(34, 4, '21240004', NULL, NULL, NULL),
(35, 7, '21240001', '1.0', '2.0', '3.0'),
(30, 2, '21240004', NULL, NULL, NULL),
(29, 2, '21240003', '8.0', '7.0', '10.0'),
(28, 1, '21240002', '9.0', '9.0', '10.0'),
(27, 1, '21240001', '7.0', '8.0', '9.0');

--
-- Triggers `chitietbangdiem`
--
DROP TRIGGER IF EXISTS `update_SLDMon_when_delete_chitietbangdiem`;
DELIMITER $$
-- CREATE TRIGGER `update_SLDMon_when_delete_chitietbangdiem` AFTER DELETE ON `chitietbangdiem` FOR EACH ROW BEGIN 
-- TRIGGER COLLISION
	DECLARE so_luong_dat INT;
    DECLARE so_hoc_sinh INT;
    SELECT COUNT(MaChiTietBangDiem) into @so_luong_dat FROM bangdiem INNER JOIN chitietbangdiem ON bangdiem.MaBangDiem = chitietbangdiem.MaBangDiem WHERE bangdiem.MaBangDiem = OLD.MaBangDiem and chitietbangdiem.DiemTB >= 5;
    SELECT COUNT(MaChiTietBangDiem) into @so_hoc_sinh FROM bangdiem INNER JOIN chitietbangdiem ON bangdiem.MaBangDiem = chitietbangdiem.MaBangDiem WHERE bangdiem.MaBangDiem = OLD.MaBangDiem;
   	UPDATE bangdiem SET bangdiem.SLDMon = @so_luong_dat, bangdiem.TLDMon = IF(@so_hoc_sinh >= 0,@so_luong_dat / @so_hoc_sinh,NULL) WHERE bangdiem.MaBangDiem = OLD.MaBangDiem;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `update_SLDMon_when_insert_chitietbangdiem`;
DELIMITER $$
CREATE TRIGGER `update_SLDMon_when_insert_chitietbangdiem` AFTER INSERT ON `chitietbangdiem` FOR EACH ROW BEGIN
	DECLARE so_luong_dat INT;
    DECLARE so_hoc_sinh DECIMAl(3,1);
    SELECT COUNT(MaChiTietBangDiem) into @so_luong_dat FROM bangdiem INNER JOIN chitietbangdiem ON bangdiem.MaBangDiem = chitietbangdiem.MaBangDiem WHERE bangdiem.MaBangDiem = NEW.MaBangDiem and chitietbangdiem.DiemTB >= 5;
    SELECT COUNT(MaChiTietBangDiem) into @so_hoc_sinh FROM bangdiem INNER JOIN chitietbangdiem ON bangdiem.MaBangDiem = chitietbangdiem.MaBangDiem WHERE bangdiem.MaBangDiem = NEW.MaBangDiem;
   	UPDATE bangdiem SET bangdiem.SLDMon = @so_luong_dat , bangdiem.TLDMon = (@so_luong_dat/@so_hoc_sinh) WHERE bangdiem.MaBangDiem = NEW.MaBangDiem;
    
    INSERT INTO `log`(`Log`) VALUES (@so_hoc_sinh);
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `update_SLDMon_when_update_chitietbangdiem`;
DELIMITER $$
CREATE TRIGGER `update_SLDMon_when_update_chitietbangdiem` AFTER UPDATE ON `chitietbangdiem` FOR EACH ROW BEGIN
	DECLARE so_luong_dat INT;
    DECLARE so_hoc_sinh INT;
    SELECT COUNT(MaChiTietBangDiem) into @so_luong_dat FROM bangdiem INNER JOIN chitietbangdiem ON bangdiem.MaBangDiem = chitietbangdiem.MaBangDiem WHERE bangdiem.MaBangDiem = NEW.MaBangDiem and chitietbangdiem.DiemTB >= 5;
    SELECT COUNT(MaChiTietBangDiem) into @so_hoc_sinh FROM bangdiem INNER JOIN chitietbangdiem ON bangdiem.MaBangDiem = chitietbangdiem.MaBangDiem WHERE bangdiem.MaBangDiem = NEW.MaBangDiem;
   	UPDATE bangdiem SET bangdiem.SLDMon = @so_luong_dat, bangdiem.TLDMon = @so_luong_dat / @so_hoc_sinh WHERE bangdiem.MaBangDiem = NEW.MaBangDiem;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `update_TBHK_when_delete_chitietbangdiem`;
DELIMITER $$
-- CREATE TRIGGER `update_TBHK_when_delete_chitietbangdiem` AFTER DELETE ON `chitietbangdiem` FOR EACH ROW BEGIN 
-- TRIGGER COLLISION
	UPDATE hocsinh INNER JOIN (SELECT AVG(DEL.DiemTB) as TB, DEL.MaHS, MaHK, COUNT(MaMon) as SLMon FROM bangdiem JOIN (SELECT * FROM chitietbangdiem WHERE chitietbangdiem.MaChiTietBangDiem = OLD.MaChiTietBangDiem) as DEL WHERE bangdiem.MaBangDiem = DEL.MaBangDiem GROUP By MaHS, MaHK) as KQ
	SET hocsinh.TBHK1 = IF(KQ.MaHK = 'HK1' AND KQ.SLMon >= 2, KQ.TB, NULL),
		hocsinh.TBHK2 = IF(KQ.MaHK = 'HK2' AND KQ.SLMon >= 2, KQ.TB, NULL)
	WHERE KQ.MaHS = hocsinh.MaHS;
    INSERT INTO log(log) VALUES
    (KQ.TB + " " +KQ.SLMon);
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `update_TBHK_when_insert_chitietbangdiem`;
DELIMITER $$
CREATE TRIGGER `update_TBHK_when_insert_chitietbangdiem` AFTER INSERT ON `chitietbangdiem` FOR EACH ROW BEGIN
	UPDATE hocsinh INNER JOIN (SELECT AVG(UP.DiemTB) as TB, UP.MaHS, MaHK, COUNT(MaMon) as SLMon FROM bangdiem JOIN (SELECT * FROM chitietbangdiem WHERE chitietbangdiem.MaChiTietBangDiem = NEW.MaChiTietBangDiem) as UP WHERE bangdiem.MaBangDiem = UP.MaBangDiem GROUP By MaHS, MaHK) as KQ 
	SET hocsinh.TBHK1 = IF(KQ.MaHK = 'HK1' AND KQ.SLMon >= 2, KQ.TB, null),
		hocsinh.TBHK2 = IF(KQ.MaHK = 'HK2' AND KQ.SLMon >= 2, KQ.TB, null)
	WHERE KQ.MaHS = hocsinh.MaHS;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `update_TBHK_when_update_chitietbangdiem`;
DELIMITER $$
CREATE TRIGGER `update_TBHK_when_update_chitietbangdiem` AFTER UPDATE ON `chitietbangdiem` FOR EACH ROW BEGIN
	UPDATE hocsinh JOIN (
  SELECT MaHK, AVG(DiemTB) as TB, MaHS, COUNT(MaMon) as SLMonDaHoc FROM bangdiem JOIN chitietbangdiem ON bangdiem.MaBangDiem = chitietbangdiem.MaBangDiem GROUP BY MaHS) as KQ
ON hocsinh.MaHS = KQ.MaHS
SET TBHK1 = IF(KQ.MaHK = 'HK1', KQ.TB, NULL), TBHK2 = IF(KQ.MaHK = 'HK2', KQ.TB, NULL)
WHERE KQ.SLMonDaHoc>=2;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `hocki`
--

DROP TABLE IF EXISTS `hocki`;
CREATE TABLE IF NOT EXISTS `hocki` (
  `MaHK` varchar(3) NOT NULL,
  `TenHK` varchar(3) NOT NULL,
  PRIMARY KEY (`MaHK`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hocki`
--

INSERT INTO `hocki` (`MaHK`, `TenHK`) VALUES
('HK1', 'HK1'),
('HK2', 'HK2');

-- --------------------------------------------------------

--
-- Table structure for table `hocsinh`
--

DROP TABLE IF EXISTS `hocsinh`;
CREATE TABLE IF NOT EXISTS `hocsinh` (
  `MaHS` varchar(8) NOT NULL,
  `MaTK` varchar(10) NOT NULL,
  `HoTen` varchar(50) NOT NULL,
  `GioiTinh` varchar(3) NOT NULL,
  `NgaySinh` date NOT NULL,
  `DiaChi` varchar(50) NOT NULL,
  `Email` varchar(20) NOT NULL,
  `MaLop` varchar(8) NOT NULL,
  `TBHK1` decimal(5,2) DEFAULT NULL,
  `TBHK2` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`MaHS`),
  KEY `MaLop` (`MaLop`),
  KEY `MaTK` (`MaTK`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hocsinh`
--

INSERT INTO `hocsinh` (`MaHS`, `MaTK`, `HoTen`, `GioiTinh`, `NgaySinh`, `DiaChi`, `Email`, `MaLop`, `TBHK1`, `TBHK2`) VALUES
('19220001', 'HS19220001', 'Nguyen Van A', 'Nam', '2004-01-27', 'TpHCM', 'nguyenvana@gmail.com', '12A1', NULL, '8.00'),
('19220002', 'HS19220002', 'Tran Ngoc Han', 'Nu', '2004-03-11', 'Kien Giang', 'ngochan@gmail.com', '12A1', '6.00', '4.00'),
('19220003', 'HS19220003', 'Tran Ngoc Linh', 'Nu', '2004-05-24', 'Tay Ninh', 'ngoclinh@gmail.com', '12A2', '5.00', '7.00'),
('19220004', 'HS19220004', 'Le Nhat Minh', 'Nam', '2004-07-06', 'Nghe An', 'minhtam@gmail.com', '12A2', NULL, NULL),
('19220005', 'HS19220005', 'Phan Thi Thanh Tam', 'Nu', '2004-01-09', 'Vinh Long', 'thanhtam@gmail.com', '12A3', NULL, NULL),
('20230001', 'HS20230001', 'Phan Thanh Trieu', 'Nam', '2005-02-12', 'Dong Nai', 'thanhtrieu@gmail.com', '11A1', NULL, NULL),
('20230002', 'HS20230002', 'Le Quang Hien', 'Nam', '2005-06-20', 'TpHCM', 'quanghien@gmail.com', '11A3', NULL, NULL),
('20230003', 'HS20230003', 'Tran Thi Hong Tham', 'Nu', '2005-01-10', 'TpHCM', 'hongtham@gmail.com', '11A2', NULL, NULL),
('20230004', 'HS20230004', 'Do Thi Xuan', 'Nu', '2005-04-03', 'Binh Duong', 'doxuan@gmail.com', '11A3', NULL, NULL),
('20230005', 'HS20230005', 'Nguyen Thi Kim Cuc', 'Nu', '2005-06-07', 'TpHCM', 'kimcuc@gmail.com', '11A2', NULL, NULL),
('21240001', 'HS21240001', 'Tran Trung Hieu', 'Nam', '2006-04-23', 'TpHCM', 'trunghieu@gmail.com', '10A1', '5.30', NULL),
('21240002', 'HS21240002', 'Truong My Hanh', 'Nu', '2006-06-15', 'Tay Ninh', 'myhanh@gmail.com', '10A1', '9.50', NULL),
('21240003', 'HS21240003', 'Ha Duy Lap', 'Nam', '2006-03-19', 'Ben Tre', 'duylap@gmail.com', '10A2', '8.05', NULL),
('21240004', 'HS21240004', 'Ngo Thanh Tuan', 'Nam', '2006-07-17', 'Dong Nai', 'thanhtuan@gmail.com', '10A2', NULL, NULL),
('21240005', 'HS21240005', 'Tran Minh Man', 'Nam', '2006-10-15', 'Binh Duong', 'minhman@gmail.com', '10A3', '9.00', '6.00'),
('21240006', 'HS21240006', 'Nguyen Trung Nghia', 'Nam', '2006-12-12', 'Binh Phuoc', 'trungnghia@gmail.com', '10A3', '10.00', '9.00');

--
-- Triggers `hocsinh`
--
DROP TRIGGER IF EXISTS `update_TTLop_when_update_diemTB`;
DELIMITER $$
CREATE TRIGGER `update_TTLop_when_update_diemTB` AFTER UPDATE ON `hocsinh` FOR EACH ROW BEGIN
	UPDATE ttlop JOIN (SELECT lop.MaLop as ML, COUNT(*) as SL, lop.SiSo as SS
FROM lop JOIN hocsinh ON lop.MaLop = hocsinh.MaLop
WHERE TBHK1 >= 5
GROUP BY lop.MaLop) as KQ on ttlop.MaLop = KQ.ML
SET ttlop.SLDLop = KQ.SL, ttlop.TLDLop = KQ.SL/KQ.SS
WHERE ttlop.MaHK = 'HK1';

	UPDATE ttlop JOIN (SELECT lop.MaLop as ML, COUNT(*) as SL, lop.SiSo as SS
FROM lop JOIN hocsinh ON lop.MaLop = hocsinh.MaLop
WHERE TBHK2 >= 5
GROUP BY lop.MaLop) as KQ on ttlop.MaLop = KQ.ML
SET ttlop.SLDLop = KQ.SL, ttlop.TLDLop = KQ.SL/KQ.SS
WHERE ttlop.MaHK = 'HK2';
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
CREATE TABLE IF NOT EXISTS `log` (
  `Ma` int(11) NOT NULL AUTO_INCREMENT,
  `Log` text NOT NULL,
  PRIMARY KEY (`Ma`)
) ENGINE=MyISAM AUTO_INCREMENT=79 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`Ma`, `Log`) VALUES
(78, '1');

-- --------------------------------------------------------

--
-- Table structure for table `lop`
--

DROP TABLE IF EXISTS `lop`;
CREATE TABLE IF NOT EXISTS `lop` (
  `MaLop` varchar(4) NOT NULL,
  `TenLop` varchar(4) NOT NULL,
  `Khoi` varchar(2) NOT NULL,
  `SiSo` int(11) NOT NULL,
  PRIMARY KEY (`MaLop`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lop`
--

INSERT INTO `lop` (`MaLop`, `TenLop`, `Khoi`, `SiSo`) VALUES
('10A1', '10A1', '10', 30),
('10A2', '10A2', '10', 30),
('10A3', '10A3', '10', 30),
('11A1', '11A1', '11', 30),
('11A2', '11A2', '11', 30),
('11A3', '11A3', '11', 30),
('12A1', '12A1', '12', 30),
('12A2', '12A2', '12', 30),
('12A3', '12A3', '12', 30),
('10A4', '10A4', '10', 28);

--
-- Triggers `lop`
--
DROP TRIGGER IF EXISTS `create_TTLop_when_insert_Lop`;
DELIMITER $$
CREATE TRIGGER `create_TTLop_when_insert_Lop` AFTER INSERT ON `lop` FOR EACH ROW BEGIN
	INSERT INTO ttlop(MaLop,MaHK) VALUES
    (NEW.MaLop, "HK1"),
	(NEW.MaLop, "HK2");
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `monhoc`
--

DROP TABLE IF EXISTS `monhoc`;
CREATE TABLE IF NOT EXISTS `monhoc` (
  `MaMH` varchar(3) NOT NULL,
  `TENMH` varchar(20) NOT NULL,
  PRIMARY KEY (`MaMH`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `monhoc`
--

INSERT INTO `monhoc` (`MaMH`, `TENMH`) VALUES
('TOA', 'TOAN'),
('VLY', 'Vat ly'),
('HOA', 'Hoa hoc'),
('SIN', 'Sinh hoc'),
('LSU', 'Lich su'),
('DIA', 'Dia ly'),
('VAN', 'Ngu van'),
('DDU', 'Dao duc'),
('TDU', 'The duc');

-- --------------------------------------------------------

--
-- Table structure for table `taikhoan`
--

DROP TABLE IF EXISTS `taikhoan`;
CREATE TABLE IF NOT EXISTS `taikhoan` (
  `MaTK` varchar(10) NOT NULL,
  `TenDN` varchar(50) NOT NULL,
  `MatKhau` varchar(255) NOT NULL,
  `ChucVu` varchar(11) NOT NULL,
  PRIMARY KEY (`MaTK`),
  UNIQUE KEY `TenDN` (`TenDN`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `taikhoan`
--

INSERT INTO `taikhoan` (`MaTK`, `TenDN`, `MatKhau`, `ChucVu`) VALUES
('HS19220001', '19220001', '123456', 'HocSinh'),
('HS19220002', '19220002', '123456', 'HocSinh'),
('HS19220003', '19220003', '123456', 'HocSinh'),
('HS19220004', '19220004', '123456', 'HocSinh'),
('HS19220005', '19220005', '123456', 'HocSinh'),
('HS20230001', '20230001', '123456', 'HocSinh'),
('HS20230002', '20230002', '123456', 'HocSinh'),
('HS20230003', '20230003', '123456', 'HocSinh'),
('HS20230004', '20230004', '123456', 'HocSinh'),
('HS20230005', '20230005', '123456', 'HocSinh'),
('HS21240001', '21240001', '123456', 'HocSinh'),
('HS21240002', '21240002', '123456', 'HocSinh'),
('HS21240003', '21240003', '123456', 'HocSinh'),
('HS21240004', '21240004', '123456', 'HocSinh'),
('HS21240005', '21240005', '123456', 'HocSinh');

-- --------------------------------------------------------

--
-- Table structure for table `thamso`
--

DROP TABLE IF EXISTS `thamso`;
CREATE TABLE IF NOT EXISTS `thamso` (
  `MaThamSo` int(11) NOT NULL AUTO_INCREMENT,
  `TenThamSo` varchar(40) NOT NULL,
  `GiaTri` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`MaThamSo`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `thamso`
--

INSERT INTO `thamso` (`MaThamSo`, `TenThamSo`, `GiaTri`) VALUES
(1, 'TuoiHocSinhLonNhatChoPhep', '20.00'),
(2, 'TuoiHocSinhNhoNhatChoPhep', '15.00'),
(3, 'SoHocSinhToiDaMotLop', '40.00'),
(4, 'DiemToiDa', '10.00'),
(5, 'DiemToiThieu', '0.00'),
(6, 'DiemTrungBinhDeDatMon', '5.00');

-- --------------------------------------------------------

--
-- Table structure for table `ttlop`
--

DROP TABLE IF EXISTS `ttlop`;
CREATE TABLE IF NOT EXISTS `ttlop` (
  `MaTTLop` int(11) NOT NULL AUTO_INCREMENT,
  `MaLop` varchar(4) NOT NULL,
  `MaHK` varchar(3) NOT NULL,
  `SLDLop` int(11) DEFAULT NULL,
  `TLDLop` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`MaTTLop`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ttlop`
--

INSERT INTO `ttlop` (`MaTTLop`, `MaLop`, `MaHK`, `SLDLop`, `TLDLop`) VALUES
(1, '10A3', 'HK1', 2, '0.07'),
(2, '10A3', 'HK2', 2, '0.07');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
