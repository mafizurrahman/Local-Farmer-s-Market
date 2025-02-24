-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 13, 2023 at 11:20 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `impulse101`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertProductBid` (IN `product_id_param` INT, IN `bid_amount_param` INT, IN `farmer_phone_param` BIGINT, IN `buyer_address_param` VARCHAR(50))   BEGIN
    INSERT INTO bids (product_id, bid_amount, farmer_phone, buyer_address)
    VALUES (product_id_param, bid_amount_param, farmer_phone_param, buyer_address_param);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MaxBid` ()   BEGIN

SELECT MAX(bid_amount) AS MaxBid FROM bids;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `raiseProductQuantityInCart` ()   BEGIN
    UPDATE cart
    SET qty = CASE
        WHEN subtotal > 50 THEN qty * 2
        ELSE qty * 1
    END;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `TotalTexanFarmers` ()   BEGIN
SELECT COUNT(farmer_id) AS TotalTexanFarmer FROM farmerregistration WHERE farmer_state = 'Texas';
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bid`
--

CREATE TABLE `bid` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_description` text NOT NULL,
  `product_image` blob NOT NULL,
  `lowest_bid` decimal(10,2) NOT NULL,
  `bid_ending_time` datetime NOT NULL,
  `farmer_phone` bigint(10) NOT NULL
) ;

--
-- Dumping data for table `bid`
--

