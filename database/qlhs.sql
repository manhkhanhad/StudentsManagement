-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 07, 2021 at 12:06 PM
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
-- Database: `qlhs`
--

-- --------------------------------------------------------

--
-- Table structure for table `bangdiem`
--

DROP TABLE IF EXISTS `bangdiem`;
CREATE TABLE IF NOT EXISTS `bangdiem` (
  `MaHS` varchar(8) NOT NULL,
  `MaMon` varchar(3) NOT NULL,
  `TenHK` varchar(3) NOT NULL,
  `Diem15p` decimal(3,1) DEFAULT NULL,
  `Diem1Tiet` decimal(3,1) DEFAULT NULL,
  `DiemHK` decimal(3,1) DEFAULT NULL,
  `DiemTB` decimal(3,1) GENERATED ALWAYS AS ((((`Diem15p` + (`Diem1Tiet` * 2)) + (`DiemHK` * 3)) / (((`Diem15p` is not null) + ((`Diem1Tiet` is not null) * 2)) + ((`DiemHK` is not null) * 3)))) STORED,
  KEY `MaHS` (`MaHS`),
  KEY `MaMon` (`MaMon`),
  KEY `TenHK` (`TenHK`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bangdiem`
--

INSERT INTO `bangdiem` (`MaHS`, `MaMon`, `TenHK`, `Diem15p`, `Diem1Tiet`, `DiemHK`) VALUES
('19220001', 'TOA', 'HK1', '9.5', '9.0', '9.0'),
('19220001', 'Ly', 'HK1', '9.5', NULL, NULL),
('19220001', 'Ly', 'HK1', NULL, '10.0', NULL),
('19220001', 'VAN', 'HK1', '6.0', '9.0', '8.0'),
('19220002', 'TOA', 'HK1', '6.0', '8.0', '9.5'),
('19220003', 'HOA', 'HK1', '8.0', '7.0', '7.5'),
('19220004', 'HOA', 'HK1', '6.0', '7.5', '8.0'),
('19220005', 'TOA', 'HK1', '7.0', '9.0', '9.0'),
('20230001', 'HOA', 'HK1', '7.0', '9.5', '9.0'),
('20230002', 'DIA', 'HK1', '9.5', '9.0', '9.0'),
('20230003', 'TOA', 'HK1', '9.5', '8.0', '9.0'),
('20230004', 'VLY', 'HK1', '9.0', '7.0', '9.0'),
('20230005', 'TOA', 'HK1', '9.5', '9.0', '9.0'),
('21240004', 'TOA', 'HK1', '8.5', '9.0', '9.0'),
('21240004', 'SIN', 'HK1', '9.5', '9.0', '8.0'),
('21240004', 'TOA', 'HK1', '8.5', '9.0', '9.0');

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
  `MaTK` varchar(11) NOT NULL,
  `HoTen` varchar(50) NOT NULL,
  `GioiTinh` varchar(3) NOT NULL,
  `NgaySinh` date NOT NULL,
  `DiaChi` varchar(50) NOT NULL,
  `Email` varchar(20) NOT NULL,
  `MaLop` varchar(8) NOT NULL,
  PRIMARY KEY (`MaHS`),
  KEY `MaLop` (`MaLop`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `hocsinh`
--

INSERT INTO `hocsinh` (`MaHS`, `MaTK`, `HoTen`, `GioiTinh`, `NgaySinh`, `DiaChi`, `Email`, `MaLop`) VALUES
('19220001', 'HS19220001', 'Nguyen Van A', 'Nam', '2004-01-27', 'TpHCM', 'nguyenvana@gmail.com', '12A1'),
('19220002', 'HS19220002', 'Tran Ngoc Han', 'Nu', '2004-03-11', 'Kien Giang', 'ngochan@gmail.com', '12A1'),
('19220003', 'HS19220003', 'Tran Ngoc Linh', 'Nu', '2004-05-24', 'Tay Ninh', 'ngoclinh@gmail.com', '12A2'),
('19220004', 'HS19220004', 'Le Nhat Minh', 'Nam', '2004-07-06', 'Nghe An', 'minhtam@gmail.com', '12A2'),
('19220005', 'HS19220005', 'Phan Thi Thanh Tam', 'Nu', '2004-01-09', 'Vinh Long', 'thanhtam@gmail.com', '12A13'),
('20230001', 'HS20230001', 'Phan Thanh Trieu', 'Nam', '2005-02-12', 'Dong Nai', 'thanhtrieu@gmail.com', '11A1'),
('20230002', 'HS20230002', 'Le Quang Hien', 'Nam', '2005-06-20', 'TpHCM', 'quanghien@gmail.com', '11A3'),
('20230003', 'HS20230003', 'Tran Thi Hong Tham', 'Nu', '2005-01-10', 'TpHCM', 'hongtham@gmail.com', '11A2'),
('20230004', 'HS20230004', 'Do Thi Xuan', 'Nu', '2005-04-03', 'Binh Duong', 'doxuan@gmail.com', '11A3'),
('20230005', 'HS20230005', 'Nguyen Thi Kim Cuc', 'Nu', '2005-06-07', 'TpHCM', 'kimcuc@gmail.com', '11A2'),
('21240001', 'HS21240001', 'Tran Trung Hieu', 'Nam', '2006-04-23', 'TpHCM', 'trunghieu@gmail.com', '10A1'),
('21240002', 'HS21240002', 'Truong My Hanh', 'Nu', '2006-06-15', 'Tay Ninh', 'myhanh@gmail.com', '10A1'),
('21240003', 'HS21240003', 'Ha Duy Lap', 'Nam', '2006-03-19', 'Ben Tre', 'duylap@gmail.com', '10A2'),
('21240004', 'HS21240004', 'Ngo Thanh Tuan', 'Nam', '2006-07-17', 'Dong Nai', 'thanhtuan@gmail.com', '10A2'),
('21240005', 'HS21240005', 'Tran Minh Man', 'Nam', '2006-10-15', 'Binh Duong', 'minhman@gmail.com', '10A3'),
('21240006', 'HS21240006', 'Nguyen Trung Nghia', 'Nam', '2006-12-12', 'Binh Phuoc', 'trungnghia@gmail.com', '10A3');

-- --------------------------------------------------------

--
-- Table structure for table `lop`
--

DROP TABLE IF EXISTS `lop`;
CREATE TABLE IF NOT EXISTS `lop` (
  `MaLop` varchar(4) NOT NULL,
  `TenLop` varchar(4) NOT NULL,
  `Khoi` int(11) NOT NULL,
  `SiSo` int(11) NOT NULL,
  `NienKhoa` varchar(8) NOT NULL,
  PRIMARY KEY (`MaLop`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `lop`
--

INSERT INTO `lop` (`MaLop`, `TenLop`, `Khoi`, `SiSo`, `NienKhoa`) VALUES
('10A1', '10A1', 10, 30, '20212024'),
('10A2', '10A2', 10, 30, '20212024'),
('10A3', '10A3', 10, 30, '20212024'),
('11A1', '11A1', 11, 30, '20202023'),
('11A2', '11A2', 11, 30, '20202023'),
('11A3', '11A3', 11, 30, '20202023'),
('12A1', '12A1', 12, 30, '20192022'),
('12A2', '12A2', 12, 30, '20192022'),
('12A3', '12A3', 12, 30, '20192022');

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