INSERT INTO `bid` (`product_id`, `product_name`, `product_description`, `product_image`, `lowest_bid`, `bid_ending_time`, `farmer_phone`) VALUES
(2, 'Lychee', 'Summer fruit is awesome.', 0x6c69636865652e6a7067, 120.00, '2023-10-25 20:28:00', 254120212),
(3, 'Carrot', 'Red carrot', 0x436172726f742e6a7067, 12.00, '2023-10-22 14:35:00', 2132321232),
(4, 'Red Apple', 'Fantastic flavoured Apple', 0x6170706c652e6a7067, 4.00, '2023-10-28 21:54:00', 112233445),
(5, 'Potato', 'It is nice product', 0x7770353438353332302e6a7067, 12.00, '2023-10-27 05:47:00', 112233445),
(6, 'Broccoli', '2kg, it is a very good product.', 0x62726f63636f6c692e6a7067, 23.00, '2023-11-27 21:47:00', 112233445),
(7, 'Lemon', '2kg, Ripe Yellow Lemon', 0x6c656d6f6e732d31323936783732382d666561747572652e6a7067, 3.00, '2023-11-25 23:03:00', 11111111),
(8, 'Capsicum', '35 KG, Its a green spicy capsicum.', 0x6f7264696e6172792d6672756974732d776974682d616d617a696e672d6865616c74682d62656e65666974732d30352d31343430783831302e6a7067, 12.00, '2023-11-17 12:37:00', 112233445);

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE `bids` (
  `bid_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `bid_amount` decimal(10,2) DEFAULT NULL,
  `farmer_phone` bigint(10) DEFAULT NULL,
  `buyer_address` varchar(50) NOT NULL
) ;

--
-- Dumping data for table `bids`
--

INSERT INTO `bids` (`bid_id`, `product_id`, `bid_amount`, `farmer_phone`, `buyer_address`) VALUES
(9, 2, 123.00, 238922222, 'HarryPOtter, Call me 267328126'),
(11, 2, 123422.00, 254120212, '98749854, 98# 3rd street Austin'),
(12, 2, 20938.00, 254120212, '12345689, Detroit ST. , TX 77660'),
(13, 4, 4.00, 112233445, '56345689, Temps ST. , NY 79660'),
(14, 4, 21.00, 112233445, '93345689, Sunnyvale ST. , Chicago 79660'),
(15, 4, 20000.00, 112233445, '47587633, Ninth ST. NC, 78987'),
(16, 2, 123.00, 254120212, '292839191 , Dowling 3rd street NC 83292'),
(17, 5, 122.00, 112233445, '123127612, 2nd St. TX'),
(18, 6, 23.00, 112233445, '2131321, Florentina St. TX 67565'),
(19, 5, 600.00, 254347987, '118943722, 014 University Drive, Prairie View, TX'),
(20, 5, 600.00, 254347987, '89843722, 714 University Drive, Prairie View, TX'),
(21, 7, 24.00, 11111111, '98765432, 9th St. Yellowstone, Montana'),
(23, 5, 60.00, 254347987, '298322289, 4th St. Town Waller');

--
-- Triggers `bids`
--
DELIMITER $$
CREATE TRIGGER `prevent_bid_amount_decrease` BEFORE UPDATE ON `bids` FOR EACH ROW BEGIN
    IF NEW.bid_amount < OLD.bid_amount THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Bid amount can only be increased, not decreased';
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `prevent_negative_bid` BEFORE INSERT ON `bids` FOR EACH ROW BEGIN
    IF NEW.bid_amount < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Hey,Bid amount cannot be negative';
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buyerregistration`
--

CREATE TABLE `buyerregistration` (
  `buyer_id` int(255) NOT NULL,
  `buyer_name` varchar(30) NOT NULL,
  `buyer_phone` bigint(10) NOT NULL,
  `buyer_addr` text NOT NULL,
  `buyer_comp` varchar(100) NOT NULL,
  `buyer_license` varchar(100) NOT NULL,
  `buyer_bank` int(16) NOT NULL,
  `buyer_pan` varchar(10) NOT NULL,
  `buyer_mail` varchar(20) NOT NULL,
  `buyer_username` varchar(20) NOT NULL,
  `buyer_password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `buyerregistration`
--

INSERT INTO `buyerregistration` (`buyer_id`, `buyer_name`, `buyer_phone`, `buyer_addr`, `buyer_comp`, `buyer_license`, `buyer_bank`, `buyer_pan`, `buyer_mail`, `buyer_username`, `buyer_password`) VALUES
(15, 'Abhishek', 1234567890, ' Raj Uday 234', 'Elysian.org', '02082000', 2147483647, '1234567890', 'abhi@hmil.com', 'admin', 'm8bf5+Y='),
(16, 'Arpit', 7666610976, 'Bhat Mansion', 'Mafia Pvt Ltd', '99', 12345, '987', 'abcd@gmail.com', 'redhawk', 'm9HW6O8B'),
(17, 'calista', 2589631472, '4/2,rose building .wadala', 'apple', 'w3566908', 8947, '2436467897', 'rose21@gmail.com', 'melissa', 'nM7d+e0b41E='),
(18, 'Lokesh', 9029788504, 'SEC -13 , PALM BEACH ROAD', '', 'MAHARASHTRA', 0, '1234567890', 'abhi@hmil.com', 'lokesh', 'yw=='),
(19, 'ansh', 9819104641, 'fam', 'Elysian.org', 'MAHARASHTRA', 2147483647, '1234567890', 'abhi@hmil.com', 'ansh', 'y5CB'),
(20, 'bhabalomkar421', 8828071232, 'bj', 'c company', 'just **** off', 1, '1', 'xyz@domain.com', '501807', 'yw=='),
(21, 'Nazara', 987654321, '714 University Drive, Apt #017', 'The Arbors', '123', 2232122, '23671', 'naz@gmail.com', 'Naazara', 'z5aBvLk='),
(23, 'Mafizur Rahman', 2543407697, '1825 S 3RD ST APT 10006A', 'The Arbors', '123', 12345, '23671', 'rmafizur10@gmail.com', 'Mafizur_Rahman1', 'm8bf5+Y='),
(24, 'Swapnil', 123456781, '1825 S 3RD ST\r\n1006A', 'The Arbors', '', 2232122, '1122', 'das@gmail.com', 'swapnil', 'y5OAvA=='),
(27, 'Rahman', 1273829311, '1825 S 3RD ST APT 10006A', '', '', 1122333322, '1122', 'rmafizur120@gmail.co', 'es', 'y5OAvA=='),
(28, 'Chen', 1122334455, '714 University Drive, Apt# 017', '', '', 223212212, '0121231', '213rmafiz121ur10@gma', '12chen', 'y5OAvA=='),
(29, 'Elvin Li', 2123407697, '14 Prairie Drive, Apt# 017', '', '', 2147483647, '1122112', '342rmaf@gmail.com', 'Elvin', 'y5OAvA==');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `product_id` int(255) NOT NULL,
  `phonenumber` bigint(10) NOT NULL,
  `qty` int(10) NOT NULL DEFAULT 1,
  `subtotal` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`product_id`, `phonenumber`, `qty`, `subtotal`) VALUES
(32, 8169193101, 10, 10),
(23, 1273829311, 1250, 56),
(23, 112233445, 1, 56),
(43, 112233445, 1, 10),
(45, 112233445, 1, 12),
(40, 1122334455, 1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `cat_id` int(11) NOT NULL,
  `cat_title` varchar(100) NOT NULL
) ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`cat_id`, `cat_title`) VALUES
(1, 'Crops'),
(2, 'Vegetables'),
(3, 'Fruits');

-- --------------------------------------------------------

--
-- Table structure for table `farmerregistration`
--

CREATE TABLE `farmerregistration` (
  `farmer_id` int(255) NOT NULL,
  `farmer_name` varchar(255) NOT NULL,
  `farmer_phone` bigint(10) NOT NULL,
  `farmer_address` text NOT NULL,
  `farmer_state` varchar(50) NOT NULL,
  `farmer_district` varchar(50) NOT NULL,
  `farmer_pan` varchar(10) NOT NULL,
  `farmer_bank` int(16) NOT NULL,
  `farmer_password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `farmerregistration`
--

INSERT INTO `farmerregistration` (`farmer_id`, `farmer_name`, `farmer_phone`, `farmer_address`, `farmer_state`, `farmer_district`, `farmer_pan`, `farmer_bank`, `farmer_password`) VALUES
(1, 'Nazara', 8169193101, 'Mars', 'Texas', 'Dallas', '1234567890', 2147483647, 'm8bf5+Y='),
(3, 'Mehnaz', 8169193102, 'SEC -13 , PALM BEACH ROAD', 'Texas', 'Dallas', '123ABC', 45745425, 'nMPb4g=='),
(4, 'Ram', 8169193103, 'Moon', 'Texas', 'Dallas', '123ABC', 211324654, 'm8bf5+Y='),
(5, 'Lokesh', 8169193104, 'SEC -13 , PALM BEACH ROAD', 'Texas', 'Dallas', '1325355', 45745425, 'yw=='),
(6, 'Ramlal', 8169193105, 'Address 1', 'Texas', 'Houston', '1234567899', 2147483647, 'yw=='),
(7, 'Chirag', 8169193106, 'Address 2', 'Texas', 'Houston', '5341874510', 2147483647, 'yw=='),
(8, 'Gladina', 8169193107, 'Address 3', 'Texas', 'Houston', '6846516843', 2147483647, 'yw=='),
(9, 'neeta', 8169193108, 'add1', 'Texas', 'Dallas', '3263062', 56878613, 'yw=='),
(10, 'meeta', 8169193109, 'add2', 'Colorado', 'Denver', '2983473057', 2147483647, 'yw=='),
(11, 'melissa', 8169193110, 'add3', 'Colorado', 'Kullu', '65416541', 454586125, 'yw=='),
(12, 'jon', 8169193111, 'add5', 'Colorado', 'Chamba', '24685435', 248654352, 'yw=='),
(13, 'daenarys', 8169193112, 'add5', 'Colorado', 'Solan', '45674852', 3216415, 'yw=='),
(14, 'drogon', 8169193113, 'add7', 'Texas', 'Solan', '246856873', 2147483647, 'yw=='),
(16, 'Bran', 8169193114, 'add10\r\n', 'Texas', 'Lakshadweep', '3549685416', 65464851, 'yw=='),
(17, 'lyanna', 8169193115, 'add10', 'Texas', 'Lakshadweep', '2456435', 21544232, 'yw=='),
(18, 'catelyn', 8169193116, 'add115', 'MADHYA PRADESH', 'Rewa', '574542', 3846835, 'yw=='),
(19, 'Sansa', 8169193117, 'add 17', 'GOA', 'North Goa', '2456843', 3468651, 'yw=='),
(20, 'Rachel', 8169193118, 'add20', 'GOA', 'North Goa', '274635213', 27486513, 'yw=='),
(21, 'Joanna', 8169193119, 'add16', 'GOA', 'South Goa', '24756215', 24568536, 'yw=='),
(22, 'Arya', 8169193120, 'add17', 'GOA', 'South Goa', '2458742884', 249685547, 'yw=='),
(23, 'Andy', 8169193121, 'add19', 'HARYANA', 'Rohtak', '255451025', 54564684, 'yw=='),
(25, 'stark', 8169193122, 'add29', 'DAMAN AND DIU', 'Diu', '54584646.', 541564564, 'yw=='),
(26, 'hound', 8169193123, 'add23', 'DAMAN AND DIU', 'Daman', '2545498', 524845638, 'yw=='),
(27, 'Ryte Richard', 8169193124, 'add45', 'TAMIL NADU', 'Nagapattinam *', '54584636', 254685746, 'yw=='),
(29, 'John', 8169193125, 'Address 7', 'Texas', 'Dallas', '656', 168, 'yw=='),
(30, 'Rogan', 8169193126, 'Address56', 'JHARKAND', 'Garhwa *', '54664851', 6455415, 'yw=='),
(31, 'Swaarop', 8169193127, 'Address 23', 'JHARKAND', 'Garhwa *', '6416545', 4646544, 'yw=='),
(32, 'Jesudas', 8169193128, 'Address 56', 'JHARKAND', 'Palamu', '4515214', 544613515, 'yw=='),
(33, 'same', 8169193129, 'addeees', 'JAMMU AND KASHMIR', 'Kupwara', '1232122121', 121321, 'yw=='),
(34, 'Mitesh Chhadva', 8169193130, '19/502,Fam chs ltd\r\nSector 11  koparkhairne', 'MAHARASHTRA', 'Nandurbar *', '656861651', 5465415, 'yw=='),
(35, 'Manali', 8169193131, '19/502,Fam chs ltd\r\n', 'JAMMU AND KASHMIR', 'Kupwara', '656861651', 5465415, 'yw=='),
(36, 'Manya', 8169193132, '19/502,Fam chs \r\nameri', 'JAMMU AND KASHMIR', 'Baramula', '6568616510', 54654101, 'yw=='),
(37, 'surli', 8169193133, '19/502,Fam chs \r\nameri', 'JAMMU AND KASHMIR', 'Baramula', '6568616510', 54654101, 'yw=='),
(38, 'asha', 8169193134, 'superman', 'JAMMU AND KASHMIR', 'Srinagar', '123123123', 3213213, 'yw=='),
(39, 'asjij', 8169193135, 'ameica', 'JAMMU AND KASHMIR', 'Srinagar', '121212121', 1212, 'yw=='),
(40, 'arama', 8169193136, 'australia', 'JAMMU AND KASHMIR', 'Badgam', '121212', 121211, 'yw=='),
(41, 'andami', 8169193137, 'askkkey', 'JAMMU AND KASHMIR', 'Badgam', '121218', 12127, 'yw=='),
(42, 'human', 8169193138, 'ansh', 'JAMMU AND KASHMIR', 'Badgam', '121218', 12127, 'yw=='),
(43, 'varma', 8169193139, 'jupiter', 'JAMMU AND KASHMIR', 'Badgam', '12131311', 22, 'yw=='),
(44, 'ashhhish', 8169193140, 'asmaan', 'HIMACHAL PRADESH', 'Chamba', '1212222222', 2147483647, 'yw=='),
(45, 'ashhhish', 8169193141, 'asmaan', 'HIMACHAL PRADESH', 'Chamba', '1212222222', 2147483647, 'yw=='),
(46, 'ruchi', 8169193142, 'juhinagar', 'HIMACHAL PRADESH', 'Kangra', '22', 1, 'yw=='),
(47, 'name', 8169193143, 'toonpur', 'HIMACHAL PRADESH', 'Kangra', '11', 11, 'yw=='),
(48, 'kargil', 8169193144, 'toonpur super', 'HIMACHAL PRADESH', 'Lahul & Spiti', '1212dw11', 223, 'yw=='),
(49, 'admi', 8169193145, 'asam\r\n', 'HIMACHAL PRADESH', 'Kangra', '121211', 222, 'yw=='),
(50, 'robot', 8169193146, 'asa1', 'HIMACHAL PRADESH', 'Lahul & Spiti', '12121', 2221, 'yw=='),
(51, 'robot shah', 8169193147, 'arya', 'HIMACHAL PRADESH', 'Lahul & Spiti', '12121', 2221, 'yw=='),
(52, 'robot farmer', 8169193148, 'doremon', 'HIMACHAL PRADESH', 'Kullu', '12121', 2221189, 'yw=='),
(53, 'robot schema', 8169193149, 'doremon nobita', 'HIMACHAL PRADESH', 'Kullu', '12129+', 222118, 'yw=='),
(54, 'ashhhish chanchali', 8169193150, 'asmeta', 'HIMACHAL PRADESH', 'Mandi', '1212222222', 2147483647, 'yw=='),
(55, 'ashhhish chanchali', 8169193151, 'asmeta', 'HIMACHAL PRADESH', 'Mandi', '1212222222', 2147483647, 'yw=='),
(56, 'arpita', 8169193152, 'asmeta upra', 'HIMACHAL PRADESH', 'Hamirpur', '1212222222', 2147483647, 'yw=='),
(57, 'robot aunty', 8169193153, 'iten', 'HIMACHAL PRADESH', 'Una', '121129', 22219, 'yw=='),
(58, 'Kira', 8169193154, 'add', 'ARUNACHAL PRADESH', 'Upper Siang *', '12', 1, 'yZE='),
(59, 'Arpit', 8169193155, 'Lenyadri Tower', 'MAHARASHTRA', 'Thane', '111', 999, 'yw=='),
(60, 'Raghu', 8169193156, 'West City', 'ANDHRA PRADESH', 'Adilabad', '1234', 4321, 'yw=='),
(61, 'Raghav', 8169193157, '9 Palk Street', 'CHANDIGARH', 'Chandigarh', '109', 991, 'yw=='),
(62, 'Keshav', 8169193158, 'Sarojnagar', 'GOA', 'North Goa', '342', 332, 'yw=='),
(63, 'Suraj', 8169193159, 'Moraj', 'CHHATTISGARH', 'Kawardha *', '789', 987, 'yw=='),
(64, 'Midoriya', 8169193160, 'Hosu', 'DAMAN AND DIU', 'Diu', '191', 818, 'yw=='),
(65, 'Dhole', 8169193161, 'North Silvasa', 'DADRA AND NAGAR HAVELI', 'Dadra & Nagar Haveli', '777', 666, 'yw=='),
(66, 'Yash', 8169193162, 'Ambika Heights', 'GOA', 'South Goa', '537', 361, 'yw=='),
(67, 'Karan', 8169193163, 'Nilgiri Gardens', 'PUDUCHERRY', 'Yanam', '2014', 1014, 'yw=='),
(68, 'Arun', 8169193164, 'Harbour View', 'JAMMU AND KASHMIR', 'Punch', '1024', 3014, 'yw=='),
(69, 'Khan', 8169193165, 'SBI colony', 'ARUNACHAL PRADESH', 'Tawang', '2048', 1048, 'yw=='),
(70, 'Kahn', 8169193166, 'Baba Niwas', 'MADHYA PRADESH', 'Sheopur *', '4096', 5096, 'yw=='),
(71, 'Iqbal', 8169193167, 'Hiranandani', 'HARYANA', 'Panchkula *', '2047', 1047, 'yw=='),
(72, 'Archit', 8169193168, 'Army Colony', 'DELHI', 'Central *', '8192', 7192, 'yw=='),
(73, 'Kumar', 8169193169, 'Masjid Rd', 'DELHI', 'West *', '1192', 2192, 'yw=='),
(74, 'Eeshan', 8169193170, 'BARC Colony', 'GOA', 'South Goa', '2192', 3192, 'yw=='),
(75, 'Gavin', 8169193171, 'Oxfordshire', 'DELHI', 'South *', '3192', 4192, 'yw=='),
(76, 'Meg', 8169193172, 'Chelsea', 'TAMIL NADU', 'Madurai', '343', 433, 'yw=='),
(77, 'Hodaka', 8169193173, 'Touto', 'JAMMU AND KASHMIR', 'Rajauri', '1729', 2729, 'yw=='),
(78, 'Rohan', 8169193174, 'Spurs', 'BIHAR', 'Purnia', '1777', 7171, 'yw=='),
(79, 'Navin', 8169193175, 'Hoenn', 'GOA', 'North Goa', '3412', 5020, 'yw=='),
(80, 'Ansh', 8169193176, 'Liverpool', 'CHANDIGARH', 'Chandigarh', '7129', 8100, 'yw=='),
(81, 'Umesh', 8169193177, 'Everton', 'DELHI', 'North West *', '6654', 7896, 'yw=='),
(82, 'Bhuvan', 8169193178, 'Leicester', 'HIMACHAL PRADESH', 'Shimla', '1010', 2020, 'yw=='),
(83, 'Pavan', 8169193179, 'Munich', 'JHARKAND', 'ORISSA', '9291', 7374, 'yw=='),
(84, 'Suman', 8169193180, 'Watford', 'GOA', 'South Goa', '9293', 8453, 'yw=='),
(85, 'Ashish', 8169193181, 'Crystal Palace', 'KERALA', 'Kasaragod', '4545', 5454, 'yw=='),
(86, 'Lal', 8169193182, 'West Ham', 'KARNATAKA', 'Belgaum', '9999', 9998, 'yw=='),
(87, 'Ranvir', 8169193183, 'Newcastle', 'MAHARASHTRA', 'Jalna', '8818', 2818, 'yw=='),
(88, 'Suresh', 8169193184, 'Real Madrid', 'MEGHALAYA', 'West Garo Hills', '9001', 8017, 'yw=='),
(89, 'Anish', 8169193185, 'Bournmouth', 'PUDUCHERRY', 'Yanam', '5543', 2999, 'yw=='),
(90, 'Lahiru', 8169193186, 'Barcelona', 'GUJARAT', 'Kachchh', '3139', 8199, 'yw=='),
(91, 'Jasmeet', 8169193187, 'Manchester city', '0', 'Kachchh', '7777', 6666, 'yw=='),
(92, 'bhabalomkar421', 8828071232, '1', 'MADHYA PRADESH', 'Sheopur *', '1', 1, 'yw=='),
(95, 'Chy', 2543407692, '714 University Drive, Apt# 017         ', '0', 'Select District', '2367111233', 983374326, 'y5OAvA=='),
(96, 'Das', 112233445, 'Kagabola, Kagabala, Moulvibazar Sadar    ', 'Texas', 'Houston', '012123321', 214748364, 'y5OAvA=='),
(97, 'Antora', 111122223, 'prairieveiw', 'Texas', 'Garland', '789453', 278913, 'y5ODvw=='),
(98, 'Marry Kim', 11111111, '1825 S 3RD ST1006A  ', 'Texas', 'Dallas', '2543407692', 2147483647, 'l8PA9+MAvFAwUg=='),
(99, 'Mafizur Rahman', 2543407697, '1825 S 3RD ST APT 10006A', 'Texas', 'Austin', '012986544', 1298472, 'y5OAvA==');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(255) NOT NULL,
  `product_id` int(255) NOT NULL,
  `qty` int(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `delivery` varchar(10) NOT NULL,
  `phonenumber` bigint(10) NOT NULL,
  `total` int(10) NOT NULL,
  `payment` varchar(10) NOT NULL,
  `buyer_phonenumber` bigint(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `product_id`, `qty`, `address`, `delivery`, `phonenumber`, `total`, `payment`, `buyer_phonenumber`) VALUES
(55, 23, 1, ' Raj Uday 234', 'Buyer', 8169193101, 56, 'cod', 1234567890),
(56, 28, 1, ' Raj Uday 234', 'Buyer', 8169193101, 45, 'cod', 1234567890),
(57, 31, 1, 'I am Hungry', 'Buyer', 8169193101, 25, 'cod', 1234567890),
(58, 3, 2, ' Raj Uday 234', 'Farmer', 8169193101, 10, 'paytm', 1234567890),
(60, 32, 1, 'Working', 'Buyer', 8169193101, 10, 'cod', 1234567890),
(61, 38, 1, '714 University Drive, Apt #017', 'Farmer', 1234567890, 12, 'paytm', 987654321),
(62, 39, 1, '1825 S 3RD ST APT 10006A', 'Courier', 2543407697, 123, 'paytm', 2543407697),
(63, 41, 1, '1825 S 3RD ST APT 10006A', 'Farmer', 2543407692, 123, 'cod', 1273829311),
(66, 43, 1, '714 University Drive, Apt# 017', 'Farmer', 112233445, 10, 'paytm', 1122334455),
(67, 44, 1, 'College Drive, Apt# 017', 'Courier', 11111111, 12, 'cod', 1122334455),
(68, 45, 1, '714 University Drive, Apt# 017', 'Farmer', 2543407697, 12, 'cod', 1122334455),
(69, 44, 1, '714 University Drive, Apt# 017', 'Farmer', 11111111, 12, 'cod', 1122334455),
(70, 44, 1, '714 University Drive, Apt# 017', 'Farmer', 11111111, 12, 'cod', 1122334455),
(71, 45, 1, '1825 S 3RD ST APT 10006A', 'Farmer', 2543407697, 12, 'cod', 2543407697),
(72, 45, 1, '1825 S 3RD ST APT 10006A', 'Buyer', 2543407697, 12, 'paytm', 2543407697);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(100) NOT NULL,
  `farmer_fk` int(255) NOT NULL,
  `product_title` varchar(100) NOT NULL,
  `product_cat` varchar(100) NOT NULL,
  `product_type` varchar(100) NOT NULL,
  `product_expiry` varchar(25) NOT NULL,
  `product_image` text NOT NULL,
  `product_stock` int(100) NOT NULL,
  `product_price` int(100) NOT NULL,
  `product_desc` text NOT NULL,
  `product_keywords` text NOT NULL,
  `product_delivery` varchar(5) NOT NULL
) ;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `farmer_fk`, `product_title`, `product_cat`, `product_type`, `product_expiry`, `product_image`, `product_stock`, `product_price`, `product_desc`, `product_keywords`, `product_delivery`) VALUES
(1, 1, 'Ramlal Potato', '2', 'Potato', '2020-04-15', 'Potato.jpg', 1000, 12, 'Best Quality product guarented 100 percent', 'potato', 'yes'),
(3, 1, 'Ramlal Tomato', '2', 'Tomato', '2020-04-15', 'Tomato.jpg', 500, 5, 'Best Quality toamato assured', 'tomato , best quality tomato , Ramlal Tomato', 'no'),
(17, 3, 'Shivneri Bananas', '3', 'Bananas', '2020-04-15', 'Bananas.jpg', 250, 30, 'Best Quality Bananas', 'banana, shivneri ,', 'yes'),
(18, 3, 'Ram Rice', '1', 'Rice', '2020-04-15', 'Rice.jpg', 1500, 2, 'waqd', 'best rice', 'yes'),
(19, 1, 'Ansh Carrot', '2', 'Carrot', '2020-04-15', 'Carrot.jpg', 1250, 56, 'Big fat juicy best quality carrots assured', 'carrot,best carrot', 'yes'),
(21, 1, 'Abhi Maize', '1', 'Maize', '2020-04-15', 'Maize.jpg', 750, 99, 'Seeds Import from australia , grown with love', 'Maize,best Maize', 'yes'),
(22, 3, 'Calista Coconut', '1', 'Coconut', '2020-04-15', 'Coconut.jpg', 450, 12, 'Better than others', 'Coconut,best Coconut', 'no'),
(23, 1, 'Arpit Grapes', '3', 'Grapes', '2020-04-15', 'Green Grapes.jpg', 4560, 56, 'Best Grapes you will ever find', 'grapes,green grapes,best grapes', 'yes'),
(24, 1, 'Arpit Apples', '3', 'Apple', '2020-04-15', 'Apple.jpg', 1500, 101, 'Best Apples grown in Kashmir and handled with love and care', 'apples,apple,best apple', 'no'),
(25, 1, 'Ramlal Wheat', '1', 'Wheat', '2020-04-15', 'Wheat.jpg', 2000, 80, 'Thin , Fragrant wheat grains grown with love', 'wheat,best quality wheat,best wheat', 'no'),
(27, 3, 'Arpit Alphonso Mango', '3', 'Mango', '2020-04-15', 'Mango.jpg', 2000, 200, 'Grown with love in Ratnagiri', 'mango,alponso mango,best mango', 'yes'),
(28, 1, 'Ansh Custard Apple', '3', 'Custard Apple', '2020-04-15', 'custartapple.cms', 500, 45, 'Custard Apple so tasty ,to die for', 'Custard Apple,custart apple, apple, best custard apple', 'yes'),
(29, 3, 'Omkar Cabbage', '2', 'Cabbage', '2020-04-15', 'Cabbage.jpg', 1500, 50, 'Best Quality Cabbage', 'cabbage, best Cabbage', 'yes'),
(30, 1, 'Ansh Onion', '2', 'Onion', '2020-04-15', 'Onion.jpg', 1500, 65, 'Grown with love', 'Onion,best onion', 'no'),
(31, 1, 'Abhi Strawberry', '3', 'Strawberry', '2020-04-15', 'strawberry.jpg', 100, 25, 'Best Strawberrys all over India ', 'Strawberry,best strawberry', 'yes'),
(32, 1, 'Abhi Orange', '3', 'Orange', '2020-04-15', 'orange.jpg', 1500, 10, 'Best Oranges grown with love in Nagpur', 'Orange,best Orange', 'yes'),
(37, 1, 'Ram Sugacane', '1', 'Sugarcane', '2020-04-25', 'Sugarcane.jpg', 1000, 50, 'Best Sugarcane', 'Sugarcane', 'yes'),
(38, 93, 'Organic Tomato', '2', 'Tomato', '2023-09-26', 'wp5485320.jpg', 2, 12, 'It is a seasonal vegetable', 'Best', 'yes'),
(39, 94, 'Seed', '1', 'Rice', '2023-10-08', 'download (2).jpg', 2, 123, 'This seed is very good. White seed.', 'Rice Seed', 'yes'),
(40, 95, 'Mango', '3', 'Mango', '2023-10-31', 'mango.jpg', 10, 3, 'Fresh and ripe mango without formaline.', 'Mango, Ripe, Good', 'yes'),
(42, 96, 'White Rice long', '1', 'Rice', '2023-11-08', 'rice.jpg', 23, 123, 'White long rice.', 'Best', 'yes'),
(43, 96, 'Broccoli', '2', 'Green Broccoli', '2023-10-31', 'broccoli.jpg', 23, 10, 'Green broccoli is very good for health. ', 'Broccoli, Green', 'yes'),
(44, 98, 'Fresh Melon', '3', 'Yellow Melon', '2023-11-13', 'korean.jpg', 23, 12, 'It is a korean fresh melon.', 'Fresh Melon', 'yes'),
(45, 99, 'Kiwiberry', '3', 'Green Kiwiberry', '2023-11-15', 'fresh-sliced-mini-kiwis-royalty-free-image-1690215764.jpg', 2, 12, 'A very healthy fruit', 'Green', 'yes'),
(46, 96, 'Capsicum', '2', 'Green Capsicum', '2023-11-28', 'images (1).jpg', 12, 12, 'Very hot and spicy green capsicum', 'capsicum, green', 'yes');

-- --------------------------------------------------------

--
-- Table structure for table `visitor`
--

CREATE TABLE `visitor` (
  `vname` varchar(50) NOT NULL,
  `reason` varchar(50) NOT NULL,
  `noofvisitors` int(60) NOT NULL,
  `phone` bigint(11) NOT NULL,
  `visitorinformation` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `visitor`
--

INSERT INTO `visitor` (`vname`, `reason`, `noofvisitors`, `phone`, `visitorinformation`) VALUES
('Shauke', 'To have fun', 1, 112233445, 'we are police'),
('nazara', 'to see products', 2, 112233445, 'we are student'),
('nazara', 'to see products', 2, 112233445, 'we are student'),
('nazara', 'to see products', 9, 254, 'we are police'),
('Archana', 'To see tomato', 3, 112233445, 'we are coming from chicago'),
('', '', 0, 0, ''),
('marjan', 'nothing', 1, 1122334223, 'student'),
('Doglus', 'nothing', 234, 112233445, 'we are coming from chicago'),
('Daisy', 'To see the cultivation ', 12, 11111111, 'We are coming for research'),
('Maliha Rahman12', 'To investigate fruit cultivation', 2, 112233445, 'We are from california state university.');

--
-- Triggers `visitor`
--
DELIMITER $$
CREATE TRIGGER `CheckVisitorNameBeforeInsert` BEFORE INSERT ON `visitor` FOR EACH ROW BEGIN
    DECLARE msg VARCHAR(100);

    IF NEW.vname REGEXP '^[0-9]+$' THEN
        SET msg = 'Visitor name cannot contain only numeric characters';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `MaxVisitor` BEFORE INSERT ON `visitor` FOR EACH ROW BEGIN
     DECLARE number_of_visitor INTEGER;
     DECLARE msg varchar(100);
     SELECT count(noofvisitors) INTO number_of_visitor FROM visitor;
     IF number_of_visitor >= 9 THEN
     set msg ='It allows only less than or equal to 9 members to visit at any time';
     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = msg;
     END IF;
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bid`
--
ALTER TABLE `bid`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `bids`
--
ALTER TABLE `bids`
  ADD PRIMARY KEY (`bid_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `buyerregistration`
--
ALTER TABLE `buyerregistration`
  ADD PRIMARY KEY (`buyer_id`),
  ADD UNIQUE KEY `buyer_username` (`buyer_username`),
  ADD UNIQUE KEY `buyer_phone` (`buyer_phone`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indexes for table `farmerregistration`
--
ALTER TABLE `farmerregistration`
  ADD UNIQUE KEY `farmer_id` (`farmer_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `phonenumber` (`phonenumber`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `farmer_fk` (`farmer_fk`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bid`
--
ALTER TABLE `bid`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bids`
--
ALTER TABLE `bids`
  MODIFY `bid_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `buyerregistration`
--
ALTER TABLE `buyerregistration`
  MODIFY `buyer_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `farmerregistration`
--
ALTER TABLE `farmerregistration`
  MODIFY `farmer_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=100;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(100) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bids`
--
ALTER TABLE `bids`
  ADD CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `bid` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
