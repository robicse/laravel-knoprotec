-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 23, 2023 at 06:18 AM
-- Server version: 10.5.19-MariaDB-cll-lve-log
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `knoprotec_main`
--

-- --------------------------------------------------------

--
-- Table structure for table `address_book`
--

CREATE TABLE `address_book` (
  `address_book_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `entry_gender` char(1) DEFAULT NULL,
  `customers_id` int(11) DEFAULT NULL,
  `entry_company` varchar(191) DEFAULT NULL,
  `entry_firstname` varchar(191) NOT NULL,
  `entry_lastname` varchar(191) NOT NULL,
  `entry_street_address` varchar(191) NOT NULL,
  `entry_suburb` varchar(191) DEFAULT NULL,
  `entry_postcode` varchar(191) NOT NULL,
  `entry_city` varchar(191) NOT NULL,
  `entry_state` varchar(191) DEFAULT NULL,
  `entry_country_id` int(11) NOT NULL DEFAULT 0,
  `entry_zone_id` int(11) NOT NULL DEFAULT 0,
  `entry_latitude` varchar(100) DEFAULT NULL,
  `entry_longitude` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `address_book`
--

INSERT INTO `address_book` (`address_book_id`, `user_id`, `entry_gender`, `customers_id`, `entry_company`, `entry_firstname`, `entry_lastname`, `entry_street_address`, `entry_suburb`, `entry_postcode`, `entry_city`, `entry_state`, `entry_country_id`, `entry_zone_id`, `entry_latitude`, `entry_longitude`) VALUES
(18, 3, NULL, 3, NULL, 'bb', 'bbb', 'bb', NULL, '32432', 'dhaka', NULL, 18, -1, NULL, NULL),
(19, 3, NULL, 3, NULL, 'aladdin', 'ada', 'ad', NULL, '123', 'ada', NULL, 8, -1, NULL, NULL),
(21, 3, NULL, 3, NULL, 'asdf', 'fsdaf', 'fsda', NULL, '34213', 'dsaf', NULL, 18, -1, NULL, NULL),
(22, 3, NULL, 3, NULL, 'dsf', 'fdsaf', 'gfd', NULL, '5343', 'hghgfd', NULL, 7, -1, NULL, NULL),
(23, 3, NULL, 3, NULL, 'tyrt', 'tyt', 'tyert', NULL, '452', 'hgfhfd', NULL, 18, -1, NULL, NULL),
(24, 3, NULL, 3, NULL, 'rwq', 'wqe', 'ewrq', NULL, '3525', 'uyyt', NULL, 18, -1, NULL, NULL),
(26, 3, NULL, 3, NULL, 'add', 'addadd', 'add', NULL, 'add', 'add', 'add', 0, 0, NULL, NULL),
(27, 3, NULL, 3, NULL, 'add', 'addadd', 'add', NULL, 'add', 'add', 'add', 0, 0, NULL, NULL),
(31, 9, NULL, 9, NULL, 'Arafat', 'Zahan', '30/53 Shahibag', NULL, '13340', 'Savar', 'Dhaka', 18, 0, NULL, NULL),
(32, 9, NULL, 9, NULL, 'Arafat', 'Zahan', 'BBTOA Building', NULL, '1106', 'Kallyanpur', 'Dhaka', 18, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `alert_settings`
--

CREATE TABLE `alert_settings` (
  `alert_id` int(11) NOT NULL,
  `create_customer_email` tinyint(1) NOT NULL DEFAULT 0,
  `create_customer_notification` tinyint(1) NOT NULL DEFAULT 0,
  `order_status_email` tinyint(1) NOT NULL DEFAULT 0,
  `order_status_notification` tinyint(1) NOT NULL DEFAULT 0,
  `new_product_email` tinyint(1) NOT NULL DEFAULT 0,
  `new_product_notification` tinyint(1) NOT NULL DEFAULT 0,
  `forgot_email` tinyint(1) NOT NULL DEFAULT 0,
  `forgot_notification` tinyint(1) NOT NULL DEFAULT 0,
  `news_email` tinyint(1) NOT NULL DEFAULT 0,
  `news_notification` tinyint(1) NOT NULL DEFAULT 0,
  `contact_us_email` tinyint(1) NOT NULL DEFAULT 0,
  `contact_us_notification` tinyint(1) NOT NULL DEFAULT 0,
  `order_email` tinyint(1) NOT NULL DEFAULT 0,
  `order_notification` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `alert_settings`
--

INSERT INTO `alert_settings` (`alert_id`, `create_customer_email`, `create_customer_notification`, `order_status_email`, `order_status_notification`, `new_product_email`, `new_product_notification`, `forgot_email`, `forgot_notification`, `news_email`, `news_notification`, `contact_us_email`, `contact_us_notification`, `order_email`, `order_notification`) VALUES
(1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `api_calls_list`
--

CREATE TABLE `api_calls_list` (
  `id` int(11) NOT NULL,
  `nonce` text NOT NULL,
  `url` varchar(64) NOT NULL,
  `device_id` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `banners_id` int(11) NOT NULL,
  `banners_title` varchar(64) NOT NULL,
  `banners_url` varchar(191) NOT NULL,
  `banners_image` text NOT NULL,
  `banners_group` varchar(10) NOT NULL,
  `banners_html_text` text DEFAULT NULL,
  `expires_impressions` int(11) DEFAULT 0,
  `expires_date` datetime DEFAULT NULL,
  `date_scheduled` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `date_status_change` datetime DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `type` varchar(250) NOT NULL,
  `banners_slug` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`banners_id`, `banners_title`, `banners_url`, `banners_image`, `banners_group`, `banners_html_text`, `expires_impressions`, `expires_date`, `date_scheduled`, `date_added`, `date_status_change`, `status`, `type`, `banners_slug`, `created_at`, `updated_at`) VALUES
(1, 'Banner 1', '6', '9', '', NULL, 0, '2020-07-23 00:00:00', NULL, '2020-04-05 01:10:00', NULL, 1, 'category', '', '2019-09-23 04:53:34', NULL),
(2, 'Banner 2', '4', '11', '', NULL, 0, '2020-06-02 00:00:00', NULL, '2020-04-05 01:10:00', NULL, 1, 'category', '', '2019-09-23 04:53:58', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `banners_history`
--

CREATE TABLE `banners_history` (
  `banners_history_id` int(11) NOT NULL,
  `banners_id` int(11) NOT NULL,
  `banners_shown` int(11) NOT NULL DEFAULT 0,
  `banners_clicked` int(11) NOT NULL DEFAULT 0,
  `banners_history_date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `block_ips`
--

CREATE TABLE `block_ips` (
  `id` int(11) NOT NULL,
  `device_id` varchar(191) DEFAULT NULL,
  `ip` varchar(191) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `categories_id` int(11) NOT NULL,
  `categories_image` text DEFAULT NULL,
  `categories_icon` text NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `sort_order` int(11) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `categories_slug` varchar(191) NOT NULL,
  `categories_status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`categories_id`, `categories_image`, `categories_icon`, `parent_id`, `sort_order`, `date_added`, `last_modified`, `categories_slug`, `categories_status`, `created_at`, `updated_at`) VALUES
(1, '586', '257', 0, NULL, NULL, NULL, 'men-s', 1, '2019-09-19 02:08:12', '2020-08-10 10:32:02'),
(2, '587', '259', 0, NULL, NULL, NULL, 'women-s', 1, '2019-09-19 02:10:26', '2020-08-10 10:34:23'),
(3, '262', '261', 0, NULL, NULL, NULL, 'kid-s', 1, '2019-09-19 02:10:47', '2019-10-01 04:58:48'),
(4, '263', '264', 3, NULL, NULL, NULL, 'boy-s-clothing', 1, '2019-09-19 02:12:48', '2019-10-01 04:59:13'),
(5, '266', '265', 3, NULL, NULL, NULL, 'girl-s-clothing', 1, '2019-09-19 02:13:12', '2019-10-01 04:59:46'),
(6, '268', '267', 3, NULL, NULL, NULL, 'kid-s-shoes', 1, '2019-09-19 02:13:52', '2019-10-01 05:00:09'),
(7, '270', '269', 1, NULL, NULL, NULL, 'men-s-accessories', 1, '2019-09-19 02:18:22', '2019-10-01 05:00:34'),
(8, '272', '271', 1, NULL, NULL, NULL, 'men-s-jeans', 1, '2019-09-19 02:19:14', '2019-10-01 05:00:46'),
(9, '274', '273', 1, NULL, NULL, NULL, 'men-s-shirts', 1, '2019-09-19 02:20:19', '2019-10-01 05:01:17'),
(10, '276', '275', 1, NULL, NULL, NULL, 'men-s-shoes', 1, '2019-09-19 02:20:38', '2019-10-01 05:01:27'),
(11, '278', '277', 2, NULL, NULL, NULL, 'women-s-accessories', 1, '2019-09-19 02:30:13', '2019-10-01 05:01:57'),
(12, '279', '280', 2, NULL, NULL, NULL, 'women-s-bottoms', 1, '2019-09-19 02:30:45', '2019-10-01 05:02:10'),
(13, '282', '281', 2, NULL, NULL, NULL, 'women-s-tops', 1, '2019-09-19 02:31:30', '2019-10-01 05:02:39'),
(14, '284', '283', 2, NULL, NULL, NULL, 'women-s-winter-wear', 1, '2019-09-19 02:31:54', '2019-10-01 05:02:50'),
(15, '286', '285', 2, NULL, NULL, NULL, 'women-s-shoes', 1, '2019-09-19 02:32:17', '2019-10-01 05:03:12'),
(20, '605', '605', 0, NULL, NULL, NULL, 'covid-19-protection', 1, '2020-07-13 19:04:48', '2020-09-08 09:39:51'),
(21, '605', '542', 20, NULL, NULL, NULL, 'mask', 1, '2020-07-13 19:06:16', '2020-09-08 09:40:09'),
(29, '577', '577', 7, NULL, NULL, NULL, 'men-s-leather-wallet', 1, '2020-07-26 13:41:09', NULL),
(24, '557', '557', 1, NULL, NULL, NULL, 'punjabi', 1, '2020-07-22 13:01:55', '2020-07-22 13:28:24'),
(25, '561', '561', 7, NULL, NULL, NULL, 'men-s-belt', 1, '2020-07-22 13:32:54', NULL),
(26, '549', '549', 20, NULL, NULL, NULL, 'portable-oxygen-concentrator', 1, '2020-07-26 13:12:57', NULL),
(27, '545', '545', 20, NULL, NULL, NULL, 'ir-thermometer', 1, '2020-07-26 13:13:54', NULL),
(28, '547', '547', 20, NULL, NULL, NULL, 'pulse-oximeter', 1, '2020-07-26 13:14:45', '2020-07-26 13:28:01'),
(30, '588', '603', 0, NULL, NULL, NULL, 'electronics', 1, '2020-08-13 09:54:25', '2020-09-05 16:57:43'),
(31, '590', '604', 0, NULL, NULL, NULL, 'electromechanical', 1, '2020-08-13 09:57:26', '2020-09-05 05:11:38'),
(32, '589', '606', 0, NULL, NULL, NULL, 'interior-design', 1, '2020-08-13 09:59:59', '2020-09-08 09:48:29'),
(33, '592', '604', 31, NULL, NULL, NULL, 'generator', 1, '2020-08-19 08:33:16', '2020-09-05 05:12:32'),
(34, '616', '601', 0, NULL, NULL, NULL, 'mobile', 1, '2020-09-05 15:56:01', '2020-09-16 15:28:18'),
(35, '601', '601', 34, NULL, NULL, NULL, 'smartphone', 1, '2020-09-05 15:56:56', NULL),
(36, '601', '601', 34, NULL, NULL, NULL, 'feature-phones', 1, '2020-09-05 16:04:37', NULL),
(37, '602', '602', 34, NULL, NULL, NULL, 'mobile-accessories', 1, '2020-09-05 16:44:56', '2020-09-05 16:51:51'),
(38, '603', '603', 30, NULL, NULL, NULL, 'computer', 1, '2020-09-08 09:59:10', NULL),
(44, '613', '613', 31, NULL, NULL, NULL, 'lv-low-voltage', 1, '2020-09-14 13:21:24', NULL),
(42, '608', '608', 38, NULL, NULL, NULL, 'desktop', 1, '2020-09-08 10:42:12', NULL),
(41, '608', '608', 30, NULL, NULL, NULL, 'computer-accessories', 1, '2020-09-08 10:02:15', '2020-09-08 10:06:02'),
(43, '603', '603', 38, NULL, NULL, NULL, 'laptop', 1, '2020-09-08 10:43:46', '2020-09-14 13:11:55'),
(45, '615', '615', 44, NULL, NULL, NULL, 'switch-socket', 1, '2020-09-14 13:26:36', NULL),
(46, '614', '614', 44, NULL, NULL, NULL, 'circuit-breaker', 1, '2020-09-14 13:27:23', NULL),
(47, '622', '622', 2, NULL, NULL, NULL, 'shari', 1, '2020-09-16 15:34:59', NULL),
(50, '601', '601', 35, NULL, NULL, NULL, 'samsung', 1, '2020-10-11 13:10:22', NULL),
(60, '692', '692', 2, NULL, NULL, NULL, 'women-s-two-piece', 1, '2021-01-20 12:50:29', NULL),
(51, '601', '601', 36, NULL, NULL, NULL, 'samsung-1', 1, '2020-10-11 13:10:51', NULL),
(52, '612', '612', 31, NULL, NULL, NULL, 'radiator', 1, '2020-10-14 05:16:08', NULL),
(53, '680', '680', 7, NULL, NULL, NULL, 'backpack', 1, '2020-10-31 10:31:46', NULL),
(54, '681', '681', 3, NULL, NULL, NULL, 'kid-s-backpack', 1, '2020-10-31 10:32:34', NULL),
(55, '669', '680', 41, NULL, NULL, NULL, 'test', 1, '2020-11-09 09:54:40', '2020-11-09 10:32:17'),
(56, '692', '692', 2, NULL, NULL, NULL, 'ladies-kurti', 1, '2020-12-09 15:29:56', NULL),
(57, '692', '692', 2, NULL, NULL, NULL, 'ladies-shirt', 1, '2020-12-09 15:30:36', NULL),
(58, '692', '692', 2, NULL, NULL, NULL, 'ladies-dress', 1, '2020-12-09 15:41:36', NULL),
(59, '694', '694', 1, NULL, NULL, NULL, 'men-s-winter-wear', 1, '2020-12-09 15:47:31', '2020-12-09 15:48:00');

-- --------------------------------------------------------

--
-- Table structure for table `categories_description`
--

CREATE TABLE `categories_description` (
  `categories_description_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `categories_name` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories_description`
--

INSERT INTO `categories_description` (`categories_description_id`, `categories_id`, `language_id`, `categories_name`) VALUES
(1, 1, 1, 'Men\'s'),
(2, 2, 1, 'Women\'s'),
(3, 3, 1, 'Kid\'s'),
(4, 4, 1, 'Boy\'s Clothing'),
(5, 5, 1, 'Girl\'s Clothing'),
(6, 6, 1, 'Kid\'s Shoes'),
(7, 7, 1, 'Men\'s Accessories'),
(8, 8, 1, 'Men\'s Jeans'),
(9, 9, 1, 'Men\'s Shirts'),
(10, 10, 1, 'Men\'s Shoes'),
(11, 11, 1, 'Women\'s Accessories'),
(12, 12, 1, 'Women\'s Bottoms'),
(13, 13, 1, 'Women\'s Tops'),
(14, 14, 1, 'Women\'s Winter Wear'),
(15, 15, 1, 'Women\'s Shoes'),
(40, 20, 4, 'Covid-19 Protection'),
(17, 1, 4, 'ملك الرجال'),
(18, 2, 4, 'للنساء'),
(19, 3, 4, 'أطفال'),
(20, 4, 4, 'ملابس الصبي'),
(21, 5, 4, 'ملابس الفتاة'),
(22, 6, 4, 'أحذية الأطفال'),
(23, 7, 4, 'اكسسوارات رجالية'),
(24, 8, 4, 'جينز للرجال'),
(25, 9, 4, 'قمصان رجالية'),
(26, 10, 4, 'احذية رجالية'),
(27, 11, 4, 'اكسسوارات نسائية'),
(28, 12, 4, 'قيعان النساء'),
(29, 13, 4, 'قمم المرأة'),
(30, 14, 4, 'ملابس الشتاء للمرأة'),
(31, 15, 4, 'أحذية المرأة'),
(39, 20, 1, 'Covid-19 Protection'),
(41, 21, 1, 'Mask'),
(42, 21, 4, 'Mask'),
(58, 29, 4, 'Men\'s Leather Wallet'),
(57, 29, 1, 'Men\'s Leather Wallet'),
(48, 24, 4, 'Punjabi'),
(47, 24, 1, 'Men\'s Punjabi'),
(49, 25, 1, 'Men\'s Belt'),
(50, 25, 4, 'Men\'s Belt'),
(51, 26, 1, 'Portable Oxygen Concentrator'),
(52, 26, 4, 'a'),
(53, 27, 1, 'IR Thermometer'),
(54, 27, 4, 'IR'),
(55, 28, 1, 'Pulse Oximeter'),
(56, 28, 4, 'PO'),
(59, 30, 1, 'Electronics'),
(60, 30, 4, 'Electronics'),
(61, 31, 1, 'Electromechanical'),
(62, 31, 4, 'Electromechanical'),
(63, 32, 1, 'Interior Design'),
(64, 32, 4, 'Interior Design'),
(65, 33, 1, 'Generator'),
(66, 33, 4, 'Generator'),
(67, 34, 1, 'Mobile'),
(68, 34, 4, 'Mobile'),
(69, 35, 1, 'Smartphone'),
(70, 35, 4, 'Smartphone'),
(71, 36, 1, 'Feature-Phones'),
(72, 36, 4, 'Feature-Phones'),
(73, 37, 1, 'Mobile-Accessories'),
(74, 37, 4, 'Mobile-Accessories'),
(75, 38, 1, 'Computer'),
(76, 38, 4, 'Computer'),
(87, 44, 1, 'LV (Low Voltage)'),
(84, 42, 4, 'desktop'),
(83, 42, 1, 'Desktop'),
(81, 41, 1, 'Computer Accessories'),
(82, 41, 4, 'Computer Accessories'),
(85, 43, 1, 'Laptop'),
(86, 43, 4, 'Laptop'),
(88, 44, 4, 'LV (Low Voltage)'),
(89, 45, 1, 'Switch Socket'),
(90, 45, 4, 'Switch Socket'),
(91, 46, 1, 'Circuit Breaker'),
(92, 46, 4, 'Circuit Breaker'),
(93, 47, 1, 'Shari'),
(94, 47, 4, 'Shari'),
(115, 60, 1, 'Women\'s Two Piece'),
(99, 50, 1, 'Samsung'),
(100, 50, 4, 'Samsung'),
(101, 51, 1, 'Samsung'),
(102, 51, 4, 'Samsung'),
(103, 52, 1, 'Radiator'),
(104, 52, 4, 'Radiator'),
(105, 53, 1, 'Backpack'),
(106, 53, 4, 'Backpack'),
(107, 54, 1, 'Kid\'s  Backpack'),
(108, 54, 4, 'Kid\'s  Backpack'),
(109, 55, 1, 'test'),
(110, 55, 4, 'test'),
(111, 56, 1, 'Ladies Kurti'),
(112, 57, 1, 'Ladies Shirt'),
(113, 58, 1, 'Ladies Dress'),
(114, 59, 1, 'Men\'s Winter Wear');

-- --------------------------------------------------------

--
-- Table structure for table `categories_role`
--

CREATE TABLE `categories_role` (
  `categories_role_id` int(11) NOT NULL,
  `categories_ids` text NOT NULL,
  `admin_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `compare`
--

CREATE TABLE `compare` (
  `id` int(11) NOT NULL,
  `product_ids` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `compare`
--

INSERT INTO `compare` (`id`, `product_ids`, `customer_id`) VALUES
(1, 14, 4),
(2, 15, 4);

-- --------------------------------------------------------

--
-- Table structure for table `constant_banners`
--

CREATE TABLE `constant_banners` (
  `banners_id` int(11) NOT NULL,
  `banners_title` varchar(191) NOT NULL,
  `banners_url` text NOT NULL,
  `banners_image` text NOT NULL,
  `date_added` datetime NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `languages_id` int(11) NOT NULL,
  `type` varchar(55) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `constant_banners`
--

INSERT INTO `constant_banners` (`banners_id`, `banners_title`, `banners_url`, `banners_image`, `date_added`, `status`, `languages_id`, `type`) VALUES
(1, '1', '/shop', '14', '2020-04-01 15:01:56', 1, 1, '1'),
(2, '2', '/shop', '15', '2020-04-01 15:03:34', 1, 1, '2'),
(3, 'banner1', '/shop', '444', '2019-09-08 18:43:34', 1, 1, '3'),
(4, 'banner1', '/shop', '445', '2019-09-08 18:43:42', 1, 1, '4'),
(5, 'banner1', '/shop', '446', '2019-09-08 18:44:15', 1, 1, '5'),
(6, 'banner2_3_4', '/shop', '28', '2019-09-10 08:50:55', 1, 1, '6'),
(7, 'banner2_3_4', '/shop', '29', '2019-09-10 08:54:18', 1, 1, '7'),
(8, 'banner2_3_4', '/shop', '30', '2019-09-10 08:54:28', 1, 1, '8'),
(9, 'banner2_3_4', '/shop', '31', '2019-09-10 08:54:38', 1, 1, '9'),
(10, 'banner5_6', '/shop', '32', '2019-09-10 09:31:13', 1, 1, '10'),
(11, 'banner5_6', '/shop', '33', '2019-09-10 09:31:24', 1, 1, '11'),
(12, 'banner5_6', '/shop', '34', '2019-09-10 09:31:35', 1, 1, '12'),
(13, 'banner5_6', '/shop', '35', '2019-09-10 09:32:18', 1, 1, '13'),
(14, 'banner5_6', '/shop', '36', '2019-09-10 09:32:28', 1, 1, '14'),
(15, 'banner7_8', '/shop', '38', '2019-09-10 09:52:02', 1, 1, '15'),
(16, 'banner7_8', '/shop', '37', '2019-09-10 09:52:29', 1, 1, '16'),
(17, 'banner7_8', '/shop', '39', '2019-09-10 09:47:56', 1, 1, '17'),
(18, 'banner7_8', '/shop', '40', '2019-09-10 09:48:05', 1, 1, '18'),
(19, 'banner9', '/shop', '41', '2019-09-10 10:19:03', 1, 1, '19'),
(20, 'banner9', '/shop', '42', '2019-09-10 10:19:13', 1, 1, '20'),
(21, 'banner10_11_12', '/shop', '44', '2019-09-10 10:26:12', 1, 1, '21'),
(22, 'banner10_11_12', '/shop', '43', '2019-09-10 10:26:30', 1, 1, '22'),
(23, 'banner10_11_12', '/shop', '45', '2019-09-10 10:26:41', 1, 1, '23'),
(24, 'banner10_11_12', '/shop', '46', '2019-09-10 10:26:54', 1, 1, '24'),
(25, 'banner13_14_15', '/shop', '47', '2019-09-10 11:01:09', 1, 1, '25'),
(26, 'banner13_14_15', '/shop', '48', '2019-09-10 11:01:27', 1, 1, '26'),
(27, 'banner13_14_15', '/shop', '49', '2019-09-10 11:02:12', 1, 1, '27'),
(28, 'banner13_14_15', '/shop', '536', '2019-09-10 11:02:23', 1, 1, '28'),
(29, 'banner13_14_15', '/shop', '51', '2019-09-10 11:02:36', 1, 1, '29'),
(30, 'banner16_17', '/shop', '52', '2019-09-10 11:19:45', 1, 1, '30'),
(31, 'banner16_17', '/shop', '53', '2019-09-10 11:19:58', 1, 1, '31'),
(32, 'banner16_17', '/shop', '54', '2019-09-10 11:21:00', 1, 1, '32'),
(33, 'banner18_19', '/shop', '55', '2019-09-10 11:30:35', 1, 1, '33'),
(34, 'banner18_19', '/shop', '56', '2019-09-10 11:30:49', 1, 1, '34'),
(35, 'banner18_19', '/shop', '57', '2019-09-10 11:31:04', 1, 1, '35'),
(36, 'banner18_19', '/shop', '58', '2019-09-10 11:31:20', 1, 1, '36'),
(37, 'banner18_19', '/shop', '59', '2019-09-10 11:31:54', 1, 1, '37'),
(38, 'banner18_19', '/shop', '60', '2019-09-10 11:32:06', 1, 1, '38'),
(39, 'ad_banner1', '/shop', '13', '2019-09-11 06:17:45', 1, 1, '39'),
(40, 'ad_banner2', '/shop', '12', '2019-09-11 06:17:58', 1, 1, '40'),
(41, 'style0', '/shop', '484', '2019-09-26 08:09:15', 1, 4, '1'),
(42, 'style0', '/shop', '531', '2019-09-08 18:43:25', 1, 4, '2'),
(43, 'banner1', '/shop', '444', '2019-09-08 18:43:34', 1, 4, '3'),
(44, 'banner1', '/shop', '445', '2019-09-08 18:43:42', 1, 4, '4'),
(45, 'banner1', '/shop', '446', '2019-09-08 18:44:15', 1, 4, '5'),
(46, 'banner2_3_4', '/shop', '499', '2019-09-10 08:50:55', 1, 4, '6'),
(47, 'banner2_3_4', '/shop', '500', '2019-09-10 08:54:18', 1, 4, '7'),
(48, 'banner2_3_4', '/shop', '501', '2019-09-10 08:54:28', 1, 4, '8'),
(49, 'banner2_3_4', '/shop', '502', '2019-09-10 08:54:38', 1, 4, '9'),
(50, 'banner5_6', '/shop', '503', '2019-09-10 09:31:13', 1, 4, '10'),
(51, 'banner5_6', '/shop', '504', '2019-09-10 09:31:24', 1, 4, '11'),
(52, 'banner5_6', '/shop', '505', '2019-09-10 09:31:35', 1, 4, '12'),
(53, 'banner5_6', '/shop', '506', '2019-09-10 09:32:18', 1, 4, '13'),
(54, 'banner5_6', '/shop', '507', '2019-09-10 09:32:28', 1, 4, '14'),
(55, 'banner7_8', '/shop', '509', '2019-09-10 09:52:02', 1, 4, '15'),
(56, 'banner7_8', '/shop', '508', '2019-09-10 09:52:29', 1, 4, '16'),
(57, 'banner7_8', '/shop', '510', '2019-09-10 09:47:56', 1, 4, '17'),
(58, 'banner7_8', '/shop', '511', '2019-09-10 09:48:05', 1, 4, '18'),
(59, 'banner9', '/shop', '512', '2019-09-10 10:19:03', 1, 4, '19'),
(60, 'banner9', '/shop', '513', '2019-09-10 10:19:13', 1, 4, '20'),
(61, 'banner10_11_12', '/shop', '515', '2019-09-10 10:26:12', 1, 4, '21'),
(62, 'banner10_11_12', '/shop', '514', '2019-09-10 10:26:30', 1, 4, '22'),
(63, 'banner10_11_12', '/shop', '517', '2019-09-10 10:26:41', 1, 4, '23'),
(64, 'banner10_11_12', '/shop', '516', '2019-09-10 10:26:54', 1, 4, '24'),
(65, 'banner13_14_15', '/shop', '519', '2019-09-10 11:01:09', 1, 4, '25'),
(66, 'banner13_14_15', '/shop', '518', '2019-09-10 11:01:27', 1, 4, '26'),
(67, 'banner13_14_15', '/shop', '520', '2019-09-10 11:02:12', 1, 4, '27'),
(68, 'banner13_14_15', '/shop', '521', '2019-09-10 11:02:23', 1, 4, '28'),
(69, 'banner13_14_15', '/shop', '522', '2019-09-10 11:02:36', 1, 4, '29'),
(70, 'banner16_17', '/shop', '496', '2019-09-10 11:19:45', 1, 4, '30'),
(71, 'banner16_17', '/shop', '497', '2019-09-10 11:19:58', 1, 4, '31'),
(72, 'banner16_17', '/shop', '498', '2019-09-10 11:21:00', 1, 4, '32'),
(73, 'banner18_19', '/shop', '523', '2019-09-10 11:30:35', 1, 4, '33'),
(74, 'banner18_19', '/shop', '524', '2019-09-10 11:30:49', 1, 4, '34'),
(75, 'banner18_19', '/shop', '526', '2019-09-10 11:31:04', 1, 4, '35'),
(76, 'banner18_19', '/shop', '525', '2019-09-10 11:31:20', 1, 4, '36'),
(77, 'banner18_19', '/shop', '527', '2019-09-10 11:31:54', 1, 4, '37'),
(78, 'banner18_19', '/shop', '528', '2019-09-10 11:32:06', 1, 4, '38'),
(79, 'ad_banner1', '/shop', '530', '2019-09-11 06:17:45', 1, 4, '39'),
(80, 'ad_banner2', '/shop', '529', '2019-09-11 06:17:58', 1, 4, '40'),
(81, 'ad_banner3', '/shop', '12', '2020-02-26 02:10:11', 1, 1, '41'),
(82, 'ad_banner3', '/shop', '107', '2020-02-26 04:08:08', 1, 2, '41');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `countries_id` int(11) NOT NULL,
  `countries_name` varchar(191) NOT NULL,
  `countries_iso_code_2` char(2) NOT NULL,
  `countries_iso_code_3` char(3) NOT NULL,
  `address_format_id` int(11) NOT NULL,
  `country_code` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`countries_id`, `countries_name`, `countries_iso_code_2`, `countries_iso_code_3`, `address_format_id`, `country_code`) VALUES
(1, 'Afghanistan', 'AF', 'AFG', 1, NULL),
(2, 'Albania', 'AL', 'ALB', 1, NULL),
(3, 'Algeria', 'DZ', 'DZA', 1, NULL),
(4, 'American Samoa', 'AS', 'ASM', 1, NULL),
(5, 'Andorra', 'AD', 'AND', 1, NULL),
(6, 'Angola', 'AO', 'AGO', 1, NULL),
(7, 'Anguilla', 'AI', 'AIA', 1, NULL),
(8, 'Antarctica', 'AQ', 'ATA', 1, NULL),
(9, 'Antigua and Barbuda', 'AG', 'ATG', 1, NULL),
(10, 'Argentina', 'AR', 'ARG', 1, NULL),
(11, 'Armenia', 'AM', 'ARM', 1, NULL),
(12, 'Aruba', 'AW', 'ABW', 1, NULL),
(13, 'Australia', 'AU', 'AUS', 1, NULL),
(14, 'Austria', 'AT', 'AUT', 5, NULL),
(15, 'Azerbaijan', 'AZ', 'AZE', 1, NULL),
(16, 'Bahamas', 'BS', 'BHS', 1, NULL),
(17, 'Bahrain', 'BH', 'BHR', 1, NULL),
(18, 'Bangladesh', 'BD', 'BGD', 1, NULL),
(19, 'Barbados', 'BB', 'BRB', 1, NULL),
(20, 'Belarus', 'BY', 'BLR', 1, NULL),
(21, 'Belgium', 'BE', 'BEL', 1, NULL),
(22, 'Belize', 'BZ', 'BLZ', 1, NULL),
(23, 'Benin', 'BJ', 'BEN', 1, NULL),
(24, 'Bermuda', 'BM', 'BMU', 1, NULL),
(25, 'Bhutan', 'BT', 'BTN', 1, NULL),
(26, 'Bolivia', 'BO', 'BOL', 1, NULL),
(27, 'Bosnia and Herzegowina', 'BA', 'BIH', 1, NULL),
(28, 'Botswana', 'BW', 'BWA', 1, NULL),
(29, 'Bouvet Island', 'BV', 'BVT', 1, NULL),
(30, 'Brazil', 'BR', 'BRA', 1, NULL),
(31, 'British Indian Ocean Territory', 'IO', 'IOT', 1, NULL),
(32, 'Brunei Darussalam', 'BN', 'BRN', 1, NULL),
(33, 'Bulgaria', 'BG', 'BGR', 1, NULL),
(34, 'Burkina Faso', 'BF', 'BFA', 1, NULL),
(35, 'Burundi', 'BI', 'BDI', 1, NULL),
(36, 'Cambodia', 'KH', 'KHM', 1, NULL),
(37, 'Cameroon', 'CM', 'CMR', 1, NULL),
(38, 'Canada', 'CA', 'CAN', 1, NULL),
(39, 'Cape Verde', 'CV', 'CPV', 1, NULL),
(40, 'Cayman Islands', 'KY', 'CYM', 1, NULL),
(41, 'Central African Republic', 'CF', 'CAF', 1, NULL),
(42, 'Chad', 'TD', 'TCD', 1, NULL),
(43, 'Chile', 'CL', 'CHL', 1, NULL),
(44, 'China', 'CN', 'CHN', 1, NULL),
(45, 'Christmas Island', 'CX', 'CXR', 1, NULL),
(46, 'Cocos (Keeling) Islands', 'CC', 'CCK', 1, NULL),
(47, 'Colombia', 'CO', 'COL', 1, NULL),
(48, 'Comoros', 'KM', 'COM', 1, NULL),
(49, 'Congo', 'CG', 'COG', 1, NULL),
(50, 'Cook Islands', 'CK', 'COK', 1, NULL),
(51, 'Costa Rica', 'CR', 'CRI', 1, NULL),
(52, 'Cote D\'Ivoire', 'CI', 'CIV', 1, NULL),
(53, 'Croatia', 'HR', 'HRV', 1, NULL),
(54, 'Cuba', 'CU', 'CUB', 1, NULL),
(55, 'Cyprus', 'CY', 'CYP', 1, NULL),
(56, 'Czech Republic', 'CZ', 'CZE', 1, NULL),
(57, 'Denmark', 'DK', 'DNK', 1, NULL),
(58, 'Djibouti', 'DJ', 'DJI', 1, NULL),
(59, 'Dominica', 'DM', 'DMA', 1, NULL),
(60, 'Dominican Republic', 'DO', 'DOM', 1, NULL),
(61, 'East Timor', 'TP', 'TMP', 1, NULL),
(62, 'Ecuador', 'EC', 'ECU', 1, NULL),
(63, 'Egypt', 'EG', 'EGY', 1, NULL),
(64, 'El Salvador', 'SV', 'SLV', 1, NULL),
(65, 'Equatorial Guinea', 'GQ', 'GNQ', 1, NULL),
(66, 'Eritrea', 'ER', 'ERI', 1, NULL),
(67, 'Estonia', 'EE', 'EST', 1, NULL),
(68, 'Ethiopia', 'ET', 'ETH', 1, NULL),
(69, 'Falkland Islands (Malvinas)', 'FK', 'FLK', 1, NULL),
(70, 'Faroe Islands', 'FO', 'FRO', 1, NULL),
(71, 'Fiji', 'FJ', 'FJI', 1, NULL),
(72, 'Finland', 'FI', 'FIN', 1, NULL),
(73, 'France', 'FR', 'FRA', 1, NULL),
(74, 'France, Metropolitan', 'FX', 'FXX', 1, NULL),
(75, 'French Guiana', 'GF', 'GUF', 1, NULL),
(76, 'French Polynesia', 'PF', 'PYF', 1, NULL),
(77, 'French Southern Territories', 'TF', 'ATF', 1, NULL),
(78, 'Gabon', 'GA', 'GAB', 1, NULL),
(79, 'Gambia', 'GM', 'GMB', 1, NULL),
(80, 'Georgia', 'GE', 'GEO', 1, NULL),
(81, 'Germany', 'DE', 'DEU', 5, NULL),
(82, 'Ghana', 'GH', 'GHA', 1, NULL),
(83, 'Gibraltar', 'GI', 'GIB', 1, NULL),
(84, 'Greece', 'GR', 'GRC', 1, NULL),
(85, 'Greenland', 'GL', 'GRL', 1, NULL),
(86, 'Grenada', 'GD', 'GRD', 1, NULL),
(87, 'Guadeloupe', 'GP', 'GLP', 1, NULL),
(88, 'Guam', 'GU', 'GUM', 1, NULL),
(89, 'Guatemala', 'GT', 'GTM', 1, NULL),
(90, 'Guinea', 'GN', 'GIN', 1, NULL),
(91, 'Guinea-bissau', 'GW', 'GNB', 1, NULL),
(92, 'Guyana', 'GY', 'GUY', 1, NULL),
(93, 'Haiti', 'HT', 'HTI', 1, NULL),
(94, 'Heard and Mc Donald Islands', 'HM', 'HMD', 1, NULL),
(95, 'Honduras', 'HN', 'HND', 1, NULL),
(96, 'Hong Kong', 'HK', 'HKG', 1, NULL),
(97, 'Hungary', 'HU', 'HUN', 1, NULL),
(98, 'Iceland', 'IS', 'ISL', 1, NULL),
(99, 'India', 'IN', 'IND', 1, NULL),
(100, 'Indonesia', 'ID', 'IDN', 1, NULL),
(101, 'Iran (Islamic Republic of)', 'IR', 'IRN', 1, NULL),
(102, 'Iraq', 'IQ', 'IRQ', 1, NULL),
(103, 'Ireland', 'IE', 'IRL', 1, NULL),
(104, 'Israel', 'IL', 'ISR', 1, NULL),
(105, 'Italy', 'IT', 'ITA', 1, NULL),
(106, 'Jamaica', 'JM', 'JAM', 1, NULL),
(107, 'Japan', 'JP', 'JPN', 1, NULL),
(108, 'Jordan', 'JO', 'JOR', 1, NULL),
(109, 'Kazakhstan', 'KZ', 'KAZ', 1, NULL),
(110, 'Kenya', 'KE', 'KEN', 1, NULL),
(111, 'Kiribati', 'KI', 'KIR', 1, NULL),
(112, 'Korea, Democratic People\'s Republic of', 'KP', 'PRK', 1, NULL),
(113, 'Korea, Republic of', 'KR', 'KOR', 1, NULL),
(114, 'Kuwait', 'KW', 'KWT', 1, NULL),
(115, 'Kyrgyzstan', 'KG', 'KGZ', 1, NULL),
(116, 'Lao People\'s Democratic Republic', 'LA', 'LAO', 1, NULL),
(117, 'Latvia', 'LV', 'LVA', 1, NULL),
(118, 'Lebanon', 'LB', 'LBN', 1, NULL),
(119, 'Lesotho', 'LS', 'LSO', 1, NULL),
(120, 'Liberia', 'LR', 'LBR', 1, NULL),
(121, 'Libyan Arab Jamahiriya', 'LY', 'LBY', 1, NULL),
(122, 'Liechtenstein', 'LI', 'LIE', 1, NULL),
(123, 'Lithuania', 'LT', 'LTU', 1, NULL),
(124, 'Luxembourg', 'LU', 'LUX', 1, NULL),
(125, 'Macau', 'MO', 'MAC', 1, NULL),
(126, 'Macedonia, The Former Yugoslav Republic of', 'MK', 'MKD', 1, NULL),
(127, 'Madagascar', 'MG', 'MDG', 1, NULL),
(128, 'Malawi', 'MW', 'MWI', 1, NULL),
(129, 'Malaysia', 'MY', 'MYS', 1, NULL),
(130, 'Maldives', 'MV', 'MDV', 1, NULL),
(131, 'Mali', 'ML', 'MLI', 1, NULL),
(132, 'Malta', 'MT', 'MLT', 1, NULL),
(133, 'Marshall Islands', 'MH', 'MHL', 1, NULL),
(134, 'Martinique', 'MQ', 'MTQ', 1, NULL),
(135, 'Mauritania', 'MR', 'MRT', 1, NULL),
(136, 'Mauritius', 'MU', 'MUS', 1, NULL),
(137, 'Mayotte', 'YT', 'MYT', 1, NULL),
(138, 'Mexico', 'MX', 'MEX', 1, NULL),
(139, 'Micronesia, Federated States of', 'FM', 'FSM', 1, NULL),
(140, 'Moldova, Republic of', 'MD', 'MDA', 1, NULL),
(141, 'Monaco', 'MC', 'MCO', 1, NULL),
(142, 'Mongolia', 'MN', 'MNG', 1, NULL),
(143, 'Montserrat', 'MS', 'MSR', 1, NULL),
(144, 'Morocco', 'MA', 'MAR', 1, NULL),
(145, 'Mozambique', 'MZ', 'MOZ', 1, NULL),
(146, 'Myanmar', 'MM', 'MMR', 1, NULL),
(147, 'Namibia', 'NA', 'NAM', 1, NULL),
(148, 'Nauru', 'NR', 'NRU', 1, NULL),
(149, 'Nepal', 'NP', 'NPL', 1, NULL),
(150, 'Netherlands', 'NL', 'NLD', 1, NULL),
(151, 'Netherlands Antilles', 'AN', 'ANT', 1, NULL),
(152, 'New Caledonia', 'NC', 'NCL', 1, NULL),
(153, 'New Zealand', 'NZ', 'NZL', 1, NULL),
(154, 'Nicaragua', 'NI', 'NIC', 1, NULL),
(155, 'Niger', 'NE', 'NER', 1, NULL),
(156, 'Nigeria', 'NG', 'NGA', 1, NULL),
(157, 'Niue', 'NU', 'NIU', 1, NULL),
(158, 'Norfolk Island', 'NF', 'NFK', 1, NULL),
(159, 'Northern Mariana Islands', 'MP', 'MNP', 1, NULL),
(160, 'Norway', 'NO', 'NOR', 1, NULL),
(161, 'Oman', 'OM', 'OMN', 1, NULL),
(162, 'Pakistan', 'PK', 'PAK', 1, NULL),
(163, 'Palau', 'PW', 'PLW', 1, NULL),
(164, 'Panama', 'PA', 'PAN', 1, NULL),
(165, 'Papua New Guinea', 'PG', 'PNG', 1, NULL),
(166, 'Paraguay', 'PY', 'PRY', 1, NULL),
(167, 'Peru', 'PE', 'PER', 1, NULL),
(168, 'Philippines', 'PH', 'PHL', 1, NULL),
(169, 'Pitcairn', 'PN', 'PCN', 1, NULL),
(170, 'Poland', 'PL', 'POL', 1, NULL),
(171, 'Portugal', 'PT', 'PRT', 1, NULL),
(172, 'Puerto Rico', 'PR', 'PRI', 1, NULL),
(173, 'Qatar', 'QA', 'QAT', 1, NULL),
(174, 'Reunion', 'RE', 'REU', 1, NULL),
(175, 'Romania', 'RO', 'ROM', 1, NULL),
(176, 'Russian Federation', 'RU', 'RUS', 1, NULL),
(177, 'Rwanda', 'RW', 'RWA', 1, NULL),
(178, 'Saint Kitts and Nevis', 'KN', 'KNA', 1, NULL),
(179, 'Saint Lucia', 'LC', 'LCA', 1, NULL),
(180, 'Saint Vincent and the Grenadines', 'VC', 'VCT', 1, NULL),
(181, 'Samoa', 'WS', 'WSM', 1, NULL),
(182, 'San Marino', 'SM', 'SMR', 1, NULL),
(183, 'Sao Tome and Principe', 'ST', 'STP', 1, NULL),
(184, 'Saudi Arabia', 'SA', 'SAU', 1, NULL),
(185, 'Senegal', 'SN', 'SEN', 1, NULL),
(186, 'Seychelles', 'SC', 'SYC', 1, NULL),
(187, 'Sierra Leone', 'SL', 'SLE', 1, NULL),
(188, 'Singapore', 'SG', 'SGP', 4, NULL),
(189, 'Slovakia (Slovak Republic)', 'SK', 'SVK', 1, NULL),
(190, 'Slovenia', 'SI', 'SVN', 1, NULL),
(191, 'Solomon Islands', 'SB', 'SLB', 1, NULL),
(192, 'Somalia', 'SO', 'SOM', 1, NULL),
(193, 'South Africa', 'ZA', 'ZAF', 1, NULL),
(194, 'South Georgia and the South Sandwich Islands', 'GS', 'SGS', 1, NULL),
(195, 'Spain', 'ES', 'ESP', 3, NULL),
(196, 'Sri Lanka', 'LK', 'LKA', 1, NULL),
(197, 'St. Helena', 'SH', 'SHN', 1, NULL),
(198, 'St. Pierre and Miquelon', 'PM', 'SPM', 1, NULL),
(199, 'Sudan', 'SD', 'SDN', 1, NULL),
(200, 'Suriname', 'SR', 'SUR', 1, NULL),
(201, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM', 1, NULL),
(202, 'Swaziland', 'SZ', 'SWZ', 1, NULL),
(203, 'Sweden', 'SE', 'SWE', 1, NULL),
(204, 'Switzerland', 'CH', 'CHE', 1, NULL),
(205, 'Syrian Arab Republic', 'SY', 'SYR', 1, NULL),
(206, 'Taiwan', 'TW', 'TWN', 1, NULL),
(207, 'Tajikistan', 'TJ', 'TJK', 1, NULL),
(208, 'Tanzania, United Republic of', 'TZ', 'TZA', 1, NULL),
(209, 'Thailand', 'TH', 'THA', 1, NULL),
(210, 'Togo', 'TG', 'TGO', 1, NULL),
(211, 'Tokelau', 'TK', 'TKL', 1, NULL),
(212, 'Tonga', 'TO', 'TON', 1, NULL),
(213, 'Trinidad and Tobago', 'TT', 'TTO', 1, NULL),
(214, 'Tunisia', 'TN', 'TUN', 1, NULL),
(215, 'Turkey', 'TR', 'TUR', 1, NULL),
(216, 'Turkmenistan', 'TM', 'TKM', 1, NULL),
(217, 'Turks and Caicos Islands', 'TC', 'TCA', 1, NULL),
(218, 'Tuvalu', 'TV', 'TUV', 1, NULL),
(219, 'Uganda', 'UG', 'UGA', 1, NULL),
(220, 'Ukraine', 'UA', 'UKR', 1, NULL),
(221, 'United Arab Emirates', 'AE', 'ARE', 1, NULL),
(222, 'United Kingdom', 'GB', 'GBR', 1, NULL),
(223, 'United States', 'US', 'USA', 2, NULL),
(224, 'United States Minor Outlying Islands', 'UM', 'UMI', 1, NULL),
(225, 'Uruguay', 'UY', 'URY', 1, NULL),
(226, 'Uzbekistan', 'UZ', 'UZB', 1, NULL),
(227, 'Vanuatu', 'VU', 'VUT', 1, NULL),
(228, 'Vatican City State (Holy See)', 'VA', 'VAT', 1, NULL),
(229, 'Venezuela', 'VE', 'VEN', 1, NULL),
(230, 'Viet Nam', 'VN', 'VNM', 1, NULL),
(231, 'Virgin Islands (British)', 'VG', 'VGB', 1, NULL),
(232, 'Virgin Islands (U.S.)', 'VI', 'VIR', 1, NULL),
(233, 'Wallis and Futuna Islands', 'WF', 'WLF', 1, NULL),
(234, 'Western Sahara', 'EH', 'ESH', 1, NULL),
(235, 'Yemen', 'YE', 'YEM', 1, NULL),
(236, 'Yugoslavia', 'YU', 'YUG', 1, NULL),
(237, 'Zaire', 'ZR', 'ZAR', 1, NULL),
(238, 'Zambia', 'ZM', 'ZMB', 1, NULL),
(239, 'Zimbabwe', 'ZW', 'ZWE', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `coupans_id` int(11) NOT NULL,
  `code` varchar(191) NOT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `description` text DEFAULT NULL,
  `discount_type` varchar(100) NOT NULL COMMENT 'Options: fixed_cart, percent, fixed_product and percent_product. Default: fixed_cart.',
  `amount` int(11) NOT NULL,
  `expiry_date` datetime NOT NULL,
  `usage_count` int(11) NOT NULL,
  `individual_use` tinyint(1) NOT NULL DEFAULT 0,
  `product_ids` varchar(191) NOT NULL,
  `exclude_product_ids` varchar(191) NOT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `usage_limit_per_user` int(11) DEFAULT NULL,
  `limit_usage_to_x_items` int(11) NOT NULL,
  `free_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `product_categories` varchar(191) NOT NULL,
  `excluded_product_categories` varchar(191) NOT NULL,
  `exclude_sale_items` tinyint(1) NOT NULL DEFAULT 0,
  `minimum_amount` decimal(10,2) NOT NULL,
  `maximum_amount` decimal(10,2) NOT NULL,
  `email_restrictions` text NOT NULL,
  `used_by` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`coupans_id`, `code`, `date_created`, `date_modified`, `description`, `discount_type`, `amount`, `expiry_date`, `usage_count`, `individual_use`, `product_ids`, `exclude_product_ids`, `usage_limit`, `usage_limit_per_user`, `limit_usage_to_x_items`, `free_shipping`, `product_categories`, `excluded_product_categories`, `exclude_sale_items`, `minimum_amount`, `maximum_amount`, `email_restrictions`, `used_by`, `created_at`, `updated_at`) VALUES
(1, 'Sample Coupon Cart Discount', NULL, NULL, NULL, 'fixed_cart', 10, '2021-08-31 00:00:00', 0, 0, '', '', NULL, NULL, 0, 0, '', '', 0, '30.00', '1000.00', '', ',11', '2019-09-18 02:27:34', '2019-09-24 06:48:00'),
(2, 'Sample Coupon Cart Percent Discount', NULL, NULL, NULL, 'percent', 10, '1970-01-01 00:00:00', 0, 0, '', '', 10, 5, 0, 0, '', '', 0, '20.00', '1000.00', '', ',10', '2019-09-18 02:28:36', '2019-09-18 02:33:03'),
(3, 'Sample Coupon Product Discount', NULL, NULL, NULL, 'fixed_product', 20, '2022-05-31 00:00:00', 0, 0, '', '', NULL, NULL, 0, 0, '', '', 0, '20.00', '1000.00', '', ',9', '2019-09-18 02:29:37', NULL),
(4, 'Sample Coupon Product Percent Discount', NULL, NULL, NULL, 'percent_product', 10, '2021-11-30 00:00:00', 0, 1, '', '', NULL, NULL, 0, 0, '', '', 0, '30.00', '1000.00', '', '', '2019-09-18 02:32:02', '2019-09-24 06:48:24'),
(6, 'POWERtrac B20', NULL, NULL, NULL, 'fixed_cart', 120, '2020-12-31 00:00:00', 0, 0, '106', '', NULL, 2, 0, 0, '59', '', 1, '0.00', '0.00', '', '', '2020-12-10 17:33:54', '2020-12-10 17:36:01');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(11) NOT NULL,
  `title` varchar(32) NOT NULL,
  `code` char(3) NOT NULL,
  `symbol_left` varchar(12) DEFAULT NULL,
  `symbol_right` varchar(12) DEFAULT NULL,
  `decimal_point` char(1) DEFAULT NULL,
  `thousands_point` char(1) DEFAULT NULL,
  `decimal_places` char(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `value` double(13,8) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `is_current` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `title`, `code`, `symbol_left`, `symbol_right`, `decimal_point`, `thousands_point`, `decimal_places`, `created_at`, `updated_at`, `value`, `is_default`, `status`, `is_current`) VALUES
(1, 'USD', 'USD', '৳', '', NULL, NULL, '2', '2020-07-13 02:46:41', '2020-07-13 02:46:41', 1.00000000, 1, 1, 1),
(9, 'AED', 'AED', '', 'د.إ', NULL, NULL, '2', '2019-10-01 06:53:40', '2019-10-01 06:53:40', 3.60000000, 0, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `currency_record`
--

CREATE TABLE `currency_record` (
  `id` int(11) NOT NULL,
  `code` varchar(191) NOT NULL,
  `currency_name` varchar(191) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currency_record`
--

INSERT INTO `currency_record` (`id`, `code`, `currency_name`) VALUES
(1, 'AED', 'United Arab Emirates Dirham'),
(2, 'AFN', 'Afghan Afghani'),
(3, 'ALL', 'Albanian Lek'),
(4, 'AMD', 'Armenian Dram'),
(5, 'ANG', 'Netherlands Antillean Guilder'),
(6, 'AOA', 'Angolan Kwanza'),
(7, 'ARS', 'Argentine Peso'),
(8, 'AUD', 'Australian Dollar'),
(9, 'AWG', 'Aruban Florin'),
(10, 'AZN', 'Azerbaijani Manat'),
(11, 'BAM', 'Bosnia-Herzegovina Convertible Mark'),
(12, 'BBD', 'Barbadian Dollar'),
(13, 'BDT', 'Bangladeshi Taka'),
(14, 'BGN', 'Bulgarian Lev'),
(15, 'BHD', 'Bahraini Dinar'),
(16, 'BIF', 'Burundian Franc'),
(17, 'BMD', 'Bermudan Dollar'),
(18, 'BND', 'Brunei Dollar'),
(19, 'BOB', 'Bolivian Boliviano'),
(20, 'BRL', 'Brazilian Real'),
(21, 'BSD', 'Bahamian Dollar'),
(22, 'BTC', 'Bitcoin'),
(23, 'BTN', 'Bhutanese Ngultrum'),
(24, 'BWP', 'Botswanan Pula'),
(25, 'BYN', 'Belarusian Ruble'),
(26, 'BZD', 'Belize Dollar'),
(27, 'CAD', 'Canadian Dollar'),
(28, 'CDF', 'Congolese Franc'),
(29, 'CHF', 'Swiss Franc'),
(30, 'CLF', 'Chilean Unit of Account (UF)'),
(31, 'CLP', 'Chilean Peso'),
(32, 'CNH', 'Chinese Yuan (Offshore)'),
(33, 'CNY', 'Chinese Yuan'),
(34, 'COP', 'Colombian Peso'),
(35, 'CRC', 'Costa Rican Colón'),
(36, 'CUC', 'Cuban Convertible Peso'),
(37, 'CUP', 'Cuban Peso'),
(38, 'CVE', 'Cape Verdean Escudo'),
(39, 'CZK', 'Czech Republic Koruna'),
(40, 'DJF', 'Djiboutian Franc'),
(41, 'DKK', 'Danish Krone'),
(42, 'DOP', 'Dominican Peso'),
(43, 'DZD', 'Algerian Dinar'),
(44, 'EGP', 'Egyptian Pound'),
(45, 'ERN', 'Eritrean Nakfa'),
(46, 'ETB', 'Ethiopian Birr'),
(47, 'EUR', 'Euro'),
(48, 'FJD', 'Fijian Dollar'),
(49, 'FKP', 'Falkland Islands Pound'),
(50, 'GBP', 'British Pound Sterling'),
(51, 'GEL', 'Georgian Lari'),
(52, 'GGP', 'Guernsey Pound'),
(53, 'GHS', 'Ghanaian Cedi'),
(54, 'GIP', 'Gibraltar Pound'),
(55, 'GMD', 'Gambian Dalasi'),
(56, 'GNF', 'Guinean Franc'),
(57, 'GTQ', 'Guatemalan Quetzal'),
(58, 'GYD', 'Guyanaese Dollar'),
(59, 'HKD', 'Hong Kong Dollar'),
(60, 'HNL', 'Honduran Lempira'),
(61, 'HRK', 'Croatian Kuna'),
(62, 'HTG', 'Haitian Gourde'),
(63, 'HUF', 'Hungarian Forint'),
(64, 'IDR', 'Indonesian Rupiah'),
(65, 'ILS', 'Israeli New Sheqel'),
(66, 'IMP', 'Manx pound'),
(67, 'INR', 'Indian Rupee'),
(68, 'IQD', 'Iraqi Dinar'),
(69, 'IRR', 'Iranian Rial'),
(70, 'ISK', 'Icelandic Króna'),
(71, 'JEP', 'Jersey Pound'),
(72, 'JMD', 'Jamaican Dollar'),
(73, 'JOD', 'Jordanian Dinar'),
(74, 'JPY', 'Japanese Yen'),
(75, 'KES', 'Kenyan Shilling'),
(76, 'KGS', 'Kyrgystani Som'),
(77, 'KHR', 'Cambodian Riel'),
(78, 'KMF', 'Comorian Franc'),
(79, 'KPW', 'North Korean Won'),
(80, 'KRW', 'South Korean Won'),
(81, 'KWD', 'Kuwaiti Dinar'),
(82, 'KYD', 'Cayman Islands Dollar'),
(83, 'KZT', 'Kazakhstani Tenge'),
(84, 'LAK', 'Laotian Kip'),
(85, 'LBP', 'Lebanese Pound'),
(86, 'LKR', 'Sri Lankan Rupee'),
(87, 'LRD', 'Liberian Dollar'),
(88, 'LSL', 'Lesotho Loti'),
(89, 'LYD', 'Libyan Dinar'),
(90, 'MAD', 'Moroccan Dirham'),
(91, 'MDL', 'Moldovan Leu'),
(92, 'MGA', 'Malagasy Ariary'),
(93, 'MKD', 'Macedonian Denar'),
(94, 'MMK', 'Myanma Kyat'),
(95, 'MNT', 'Mongolian Tugrik'),
(96, 'MOP', 'Macanese Pataca'),
(97, 'MRO', 'Mauritanian Ouguiya (pre-2018)'),
(98, 'MRU', 'Mauritanian Ouguiya'),
(99, 'MUR', 'Mauritian Rupee'),
(100, 'MVR', 'Maldivian Rufiyaa'),
(101, 'MWK', 'Malawian Kwacha'),
(102, 'MXN', 'Mexican Peso'),
(103, 'MYR', 'Malaysian Ringgit'),
(104, 'MZN', 'Mozambican Metical'),
(105, 'NAD', 'Namibian Dollar'),
(106, 'NGN', 'Nigerian Naira'),
(107, 'NIO', 'Nicaraguan Córdoba'),
(108, 'NOK', 'Norwegian Krone'),
(109, 'NPR', 'Nepalese Rupee'),
(110, 'NZD', 'New Zealand Dollar'),
(111, 'OMR', 'Omani Rial'),
(112, 'PAB', 'Panamanian Balboa'),
(113, 'PEN', 'Peruvian Nuevo Sol'),
(114, 'PGK', 'Papua New Guinean Kina'),
(115, 'PHP', 'Philippine Peso'),
(116, 'PKR', 'Pakistani Rupee'),
(117, 'PLN', 'Polish Zloty'),
(118, 'PYG', 'Paraguayan Guarani'),
(119, 'QAR', 'Qatari Rial'),
(120, 'RON', 'Romanian Leu'),
(121, 'RSD', 'Serbian Dinar'),
(122, 'RUB', 'Russian Ruble'),
(123, 'RWF', 'Rwandan Franc'),
(124, 'SAR', 'Saudi Riyal'),
(125, 'SBD', 'Solomon Islands Dollar'),
(126, 'SCR', 'Seychellois Rupee'),
(127, 'SDG', 'Sudanese Pound'),
(128, 'SEK', 'Swedish Krona'),
(129, 'SGD', 'Singapore Dollar'),
(130, 'SHP', 'Saint Helena Pound'),
(131, 'SLL', 'Sierra Leonean Leone'),
(132, 'SOS', 'Somali Shilling'),
(133, 'SRD', 'Surinamese Dollar'),
(134, 'SSP', 'South Sudanese Pound'),
(135, 'STD', 'São Tomé and Príncipe Dobra (pre-2018)'),
(136, 'STN', 'São Tomé and Príncipe Dobra'),
(137, 'SVC', 'Salvadoran Colón'),
(138, 'SYP', 'Syrian Pound'),
(139, 'SZL', 'Swazi Lilangeni'),
(140, 'THB', 'Thai Baht'),
(141, 'TJS', 'Tajikistani Somoni'),
(142, 'TMT', 'Turkmenistani Manat'),
(143, 'TND', 'Tunisian Dinar'),
(144, 'TOP', 'Tongan Pa\'anga'),
(145, 'TRY', 'Turkish Lira'),
(146, 'TTD', 'Trinidad and Tobago Dollar'),
(147, 'TWD', 'New Taiwan Dollar'),
(148, 'TZS', 'Tanzanian Shilling'),
(149, 'UAH', 'Ukrainian Hryvnia'),
(150, 'UGX', 'Ugandan Shilling'),
(151, 'USD', 'United States Dollar'),
(152, 'UYU', 'Uruguayan Peso'),
(153, 'UZS', 'Uzbekistan Som'),
(154, 'VEF', 'Venezuelan Bolívar Fuerte'),
(155, 'VND', 'Vietnamese Dong'),
(156, 'VUV', 'Vanuatu Vatu'),
(157, 'WST', 'Samoan Tala'),
(158, 'XAF', 'CFA Franc BEAC'),
(159, 'XAG', 'Silver Ounce'),
(160, 'XAU', 'Gold Ounce'),
(161, 'XCD', 'East Caribbean Dollar'),
(162, 'XDR', 'Special Drawing Rights'),
(163, 'XOF', 'CFA Franc BCEAO'),
(164, 'XPD', 'Palladium Ounce'),
(165, 'XPF', 'CFP Franc'),
(166, 'XPT', 'Platinum Ounce'),
(167, 'YER', 'Yemeni Rial'),
(168, 'ZAR', 'South African Rand'),
(169, 'ZMW', 'Zambian Kwacha'),
(170, 'ZWL', 'Zimbabwean Dollar');

-- --------------------------------------------------------

--
-- Table structure for table `current_theme`
--

CREATE TABLE `current_theme` (
  `id` int(11) NOT NULL,
  `header` int(11) NOT NULL,
  `carousel` int(11) NOT NULL,
  `banner` int(11) NOT NULL,
  `footer` int(11) NOT NULL,
  `product_section_order` text NOT NULL,
  `cart` int(11) NOT NULL,
  `news` int(11) NOT NULL,
  `detail` int(11) NOT NULL,
  `shop` int(11) NOT NULL,
  `contact` int(11) NOT NULL,
  `top_offer` int(11) NOT NULL DEFAULT 1,
  `login` int(11) NOT NULL DEFAULT 1,
  `transitions` int(11) NOT NULL,
  `banner_two` int(11) NOT NULL,
  `customers_id` varchar(255) NOT NULL,
  `session_id` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `current_theme`
--

INSERT INTO `current_theme` (`id`, `header`, `carousel`, `banner`, `footer`, `product_section_order`, `cart`, `news`, `detail`, `shop`, `contact`, `top_offer`, `login`, `transitions`, `banner_two`, `customers_id`, `session_id`) VALUES
(1, 9, 4, 1, 5, '[{\"id\":11,\"name\":\"Tab Products View\",\"order\":1,\"file_name\":\"tab\",\"status\":1,\"image\":\"images\\/prototypes\\/tab.jpg\",\"disabled_image\":\"images\\/prototypes\\/tab-cross.jpg\",\"alt\":\"Tab Products View\"},{\"id\":1,\"name\":\"Banner Section\",\"order\":2,\"file_name\":\"banner_section\",\"status\":1,\"image\":\"images\\/prototypes\\/banner_section.jpg\",\"alt\":\"Banner Section\"},{\"id\":5,\"name\":\"Categories\",\"order\":3,\"file_name\":\"categories\",\"status\":1,\"image\":\"images\\/prototypes\\/categories.jpg\",\"disabled_image\":\"images\\/prototypes\\/categories-cross.jpg\",\"alt\":\"Categories\"},{\"id\":2,\"name\":\"Flash Sale Section\",\"order\":4,\"file_name\":\"flash_sale_section\",\"status\":0,\"image\":\"images\\/prototypes\\/flash_sale_section.jpg\",\"disabled_image\":\"images\\/prototypes\\/flash_sale_section-cross.jpg\",\"alt\":\"Flash Sale Section\"},{\"id\":10,\"name\":\"Second Ad Section\",\"order\":5,\"file_name\":\"sec_ad_banner\",\"status\":0,\"image\":\"images\\/prototypes\\/sec_ad_section.jpg\",\"disabled_image\":\"images\\/prototypes\\/sec_ad_section-cross.jpg\",\"alt\":\"Second Ad Section\"},{\"id\":9,\"name\":\"Top Selling\",\"order\":6,\"file_name\":\"top\",\"status\":0,\"image\":\"images\\/prototypes\\/top.jpg\",\"disabled_image\":\"images\\/prototypes\\/top-cross.jpg\",\"alt\":\"Top Selling\"},{\"id\":4,\"name\":\"Ad Section\",\"order\":7,\"file_name\":\"ad_banner_section\",\"status\":1,\"image\":\"images\\/prototypes\\/ad_banner_section.jpg\",\"disabled_image\":\"images\\/prototypes\\/ad_banner_section-cross.jpg\",\"alt\":\"Ad Section\"},{\"id\":3,\"name\":\"Special Products Section\",\"order\":8,\"file_name\":\"special\",\"status\":0,\"image\":\"images\\/prototypes\\/special_product.jpg\",\"disabled_image\":\"images\\/prototypes\\/special_product-cross.jpg\",\"alt\":\"Special Products Section\"},{\"id\":8,\"name\":\"Newest Product Section\",\"order\":9,\"file_name\":\"newest_product\",\"status\":1,\"image\":\"images\\/prototypes\\/newest_product.jpg\",\"disabled_image\":\"images\\/prototypes\\/newest_product-cross.jpg\",\"alt\":\"Newest Product Section\"},{\"id\":12,\"name\":\"Banner 2 Section\",\"order\":10,\"file_name\":\"banner_two_section\",\"status\":0,\"image\":\"images\\/prototypes\\/sec_ad_section.jpg\",\"disabled_image\":\"images\\/prototypes\\/sec_ad_section-cross.jpg\",\"alt\":\"Banner 2 Section\"},{\"id\":7,\"name\":\"Info Boxes\",\"order\":11,\"file_name\":\"info_boxes\",\"status\":0,\"image\":\"images\\/prototypes\\/info_boxes.jpg\",\"disabled_image\":\"images\\/prototypes\\/info_boxes-cross.jpg\",\"alt\":\"Info Boxes\"},{\"id\":6,\"name\":\"Blog Section\",\"order\":12,\"file_name\":\"blog_section\",\"status\":0,\"image\":\"images\\/prototypes\\/blog_section.jpg\",\"disabled_image\":\"images\\/prototypes\\/blog_section-cross.jpg\",\"alt\":\"Blog Section\"}]', 1, 1, 1, 2, 1, 1, 2, 3, 1, '', '5d2ZmpgcBADkan2oZmcfhicKaQKQqEE5cA8NIPfC');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customers_id` int(11) NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `customers_fax` varchar(191) DEFAULT NULL,
  `customers_newsletter` varchar(191) DEFAULT NULL,
  `fb_id` varchar(191) DEFAULT NULL,
  `google_id` varchar(191) DEFAULT NULL,
  `auth_id_tiwilo` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customers_basket`
--

CREATE TABLE `customers_basket` (
  `customers_basket_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `products_id` text NOT NULL,
  `customers_basket_quantity` int(11) NOT NULL,
  `final_price` decimal(15,2) DEFAULT NULL,
  `customers_basket_date_added` char(10) DEFAULT NULL,
  `is_order` tinyint(1) NOT NULL DEFAULT 0,
  `session_id` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customers_basket`
--

INSERT INTO `customers_basket` (`customers_basket_id`, `customers_id`, `products_id`, `customers_basket_quantity`, `final_price`, `customers_basket_date_added`, `is_order`, `session_id`) VALUES
(3, 2, '30', 1, '130.00', '2020-07-13', 1, 'AINe2sJLKrtWjEc1oIEmeMvL3FWmKGwp9OPOR4G3'),
(4, 2, '7', 1, '25.00', '2020-07-13', 1, 'AINe2sJLKrtWjEc1oIEmeMvL3FWmKGwp9OPOR4G3'),
(5, 0, '16', 1, '35.00', '2020-07-13', 0, 'fexTI7MTbMoZFh8cvHW9VJOZ43H3UwfTlaT9ykym'),
(6, 2, '36', 2, '120.00', '2020-07-16', 1, 'lYpodqVPYcJptq6GCrUHdyNinbnrpW4b3ZqHISsT'),
(7, 2, '31', 2, '67.00', '2020-07-16', 1, '47DuORKDqV0NMXCtqfmv6ozaIn4qNgv8uE6q7xg1'),
(8, 2, '32', 1, '81.00', '2020-07-16', 1, 'hkFGsIQ8VdLMNCNLKwW8Vp3Unp9jFytYqhJMROnJ'),
(9, 2, '32', 1, '81.00', '2020-07-16', 0, 'vlpqHTPFVKWuT7AL52Ccnl83kTKOARJnWHR5E812'),
(10, 2, '36', 1, '120.00', '2020-07-18', 0, 'vlpqHTPFVKWuT7AL52Ccnl83kTKOARJnWHR5E812'),
(12, 0, '36', 1, '120.00', '2020-07-19', 0, 'kCs3Vb50CHuJ21dHLwkQSc7H60QNDYjczDkVpfwA'),
(13, 0, '36', 2, '120.00', '2020-07-22', 0, 'lsviYTpApv8ysGs8GywC6YzQzMbcXAZlQc5eRsod'),
(16, 0, '45', 1, '950.00', '2020-07-22', 0, 'MwJe2cP3ZWb4E7aAWXdowuM0pw2Yz9JF4ALzBtMZ'),
(18, 5, '42', 2, '2050.00', '2020-08-10', 1, 'QZZ63R4Z9o010ACOHkWOakHXXOpSYlsOduPjiTdK'),
(19, 5, '52', 2, '890.00', '2020-08-10', 1, 'QZZ63R4Z9o010ACOHkWOakHXXOpSYlsOduPjiTdK'),
(20, 5, '63', 2, '1250.00', '2020-08-10', 1, 'QZZ63R4Z9o010ACOHkWOakHXXOpSYlsOduPjiTdK'),
(26, 0, '63', 1, '1250.00', '2020-08-16', 0, '5XsfFHikESmWOItpYUNi0dyMRpgvSSnPfekabFHy'),
(27, 3, '61', 1, '1100.00', '2020-08-19', 1, 'F4YsaHQPNIbLd2FLFI4vwKz25SzVLdAY6qMhImOb'),
(28, 0, '70', 2, '1580000.00', '2020-08-20', 0, '7qkP9bhcIoIvuVhl2HDLHwdLpbiq9kPg15XlT1RJ'),
(33, 3, '36', 1, '120.00', '2020-08-20', 1, '7kIks65ZRp54V3dNHkScs8tWhfTh5ThWDS1EbpNd'),
(34, 0, '38', 2, '2750.00', '2020-08-22', 0, 'gZSS6pYin1D080bszX0JtfcMVYtvU7L2rN3375yT'),
(35, 3, '38', 1, '2750.00', '2020-08-23', 1, '7kIks65ZRp54V3dNHkScs8tWhfTh5ThWDS1EbpNd'),
(37, 3, '73', 2, '3425000.00', '2020-08-25', 1, 'YaSrIjL3NJtPISIodBAEXWQCSgK8cmkVwq3Nq5yz'),
(38, 3, '70', 3, '1580000.00', '2020-08-25', 1, 'YaSrIjL3NJtPISIodBAEXWQCSgK8cmkVwq3Nq5yz'),
(39, 9, '36', 1, '120.00', '2020-08-26', 1, 'kHVBG9er2gcscs2yUrNEHRRvAVPYy5azaLeQ9iRx'),
(40, 3, '60', 2, '950.00', '2020-08-26', 1, '5QDXj7s70COfQQebebrrYrXGSZ0uenOB0B3oh7fc'),
(41, 3, '61', 2, '1100.00', '2020-08-26', 1, '5QDXj7s70COfQQebebrrYrXGSZ0uenOB0B3oh7fc'),
(42, 0, '71', 2, '2110000.00', '2020-08-27', 0, 'bunYJ4PDRDs0cKYX4BRkyoBIuyWaJeJj6JZ5ccBf'),
(44, 0, '73', 1, '3425000.00', '2020-08-31', 0, 'eBoyl1F3Cd34ZBvopv7NQ87pfAcBbCRekRaNLyud'),
(45, 0, '24', 1, '2050.00', '2020-08-31', 0, 'IXcEJTPiZmJm2SzmDYXM7eutchZcCe7ShmMIEUSk'),
(46, 13, '53', 1, '800.00', '2020-09-03', 1, 'IdggIOsV75m1uNyltA0qKc1m2aAqNTHi2nDNf9yV'),
(47, 3, '47', 1, '950.00', '2020-09-06', 1, 'M5CgscRMbwKbDpKZ8R3pxCsuYOujyZDZQr5iO2q9'),
(48, 3, '38', 1, '2750.00', '2020-09-26', 1, '9b58RrqxqjghuHrQR4ZbliXkbNmMikuhpR8GcOb3'),
(49, 3, '36', 1, '120.00', '2020-09-26', 1, '9b58RrqxqjghuHrQR4ZbliXkbNmMikuhpR8GcOb3'),
(50, 3, '36', 1, '120.00', '2020-09-26', 1, '9b58RrqxqjghuHrQR4ZbliXkbNmMikuhpR8GcOb3'),
(51, 3, '36', 1, '120.00', '2020-09-26', 1, '9b58RrqxqjghuHrQR4ZbliXkbNmMikuhpR8GcOb3'),
(52, 3, '36', 1, '120.00', '2020-09-26', 1, '9b58RrqxqjghuHrQR4ZbliXkbNmMikuhpR8GcOb3'),
(53, 3, '86', 1, '520.00', '2020-09-26', 1, '9b58RrqxqjghuHrQR4ZbliXkbNmMikuhpR8GcOb3'),
(54, 3, '86', 1, '520.00', '2020-09-26', 1, '9b58RrqxqjghuHrQR4ZbliXkbNmMikuhpR8GcOb3'),
(55, 3, '36', 1, '120.00', '2020-09-27', 1, 'zqqHqLk8atdDOXLjboBz13KQhVDFZzjP8hYntBrm'),
(56, 3, '36', 1, '120.00', '2020-09-27', 1, 'w1SUgywffz52PktfWF3aC0X69mAXiLiuePNgBWf0'),
(57, 3, '36', 1, '120.00', '2020-09-27', 1, 'w1SUgywffz52PktfWF3aC0X69mAXiLiuePNgBWf0'),
(58, 3, '36', 1, '120.00', '2020-09-27', 1, 'w1SUgywffz52PktfWF3aC0X69mAXiLiuePNgBWf0'),
(59, 3, '36', 1, '120.00', '2020-09-27', 1, 'ZFykrDD3M9cs8j0uS7cyGIAminTfbZYf5nsAAo0q'),
(60, 3, '36', 1, '120.00', '2020-09-28', 1, 'CcCGxb3XcswSZD53HZp9Lro8FL1RIeTIVQvWJh6s'),
(61, 3, '36', 1, '120.00', '2020-09-28', 1, 'bOA1uJEnhk2dzmhJXSYhVLDYGzKQ127Ndw0uoov7'),
(62, 3, '36', 1, '120.00', '2020-09-29', 1, 'nFEC5OrWvAZlLJuSYnuo4Ul1AvIUouhruIGAYSCA'),
(63, 9, '87', 1, '545.00', '2020-09-29', 0, 'GeITfGVYrncpN3UQGcmAMh7gIl3lnZ3gZcosleI1'),
(64, 18, '48', 1, '900.00', '2020-10-13', 1, 'F9at7Pn2X8pX2qubndBuWYJeXiv3G7YCbP9LKN7v'),
(65, 19, '88', 1, '5525.00', '2020-10-14', 1, 'V0p9R5ijHXALFrwyxTMbkHtPUkJ3szuVHJV05faU'),
(66, 19, '78', 1, '750.00', '2020-10-14', 1, 'V0p9R5ijHXALFrwyxTMbkHtPUkJ3szuVHJV05faU'),
(67, 0, '76', 1, '950.00', '2020-10-18', 0, 'wuEVz0zYITi7pl9tn7ZVXnOxkL1xpQGcJ2L8lZGk'),
(68, 3, '96', 1, '1450.00', '2020-11-09', 1, 'cuRqbZtyQLlwIh74jIdLbMq2IyGCLkCi3H6qN3OM'),
(72, 3, '32', 3, '7000.00', '2020-11-09', 1, '9Cfxp8NrmZI6VszJIwdzk71Oft0k0ksqgv2S9EIp'),
(73, 21, '32', 1, '7000.00', '2020-11-09', 1, 'oVzRPkbZHxp7foC4hOOcqFdLMUpGKHHebPXQhZiL'),
(74, 21, '32', 1, '7000.00', '2020-11-09', 1, 'oVzRPkbZHxp7foC4hOOcqFdLMUpGKHHebPXQhZiL'),
(75, 21, '32', 1, '7000.00', '2020-11-09', 1, 'fNiuEj72OqA9GlU4yUCVzrScIpBDGKwaC2FrljDC'),
(76, 0, '107', 2, '800.00', '2020-12-10', 0, '2YkoK5JIoV3mIKuU1c5kEvD2uNHEZPNG1TJM04wW'),
(77, 0, '101', 1, '600.00', '2020-12-10', 0, 'U00SnzLHezeKvgq5wWJg8q6Xp76tkEQjuWiCFQ12'),
(82, 18, '95', 2, '1250.00', '2020-12-13', 1, 'ykLVfBOPgFAJLxbV4IS02bPWx3NOC44ZIJPyXPX3'),
(84, 18, '42', 1, '2050.00', '2020-12-13', 1, 'aRt1WOlzP6zppoHqFIq9Y2i81WNU5UNPfhS7aWw1'),
(85, 13, '79', 2, '130.00', '2020-12-24', 1, 'VDBDayg4YT8XJze7djNPjmlHd8hdhsL2ug8KoBq2'),
(86, 3, '49', 1, '900.00', '2020-12-24', 1, 'EjXo4yxcZpSte8Q8SYFaM2q5LHaZO6tmOj5rADQh'),
(87, 13, '79', 2, '130.00', '2020-12-24', 1, 'nHMqEHKy0th8cNiFiXcAWKuEi6u1URLtbWBh6yrx'),
(88, 3, '96', 1, '1450.00', '2020-12-24', 1, 'EjXo4yxcZpSte8Q8SYFaM2q5LHaZO6tmOj5rADQh'),
(89, 3, '48', 1, '900.00', '2020-12-24', 1, 'EjXo4yxcZpSte8Q8SYFaM2q5LHaZO6tmOj5rADQh'),
(90, 0, '78', 4, '750.00', '2021-02-03', 0, 'fMIWyVK9szV2NgYVKJheWDKAt9x3ZbJ6YGMmQwIE'),
(91, 0, '54', 3, '900.00', '2021-02-06', 0, 'HXfRTM8pMVAOq6LRGIDEcrlY7P06hpspWHRM0fWR'),
(92, 0, '163', 3, '1400.00', '2021-02-10', 0, 'u4Nh0UcweKGaeiAxrl8XK4tkNaDLZmi8JlWeaZhd'),
(93, 0, '172', 1, '2100.00', '2021-02-10', 0, 'u4Nh0UcweKGaeiAxrl8XK4tkNaDLZmi8JlWeaZhd'),
(94, 0, '71', 3, '2110000.00', '2021-04-30', 0, 'u1Rjn9FVaf0rU9UtSJsfpWbaSLvHbecwE6TGjeFr'),
(95, 0, '71', 1, '2110000.00', '2021-04-30', 0, 'az9NieqLNySNMFTTYuIbz4fSlwPTQQzGqnREnjGc'),
(96, 0, '80', 1, '270.00', '2021-04-30', 0, 'az9NieqLNySNMFTTYuIbz4fSlwPTQQzGqnREnjGc'),
(99, 23, '78', 1, '750.00', '2021-08-18', 1, 'l8wFxCJgV45uifhp30KEyi70Anu4mFH463CUrgOe'),
(100, 23, '4', 1, '3000.00', '2021-08-23', 1, 'vieqg4N1SNmpTyki07VSBEo0Ba31bzcLwve6xc0k'),
(101, 13, '96', 1, '1450.00', '2021-08-28', 1, 'fDKDfL4DikyHZ6HJXBk0J7AI6CZRBcNULdxnhP7g'),
(102, 0, '78', 3, '750.00', '2021-10-22', 0, 'EaSqW8XXAo6q6yqZ5KLWi4MzP9lLWyhAsc0uKpPP'),
(103, 0, '49', 1, '900.00', '2021-11-10', 0, 'v08JVCqHbHm3XlUWt4gn7tZa6fzVSeT8JfIHX3AW'),
(104, 0, '86', 1, '520.00', '2021-12-01', 0, '6jI66cNPvdvio8QE6GN6mCrZmXUQ0gUZc6b3xaf5'),
(107, 24, '326', 1, '1800.00', '2022-01-02', 1, 'Q9xO2JqegKxaVpxPHnEQ52TVjPRJmuBFO38Ys9tH'),
(108, 24, '323', 1, '1250.00', '2022-01-02', 1, '7RTILLIxgRt5XgT1xqreKqIMrOasW6nW64SCrClW'),
(110, 13, '306', 1, '9000.00', '2022-01-10', 1, 'XXqiTdUak1pMqc9CIsfrQPzyWVJCbe8vKA65KFqi'),
(111, 13, '325', 1, '1400.00', '2022-01-13', 1, '6Id0LjTQx9Hgby3ubhjxyWRe2wAWzDaQ9PeMeHR8'),
(112, 25, '47', 1, '950.00', '2022-01-17', 1, 'M8VWwQoLSvFkhG48ywcGTLOAFDUPoOtLYX2poR3H'),
(113, 0, '81', 3, '430.00', '2022-03-23', 0, 'Iyh7R7k0myr5bM8cTjKChT7RGUxrHgckvo03iuGV'),
(114, 26, '96', 1, '1450.00', '2022-03-23', 0, 'HQNN6kARoqysivoPPbVv7vh5eLYjvtl4lkF7eqmc'),
(116, 0, '46', 1, '950.00', '2022-03-23', 0, 'fOdc9F6CKEz0Q1PSDWnf6PRMADXnjUEgz2N2drnV'),
(117, 27, '36', 1, '150.00', '2022-03-23', 1, '4YcmZposAf89ic7QFUa9qZ6oqeY3loGDjxfQCykn');

-- --------------------------------------------------------

--
-- Table structure for table `customers_basket_attributes`
--

CREATE TABLE `customers_basket_attributes` (
  `customers_basket_attributes_id` int(11) NOT NULL,
  `customers_basket_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `products_id` text NOT NULL,
  `products_options_id` int(11) NOT NULL,
  `products_options_values_id` int(11) NOT NULL,
  `session_id` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customers_basket_attributes`
--

INSERT INTO `customers_basket_attributes` (`customers_basket_attributes_id`, `customers_basket_id`, `customers_id`, `products_id`, `products_options_id`, `products_options_values_id`, `session_id`) VALUES
(2, 45, 0, '24', 1, 4, 'IXcEJTPiZmJm2SzmDYXM7eutchZcCe7ShmMIEUSk'),
(3, 100, 23, '4', 1, 1, 'vieqg4N1SNmpTyki07VSBEo0Ba31bzcLwve6xc0k');

-- --------------------------------------------------------

--
-- Table structure for table `customers_info`
--

CREATE TABLE `customers_info` (
  `customers_info_id` int(11) NOT NULL,
  `customers_info_date_of_last_logon` datetime DEFAULT NULL,
  `customers_info_number_of_logons` int(11) DEFAULT NULL,
  `customers_info_date_account_created` datetime DEFAULT NULL,
  `customers_info_date_account_last_modified` datetime DEFAULT NULL,
  `global_product_notifications` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `id` int(11) NOT NULL,
  `device_id` text NOT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `device_type` int(11) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `ram` varchar(250) DEFAULT NULL,
  `processor` varchar(250) DEFAULT NULL,
  `device_os` varchar(250) DEFAULT NULL,
  `location` varchar(250) DEFAULT NULL,
  `latittude` varchar(100) DEFAULT NULL,
  `longitude` varchar(100) DEFAULT NULL,
  `device_model` varchar(191) NOT NULL,
  `manufacturer` varchar(100) NOT NULL,
  `operating_system` varchar(100) NOT NULL,
  `browser_info` varchar(100) NOT NULL,
  `is_notify` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `flash_sale`
--

CREATE TABLE `flash_sale` (
  `flash_sale_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `flash_sale_products_price` decimal(15,2) NOT NULL,
  `flash_sale_date_added` int(11) NOT NULL,
  `flash_sale_last_modified` int(11) NOT NULL,
  `flash_start_date` int(11) NOT NULL,
  `flash_expires_date` int(11) NOT NULL,
  `flash_status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flash_sale`
--

INSERT INTO `flash_sale` (`flash_sale_id`, `products_id`, `flash_sale_products_price`, `flash_sale_date_added`, `flash_sale_last_modified`, `flash_start_date`, `flash_expires_date`, `flash_status`, `created_at`, `updated_at`) VALUES
(1, 5, '30.00', 0, 0, 1568133900, 1706633100, 0, '2019-09-17 05:51:32', '2019-10-01 06:15:21'),
(3, 16, '35.00', 0, 0, 1567620000, 1701367200, 0, '2019-09-16 19:07:07', '2019-10-01 05:59:13'),
(4, 20, '70.00', 0, 0, 1568139300, 1682878500, 0, '2019-09-16 19:23:37', '2020-07-16 10:09:14'),
(5, 28, '65.00', 0, 0, 1568201400, 1669807800, 0, '2019-09-18 00:45:49', '2020-07-16 10:03:33'),
(6, 28, '65.00', 0, 0, 1568201400, 1669807800, 0, '2019-09-19 04:10:52', '2020-07-16 10:03:33'),
(7, 20, '70.00', 0, 0, 1568096100, 1682835300, 0, '2019-09-19 04:49:36', '2020-07-16 10:09:14'),
(8, 16, '35.00', 0, 0, 1567576800, 1701324000, 0, '2019-09-19 05:08:20', '2019-10-01 05:59:13'),
(10, 5, '30.00', 0, 0, 1568090700, 1706589900, 0, '2019-09-19 05:42:46', '2019-10-01 06:15:21'),
(11, 5, '30.00', 0, 0, 1568090700, 1706589900, 0, '2019-09-19 05:49:57', '2019-10-01 06:15:21'),
(12, 33, '20.00', 0, 0, 1568135700, 1569777300, 1, '2019-09-19 06:23:50', NULL),
(13, 5, '30.00', 0, 0, 1568090700, 1706589900, 0, '2019-09-24 04:23:20', '2019-10-01 06:15:21'),
(14, 34, '30.00', 0, 0, 1568046600, 1569861000, 1, '2019-09-25 05:43:49', NULL),
(15, 35, '30.00', 0, 0, 1568133900, 1569861900, 0, '2019-09-25 05:46:31', '2019-09-25 05:47:48'),
(16, 35, '30.00', 0, 0, 1568090700, 1569818700, 1, '2019-09-25 05:47:48', NULL),
(17, 28, '65.00', 0, 0, 1568201400, 1669807800, 0, '2019-10-01 05:52:07', '2020-07-16 10:03:33'),
(18, 20, '70.00', 0, 0, 1568096100, 1682835300, 0, '2019-10-01 05:56:36', '2020-07-16 10:09:14'),
(19, 16, '35.00', 0, 0, 1567576800, 1701324000, 1, '2019-10-01 05:59:13', NULL),
(21, 5, '30.00', 0, 0, 1568090700, 1706589900, 1, '2019-10-01 06:15:21', NULL),
(22, 28, '65.00', 0, 0, 1568201400, 1669807800, 1, '2020-07-16 10:03:33', NULL),
(23, 20, '70.00', 0, 0, 1568096100, 1682835300, 1, '2020-07-16 10:09:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `flate_rate`
--

CREATE TABLE `flate_rate` (
  `id` int(11) NOT NULL,
  `flate_rate` varchar(100) NOT NULL,
  `currency` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flate_rate`
--

INSERT INTO `flate_rate` (`id`, `flate_rate`, `currency`) VALUES
(1, '60', 'USD');

-- --------------------------------------------------------

--
-- Table structure for table `front_end_theme_content`
--

CREATE TABLE `front_end_theme_content` (
  `id` int(11) NOT NULL,
  `top_offers` text NOT NULL,
  `login` text NOT NULL,
  `transitions` text NOT NULL,
  `banners_two` text NOT NULL,
  `headers` text NOT NULL,
  `carousels` text NOT NULL,
  `banners` text NOT NULL,
  `footers` text NOT NULL,
  `product_section_order` text NOT NULL,
  `cart` text NOT NULL,
  `news` text NOT NULL,
  `detail` text NOT NULL,
  `shop` text NOT NULL,
  `contact` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `front_end_theme_content`
--

INSERT INTO `front_end_theme_content` (`id`, `top_offers`, `login`, `transitions`, `banners_two`, `headers`, `carousels`, `banners`, `footers`, `product_section_order`, `cart`, `news`, `detail`, `shop`, `contact`) VALUES
(1, '[{ \"id\": 1, \"name\": \"Top Offer\", \"image\": \"images/prototypes/banner1.jpg\", \"alt\": \"Top Offer\" }]', '[ { \"id\":1, \"name\":\"Login Page One\" }, { \"id\":2, \"name\":\"Login Page Two\" } ]', '[ { \"id\":1, \"name\":\"Transition Zoomin\" }, { \"id\":2, \"name\":\"Transition Flashing\" }, { \"id\":3, \"name\":\"Transition Shine\" }, { \"id\":4, \"name\":\"Transition Circle\" }, { \"id\":5, \"name\":\"Transition Opacity\" } ]', '[ { \"id\": 1, \"name\": \"Banner One\", \"image\": \"images/prototypes/banner1.jpg\", \"alt\": \"Banner One\" }, { \"id\": 2, \"name\": \"Banner Two\", \"image\": \"images/prototypes/banner2.jpg\", \"alt\": \"Banner Two\" }, { \"id\": 3, \"name\": \"Banner Three\", \"image\": \"images/prototypes/banner3.jpg\", \"alt\": \"Banner Three\" }, { \"id\": 4, \"name\": \"Banner Four\", \"image\": \"images/prototypes/banner4.jpg\", \"alt\": \"Banner Four\" }, { \"id\": 5, \"name\": \"Banner Five\", \"image\": \"images/prototypes/banner5.jpg\", \"alt\": \"Banner Five\" }, { \"id\": 6, \"name\": \"Banner Six\", \"image\": \"images/prototypes/banner6.jpg\", \"alt\": \"Banner Six\" }, { \"id\": 7, \"name\": \"Banner Seven\", \"image\": \"images/prototypes/banner7.jpg\", \"alt\": \"Banner Seven\" }, { \"id\": 8, \"name\": \"Banner Eight\", \"image\": \"images/prototypes/banner8.jpg\", \"alt\": \"Banner Eight\" }, { \"id\": 9, \"name\": \"Banner Nine\", \"image\": \"images/prototypes/banner9.jpg\", \"alt\": \"Banner Nine\" }, { \"id\": 10, \"name\": \"Banner Ten\", \"image\": \"images/prototypes/banner10.jpg\", \"alt\": \"Banner Ten\" }, { \"id\": 11, \"name\": \"Banner Eleven\", \"image\": \"images/prototypes/banner11.jpg\", \"alt\": \"Banner Eleven\" }, { \"id\": 12, \"name\": \"Banner Twelve\", \"image\": \"images/prototypes/banner12.jpg\", \"alt\": \"Banner Twelve\" }, { \"id\": 13, \"name\": \"Banner Thirteen\", \"image\": \"images/prototypes/banner13.jpg\", \"alt\": \"Banner Thirteen\" }, { \"id\": 14, \"name\": \"Banner Fourteen\", \"image\": \"images/prototypes/banner14.jpg\", \"alt\": \"Banner Fourteen\" }, { \"id\": 15, \"name\": \"Banner Fifteen\", \"image\": \"images/prototypes/banner15.jpg\", \"alt\": \"Banner Fifteen\" }, { \"id\": 16, \"name\": \"Banner Sixteen\", \"image\": \"images/prototypes/banner16.jpg\", \"alt\": \"Banner Sixteen\" }, { \"id\": 17, \"name\": \"Banner Seventeen\", \"image\": \"images/prototypes/banner17.jpg\", \"alt\": \"Banner Seventeen\" }, { \"id\": 18, \"name\": \"Banner Eighteen\", \"image\": \"images/prototypes/banner18.jpg\", \"alt\": \"Banner Eighteen\" }, { \"id\": 19, \"name\": \"Banner Nineteen\", \"image\": \"images/prototypes/banner19.jpg\", \"alt\": \"Banner Nineteen\" } ]', '[\r\n{\r\n\"id\": 1,\r\n\"name\": \"Header One\",\r\n\"image\": \"images/prototypes/header1.jpg\",\r\n\"alt\" : \"header One\" \r\n},\r\n{\r\n\"id\": 2,\r\n\"name\": \"Header Two\",\r\n\"image\": \"images/prototypes/header2.jpg\",\r\n\"alt\" : \"header Two\" \r\n},\r\n{\r\n\"id\": 3,\r\n\"name\": \"Header Three\",\r\n\"image\": \"images/prototypes/header3.jpg\",\r\n\"alt\" : \"header Three\" \r\n},\r\n{\r\n\"id\": 4,\r\n\"name\": \"Header Four\",\r\n\"image\": \"images/prototypes/header4.jpg\",\r\n\"alt\" : \"header Four\" \r\n},\r\n{\r\n\"id\": 5,\r\n\"name\": \"Header Five\",\r\n\"image\": \"images/prototypes/header5.jpg\",\r\n\"alt\" : \"header Five\" \r\n},\r\n{\r\n\"id\": 6,\r\n\"name\": \"Header Six\",\r\n\"image\": \"images/prototypes/header6.jpg\",\r\n\"alt\" : \"header Six\" \r\n},\r\n{\r\n\"id\": 7,\r\n\"name\": \"Header Seven\",\r\n\"image\": \"images/prototypes/header7.jpg\",\r\n\"alt\" : \"header Seven\" \r\n},\r\n{\r\n\"id\": 8,\r\n\"name\": \"Header Eight\",\r\n\"image\": \"images/prototypes/header8.jpg\",\r\n\"alt\" : \"header Eight\" \r\n},\r\n{\r\n\"id\": 9,\r\n\"name\": \"Header Nine\",\r\n\"image\": \"images/prototypes/header9.jpg\",\r\n\"alt\" : \"header Nine\" \r\n},\r\n{\r\n\"id\": 10,\r\n\"name\": \"Header Ten\",\r\n\"image\": \"images/prototypes/header10.jpg\",\r\n\"alt\" : \"header Ten\" \r\n}\r\n]', '[\r\n{\r\n\"id\": 1,\r\n\"name\": \"Bootstrap Carousel Content Full Screen\",\r\n\"image\": \"images/prototypes/carousal1.jpg\",\r\n\"alt\": \"Bootstrap Carousel Content Full Screen\"\r\n},\r\n{\r\n\"id\": 2,\r\n\"name\": \"Bootstrap Carousel Content Full Width\",\r\n\"image\": \"images/prototypes/carousal2.jpg\",\r\n\"alt\": \"Bootstrap Carousel Content Full Width\"\r\n},\r\n{\r\n\"id\": 3,\r\n\"name\": \"Bootstrap Carousel Content with Left Banner\",\r\n\"image\": \"images/prototypes/carousal3.jpg\",\r\n\"alt\": \"Bootstrap Carousel Content with Left Banner\"\r\n},\r\n{\r\n\"id\": 4,\r\n\"name\": \"Bootstrap Carousel Content with Navigation\",\r\n\"image\": \"images/prototypes/carousal4.jpg\",\r\n\"alt\": \"Bootstrap Carousel Content with Navigation\"\r\n},\r\n{\r\n\"id\": 5,\r\n\"name\": \"Bootstrap Carousel Content with Right Banner\",\r\n\"image\": \"images/prototypes/carousal5.jpg\",\r\n\"alt\": \"Bootstrap Carousel Content with Right Banner\"\r\n}\r\n]', '[\r\n{\r\n\"id\": 1,\r\n\"name\": \"Banner One\",\r\n\"image\": \"images/prototypes/banner1.jpg\",\r\n\"alt\": \"Banner One\"\r\n},\r\n{\r\n\"id\": 2,\r\n\"name\": \"Banner Two\",\r\n\"image\": \"images/prototypes/banner2.jpg\",\r\n\"alt\": \"Banner Two\"\r\n},\r\n{\r\n\"id\": 3,\r\n\"name\": \"Banner Three\",\r\n\"image\": \"images/prototypes/banner3.jpg\",\r\n\"alt\": \"Banner Three\"\r\n},\r\n{\r\n\"id\": 4,\r\n\"name\": \"Banner Four\",\r\n\"image\": \"images/prototypes/banner4.jpg\",\r\n\"alt\": \"Banner Four\"\r\n},\r\n{\r\n\"id\": 5,\r\n\"name\": \"Banner Five\",\r\n\"image\": \"images/prototypes/banner5.jpg\",\r\n\"alt\": \"Banner Five\"\r\n},\r\n{\r\n\"id\": 6,\r\n\"name\": \"Banner Six\",\r\n\"image\": \"images/prototypes/banner6.jpg\",\r\n\"alt\": \"Banner Six\"\r\n},\r\n{\r\n\"id\": 7,\r\n\"name\": \"Banner Seven\",\r\n\"image\": \"images/prototypes/banner7.jpg\",\r\n\"alt\": \"Banner Seven\"\r\n},\r\n{\r\n\"id\": 8,\r\n\"name\": \"Banner Eight\",\r\n\"image\": \"images/prototypes/banner8.jpg\",\r\n\"alt\": \"Banner Eight\"\r\n},\r\n{\r\n\"id\": 9,\r\n\"name\": \"Banner Nine\",\r\n\"image\": \"images/prototypes/banner9.jpg\",\r\n\"alt\": \"Banner Nine\"\r\n},\r\n{\r\n\"id\": 10,\r\n\"name\": \"Banner Ten\",\r\n\"image\": \"images/prototypes/banner10.jpg\",\r\n\"alt\": \"Banner Ten\"\r\n},\r\n{\r\n\"id\": 11,\r\n\"name\": \"Banner Eleven\",\r\n\"image\": \"images/prototypes/banner11.jpg\",\r\n\"alt\": \"Banner Eleven\"\r\n},\r\n{\r\n\"id\": 12,\r\n\"name\": \"Banner Twelve\",\r\n\"image\": \"images/prototypes/banner12.jpg\",\r\n\"alt\": \"Banner Twelve\"\r\n},\r\n{\r\n\"id\": 13,\r\n\"name\": \"Banner Thirteen\",\r\n\"image\": \"images/prototypes/banner13.jpg\",\r\n\"alt\": \"Banner Thirteen\"\r\n},\r\n{\r\n\"id\": 14,\r\n\"name\": \"Banner Fourteen\",\r\n\"image\": \"images/prototypes/banner14.jpg\",\r\n\"alt\": \"Banner Fourteen\"\r\n},\r\n{\r\n\"id\": 15,\r\n\"name\": \"Banner Fifteen\",\r\n\"image\": \"images/prototypes/banner15.jpg\",\r\n\"alt\": \"Banner Fifteen\"\r\n},\r\n{\r\n\"id\": 16,\r\n\"name\": \"Banner Sixteen\",\r\n\"image\": \"images/prototypes/banner16.jpg\",\r\n\"alt\": \"Banner Sixteen\"\r\n},\r\n{\r\n\"id\": 17,\r\n\"name\": \"Banner Seventeen\",\r\n\"image\": \"images/prototypes/banner17.jpg\",\r\n\"alt\": \"Banner Seventeen\"\r\n},\r\n{\r\n\"id\": 18,\r\n\"name\": \"Banner Eighteen\",\r\n\"image\": \"images/prototypes/banner18.jpg\",\r\n\"alt\": \"Banner Eighteen\"\r\n},\r\n{\r\n\"id\": 19,\r\n\"name\": \"Banner Nineteen\",\r\n\"image\": \"images/prototypes/banner19.jpg\",\r\n\"alt\": \"Banner Nineteen\"\r\n}\r\n]', '[\r\n{\r\n\"id\": 1,\r\n\"name\": \"Footer One\",\r\n\"image\": \"images/prototypes/footer1.png\",\r\n\"alt\" : \"Footer One\"\r\n},\r\n{\r\n\"id\": 2,\r\n\"name\": \"Footer Two\",\r\n\"image\": \"images/prototypes/footer2.png\",\r\n\"alt\" : \"Footer Two\"\r\n},\r\n{\r\n\"id\": 3,\r\n\"name\": \"Footer Three\",\r\n\"image\": \"images/prototypes/footer3.png\",\r\n\"alt\" : \"Footer Three\"\r\n},\r\n{\r\n\"id\": 4,\r\n\"name\": \"Footer Four\",\r\n\"image\": \"images/prototypes/footer4.png\",\r\n\"alt\" : \"Footer Four\"\r\n},\r\n{\r\n\"id\": 5,\r\n\"name\": \"Footer Five\",\r\n\"image\": \"images/prototypes/footer5.png\",\r\n\"alt\" : \"Footer Five\"\r\n},\r\n{\r\n\"id\": 6,\r\n\"name\": \"Footer Six\",\r\n\"image\": \"images/prototypes/footer6.png\",\r\n\"alt\" : \"Footer Six\"\r\n},\r\n{\r\n\"id\": 7,\r\n\"name\": \"Footer Seven\",\r\n\"image\": \"images/prototypes/footer7.png\",\r\n\"alt\" : \"Footer Seven\"\r\n},\r\n{\r\n\"id\": 8,\r\n\"name\": \"Footer Eight\",\r\n\"image\": \"images/prototypes/footer8.png\",\r\n\"alt\" : \"Footer Eight\"\r\n},\r\n{\r\n\"id\": 9,\r\n\"name\": \"Footer Nine\",\r\n\"image\": \"images/prototypes/footer9.png\",\r\n\"alt\" : \"Footer Nine\"\r\n},\r\n{\r\n\"id\": 10,\r\n\"name\": \"Footer Ten\",\r\n\"image\": \"images/prototypes/footer10.png\",\r\n\"alt\" : \"Footer Ten\"\r\n}\r\n]', '[{\"id\":11,\"name\":\"Tab Products View\",\"order\":1,\"file_name\":\"tab\",\"status\":1,\"image\":\"images\\/prototypes\\/tab.jpg\",\"disabled_image\":\"images\\/prototypes\\/tab-cross.jpg\",\"alt\":\"Tab Products View\"},{\"id\":1,\"name\":\"Banner Section\",\"order\":2,\"file_name\":\"banner_section\",\"status\":1,\"image\":\"images\\/prototypes\\/banner_section.jpg\",\"alt\":\"Banner Section\"},{\"id\":5,\"name\":\"Categories\",\"order\":3,\"file_name\":\"categories\",\"status\":1,\"image\":\"images\\/prototypes\\/categories.jpg\",\"disabled_image\":\"images\\/prototypes\\/categories-cross.jpg\",\"alt\":\"Categories\"},{\"id\":2,\"name\":\"Flash Sale Section\",\"order\":4,\"file_name\":\"flash_sale_section\",\"status\":0,\"image\":\"images\\/prototypes\\/flash_sale_section.jpg\",\"disabled_image\":\"images\\/prototypes\\/flash_sale_section-cross.jpg\",\"alt\":\"Flash Sale Section\"},{\"id\":10,\"name\":\"Second Ad Section\",\"order\":5,\"file_name\":\"sec_ad_banner\",\"status\":0,\"image\":\"images\\/prototypes\\/sec_ad_section.jpg\",\"disabled_image\":\"images\\/prototypes\\/sec_ad_section-cross.jpg\",\"alt\":\"Second Ad Section\"},{\"id\":9,\"name\":\"Top Selling\",\"order\":6,\"file_name\":\"top\",\"status\":0,\"image\":\"images\\/prototypes\\/top.jpg\",\"disabled_image\":\"images\\/prototypes\\/top-cross.jpg\",\"alt\":\"Top Selling\"},{\"id\":4,\"name\":\"Ad Section\",\"order\":7,\"file_name\":\"ad_banner_section\",\"status\":1,\"image\":\"images\\/prototypes\\/ad_banner_section.jpg\",\"disabled_image\":\"images\\/prototypes\\/ad_banner_section-cross.jpg\",\"alt\":\"Ad Section\"},{\"id\":3,\"name\":\"Special Products Section\",\"order\":8,\"file_name\":\"special\",\"status\":0,\"image\":\"images\\/prototypes\\/special_product.jpg\",\"disabled_image\":\"images\\/prototypes\\/special_product-cross.jpg\",\"alt\":\"Special Products Section\"},{\"id\":8,\"name\":\"Newest Product Section\",\"order\":9,\"file_name\":\"newest_product\",\"status\":1,\"image\":\"images\\/prototypes\\/newest_product.jpg\",\"disabled_image\":\"images\\/prototypes\\/newest_product-cross.jpg\",\"alt\":\"Newest Product Section\"},{\"id\":12,\"name\":\"Banner 2 Section\",\"order\":10,\"file_name\":\"banner_two_section\",\"status\":0,\"image\":\"images\\/prototypes\\/sec_ad_section.jpg\",\"disabled_image\":\"images\\/prototypes\\/sec_ad_section-cross.jpg\",\"alt\":\"Banner 2 Section\"},{\"id\":7,\"name\":\"Info Boxes\",\"order\":11,\"file_name\":\"info_boxes\",\"status\":0,\"image\":\"images\\/prototypes\\/info_boxes.jpg\",\"disabled_image\":\"images\\/prototypes\\/info_boxes-cross.jpg\",\"alt\":\"Info Boxes\"},{\"id\":6,\"name\":\"Blog Section\",\"order\":12,\"file_name\":\"blog_section\",\"status\":0,\"image\":\"images\\/prototypes\\/blog_section.jpg\",\"disabled_image\":\"images\\/prototypes\\/blog_section-cross.jpg\",\"alt\":\"Blog Section\"}]', '[      {         \"id\":1,       \"name\":\"Cart One\"    },    {         \"id\":2,       \"name\":\"Cart Two\"    }     ]', '[ { \"id\":1, \"name\":\"News One\" }, { \"id\":2, \"name\":\"News Two\" } ]', '[  \r\n{  \r\n\"id\":1,\r\n\"name\":\"Product Detail Page One\"\r\n},\r\n{  \r\n\"id\":2,\r\n\"name\":\"Product Detail Page Two\"\r\n},\r\n{  \r\n\"id\":3,\r\n\"name\":\"Product Detail Page Three\"\r\n},\r\n{  \r\n\"id\":4,\r\n\"name\":\"Product Detail Page Four\"\r\n},\r\n{  \r\n\"id\":5,\r\n\"name\":\"Product Detail Page Five\"\r\n},\r\n{  \r\n\"id\":6,\r\n\"name\":\"Product Detail Page Six\"\r\n}\r\n\r\n]', '[ { \"id\":1, \"name\":\"Shop Page One\" }, { \"id\":2, \"name\":\"Shop Page Two\" }, { \"id\":3, \"name\":\"Shop Page Three\" }, { \"id\":4, \"name\":\"Shop Page Four\" }, { \"id\":5, \"name\":\"Shop Page Five\" } ]', '[      {         \"id\":1,       \"name\":\"Contact Page One\"    },    {         \"id\":2,       \"name\":\"Contact Page Two\"    } ]');

-- --------------------------------------------------------

--
-- Table structure for table `geo_zones`
--

CREATE TABLE `geo_zones` (
  `geo_zone_id` int(11) NOT NULL,
  `geo_zone_name` varchar(32) NOT NULL,
  `geo_zone_description` varchar(191) NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `home_banners`
--

CREATE TABLE `home_banners` (
  `home_banners_id` int(100) NOT NULL,
  `banner_name` varchar(100) NOT NULL,
  `language_id` int(100) NOT NULL DEFAULT 1,
  `text` text NOT NULL,
  `image` int(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `home_banners`
--

INSERT INTO `home_banners` (`home_banners_id`, `banner_name`, `language_id`, `text`, `image`, `created_at`, `updated_at`) VALUES
(0, 'banners_1', 1, '<div class=\\\"parallax-banner-text\\\">\r\n        <h2> SNEAKER</h2>\r\n        <h4>Couples Footwear</h4>\r\n        <div class=\\\"hover-link\\\">\r\n          <a href=\\\"/shop\\\" class=\\\"btn btn-secondary swipe-to-top\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"bottom\\\" title=\\\"\\\" data-original-title=\\\"View All Range\\\">View All Range</a>\r\n        </div>  \r\n      </div>', 13, '2020-04-02 05:51:35', '2020-04-02 05:51:35'),
(0, 'banners_2', 1, '<div class=\\\"parallax-banner-text\\\">\r\n        <h2> TRENDING</h2>\r\n        <h4>Fashion Wear</h4>\r\n        <div class=\\\"hover-link\\\">\r\n          <a href=\\\"/shop\\\" class=\\\"btn btn-secondary swipe-to-top\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"bottom\\\" title=\\\"\\\" data-original-title=\\\"View All Range\\\">View All Range</a>\r\n        </div>  \r\n      </div>', 12, '2020-04-02 05:51:35', '2020-04-02 05:51:35'),
(0, 'banners_3', 1, '<div class=\\\"parallax-banner-text\\\">\r\n        <h2> BIG SALE</h2>\r\n        <h4>Women Clothing</h4>\r\n        <div class=\\\"hover-link\\\">\r\n          <a href=\\\"/shop\\\" class=\\\"btn btn-secondary swipe-to-top\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"bottom\\\" title=\\\"\\\" data-original-title=\\\"Shop Now\\\">Shop Now</a>\r\n        </div>  \r\n      </div>', 539, '2020-04-02 05:51:35', '2020-04-02 05:51:35'),
(0, 'banners_1', 4, '<div class=\\\"parallax-banner-text\\\">\r\n        <h2> حذاء رياضة</h2>\r\n        <h4>أحذية الأزواج</h4>\r\n        <div class=\\\"hover-link\\\">\r\n          <a href=\\\"/shop\\\" class=\\\"btn btn-secondary swipe-to-top\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"bottom\\\" title=\\\"\\\" data-original-title=\\\"\\\">عرض كل المدى</a>\r\n        </div>  \r\n      </div>', 13, '2020-04-02 05:51:35', '2020-04-02 05:51:35'),
(0, 'banners_2', 4, '<div class=\\\"parallax-banner-text\\\">\r\n        <h2> حذاء رياضة</h2>\r\n        <h4>أحذية الأزواج</h4>\r\n        <div class=\\\"hover-link\\\">\r\n          <a href=\\\"/shop\\\" class=\\\"btn btn-secondary swipe-to-top\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"bottom\\\" title=\\\"\\\" data-original-title=\\\"\\\">عرض كل المدى</a>\r\n        </div>  \r\n      </div>', 12, '2020-04-02 05:51:35', '2020-04-02 05:51:35'),
(0, 'banners_3', 4, '<div class=\\\"parallax-banner-text\\\">\r\n        <h2> حذاء رياضة</h2>\r\n        <h4>أحذية الأزواج</h4>\r\n        <div class=\\\"hover-link\\\">\r\n          <a href=\\\"/shop\\\" class=\\\"btn btn-secondary swipe-to-top\\\" data-toggle=\\\"tooltip\\\" data-placement=\\\"bottom\\\" title=\\\"\\\" data-original-title=\\\"\\\">عرض كل المدى</a>\r\n        </div>  \r\n      </div>', 539, '2020-04-02 05:51:35', '2020-04-02 05:51:35');

-- --------------------------------------------------------

--
-- Table structure for table `http_call_record`
--

CREATE TABLE `http_call_record` (
  `id` int(11) NOT NULL,
  `device_id` varchar(191) DEFAULT NULL,
  `ip` varchar(191) DEFAULT NULL,
  `url` varchar(191) DEFAULT NULL,
  `ping_time` datetime DEFAULT NULL,
  `difference_from_previous` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `user_id` int(11) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `name`, `user_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(3, 'XUF1110211.png', 1, NULL, NULL, NULL),
(4, '0S9Uj10711.png', 1, NULL, NULL, NULL),
(5, '49YbL10411.png', 1, NULL, NULL, NULL),
(431, 'vURED27710.jpg', 1, NULL, NULL, NULL),
(440, 'mo6Yk27410.jpg', 1, NULL, NULL, NULL),
(779, 'NzEhM09605.jpg', 1, NULL, NULL, NULL),
(780, 'Tbegh09809.jpg', 1, NULL, NULL, NULL),
(781, 'hurQN09409.jpg', 1, NULL, NULL, NULL),
(782, 'D1csl09809.jpg', 1, NULL, NULL, NULL),
(783, 'tT1LL09309.jpg', 1, NULL, NULL, NULL),
(784, 'RAfZn09609.jpg', 1, NULL, NULL, NULL),
(785, '231dw20408.png', 1, NULL, NULL, NULL),
(786, '0P3d920108.png', 1, NULL, NULL, NULL),
(787, '0GPrc20708.png', 1, NULL, NULL, NULL),
(788, '9zBt220708.png', 1, NULL, NULL, NULL),
(789, '91A2P20308.png', 1, NULL, NULL, NULL),
(790, '8lm3H20508.png', 1, NULL, NULL, NULL),
(791, 'Vkwaq20808.png', 1, NULL, NULL, NULL),
(792, 'GhEZp20608.png', 1, NULL, NULL, NULL),
(793, '5nJIM20708.png', 1, NULL, NULL, NULL),
(794, 'iUEtw20909.jpg', 1, NULL, NULL, NULL),
(795, 'yqlgm20209.jpg', 1, NULL, NULL, NULL),
(796, 'ZBrSt20409.jpg', 1, NULL, NULL, NULL),
(797, 'HnSdM20409.jpg', 1, NULL, NULL, NULL),
(798, 'bQJyf20909.jpg', 1, NULL, NULL, NULL),
(799, 'Rz0of20309.jpg', 1, NULL, NULL, NULL),
(800, 'QK2l320209.jpg', 1, NULL, NULL, NULL),
(801, 'egXad21403.jpg', 1, NULL, NULL, NULL),
(802, 'MYOzf21803.jpg', 1, NULL, NULL, NULL),
(803, 'bOmHB21103.jpg', 1, NULL, NULL, NULL),
(804, 'CNELX21403.jpg', 1, NULL, NULL, NULL),
(805, 'l1Wgk21603.jpg', 1, NULL, NULL, NULL),
(806, 'fb4ph21903.jpg', 1, NULL, NULL, NULL),
(807, 'rDvtp21703.jpg', 1, NULL, NULL, NULL),
(808, 'tP1b721603.jpg', 1, NULL, NULL, NULL),
(535, 'kp7IT19104.jpg', 1, NULL, NULL, NULL),
(536, 'dYoZ120612.jpg', 1, NULL, NULL, NULL),
(537, 'ianfk25812.png', 1, NULL, NULL, NULL),
(560, 'k1gEb22709.jpg', 1, NULL, NULL, NULL),
(570, 'XYzAN23410.jpg', 1, NULL, NULL, NULL),
(586, '0vzx810806.png', 1, NULL, NULL, NULL),
(587, 'hobqI10706.png', 1, NULL, NULL, NULL),
(588, '1qhyL13205.jpg', 1, NULL, NULL, NULL),
(589, 'YkTRS13705.jpg', 1, NULL, NULL, NULL),
(590, 'aQdrK13905.jpg', 1, NULL, NULL, NULL),
(592, 'uAEIj19504.jpg', 1, NULL, NULL, NULL),
(593, 'ZJxM519104.jpg', 1, NULL, NULL, NULL),
(594, 'sm1Xo19704.jpg', 1, NULL, NULL, NULL),
(595, 'zUDco19504.jpg', 1, NULL, NULL, NULL),
(596, 'JyHrj19104.jpg', 1, NULL, NULL, NULL),
(597, 'UMiXd19504.jpg', 1, NULL, NULL, NULL),
(598, 'ePPhc19304.jpg', 1, NULL, NULL, NULL),
(599, 'naHKk19604.jpg', 1, NULL, NULL, NULL),
(600, 'Iz1xq19704.jpg', 1, NULL, NULL, NULL),
(625, 'qOjUZ22503.jpg', 1, NULL, NULL, NULL),
(649, 'SnFlk26707.jpg', 1, NULL, NULL, NULL),
(650, 'n1A8B26607.jpg', 1, NULL, NULL, NULL),
(651, 'd8x3u26307.jpg', 1, NULL, NULL, NULL),
(652, 'cO3uQ26507.jpg', 1, NULL, NULL, NULL),
(653, '4mhTG26807.jpg', 1, NULL, NULL, NULL),
(654, 'pVSAm26307.jpg', 1, NULL, NULL, NULL),
(655, 'XrBdL26907.jpg', 1, NULL, NULL, NULL),
(656, 'mNPVB26407.jpg', 1, NULL, NULL, NULL),
(657, 'QSZxp26907.jpg', 1, NULL, NULL, NULL),
(658, '7tmXZ26307.jpg', 1, NULL, NULL, NULL),
(659, 'ElrSh26407.jpg', 1, NULL, NULL, NULL),
(646, 'cy3vO26807.jpg', 1, NULL, NULL, NULL),
(647, '1DiNb26607.jpg', 1, NULL, NULL, NULL),
(648, 'VkRAI26107.jpg', 1, NULL, NULL, NULL),
(660, 'Isa5g26207.jpg', 1, NULL, NULL, NULL),
(661, 'ulkzG26407.jpg', 1, NULL, NULL, NULL),
(662, 'UobGQ11305.jpg', 1, NULL, NULL, NULL),
(663, 'B8UrS11605.jpg', 1, NULL, NULL, NULL),
(664, 'PGV3Y11105.jpg', 1, NULL, NULL, NULL),
(665, 'SHRTc11805.jpg', 1, NULL, NULL, NULL),
(666, '0QhAh11205.png', 1, NULL, NULL, NULL),
(667, 'kUCMX11608.jpg', 1, NULL, NULL, NULL),
(670, 'icRMP14301.jpg', 1, NULL, NULL, NULL),
(671, 'Tsu5Q31706.jpg', 1, NULL, NULL, NULL),
(674, 'HyNbq31806.jpg', 1, NULL, NULL, NULL),
(677, 'hUVtj31706.jpg', 1, NULL, NULL, NULL),
(685, 'Nfc3I09210.jpg', 1, NULL, NULL, NULL),
(687, 'ZH7ux09810.jpg', 1, NULL, NULL, NULL),
(689, 'JhAd609810.jpg', 1, NULL, NULL, NULL),
(690, 'FluQC09410.jpg', 1, NULL, NULL, NULL),
(691, 'C9uYI09310.jpg', 1, NULL, NULL, NULL),
(707, 'v0T1I14908.png', 1, NULL, NULL, NULL),
(708, 'GymQG14908.png', 1, NULL, NULL, NULL),
(715, 'bD4cM05604.png', 1, NULL, NULL, NULL),
(716, 'XiLt405204.png', 1, NULL, NULL, NULL),
(725, '0rVAX24406.png', 1, NULL, NULL, NULL),
(726, 'e0xUz24806.png', 1, NULL, NULL, NULL),
(739, 'CHYib28110.png', 1, NULL, NULL, NULL),
(740, 'AYtxa28110.png', 1, NULL, NULL, NULL),
(744, 'BdPJn03210.png', 1, NULL, NULL, NULL),
(742, 'KHrWV31705.png', 1, NULL, NULL, NULL),
(743, 'LrI9W31205.png', 1, NULL, NULL, NULL),
(745, 'jSB1603810.png', 1, NULL, NULL, NULL),
(746, 'PS6B903810.png', 1, NULL, NULL, NULL),
(747, 'F7j1E06609.png', 1, NULL, NULL, NULL),
(748, 'kAocK07506.png', 1, NULL, NULL, NULL),
(749, 'znDjV07806.png', 1, NULL, NULL, NULL),
(750, 'klnWy07606.png', 1, NULL, NULL, NULL),
(751, 'bvBfe07506.png', 1, NULL, NULL, NULL),
(758, 'HMTFx07106.png', 1, NULL, NULL, NULL),
(759, '87FPy07606.png', 1, NULL, NULL, NULL),
(760, 'TJ0O507606.png', 1, NULL, NULL, NULL),
(761, 'wTKXG07207.png', 1, NULL, NULL, NULL),
(762, 'zQabQ07407.png', 1, NULL, NULL, NULL),
(768, 'b9Cqw06109.jpg', 1, NULL, NULL, NULL),
(767, 'gqoFZ06206.jpg', 1, NULL, NULL, NULL),
(765, 'c13vc04508.jpg', 1, NULL, NULL, NULL),
(766, 'pCtjA04309.jpg', 1, NULL, NULL, NULL),
(769, 'Lw9fh08905.jpg', 1, NULL, NULL, NULL),
(770, 'CVEtf08405.jpg', 1, NULL, NULL, NULL),
(771, 'Yik7k08105.jpg', 1, NULL, NULL, NULL),
(772, 'WAGEE08712.jpg', 1, NULL, NULL, NULL),
(773, 'JWWlV12910.jpg', 1, NULL, NULL, NULL),
(774, 'TN1Lt12910.jpg', 1, NULL, NULL, NULL),
(775, 'dAKox13511.jpg', 1, NULL, NULL, NULL),
(776, 'Px3Ht13111.jpg', 1, NULL, NULL, NULL),
(777, '1Ox1n14611.jpg', 1, NULL, NULL, NULL),
(824, 'EjCvV13809.png', 1, NULL, NULL, NULL),
(818, 'tSFb406909.png', 1, NULL, NULL, NULL),
(820, 'YAMCN06910.png', 1, NULL, NULL, NULL),
(822, '8m0bK06410.png', 1, NULL, NULL, NULL),
(825, 'kFIyF23511.png', 1, NULL, NULL, NULL),
(826, 'kEedd23811.png', 1, NULL, NULL, NULL),
(827, '3DR2s23311.png', 1, NULL, NULL, NULL),
(828, 'kDW7423711.png', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `image_categories`
--

CREATE TABLE `image_categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `image_id` int(10) UNSIGNED NOT NULL,
  `image_type` enum('ACTUAL','THUMBNAIL','LARGE','MEDIUM') NOT NULL,
  `height` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `path` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `image_categories`
--

INSERT INTO `image_categories` (`id`, `image_id`, `image_type`, `height`, `width`, `path`, `created_at`, `updated_at`) VALUES
(432, 431, 'ACTUAL', 421, 1170, 'images/media/2019/09/vURED27710.jpg', NULL, NULL),
(441, 440, 'ACTUAL', 418, 885, 'images/media/2019/09/mo6Yk27410.jpg', NULL, NULL),
(1529, 779, 'ACTUAL', 1024, 1024, 'images/media/2022/04/NzEhM09605.jpg', NULL, NULL),
(1530, 779, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail1649483920NzEhM09605.jpg', NULL, NULL),
(1531, 779, 'MEDIUM', 400, 400, 'images/media/2022/04/medium1649483920NzEhM09605.jpg', NULL, '2022-04-09 10:01:56'),
(1532, 779, 'LARGE', 900, 900, 'images/media/2022/04/large1649483920NzEhM09605.jpg', NULL, '2022-04-09 09:58:40'),
(1533, 780, 'ACTUAL', 1024, 1024, 'images/media/2022/04/Tbegh09809.jpg', NULL, NULL),
(1534, 780, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail1649495442Tbegh09809.jpg', NULL, NULL),
(1535, 780, 'MEDIUM', 400, 400, 'images/media/2022/04/medium1649495442Tbegh09809.jpg', NULL, NULL),
(1536, 780, 'LARGE', 900, 900, 'images/media/2022/04/large1649495442Tbegh09809.jpg', NULL, '2022-04-09 13:10:42'),
(1537, 781, 'ACTUAL', 1024, 1024, 'images/media/2022/04/hurQN09409.jpg', NULL, NULL),
(1538, 781, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail1649496408hurQN09409.jpg', NULL, NULL),
(1539, 781, 'MEDIUM', 400, 400, 'images/media/2022/04/medium1649496408hurQN09409.jpg', NULL, NULL),
(1540, 781, 'LARGE', 900, 900, 'images/media/2022/04/large1649496408hurQN09409.jpg', NULL, '2022-04-09 13:26:48'),
(1541, 782, 'ACTUAL', 1024, 1024, 'images/media/2022/04/D1csl09809.jpg', NULL, NULL),
(1542, 782, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail1649497630D1csl09809.jpg', NULL, NULL),
(1543, 782, 'MEDIUM', 400, 400, 'images/media/2022/04/medium1649497630D1csl09809.jpg', NULL, NULL),
(1544, 783, 'ACTUAL', 1024, 1024, 'images/media/2022/04/tT1LL09309.jpg', NULL, NULL),
(1545, 782, 'LARGE', 900, 900, 'images/media/2022/04/large1649497631D1csl09809.jpg', NULL, '2022-04-09 13:47:11'),
(1546, 783, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail1649497631tT1LL09309.jpg', NULL, NULL),
(1547, 783, 'MEDIUM', 400, 400, 'images/media/2022/04/medium1649497631tT1LL09309.jpg', NULL, NULL),
(1548, 783, 'LARGE', 900, 900, 'images/media/2022/04/large1649497631tT1LL09309.jpg', NULL, '2022-04-09 13:47:11'),
(1549, 784, 'ACTUAL', 1024, 1024, 'images/media/2022/04/RAfZn09609.jpg', NULL, NULL),
(1550, 784, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail1649497632RAfZn09609.jpg', NULL, NULL),
(1551, 784, 'MEDIUM', 400, 400, 'images/media/2022/04/medium1649497632RAfZn09609.jpg', NULL, NULL),
(1552, 784, 'LARGE', 900, 900, 'images/media/2022/04/large1649497633RAfZn09609.jpg', NULL, '2022-04-09 13:47:13'),
(1553, 785, 'ACTUAL', 1200, 1200, 'images/media/2022/04/231dw20408.png', NULL, NULL),
(1554, 786, 'ACTUAL', 1200, 1200, 'images/media/2022/04/0P3d920108.png', NULL, NULL),
(1555, 786, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail16504417840P3d920108.png', NULL, NULL),
(1556, 785, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail1650441784231dw20408.png', NULL, NULL),
(1557, 786, 'MEDIUM', 400, 400, 'images/media/2022/04/medium16504417840P3d920108.png', NULL, NULL),
(1558, 785, 'MEDIUM', 400, 400, 'images/media/2022/04/medium1650441784231dw20408.png', NULL, NULL),
(1559, 787, 'ACTUAL', 1200, 1200, 'images/media/2022/04/0GPrc20708.png', NULL, NULL),
(1560, 787, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail16504417870GPrc20708.png', NULL, NULL),
(1561, 787, 'MEDIUM', 400, 400, 'images/media/2022/04/medium16504417870GPrc20708.png', NULL, NULL),
(1562, 788, 'ACTUAL', 1200, 1200, 'images/media/2022/04/9zBt220708.png', NULL, NULL),
(1563, 787, 'LARGE', 900, 900, 'images/media/2022/04/large16504417870GPrc20708.png', NULL, '2022-04-20 12:03:07'),
(1564, 788, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail16504417889zBt220708.png', NULL, NULL),
(1565, 788, 'MEDIUM', 400, 400, 'images/media/2022/04/medium16504417889zBt220708.png', NULL, NULL),
(1566, 788, 'LARGE', 900, 900, 'images/media/2022/04/large16504417889zBt220708.png', NULL, '2022-04-20 12:03:08'),
(1567, 789, 'ACTUAL', 1200, 1200, 'images/media/2022/04/91A2P20308.png', NULL, NULL),
(1568, 789, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail165044178991A2P20308.png', NULL, NULL),
(1569, 789, 'MEDIUM', 400, 400, 'images/media/2022/04/medium165044178991A2P20308.png', NULL, NULL),
(1570, 790, 'ACTUAL', 1200, 1200, 'images/media/2022/04/8lm3H20508.png', NULL, NULL),
(1571, 789, 'LARGE', 900, 900, 'images/media/2022/04/large165044179091A2P20308.png', NULL, '2022-04-20 12:03:10'),
(1572, 790, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail16504417908lm3H20508.png', NULL, NULL),
(1573, 790, 'MEDIUM', 400, 400, 'images/media/2022/04/medium16504417908lm3H20508.png', NULL, NULL),
(1574, 791, 'ACTUAL', 1200, 1200, 'images/media/2022/04/Vkwaq20808.png', NULL, NULL),
(1575, 791, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail1650441792Vkwaq20808.png', NULL, NULL),
(1576, 791, 'MEDIUM', 400, 400, 'images/media/2022/04/medium1650441792Vkwaq20808.png', NULL, NULL),
(1577, 792, 'ACTUAL', 1200, 1200, 'images/media/2022/04/GhEZp20608.png', NULL, NULL),
(1578, 792, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail1650441793GhEZp20608.png', NULL, NULL),
(1579, 792, 'MEDIUM', 400, 400, 'images/media/2022/04/medium1650441793GhEZp20608.png', NULL, NULL),
(1580, 792, 'LARGE', 900, 900, 'images/media/2022/04/large1650441793GhEZp20608.png', NULL, '2022-04-20 12:03:13'),
(1581, 793, 'ACTUAL', 1200, 1200, 'images/media/2022/04/5nJIM20708.png', NULL, NULL),
(1582, 793, 'THUMBNAIL', 150, 150, 'images/media/2022/04/thumbnail16504417955nJIM20708.png', NULL, NULL),
(1583, 793, 'MEDIUM', 400, 400, 'images/media/2022/04/medium16504417955nJIM20708.png', NULL, NULL),
(1584, 794, 'ACTUAL', 1039, 622, 'images/media/2022/04/iUEtw20909.jpg', NULL, NULL),
(1585, 795, 'ACTUAL', 1039, 666, 'images/media/2022/04/yqlgm20209.jpg', NULL, NULL),
(1586, 795, 'THUMBNAIL', 150, 96, 'images/media/2022/04/thumbnail1650446510yqlgm20209.jpg', NULL, NULL),
(1587, 794, 'THUMBNAIL', 150, 90, 'images/media/2022/04/thumbnail1650446510iUEtw20909.jpg', NULL, NULL),
(1588, 795, 'MEDIUM', 400, 256, 'images/media/2022/04/medium1650446510yqlgm20209.jpg', NULL, NULL),
(1589, 794, 'MEDIUM', 400, 239, 'images/media/2022/04/medium1650446510iUEtw20909.jpg', NULL, NULL),
(1590, 795, 'LARGE', 900, 577, 'images/media/2022/04/large1650446510yqlgm20209.jpg', NULL, '2022-04-20 13:21:50'),
(1591, 794, 'LARGE', 900, 539, 'images/media/2022/04/large1650446510iUEtw20909.jpg', NULL, '2022-04-20 13:21:50'),
(1592, 796, 'ACTUAL', 889, 576, 'images/media/2022/04/ZBrSt20409.jpg', NULL, NULL),
(1593, 796, 'THUMBNAIL', 150, 97, 'images/media/2022/04/thumbnail1650446512ZBrSt20409.jpg', NULL, NULL),
(1594, 797, 'ACTUAL', 889, 622, 'images/media/2022/04/HnSdM20409.jpg', NULL, NULL),
(1595, 796, 'MEDIUM', 400, 259, 'images/media/2022/04/medium1650446512ZBrSt20409.jpg', NULL, NULL),
(1596, 797, 'THUMBNAIL', 150, 105, 'images/media/2022/04/thumbnail1650446512HnSdM20409.jpg', NULL, NULL),
(1597, 797, 'MEDIUM', 400, 280, 'images/media/2022/04/medium1650446512HnSdM20409.jpg', NULL, NULL),
(1598, 798, 'ACTUAL', 871, 560, 'images/media/2022/04/bQJyf20909.jpg', NULL, NULL),
(1599, 798, 'THUMBNAIL', 150, 96, 'images/media/2022/04/thumbnail1650446514bQJyf20909.jpg', NULL, NULL),
(1600, 798, 'MEDIUM', 400, 257, 'images/media/2022/04/medium1650446514bQJyf20909.jpg', NULL, NULL),
(1601, 799, 'ACTUAL', 871, 576, 'images/media/2022/04/Rz0of20309.jpg', NULL, NULL),
(1602, 799, 'THUMBNAIL', 150, 99, 'images/media/2022/04/thumbnail1650446514Rz0of20309.jpg', NULL, NULL),
(1603, 799, 'MEDIUM', 400, 265, 'images/media/2022/04/medium1650446514Rz0of20309.jpg', NULL, NULL),
(1604, 800, 'ACTUAL', 841, 560, 'images/media/2022/04/QK2l320209.jpg', NULL, NULL),
(1605, 800, 'THUMBNAIL', 150, 100, 'images/media/2022/04/thumbnail1650446516QK2l320209.jpg', NULL, NULL),
(1606, 800, 'MEDIUM', 400, 266, 'images/media/2022/04/medium1650446516QK2l320209.jpg', NULL, NULL),
(1607, 801, 'ACTUAL', 1280, 807, 'images/media/2022/04/egXad21403.jpg', NULL, NULL),
(1608, 801, 'THUMBNAIL', 150, 95, 'images/media/2022/04/thumbnail1650513349egXad21403.jpg', NULL, NULL),
(1609, 802, 'ACTUAL', 1201, 807, 'images/media/2022/04/MYOzf21803.jpg', NULL, NULL),
(1610, 801, 'MEDIUM', 400, 252, 'images/media/2022/04/medium1650513349egXad21403.jpg', NULL, NULL),
(1611, 802, 'THUMBNAIL', 150, 101, 'images/media/2022/04/thumbnail1650513349MYOzf21803.jpg', NULL, NULL),
(1612, 801, 'LARGE', 900, 567, 'images/media/2022/04/large1650513349egXad21403.jpg', NULL, '2022-04-21 07:55:49'),
(1613, 802, 'MEDIUM', 400, 269, 'images/media/2022/04/medium1650513349MYOzf21803.jpg', NULL, NULL),
(1614, 802, 'LARGE', 900, 605, 'images/media/2022/04/large1650513349MYOzf21803.jpg', NULL, '2022-04-21 07:55:49'),
(1615, 803, 'ACTUAL', 1201, 663, 'images/media/2022/04/bOmHB21103.jpg', NULL, NULL),
(1616, 803, 'THUMBNAIL', 150, 83, 'images/media/2022/04/thumbnail1650513351bOmHB21103.jpg', NULL, NULL),
(1617, 803, 'MEDIUM', 400, 221, 'images/media/2022/04/medium1650513351bOmHB21103.jpg', NULL, NULL),
(1618, 804, 'ACTUAL', 1106, 807, 'images/media/2022/04/CNELX21403.jpg', NULL, NULL),
(1619, 803, 'LARGE', 900, 497, 'images/media/2022/04/large1650513351bOmHB21103.jpg', NULL, '2022-04-21 07:55:51'),
(1620, 804, 'THUMBNAIL', 150, 109, 'images/media/2022/04/thumbnail1650513351CNELX21403.jpg', NULL, NULL),
(1621, 804, 'MEDIUM', 400, 292, 'images/media/2022/04/medium1650513351CNELX21403.jpg', NULL, NULL),
(1622, 804, 'LARGE', 900, 657, 'images/media/2022/04/large1650513351CNELX21403.jpg', NULL, '2022-04-21 07:55:51'),
(1623, 805, 'ACTUAL', 1106, 807, 'images/media/2022/04/l1Wgk21603.jpg', NULL, NULL),
(1624, 806, 'ACTUAL', 1106, 807, 'images/media/2022/04/fb4ph21903.jpg', NULL, NULL),
(1625, 805, 'THUMBNAIL', 150, 109, 'images/media/2022/04/thumbnail1650513353l1Wgk21603.jpg', NULL, NULL),
(1626, 806, 'THUMBNAIL', 150, 109, 'images/media/2022/04/thumbnail1650513353fb4ph21903.jpg', NULL, NULL),
(1627, 805, 'MEDIUM', 400, 292, 'images/media/2022/04/medium1650513353l1Wgk21603.jpg', NULL, NULL),
(1628, 806, 'MEDIUM', 400, 292, 'images/media/2022/04/medium1650513353fb4ph21903.jpg', NULL, NULL),
(1629, 805, 'LARGE', 900, 657, 'images/media/2022/04/large1650513353l1Wgk21603.jpg', NULL, '2022-04-21 07:55:53'),
(1630, 806, 'LARGE', 900, 657, 'images/media/2022/04/large1650513353fb4ph21903.jpg', NULL, '2022-04-21 07:55:53'),
(1631, 807, 'ACTUAL', 1039, 715, 'images/media/2022/04/rDvtp21703.jpg', NULL, NULL),
(1632, 807, 'THUMBNAIL', 150, 103, 'images/media/2022/04/thumbnail1650513354rDvtp21703.jpg', NULL, NULL),
(1633, 807, 'MEDIUM', 400, 275, 'images/media/2022/04/medium1650513354rDvtp21703.jpg', NULL, NULL),
(1634, 808, 'ACTUAL', 1106, 715, 'images/media/2022/04/tP1b721603.jpg', NULL, NULL),
(1635, 807, 'LARGE', 900, 619, 'images/media/2022/04/large1650513354rDvtp21703.jpg', NULL, '2022-04-21 07:55:54'),
(1636, 808, 'THUMBNAIL', 150, 97, 'images/media/2022/04/thumbnail1650513354tP1b721603.jpg', NULL, NULL),
(1637, 808, 'MEDIUM', 400, 259, 'images/media/2022/04/medium1650513354tP1b721603.jpg', NULL, NULL),
(1638, 808, 'LARGE', 900, 582, 'images/media/2022/04/large1650513355tP1b721603.jpg', NULL, '2022-04-21 07:55:55'),
(665, 535, 'ACTUAL', 885, 1673, 'images/media/2020/03/kp7IT19104.jpg', NULL, NULL),
(666, 535, 'THUMBNAIL', 79, 150, 'images/media/2020/03/thumbnail1584636420kp7IT19104.jpg', NULL, NULL),
(667, 535, 'MEDIUM', 212, 400, 'images/media/2020/03/medium1584636420kp7IT19104.jpg', NULL, NULL),
(668, 535, 'LARGE', 476, 900, 'images/media/2020/03/large1584636420kp7IT19104.jpg', NULL, NULL),
(669, 536, 'ACTUAL', 230, 370, 'images/media/2020/03/dYoZ120612.jpg', NULL, NULL),
(670, 536, 'THUMBNAIL', 93, 150, 'images/media/2020/03/thumbnail1584706724dYoZ120612.jpg', NULL, NULL),
(671, 537, 'ACTUAL', 43, 172, 'images/media/2020/03/ianfk25812.png', NULL, NULL),
(672, 537, 'THUMBNAIL', 38, 150, 'images/media/2020/03/thumbnail1585137994ianfk25812.png', NULL, NULL),
(736, 560, 'ACTUAL', 1024, 1024, 'images/media/2020/07/k1gEb22709.jpg', NULL, NULL),
(737, 560, 'THUMBNAIL', 150, 150, 'images/media/2020/07/thumbnail1595409856k1gEb22709.jpg', NULL, NULL),
(738, 560, 'MEDIUM', 400, 400, 'images/media/2020/07/medium1595409856k1gEb22709.jpg', NULL, NULL),
(739, 560, 'LARGE', 900, 900, 'images/media/2020/07/large1595409856k1gEb22709.jpg', NULL, '2020-07-22 13:24:16'),
(776, 570, 'ACTUAL', 1024, 1024, 'images/media/2020/07/XYzAN23410.jpg', NULL, NULL),
(777, 570, 'THUMBNAIL', 150, 150, 'images/media/2020/07/thumbnail1595500518XYzAN23410.jpg', NULL, NULL),
(778, 570, 'MEDIUM', 400, 400, 'images/media/2020/07/medium1595500518XYzAN23410.jpg', NULL, NULL),
(779, 570, 'LARGE', 900, 900, 'images/media/2020/07/large1595500518XYzAN23410.jpg', NULL, '2020-07-23 14:35:18'),
(839, 586, 'THUMBNAIL', 88, 150, 'images/media/2020/08/thumbnail15970410550vzx810806.png', NULL, NULL),
(838, 586, 'ACTUAL', 600, 1024, 'images/media/2020/08/0vzx810806.png', NULL, NULL),
(840, 586, 'MEDIUM', 234, 400, 'images/media/2020/08/medium15970410550vzx810806.png', NULL, NULL),
(841, 587, 'ACTUAL', 600, 1024, 'images/media/2020/08/hobqI10706.png', NULL, NULL),
(842, 587, 'THUMBNAIL', 88, 150, 'images/media/2020/08/thumbnail1597041214hobqI10706.png', NULL, NULL),
(843, 587, 'MEDIUM', 234, 400, 'images/media/2020/08/medium1597041215hobqI10706.png', NULL, NULL),
(844, 587, 'LARGE', 527, 900, 'images/media/2020/08/large1597041215hobqI10706.png', NULL, '2020-08-10 10:33:35'),
(845, 588, 'ACTUAL', 600, 1024, 'images/media/2020/08/1qhyL13205.jpg', NULL, NULL),
(846, 588, 'THUMBNAIL', 88, 150, 'images/media/2020/08/thumbnail15972976561qhyL13205.jpg', NULL, NULL),
(847, 588, 'MEDIUM', 234, 400, 'images/media/2020/08/medium15972976561qhyL13205.jpg', NULL, NULL),
(848, 588, 'LARGE', 527, 900, 'images/media/2020/08/large15972976561qhyL13205.jpg', NULL, '2020-08-13 09:47:36'),
(849, 589, 'ACTUAL', 600, 1024, 'images/media/2020/08/YkTRS13705.jpg', NULL, NULL),
(850, 589, 'THUMBNAIL', 88, 150, 'images/media/2020/08/thumbnail1597297679YkTRS13705.jpg', NULL, NULL),
(851, 589, 'MEDIUM', 234, 400, 'images/media/2020/08/medium1597297679YkTRS13705.jpg', NULL, NULL),
(852, 589, 'LARGE', 527, 900, 'images/media/2020/08/large1597297679YkTRS13705.jpg', NULL, '2020-08-13 09:47:59'),
(853, 590, 'ACTUAL', 600, 1024, 'images/media/2020/08/aQdrK13905.jpg', NULL, NULL),
(854, 590, 'THUMBNAIL', 88, 150, 'images/media/2020/08/thumbnail1597297680aQdrK13905.jpg', NULL, NULL),
(855, 590, 'MEDIUM', 234, 400, 'images/media/2020/08/medium1597297680aQdrK13905.jpg', NULL, NULL),
(856, 590, 'LARGE', 527, 900, 'images/media/2020/08/large1597297680aQdrK13905.jpg', NULL, '2020-08-13 09:48:00'),
(861, 592, 'ACTUAL', 600, 1024, 'images/media/2020/08/uAEIj19504.jpg', NULL, NULL),
(862, 592, 'THUMBNAIL', 88, 150, 'images/media/2020/08/thumbnail1597811210uAEIj19504.jpg', NULL, NULL),
(863, 592, 'MEDIUM', 234, 400, 'images/media/2020/08/medium1597811210uAEIj19504.jpg', NULL, NULL),
(864, 593, 'ACTUAL', 1024, 1024, 'images/media/2020/08/ZJxM519104.jpg', NULL, NULL),
(865, 593, 'THUMBNAIL', 150, 150, 'images/media/2020/08/thumbnail1597811219ZJxM519104.jpg', NULL, NULL),
(866, 593, 'MEDIUM', 400, 400, 'images/media/2020/08/medium1597811219ZJxM519104.jpg', NULL, NULL),
(867, 593, 'LARGE', 900, 900, 'images/media/2020/08/large1597811220ZJxM519104.jpg', NULL, '2020-08-19 08:27:00'),
(868, 594, 'ACTUAL', 1024, 1024, 'images/media/2020/08/sm1Xo19704.jpg', NULL, NULL),
(869, 594, 'THUMBNAIL', 150, 150, 'images/media/2020/08/thumbnail1597811220sm1Xo19704.jpg', NULL, NULL),
(870, 594, 'MEDIUM', 400, 400, 'images/media/2020/08/medium1597811220sm1Xo19704.jpg', NULL, NULL),
(871, 594, 'LARGE', 900, 900, 'images/media/2020/08/large1597811221sm1Xo19704.jpg', NULL, '2020-08-19 08:27:01'),
(872, 595, 'ACTUAL', 1024, 1024, 'images/media/2020/08/zUDco19504.jpg', NULL, NULL),
(873, 595, 'THUMBNAIL', 150, 150, 'images/media/2020/08/thumbnail1597811222zUDco19504.jpg', NULL, NULL),
(874, 595, 'MEDIUM', 400, 400, 'images/media/2020/08/medium1597811222zUDco19504.jpg', NULL, NULL),
(875, 595, 'LARGE', 900, 900, 'images/media/2020/08/large1597811222zUDco19504.jpg', NULL, '2020-08-19 08:27:02'),
(876, 596, 'ACTUAL', 1024, 1024, 'images/media/2020/08/JyHrj19104.jpg', NULL, NULL),
(877, 596, 'THUMBNAIL', 150, 150, 'images/media/2020/08/thumbnail1597811223JyHrj19104.jpg', NULL, NULL),
(878, 596, 'MEDIUM', 400, 400, 'images/media/2020/08/medium1597811223JyHrj19104.jpg', NULL, NULL),
(879, 596, 'LARGE', 900, 900, 'images/media/2020/08/large1597811223JyHrj19104.jpg', NULL, '2020-08-19 08:27:03'),
(880, 597, 'ACTUAL', 1024, 1024, 'images/media/2020/08/UMiXd19504.jpg', NULL, NULL),
(881, 597, 'THUMBNAIL', 150, 150, 'images/media/2020/08/thumbnail1597811224UMiXd19504.jpg', NULL, NULL),
(882, 597, 'MEDIUM', 400, 400, 'images/media/2020/08/medium1597811224UMiXd19504.jpg', NULL, NULL),
(883, 597, 'LARGE', 900, 900, 'images/media/2020/08/large1597811224UMiXd19504.jpg', NULL, '2020-08-19 08:27:04'),
(884, 598, 'ACTUAL', 1024, 1024, 'images/media/2020/08/ePPhc19304.jpg', NULL, NULL),
(885, 598, 'THUMBNAIL', 150, 150, 'images/media/2020/08/thumbnail1597811225ePPhc19304.jpg', NULL, NULL),
(886, 598, 'MEDIUM', 400, 400, 'images/media/2020/08/medium1597811225ePPhc19304.jpg', NULL, NULL),
(887, 598, 'LARGE', 900, 900, 'images/media/2020/08/large1597811225ePPhc19304.jpg', NULL, '2020-08-19 08:27:05'),
(888, 599, 'ACTUAL', 1024, 1024, 'images/media/2020/08/naHKk19604.jpg', NULL, NULL),
(889, 599, 'THUMBNAIL', 150, 150, 'images/media/2020/08/thumbnail1597811226naHKk19604.jpg', NULL, NULL),
(890, 599, 'MEDIUM', 400, 400, 'images/media/2020/08/medium1597811226naHKk19604.jpg', NULL, NULL),
(891, 599, 'LARGE', 900, 900, 'images/media/2020/08/large1597811226naHKk19604.jpg', NULL, '2020-08-19 08:27:06'),
(892, 600, 'ACTUAL', 1024, 1024, 'images/media/2020/08/Iz1xq19704.jpg', NULL, NULL),
(893, 600, 'THUMBNAIL', 150, 150, 'images/media/2020/08/thumbnail1597811227Iz1xq19704.jpg', NULL, NULL),
(894, 600, 'MEDIUM', 400, 400, 'images/media/2020/08/medium1597811227Iz1xq19704.jpg', NULL, NULL),
(895, 600, 'LARGE', 900, 900, 'images/media/2020/08/large1597811227Iz1xq19704.jpg', NULL, '2020-08-19 08:27:07'),
(971, 625, 'ACTUAL', 660, 1049, 'images/media/2020/09/qOjUZ22503.jpg', NULL, NULL),
(972, 625, 'THUMBNAIL', 94, 150, 'images/media/2020/09/thumbnail1600746992qOjUZ22503.jpg', NULL, NULL),
(973, 625, 'MEDIUM', 252, 400, 'images/media/2020/09/medium1600746992qOjUZ22503.jpg', NULL, NULL),
(974, 625, 'LARGE', 566, 900, 'images/media/2020/09/large1600746992qOjUZ22503.jpg', NULL, '2020-09-22 07:56:32'),
(1122, 663, 'ACTUAL', 1024, 1024, 'images/media/2020/10/B8UrS11605.jpg', NULL, NULL),
(1123, 663, 'THUMBNAIL', 150, 150, 'images/media/2020/10/thumbnail1602394382B8UrS11605.jpg', NULL, NULL),
(1119, 662, 'ACTUAL', 1024, 1024, 'images/media/2020/10/UobGQ11305.jpg', NULL, NULL),
(1120, 662, 'THUMBNAIL', 150, 150, 'images/media/2020/10/thumbnail1602394382UobGQ11305.jpg', NULL, NULL),
(1121, 662, 'MEDIUM', 400, 400, 'images/media/2020/10/medium1602394382UobGQ11305.jpg', NULL, NULL),
(1072, 650, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104733n1A8B26607.jpg', NULL, NULL),
(1073, 650, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104733n1A8B26607.jpg', NULL, NULL),
(1074, 651, 'ACTUAL', 1024, 1024, 'images/media/2020/09/d8x3u26307.jpg', NULL, NULL),
(1075, 651, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104733d8x3u26307.jpg', NULL, NULL),
(1076, 650, 'LARGE', 900, 900, 'images/media/2020/09/large1601104733n1A8B26607.jpg', NULL, '2020-09-26 11:18:53'),
(1077, 651, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104733d8x3u26307.jpg', NULL, NULL),
(1078, 651, 'LARGE', 900, 900, 'images/media/2020/09/large1601104734d8x3u26307.jpg', NULL, '2020-09-26 11:18:54'),
(1079, 652, 'ACTUAL', 1024, 1024, 'images/media/2020/09/cO3uQ26507.jpg', NULL, NULL),
(1080, 652, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104735cO3uQ26507.jpg', NULL, NULL),
(1081, 652, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104735cO3uQ26507.jpg', NULL, NULL),
(1082, 653, 'ACTUAL', 1024, 1024, 'images/media/2020/09/4mhTG26807.jpg', NULL, NULL),
(1083, 652, 'LARGE', 900, 900, 'images/media/2020/09/large1601104735cO3uQ26507.jpg', NULL, '2020-09-26 11:18:55'),
(1084, 653, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail16011047354mhTG26807.jpg', NULL, NULL),
(1085, 653, 'MEDIUM', 400, 400, 'images/media/2020/09/medium16011047354mhTG26807.jpg', NULL, NULL),
(1086, 653, 'LARGE', 900, 900, 'images/media/2020/09/large16011047354mhTG26807.jpg', NULL, '2020-09-26 11:18:55'),
(1087, 654, 'ACTUAL', 1024, 1024, 'images/media/2020/09/pVSAm26307.jpg', NULL, NULL),
(1088, 654, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104736pVSAm26307.jpg', NULL, NULL),
(1089, 654, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104736pVSAm26307.jpg', NULL, NULL),
(1090, 654, 'LARGE', 900, 900, 'images/media/2020/09/large1601104737pVSAm26307.jpg', NULL, '2020-09-26 11:18:57'),
(1091, 655, 'ACTUAL', 1024, 1024, 'images/media/2020/09/XrBdL26907.jpg', NULL, NULL),
(1092, 655, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104737XrBdL26907.jpg', NULL, NULL),
(1093, 655, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104737XrBdL26907.jpg', NULL, NULL),
(1094, 655, 'LARGE', 900, 900, 'images/media/2020/09/large1601104737XrBdL26907.jpg', NULL, '2020-09-26 11:18:57'),
(1095, 656, 'ACTUAL', 1024, 1024, 'images/media/2020/09/mNPVB26407.jpg', NULL, NULL),
(1096, 656, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104738mNPVB26407.jpg', NULL, NULL),
(1097, 656, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104738mNPVB26407.jpg', NULL, NULL),
(1098, 656, 'LARGE', 900, 900, 'images/media/2020/09/large1601104738mNPVB26407.jpg', NULL, '2020-09-26 11:18:58'),
(1099, 657, 'ACTUAL', 1024, 1024, 'images/media/2020/09/QSZxp26907.jpg', NULL, NULL),
(1100, 657, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104738QSZxp26907.jpg', NULL, NULL),
(1101, 657, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104739QSZxp26907.jpg', NULL, NULL),
(1102, 657, 'LARGE', 900, 900, 'images/media/2020/09/large1601104739QSZxp26907.jpg', NULL, '2020-09-26 11:18:59'),
(1103, 658, 'ACTUAL', 1024, 1024, 'images/media/2020/09/7tmXZ26307.jpg', NULL, NULL),
(1104, 658, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail16011047407tmXZ26307.jpg', NULL, NULL),
(1105, 658, 'MEDIUM', 400, 400, 'images/media/2020/09/medium16011047407tmXZ26307.jpg', NULL, NULL),
(1106, 659, 'ACTUAL', 1024, 1024, 'images/media/2020/09/ElrSh26407.jpg', NULL, NULL),
(1107, 658, 'LARGE', 900, 900, 'images/media/2020/09/large16011047407tmXZ26307.jpg', NULL, '2020-09-26 11:19:00'),
(1108, 659, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104740ElrSh26407.jpg', NULL, NULL),
(1109, 659, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104740ElrSh26407.jpg', NULL, NULL),
(1110, 659, 'LARGE', 900, 900, 'images/media/2020/09/large1601104741ElrSh26407.jpg', NULL, '2020-09-26 11:19:01'),
(1111, 660, 'ACTUAL', 1024, 1024, 'images/media/2020/09/Isa5g26207.jpg', NULL, NULL),
(1112, 660, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104742Isa5g26207.jpg', NULL, NULL),
(1113, 660, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104742Isa5g26207.jpg', NULL, NULL),
(1114, 661, 'ACTUAL', 1024, 1024, 'images/media/2020/09/ulkzG26407.jpg', NULL, NULL),
(1115, 661, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104742ulkzG26407.jpg', NULL, NULL),
(1116, 660, 'LARGE', 900, 900, 'images/media/2020/09/large1601104742Isa5g26207.jpg', NULL, '2020-09-26 11:19:02'),
(1117, 661, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104742ulkzG26407.jpg', NULL, NULL),
(1118, 661, 'LARGE', 900, 900, 'images/media/2020/09/large1601104742ulkzG26407.jpg', NULL, '2020-09-26 11:19:02'),
(1071, 650, 'ACTUAL', 1024, 1024, 'images/media/2020/09/n1A8B26607.jpg', NULL, NULL),
(1069, 648, 'LARGE', 900, 900, 'images/media/2020/09/large1601104732VkRAI26107.jpg', NULL, '2020-09-26 11:18:52'),
(1070, 649, 'LARGE', 900, 900, 'images/media/2020/09/large1601104732SnFlk26707.jpg', NULL, '2020-09-26 11:18:52'),
(1068, 649, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104731SnFlk26707.jpg', NULL, NULL),
(1055, 646, 'ACTUAL', 1024, 1024, 'images/media/2020/09/cy3vO26807.jpg', NULL, NULL),
(1056, 647, 'ACTUAL', 1024, 1024, 'images/media/2020/09/1DiNb26607.jpg', NULL, NULL),
(1057, 646, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104729cy3vO26807.jpg', NULL, NULL),
(1058, 646, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104729cy3vO26807.jpg', NULL, NULL),
(1059, 647, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail16011047291DiNb26607.jpg', NULL, NULL),
(1060, 647, 'MEDIUM', 400, 400, 'images/media/2020/09/medium16011047301DiNb26607.jpg', NULL, NULL),
(1061, 646, 'LARGE', 900, 900, 'images/media/2020/09/large1601104730cy3vO26807.jpg', NULL, '2020-09-26 11:18:50'),
(1062, 647, 'LARGE', 900, 900, 'images/media/2020/09/large16011047301DiNb26607.jpg', NULL, '2020-09-26 11:18:50'),
(1063, 648, 'ACTUAL', 1024, 1024, 'images/media/2020/09/VkRAI26107.jpg', NULL, NULL),
(1064, 649, 'ACTUAL', 1024, 1024, 'images/media/2020/09/SnFlk26707.jpg', NULL, NULL),
(1065, 648, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104731VkRAI26107.jpg', NULL, NULL),
(1066, 649, 'THUMBNAIL', 150, 150, 'images/media/2020/09/thumbnail1601104731SnFlk26707.jpg', NULL, NULL),
(1067, 648, 'MEDIUM', 400, 400, 'images/media/2020/09/medium1601104731VkRAI26107.jpg', NULL, NULL),
(1124, 662, 'LARGE', 900, 900, 'images/media/2020/10/large1602394382UobGQ11305.jpg', NULL, '2020-10-11 09:33:02'),
(1125, 663, 'MEDIUM', 400, 400, 'images/media/2020/10/medium1602394382B8UrS11605.jpg', NULL, NULL),
(1126, 663, 'LARGE', 900, 900, 'images/media/2020/10/large1602394382B8UrS11605.jpg', NULL, '2020-10-11 09:33:02'),
(1127, 664, 'ACTUAL', 1024, 1024, 'images/media/2020/10/PGV3Y11105.jpg', NULL, NULL),
(1128, 664, 'THUMBNAIL', 150, 150, 'images/media/2020/10/thumbnail1602394383PGV3Y11105.jpg', NULL, NULL),
(1129, 664, 'MEDIUM', 400, 400, 'images/media/2020/10/medium1602394384PGV3Y11105.jpg', NULL, NULL),
(1130, 664, 'LARGE', 900, 900, 'images/media/2020/10/large1602394384PGV3Y11105.jpg', NULL, '2020-10-11 09:33:04'),
(1131, 665, 'ACTUAL', 1024, 1024, 'images/media/2020/10/SHRTc11805.jpg', NULL, NULL),
(1132, 665, 'THUMBNAIL', 150, 150, 'images/media/2020/10/thumbnail1602394384SHRTc11805.jpg', NULL, NULL),
(1133, 665, 'MEDIUM', 400, 400, 'images/media/2020/10/medium1602394385SHRTc11805.jpg', NULL, NULL),
(1134, 665, 'LARGE', 900, 900, 'images/media/2020/10/large1602394385SHRTc11805.jpg', NULL, '2020-10-11 09:33:05'),
(1135, 666, 'ACTUAL', 418, 885, 'images/media/2020/10/0QhAh11205.png', NULL, NULL),
(1136, 666, 'THUMBNAIL', 71, 150, 'images/media/2020/10/thumbnail16023943860QhAh11205.png', NULL, NULL),
(1137, 666, 'MEDIUM', 189, 400, 'images/media/2020/10/medium16023943860QhAh11205.png', NULL, NULL),
(1138, 667, 'ACTUAL', 1024, 1024, 'images/media/2020/10/kUCMX11608.jpg', NULL, NULL),
(1139, 667, 'THUMBNAIL', 150, 150, 'images/media/2020/10/thumbnail1602406323kUCMX11608.jpg', NULL, NULL),
(1140, 667, 'MEDIUM', 400, 400, 'images/media/2020/10/medium1602406323kUCMX11608.jpg', NULL, NULL),
(1141, 667, 'LARGE', 900, 900, 'images/media/2020/10/large1602406323kUCMX11608.jpg', NULL, '2020-10-11 12:52:03'),
(1149, 670, 'ACTUAL', 1024, 1024, 'images/media/2020/10/icRMP14301.jpg', NULL, NULL),
(1150, 670, 'THUMBNAIL', 150, 150, 'images/media/2020/10/thumbnail1602681782icRMP14301.jpg', NULL, NULL),
(1151, 670, 'MEDIUM', 400, 400, 'images/media/2020/10/medium1602681783icRMP14301.jpg', NULL, NULL),
(1152, 670, 'LARGE', 900, 900, 'images/media/2020/10/large1602681783icRMP14301.jpg', NULL, '2020-10-14 05:23:03'),
(1153, 671, 'ACTUAL', 1024, 1024, 'images/media/2020/10/Tsu5Q31706.jpg', NULL, NULL),
(1154, 671, 'THUMBNAIL', 150, 150, 'images/media/2020/10/thumbnail1604125628Tsu5Q31706.jpg', NULL, NULL),
(1155, 671, 'MEDIUM', 400, 400, 'images/media/2020/10/medium1604125628Tsu5Q31706.jpg', NULL, NULL),
(1156, 671, 'LARGE', 900, 900, 'images/media/2020/10/large1604125628Tsu5Q31706.jpg', NULL, '2020-10-31 10:27:08'),
(1165, 674, 'ACTUAL', 1024, 1024, 'images/media/2020/10/HyNbq31806.jpg', NULL, NULL),
(1166, 674, 'THUMBNAIL', 150, 150, 'images/media/2020/10/thumbnail1604125632HyNbq31806.jpg', NULL, NULL),
(1167, 674, 'MEDIUM', 400, 400, 'images/media/2020/10/medium1604125632HyNbq31806.jpg', NULL, NULL),
(1169, 674, 'LARGE', 900, 900, 'images/media/2020/10/large1604125633HyNbq31806.jpg', NULL, '2020-10-31 10:27:13'),
(1206, 685, 'THUMBNAIL', 150, 150, 'images/media/2020/12/thumbnail1607509307Nfc3I09210.jpg', NULL, NULL),
(1204, 685, 'ACTUAL', 1600, 1600, 'images/media/2020/12/Nfc3I09210.jpg', NULL, NULL),
(1177, 677, 'ACTUAL', 1024, 1024, 'images/media/2020/10/hUVtj31706.jpg', NULL, NULL),
(1178, 677, 'THUMBNAIL', 150, 150, 'images/media/2020/10/thumbnail1604125636hUVtj31706.jpg', NULL, NULL),
(1179, 677, 'MEDIUM', 400, 400, 'images/media/2020/10/medium1604125636hUVtj31706.jpg', NULL, NULL),
(1180, 677, 'LARGE', 900, 900, 'images/media/2020/10/large1604125636hUVtj31706.jpg', NULL, '2020-10-31 10:27:16'),
(1214, 687, 'THUMBNAIL', 150, 150, 'images/media/2020/12/thumbnail1607509312ZH7ux09810.jpg', NULL, NULL),
(1213, 687, 'ACTUAL', 1600, 1600, 'images/media/2020/12/ZH7ux09810.jpg', NULL, NULL),
(1208, 685, 'MEDIUM', 400, 400, 'images/media/2020/12/medium1607509308Nfc3I09210.jpg', NULL, NULL),
(1209, 685, 'LARGE', 900, 900, 'images/media/2020/12/large1607509308Nfc3I09210.jpg', NULL, '2020-12-09 15:21:48'),
(1215, 687, 'MEDIUM', 400, 400, 'images/media/2020/12/medium1607509312ZH7ux09810.jpg', NULL, NULL),
(1216, 687, 'LARGE', 900, 900, 'images/media/2020/12/large1607509312ZH7ux09810.jpg', NULL, '2020-12-09 15:21:52'),
(1218, 689, 'ACTUAL', 1600, 1600, 'images/media/2020/12/JhAd609810.jpg', NULL, NULL),
(1220, 689, 'THUMBNAIL', 150, 150, 'images/media/2020/12/thumbnail1607509314JhAd609810.jpg', NULL, NULL),
(1222, 689, 'MEDIUM', 400, 400, 'images/media/2020/12/medium1607509315JhAd609810.jpg', NULL, NULL),
(1224, 689, 'LARGE', 900, 900, 'images/media/2020/12/large1607509315JhAd609810.jpg', NULL, '2020-12-09 15:21:55'),
(1225, 690, 'ACTUAL', 1600, 1600, 'images/media/2020/12/FluQC09410.jpg', NULL, NULL),
(1226, 690, 'THUMBNAIL', 150, 150, 'images/media/2020/12/thumbnail1607509317FluQC09410.jpg', NULL, NULL),
(1227, 690, 'MEDIUM', 400, 400, 'images/media/2020/12/medium1607509317FluQC09410.jpg', NULL, NULL),
(1228, 691, 'ACTUAL', 1600, 1600, 'images/media/2020/12/C9uYI09310.jpg', NULL, NULL),
(1229, 690, 'LARGE', 900, 900, 'images/media/2020/12/large1607509318FluQC09410.jpg', NULL, '2020-12-09 15:21:58'),
(1230, 691, 'THUMBNAIL', 150, 150, 'images/media/2020/12/thumbnail1607509318C9uYI09310.jpg', NULL, NULL),
(1231, 691, 'MEDIUM', 400, 400, 'images/media/2020/12/medium1607509318C9uYI09310.jpg', NULL, NULL),
(1232, 691, 'LARGE', 900, 900, 'images/media/2020/12/large1607509319C9uYI09310.jpg', NULL, '2020-12-09 15:21:59'),
(1281, 707, 'ACTUAL', 1024, 1024, 'images/media/2020/12/v0T1I14908.png', NULL, NULL),
(1282, 707, 'THUMBNAIL', 150, 150, 'images/media/2020/12/thumbnail1607936316v0T1I14908.png', NULL, NULL),
(1283, 708, 'ACTUAL', 1024, 1024, 'images/media/2020/12/GymQG14908.png', NULL, NULL),
(1284, 708, 'THUMBNAIL', 150, 150, 'images/media/2020/12/thumbnail1607936317GymQG14908.png', NULL, NULL),
(1285, 707, 'MEDIUM', 400, 400, 'images/media/2020/12/medium1607936317v0T1I14908.png', NULL, NULL),
(1286, 708, 'MEDIUM', 400, 400, 'images/media/2020/12/medium1607936317GymQG14908.png', NULL, NULL),
(1305, 715, 'ACTUAL', 577, 433, 'images/media/2021/01/bD4cM05604.png', NULL, NULL),
(1307, 716, 'ACTUAL', 550, 454, 'images/media/2021/01/XiLt405204.png', NULL, NULL),
(1308, 716, 'THUMBNAIL', 150, 124, 'images/media/2021/01/thumbnail1609821266XiLt405204.png', NULL, NULL),
(1309, 716, 'MEDIUM', 400, 330, 'images/media/2021/01/medium1609821267XiLt405204.png', NULL, NULL),
(1337, 725, 'ACTUAL', 1024, 1024, 'images/media/2021/01/0rVAX24406.png', NULL, NULL),
(1338, 725, 'THUMBNAIL', 150, 150, 'images/media/2021/01/thumbnail16114698900rVAX24406.png', NULL, NULL),
(1339, 726, 'ACTUAL', 1024, 1024, 'images/media/2021/01/e0xUz24806.png', NULL, NULL),
(1340, 726, 'THUMBNAIL', 150, 150, 'images/media/2021/01/thumbnail1611471063e0xUz24806.png', NULL, NULL),
(1341, 726, 'MEDIUM', 400, 400, 'images/media/2021/01/medium1611471063e0xUz24806.png', NULL, NULL),
(1387, 739, 'ACTUAL', 1024, 1024, 'images/media/2021/01/CHYib28110.png', NULL, NULL),
(1388, 739, 'THUMBNAIL', 150, 150, 'images/media/2021/01/thumbnail1611830550CHYib28110.png', NULL, NULL),
(1389, 739, 'MEDIUM', 400, 400, 'images/media/2021/01/medium1611830550CHYib28110.png', NULL, NULL),
(1390, 739, 'LARGE', 900, 900, 'images/media/2021/01/large1611830551CHYib28110.png', NULL, '2021-01-28 15:42:31'),
(1391, 740, 'ACTUAL', 1024, 1024, 'images/media/2021/01/AYtxa28110.png', NULL, NULL),
(1392, 740, 'THUMBNAIL', 150, 150, 'images/media/2021/01/thumbnail1611830565AYtxa28110.png', NULL, NULL),
(1393, 740, 'MEDIUM', 400, 400, 'images/media/2021/01/medium1611830565AYtxa28110.png', NULL, NULL),
(1407, 744, 'MEDIUM', 400, 400, 'images/media/2021/02/medium1612347050BdPJn03210.png', NULL, NULL),
(1406, 744, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612347050BdPJn03210.png', NULL, NULL),
(1405, 744, 'ACTUAL', 1024, 1024, 'images/media/2021/02/BdPJn03210.png', NULL, NULL),
(1397, 742, 'ACTUAL', 1024, 1024, 'images/media/2021/01/KHrWV31705.png', NULL, NULL),
(1398, 742, 'THUMBNAIL', 150, 150, 'images/media/2021/01/thumbnail1612069326KHrWV31705.png', NULL, NULL),
(1399, 742, 'MEDIUM', 400, 400, 'images/media/2021/01/medium1612069326KHrWV31705.png', NULL, NULL),
(1400, 742, 'LARGE', 900, 900, 'images/media/2021/01/large1612069327KHrWV31705.png', NULL, '2021-01-31 10:02:07'),
(1401, 743, 'ACTUAL', 1024, 1024, 'images/media/2021/01/LrI9W31205.png', NULL, NULL),
(1402, 743, 'THUMBNAIL', 150, 150, 'images/media/2021/01/thumbnail1612069341LrI9W31205.png', NULL, NULL),
(1403, 743, 'MEDIUM', 400, 400, 'images/media/2021/01/medium1612069341LrI9W31205.png', NULL, NULL),
(1404, 743, 'LARGE', 900, 900, 'images/media/2021/01/large1612069342LrI9W31205.png', NULL, '2021-01-31 10:02:22'),
(1408, 744, 'LARGE', 900, 900, 'images/media/2021/02/large1612347051BdPJn03210.png', NULL, '2021-02-03 15:10:51'),
(1409, 745, 'ACTUAL', 1024, 1024, 'images/media/2021/02/jSB1603810.png', NULL, NULL),
(1410, 745, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612347877jSB1603810.png', NULL, NULL),
(1411, 745, 'MEDIUM', 400, 400, 'images/media/2021/02/medium1612347877jSB1603810.png', NULL, NULL),
(1412, 746, 'ACTUAL', 1024, 1024, 'images/media/2021/02/PS6B903810.png', NULL, NULL),
(1413, 746, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612348629PS6B903810.png', NULL, NULL),
(1414, 746, 'MEDIUM', 400, 400, 'images/media/2021/02/medium1612348630PS6B903810.png', NULL, NULL),
(1415, 746, 'LARGE', 900, 900, 'images/media/2021/02/large1612348630PS6B903810.png', NULL, '2021-02-03 15:37:10'),
(1416, 747, 'ACTUAL', 1024, 1024, 'images/media/2021/02/F7j1E06609.png', NULL, NULL),
(1417, 747, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612604917F7j1E06609.png', NULL, NULL),
(1418, 747, 'MEDIUM', 400, 400, 'images/media/2021/02/medium1612604917F7j1E06609.png', NULL, NULL),
(1419, 748, 'ACTUAL', 1024, 1024, 'images/media/2021/02/kAocK07506.png', NULL, NULL),
(1420, 748, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612680199kAocK07506.png', NULL, NULL),
(1421, 748, 'MEDIUM', 400, 400, 'images/media/2021/02/medium1612680199kAocK07506.png', NULL, NULL),
(1422, 749, 'ACTUAL', 1024, 1024, 'images/media/2021/02/znDjV07806.png', NULL, NULL),
(1423, 749, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612680472znDjV07806.png', NULL, NULL),
(1424, 749, 'MEDIUM', 400, 400, 'images/media/2021/02/medium1612680472znDjV07806.png', NULL, NULL),
(1425, 749, 'LARGE', 900, 900, 'images/media/2021/02/large1612680473znDjV07806.png', NULL, '2021-02-07 11:47:53'),
(1426, 750, 'ACTUAL', 1024, 1024, 'images/media/2021/02/klnWy07606.png', NULL, NULL),
(1427, 750, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612680503klnWy07606.png', NULL, NULL),
(1428, 751, 'ACTUAL', 1024, 1024, 'images/media/2021/02/bvBfe07506.png', NULL, NULL),
(1429, 751, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612680625bvBfe07506.png', NULL, NULL),
(1430, 751, 'MEDIUM', 400, 400, 'images/media/2021/02/medium1612680625bvBfe07506.png', NULL, NULL),
(1451, 758, 'ACTUAL', 1024, 1024, 'images/media/2021/02/HMTFx07106.png', NULL, NULL),
(1452, 758, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612680897HMTFx07106.png', NULL, NULL),
(1453, 758, 'MEDIUM', 400, 400, 'images/media/2021/02/medium1612680897HMTFx07106.png', NULL, NULL),
(1454, 759, 'ACTUAL', 1024, 1024, 'images/media/2021/02/87FPy07606.png', NULL, NULL),
(1455, 759, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail161268091187FPy07606.png', NULL, NULL),
(1456, 759, 'MEDIUM', 400, 400, 'images/media/2021/02/medium161268091187FPy07606.png', NULL, NULL),
(1457, 760, 'ACTUAL', 1024, 1024, 'images/media/2021/02/TJ0O507606.png', NULL, NULL),
(1458, 760, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612680922TJ0O507606.png', NULL, NULL),
(1459, 760, 'MEDIUM', 400, 400, 'images/media/2021/02/medium1612680923TJ0O507606.png', NULL, NULL),
(1460, 760, 'LARGE', 900, 900, 'images/media/2021/02/large1612680923TJ0O507606.png', NULL, '2021-02-07 11:55:23'),
(1461, 761, 'ACTUAL', 1024, 1024, 'images/media/2021/02/wTKXG07207.png', NULL, NULL),
(1462, 761, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612682951wTKXG07207.png', NULL, NULL),
(1463, 761, 'MEDIUM', 400, 400, 'images/media/2021/02/medium1612682952wTKXG07207.png', NULL, NULL),
(1464, 762, 'ACTUAL', 1024, 1024, 'images/media/2021/02/zQabQ07407.png', NULL, NULL),
(1465, 762, 'THUMBNAIL', 150, 150, 'images/media/2021/02/thumbnail1612683010zQabQ07407.png', NULL, NULL),
(1466, 762, 'MEDIUM', 400, 400, 'images/media/2021/02/medium1612683010zQabQ07407.png', NULL, NULL),
(1489, 768, 'MEDIUM', 400, 400, 'images/media/2021/12/medium1638781656b9Cqw06109.jpg', NULL, NULL),
(1488, 768, 'THUMBNAIL', 150, 150, 'images/media/2021/12/thumbnail1638781656b9Cqw06109.jpg', NULL, NULL),
(1486, 767, 'LARGE', 900, 900, 'images/media/2021/12/large1638771208gqoFZ06206.jpg', NULL, '2021-12-06 11:13:28'),
(1487, 768, 'ACTUAL', 900, 900, 'images/media/2021/12/b9Cqw06109.jpg', NULL, NULL),
(1484, 767, 'THUMBNAIL', 150, 150, 'images/media/2021/12/thumbnail1638771208gqoFZ06206.jpg', NULL, NULL),
(1485, 767, 'MEDIUM', 400, 400, 'images/media/2021/12/medium1638771208gqoFZ06206.jpg', NULL, NULL),
(1483, 767, 'ACTUAL', 900, 900, 'images/media/2021/12/gqoFZ06206.jpg', NULL, NULL),
(1475, 765, 'ACTUAL', 900, 900, 'images/media/2021/12/c13vc04508.jpg', NULL, NULL),
(1476, 765, 'THUMBNAIL', 150, 150, 'images/media/2021/12/thumbnail1638607672c13vc04508.jpg', NULL, NULL),
(1477, 765, 'MEDIUM', 400, 400, 'images/media/2021/12/medium1638607672c13vc04508.jpg', NULL, NULL),
(1478, 765, 'LARGE', 900, 900, 'images/media/2021/12/large1638607672c13vc04508.jpg', NULL, '2021-12-04 13:47:52'),
(1479, 766, 'ACTUAL', 900, 900, 'images/media/2021/12/pCtjA04309.jpg', NULL, NULL),
(1480, 766, 'THUMBNAIL', 150, 150, 'images/media/2021/12/thumbnail1638610994pCtjA04309.jpg', NULL, NULL),
(1481, 766, 'MEDIUM', 400, 400, 'images/media/2021/12/medium1638610994pCtjA04309.jpg', NULL, NULL),
(1482, 766, 'LARGE', 900, 900, 'images/media/2021/12/large1638610994pCtjA04309.jpg', NULL, '2021-12-04 14:43:14'),
(1490, 768, 'LARGE', 900, 900, 'images/media/2021/12/large1638781657b9Cqw06109.jpg', NULL, '2021-12-06 14:07:37'),
(1491, 769, 'ACTUAL', 900, 900, 'images/media/2021/12/Lw9fh08905.jpg', NULL, NULL),
(1492, 769, 'THUMBNAIL', 150, 150, 'images/media/2021/12/thumbnail1638941214Lw9fh08905.jpg', NULL, NULL),
(1493, 769, 'MEDIUM', 400, 400, 'images/media/2021/12/medium1638941214Lw9fh08905.jpg', NULL, NULL),
(1494, 769, 'LARGE', 900, 900, 'images/media/2021/12/large1638941214Lw9fh08905.jpg', NULL, '2021-12-08 10:26:54'),
(1495, 770, 'ACTUAL', 900, 900, 'images/media/2021/12/CVEtf08405.jpg', NULL, NULL),
(1496, 770, 'THUMBNAIL', 150, 150, 'images/media/2021/12/thumbnail1638941215CVEtf08405.jpg', NULL, NULL),
(1497, 770, 'MEDIUM', 400, 400, 'images/media/2021/12/medium1638941215CVEtf08405.jpg', NULL, NULL),
(1498, 770, 'LARGE', 900, 900, 'images/media/2021/12/large1638941215CVEtf08405.jpg', NULL, '2021-12-08 10:26:55'),
(1499, 771, 'ACTUAL', 900, 900, 'images/media/2021/12/Yik7k08105.jpg', NULL, NULL),
(1500, 771, 'THUMBNAIL', 150, 150, 'images/media/2021/12/thumbnail1638941216Yik7k08105.jpg', NULL, NULL),
(1501, 771, 'MEDIUM', 400, 400, 'images/media/2021/12/medium1638941216Yik7k08105.jpg', NULL, NULL),
(1502, 771, 'LARGE', 900, 900, 'images/media/2021/12/large1638941216Yik7k08105.jpg', NULL, '2021-12-08 10:26:56'),
(1503, 772, 'ACTUAL', 418, 885, 'images/media/2021/12/WAGEE08712.jpg', NULL, NULL),
(1504, 772, 'THUMBNAIL', 71, 150, 'images/media/2021/12/thumbnail1638965758WAGEE08712.jpg', NULL, NULL),
(1505, 772, 'MEDIUM', 189, 400, 'images/media/2021/12/medium1638965758WAGEE08712.jpg', NULL, NULL),
(1506, 773, 'ACTUAL', 900, 900, 'images/media/2021/12/JWWlV12910.jpg', NULL, NULL),
(1507, 773, 'THUMBNAIL', 150, 150, 'images/media/2021/12/thumbnail1639304330JWWlV12910.jpg', NULL, '2022-01-10 16:37:07'),
(1508, 773, 'MEDIUM', 400, 400, 'images/media/2021/12/medium1639304330JWWlV12910.jpg', NULL, NULL),
(1509, 773, 'LARGE', 900, 900, 'images/media/2021/12/large1639304330JWWlV12910.jpg', NULL, '2021-12-12 15:18:50'),
(1510, 774, 'ACTUAL', 900, 900, 'images/media/2021/12/TN1Lt12910.jpg', NULL, NULL),
(1511, 774, 'THUMBNAIL', 150, 150, 'images/media/2021/12/thumbnail1639304457TN1Lt12910.jpg', NULL, NULL),
(1512, 774, 'MEDIUM', 400, 400, 'images/media/2021/12/medium1639304457TN1Lt12910.jpg', NULL, NULL),
(1513, 774, 'LARGE', 900, 900, 'images/media/2021/12/large1639304457TN1Lt12910.jpg', NULL, '2021-12-12 15:20:57'),
(1514, 775, 'ACTUAL', 418, 885, 'images/media/2021/12/dAKox13511.jpg', NULL, NULL),
(1515, 775, 'THUMBNAIL', 71, 150, 'images/media/2021/12/thumbnail1639394865dAKox13511.jpg', NULL, NULL),
(1516, 775, 'MEDIUM', 189, 400, 'images/media/2021/12/medium1639394865dAKox13511.jpg', NULL, NULL),
(1517, 776, 'ACTUAL', 2284, 1542, 'images/media/2021/12/Px3Ht13111.jpg', NULL, NULL),
(1518, 776, 'THUMBNAIL', 150, 101, 'images/media/2021/12/thumbnail1639394866Px3Ht13111.jpg', NULL, NULL),
(1519, 776, 'MEDIUM', 400, 270, 'images/media/2021/12/medium1639394866Px3Ht13111.jpg', NULL, NULL),
(1520, 776, 'LARGE', 900, 608, 'images/media/2021/12/large1639394866Px3Ht13111.jpg', NULL, '2021-12-13 16:27:46'),
(1521, 777, 'ACTUAL', 900, 900, 'images/media/2021/12/1Ox1n14611.jpg', NULL, NULL),
(1522, 777, 'THUMBNAIL', 150, 150, 'images/media/2021/12/thumbnail16394814101Ox1n14611.jpg', NULL, NULL),
(1523, 777, 'MEDIUM', 400, 400, 'images/media/2021/12/medium16394814101Ox1n14611.jpg', NULL, NULL),
(1524, 777, 'LARGE', 900, 900, 'images/media/2021/12/large16394814101Ox1n14611.jpg', NULL, '2021-12-14 16:30:10'),
(1694, 825, 'ACTUAL', 788, 940, 'images/media/2022/11/kFIyF23511.png', NULL, NULL),
(1695, 825, 'THUMBNAIL', 126, 150, 'images/media/2022/11/thumbnail1669203493kFIyF23511.png', NULL, NULL),
(1690, 824, 'ACTUAL', 1667, 1667, 'images/media/2022/11/EjCvV13809.png', NULL, NULL),
(1691, 824, 'THUMBNAIL', 150, 150, 'images/media/2022/11/thumbnail1668332346EjCvV13809.png', NULL, NULL),
(1692, 824, 'MEDIUM', 400, 400, 'images/media/2022/11/medium1668332347EjCvV13809.png', NULL, NULL),
(1693, 824, 'LARGE', 900, 900, 'images/media/2022/11/large1668332347EjCvV13809.png', NULL, '2022-11-13 14:39:07'),
(1686, 822, 'MEDIUM', 335, 400, 'images/media/2022/11/medium16677292318m0bK06410.png', NULL, NULL),
(1685, 822, 'THUMBNAIL', 126, 150, 'images/media/2022/11/thumbnail16677292318m0bK06410.png', NULL, NULL),
(1677, 820, 'ACTUAL', 788, 940, 'images/media/2022/11/YAMCN06910.png', NULL, NULL),
(1670, 818, 'ACTUAL', 788, 940, 'images/media/2022/11/tSFb406909.png', NULL, NULL),
(1671, 818, 'THUMBNAIL', 126, 150, 'images/media/2022/11/thumbnail1667727465tSFb406909.png', NULL, NULL),
(1672, 818, 'MEDIUM', 335, 400, 'images/media/2022/11/medium1667727465tSFb406909.png', NULL, NULL),
(1684, 822, 'ACTUAL', 788, 940, 'images/media/2022/11/8m0bK06410.png', NULL, NULL),
(1679, 820, 'MEDIUM', 335, 400, 'images/media/2022/11/medium1667729059YAMCN06910.png', NULL, NULL),
(1678, 820, 'THUMBNAIL', 126, 150, 'images/media/2022/11/thumbnail1667729059YAMCN06910.png', NULL, NULL),
(1696, 825, 'MEDIUM', 335, 400, 'images/media/2022/11/medium1669203493kFIyF23511.png', NULL, NULL),
(1697, 826, 'ACTUAL', 788, 940, 'images/media/2022/11/kEedd23811.png', NULL, NULL),
(1698, 826, 'THUMBNAIL', 126, 150, 'images/media/2022/11/thumbnail1669203510kEedd23811.png', NULL, NULL),
(1699, 826, 'MEDIUM', 335, 400, 'images/media/2022/11/medium1669203510kEedd23811.png', NULL, NULL),
(1700, 827, 'ACTUAL', 788, 940, 'images/media/2022/11/3DR2s23311.png', NULL, NULL),
(1701, 827, 'THUMBNAIL', 126, 150, 'images/media/2022/11/thumbnail16692035243DR2s23311.png', NULL, NULL),
(1702, 827, 'MEDIUM', 335, 400, 'images/media/2022/11/medium16692035243DR2s23311.png', NULL, NULL),
(1703, 828, 'ACTUAL', 788, 940, 'images/media/2022/11/kDW7423711.png', NULL, NULL),
(1704, 828, 'THUMBNAIL', 126, 150, 'images/media/2022/11/thumbnail1669203537kDW7423711.png', NULL, NULL),
(1705, 828, 'MEDIUM', 335, 400, 'images/media/2022/11/medium1669203537kDW7423711.png', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_ref_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `added_date` int(11) NOT NULL,
  `reference_code` varchar(191) DEFAULT NULL,
  `stock` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `purchase_price` decimal(10,2) NOT NULL,
  `stock_type` varchar(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_ref_id`, `admin_id`, `added_date`, `reference_code`, `stock`, `products_id`, `purchase_price`, `stock_type`, `created_at`, `updated_at`) VALUES
(1, 1, 0, 's101', 1000, 1, '60.00', 'in', '2019-09-17 05:44:55', NULL),
(2, 1, 0, 's102', 1000, 6, '20.00', 'in', '2019-09-18 01:19:17', NULL),
(3, 1, 0, 's103', 1000, 13, '25.00', 'in', '2019-09-18 01:21:15', NULL),
(4, 1, 0, 's104', 1000, 13, '25.00', 'in', '2019-09-18 01:21:47', NULL),
(5, 1, 0, 's105', 1000, 13, '25.00', 'in', '2019-09-18 01:23:33', NULL),
(6, 1, 0, 's106', 1000, 19, '20.00', 'in', '2019-09-18 01:25:25', NULL),
(7, 1, 0, 's107', 1000, 29, '55.00', 'in', '2019-09-18 01:27:45', NULL),
(8, 1, 0, 'S108', 1000, 2, '45.00', 'in', '2019-09-18 01:28:54', NULL),
(9, 1, 0, 'S108', 1000, 3, '30.00', 'in', '2019-09-18 01:29:33', NULL),
(10, 1, 0, 'S109', 500, 4, '70.00', 'in', '2019-09-18 01:30:16', NULL),
(11, 1, 0, 'S109', 500, 4, '70.00', 'in', '2019-09-18 01:30:51', NULL),
(12, 1, 0, 'S110', 500, 4, '70.00', 'in', '2019-09-18 01:31:11', NULL),
(13, 1, 0, 'S111', 1000, 5, '30.00', 'in', '2019-09-18 01:31:55', NULL),
(14, 1, 0, 's112', 1000, 7, '18.00', 'in', '2019-09-18 01:32:40', NULL),
(15, 1, 0, 's113', 500, 8, '20.00', 'in', '2019-09-18 01:33:24', NULL),
(16, 1, 0, 's114', 500, 8, '20.00', 'in', '2019-09-18 01:34:05', NULL),
(17, 1, 0, 's115', 500, 8, '20.00', 'in', '2019-09-18 01:34:55', NULL),
(18, 1, 0, 's116', 1000, 9, '10.00', 'in', '2019-09-18 01:35:45', NULL),
(19, 1, 0, 's116', 1000, 10, '20.00', 'in', '2019-09-18 01:37:40', NULL),
(20, 1, 0, 's117', 500, 11, '15.00', 'in', '2019-09-18 01:38:23', NULL),
(21, 1, 0, 's117', 500, 11, '15.00', 'in', '2019-09-18 01:39:52', NULL),
(22, 1, 0, 's117', 500, 11, '15.00', 'in', '2019-09-18 01:40:41', NULL),
(23, 1, 0, 's118', 1000, 12, '15.00', 'in', '2019-09-18 01:41:33', NULL),
(24, 1, 0, 's119', 200, 14, '30.00', 'in', '2019-09-18 01:42:17', NULL),
(25, 1, 0, 's120', 500, 15, '35.00', 'in', '2019-09-18 01:42:54', NULL),
(26, 1, 0, 's121', 600, 16, '40.00', 'in', '2019-09-18 01:43:31', NULL),
(27, 1, 0, 's121', 800, 17, '15.00', 'in', '2019-09-18 01:44:29', NULL),
(28, 1, 0, 's122', 600, 18, '30.00', 'in', '2019-09-18 01:45:18', NULL),
(29, 1, 0, 's123', 900, 20, '60.00', 'in', '2019-09-18 01:46:28', NULL),
(30, 1, 0, 's124', 400, 21, '55.00', 'in', '2019-09-18 01:47:22', NULL),
(31, 1, 0, 's124', 300, 21, '55.00', 'in', '2019-09-18 01:47:38', NULL),
(32, 1, 0, 's125', 800, 22, '70.00', 'in', '2019-09-18 01:48:18', NULL),
(33, 1, 0, 's125', 400, 24, '50.00', 'in', '2019-09-18 01:49:44', NULL),
(34, 1, 0, 's128', 300, 24, '50.00', 'in', '2019-09-18 01:50:05', NULL),
(35, 1, 0, 's129', 800, 25, '60.00', 'in', '2019-09-18 01:50:52', NULL),
(36, 1, 0, 's130', 800, 26, '80.00', 'in', '2019-09-18 01:51:28', NULL),
(37, 1, 0, 's131', 900, 27, '55.00', 'in', '2019-09-18 01:52:33', NULL),
(38, 1, 0, 's131', 500, 28, '70.00', 'in', '2019-09-18 01:53:08', NULL),
(39, 1, 0, 's132', 500, 28, '70.00', 'in', '2019-09-18 01:53:26', NULL),
(40, 1, 0, 's133', 1100, 30, '105.00', 'in', '2019-09-18 01:53:52', NULL),
(41, 1, 0, 's134', 900, 31, '52.00', 'in', '2019-09-18 01:54:19', NULL),
(42, 1, 0, 's135', 1200, 32, '71.00', 'in', '2019-09-18 01:54:44', NULL),
(43, 0, 1568989337, '', 1, 32, '0.00', 'out', NULL, NULL),
(44, 0, 1568989349, '', 1, 32, '0.00', 'out', NULL, NULL),
(45, 0, 1568989974, '', 1, 32, '0.00', 'out', NULL, NULL),
(46, 0, 1569219521, '', 1, 29, '0.00', 'out', NULL, NULL),
(47, 0, 1569219840, '', 1, 29, '0.00', 'out', NULL, NULL),
(48, 0, 1569220035, '', 1, 29, '0.00', 'out', NULL, NULL),
(49, 0, 1569220106, '', 1, 29, '0.00', 'out', NULL, NULL),
(50, 0, 1569220168, '', 1, 29, '0.00', 'out', NULL, NULL),
(51, 0, 1569220495, '', 1, 29, '0.00', 'out', NULL, NULL),
(52, 0, 1569330243, '', 1, 26, '0.00', 'out', NULL, NULL),
(53, 0, 1569330243, '', 1, 27, '0.00', 'out', NULL, NULL),
(54, 0, 1569330243, '', 3, 30, '0.00', 'out', NULL, NULL),
(55, 0, 1569330243, '', 2, 31, '0.00', 'out', NULL, NULL),
(56, 0, 1569486590, '', 1, 32, '0.00', 'out', NULL, NULL),
(57, 0, 1569495585, '', 1, 19, '0.00', 'out', NULL, NULL),
(58, 0, 1569495585, '', 1, 29, '0.00', 'out', NULL, NULL),
(59, 0, 1569495911, '', 1, 1, '0.00', 'out', NULL, NULL),
(60, 0, 1569496301, '', 1, 29, '0.00', 'out', NULL, NULL),
(61, 0, 1569496712, '', 1, 29, '0.00', 'out', NULL, NULL),
(62, 0, 1569497195, '', 3, 32, '0.00', 'out', NULL, NULL),
(63, 0, 1569497197, '', 3, 32, '0.00', 'out', NULL, NULL),
(64, 0, 1569503812, '', 1, 8, '0.00', 'out', NULL, NULL),
(65, 0, 1569583044, '', 1, 26, '0.00', 'out', NULL, NULL),
(66, 0, 1569583044, '', 1, 27, '0.00', 'out', NULL, NULL),
(67, 0, 1569583044, '', 1, 30, '0.00', 'out', NULL, NULL),
(68, 0, 1569583044, '', 1, 31, '0.00', 'out', NULL, NULL),
(69, 0, 1569607915, '', 1, 14, '0.00', 'out', NULL, NULL),
(70, 0, 1569655219, '', 1, 27, '0.00', 'out', NULL, NULL),
(71, 0, 1569655219, '', 1, 29, '0.00', 'out', NULL, NULL),
(72, 0, 1569655219, '', 1, 32, '0.00', 'out', NULL, NULL),
(73, 0, 1569655219, '', 1, 6, '0.00', 'out', NULL, NULL),
(74, 0, 1569692983, '', 1, 31, '0.00', 'out', NULL, NULL),
(75, 0, 1569834237, '', 1, 18, '0.00', 'out', NULL, NULL),
(76, 0, 1569843699, '', 1, 3, '0.00', 'out', NULL, NULL),
(77, 0, 1569901100, '', 1, 18, '0.00', 'out', NULL, NULL),
(78, 0, 1569901100, '', 1, 25, '0.00', 'out', NULL, NULL),
(79, 0, 1569901100, '', 1, 26, '0.00', 'out', NULL, NULL),
(80, 0, 1569901100, '', 1, 3, '0.00', 'out', NULL, NULL),
(81, 0, 1569901100, '', 1, 6, '0.00', 'out', NULL, NULL),
(82, 0, 1569913767, '', 1, 3, '0.00', 'out', NULL, NULL),
(83, 0, 1569913767, '', 6, 30, '0.00', 'out', NULL, NULL),
(84, 0, 1569913767, '', 1, 6, '0.00', 'out', NULL, NULL),
(85, 0, 1569935181, '', 1, 13, '0.00', 'out', NULL, NULL),
(86, 0, 1570024696, '', 1, 18, '0.00', 'out', NULL, NULL),
(87, 0, 1570083856, '', 2, 4, '0.00', 'out', NULL, NULL),
(88, 0, 1570085481, '', 1, 18, '0.00', 'out', NULL, NULL),
(89, 0, 1570095995, '', 1, 18, '0.00', 'out', NULL, NULL),
(90, 0, 1570095995, '', 1, 25, '0.00', 'out', NULL, NULL),
(91, 0, 1570282489, '', 1, 29, '0.00', 'out', NULL, NULL),
(92, 0, 1570360230, '', 1, 2, '0.00', 'out', NULL, NULL),
(93, 0, 1570372049, '', 1, 1, '0.00', 'out', NULL, NULL),
(94, 0, 1570434540, '', 1, 26, '0.00', 'out', NULL, NULL),
(95, 0, 1570434540, '', 1, 27, '0.00', 'out', NULL, NULL),
(96, 0, 1570434541, '', 1, 29, '0.00', 'out', NULL, NULL),
(97, 0, 1570434541, '', 1, 30, '0.00', 'out', NULL, NULL),
(98, 0, 1570434541, '', 1, 31, '0.00', 'out', NULL, NULL),
(99, 0, 1570434541, '', 1, 32, '0.00', 'out', NULL, NULL),
(100, 0, 1570456145, '', 3, 6, '0.00', 'out', NULL, NULL),
(101, 0, 1570776834, '', 1, 2, '0.00', 'out', NULL, NULL),
(102, 0, 1570777371, '', 1, 29, '0.00', 'out', NULL, NULL),
(103, 0, 1570794856, '', 1, 4, '0.00', 'out', NULL, NULL),
(104, 0, 1570843860, '', 2, 31, '0.00', 'out', NULL, NULL),
(105, 0, 1570978655, '', 1, 30, '0.00', 'out', NULL, NULL),
(106, 0, 1570978655, '', 1, 31, '0.00', 'out', NULL, NULL),
(107, 0, 1570978655, '', 1, 32, '0.00', 'out', NULL, NULL),
(108, 0, 1571013156, '', 1, 30, '0.00', 'out', NULL, NULL),
(109, 0, 1571388785, '', 1, 30, '0.00', 'out', NULL, NULL),
(110, 0, 1571388785, '', 1, 31, '0.00', 'out', NULL, NULL),
(111, 0, 1571403810, '', 1, 1, '0.00', 'out', NULL, NULL),
(112, 0, 1571483054, '', 1, 25, '0.00', 'out', NULL, NULL),
(113, 0, 1571483054, '', 1, 27, '0.00', 'out', NULL, NULL),
(114, 0, 1571492712, '', 1, 31, '0.00', 'out', NULL, NULL),
(115, 0, 1571492712, '', 1, 32, '0.00', 'out', NULL, NULL),
(116, 0, 1571609798, '', 141, 29, '0.00', 'out', NULL, NULL),
(117, 0, 1571609798, '', 1, 30, '0.00', 'out', NULL, NULL),
(118, 0, 1571609798, '', 1, 6, '0.00', 'out', NULL, NULL),
(119, 0, 1571749086, '', 1, 30, '0.00', 'out', NULL, NULL),
(120, 0, 1571749086, '', 1, 31, '0.00', 'out', NULL, NULL),
(121, 0, 1571758880, '', 2, 1, '0.00', 'out', NULL, NULL),
(122, 0, 1571829621, '', 1, 32, '0.00', 'out', NULL, NULL),
(123, 0, 1571898183, '', 1, 32, '0.00', 'out', NULL, NULL),
(124, 0, 1571914913, '', 1, 1, '0.00', 'out', NULL, NULL),
(125, 0, 1571925502, '', 3, 1, '0.00', 'out', NULL, NULL),
(126, 0, 1572090563, '', 1, 31, '0.00', 'out', NULL, NULL),
(127, 0, 1572155904, '', 2, 1, '0.00', 'out', NULL, NULL),
(128, 0, 1572258276, '', 1, 26, '0.00', 'out', NULL, NULL),
(129, 0, 1572439226, '', 1, 32, '0.00', 'out', NULL, NULL),
(130, 0, 1572439526, '', 1, 31, '0.00', 'out', NULL, NULL),
(131, 0, 1572443429, '', 1, 29, '0.00', 'out', NULL, NULL),
(132, 0, 1572443429, '', 3, 31, '0.00', 'out', NULL, NULL),
(133, 0, 1572449034, '', 1, 30, '0.00', 'out', NULL, NULL),
(134, 0, 1572449034, '', 1, 31, '0.00', 'out', NULL, NULL),
(135, 0, 1572552652, '', 1, 1, '0.00', 'out', NULL, NULL),
(136, 0, 1572552652, '', 2, 30, '0.00', 'out', NULL, NULL),
(137, 0, 1572611252, '', 1, 21, '0.00', 'out', NULL, NULL),
(138, 0, 1572611252, '', 2, 25, '0.00', 'out', NULL, NULL),
(139, 0, 1572611252, '', 1, 27, '0.00', 'out', NULL, NULL),
(140, 0, 1572677571, '', 18, 15, '0.00', 'out', NULL, NULL),
(141, 0, 1572694686, '', 3, 1, '0.00', 'out', NULL, NULL),
(142, 0, 1572704623, '', 1, 14, '0.00', 'out', NULL, NULL),
(143, 0, 1572704623, '', 1, 15, '0.00', 'out', NULL, NULL),
(144, 0, 1572704623, '', 1, 17, '0.00', 'out', NULL, NULL),
(145, 0, 1572704623, '', 1, 32, '0.00', 'out', NULL, NULL),
(146, 0, 1572729539, '', 1, 4, '0.00', 'out', NULL, NULL),
(147, 0, 1572868871, '', 1, 30, '0.00', 'out', NULL, NULL),
(148, 0, 1573019664, '', 1, 29, '0.00', 'out', NULL, NULL),
(149, 0, 1573019664, '', 2, 30, '0.00', 'out', NULL, NULL),
(150, 0, 1573019664, '', 3, 32, '0.00', 'out', NULL, NULL),
(151, 0, 1573049636, '', 1, 31, '0.00', 'out', NULL, NULL),
(152, 0, 1573104846, '', 20, 2, '0.00', 'out', NULL, NULL),
(153, 0, 1573109729, '', 1, 31, '0.00', 'out', NULL, NULL),
(154, 0, 1573303350, '', 1, 26, '0.00', 'out', NULL, NULL),
(155, 0, 1573303350, '', 1, 30, '0.00', 'out', NULL, NULL),
(156, 0, 1573322647, '', 1, 31, '0.00', 'out', NULL, NULL),
(157, 0, 1573389364, '', 1, 19, '0.00', 'out', NULL, NULL),
(158, 0, 1573540158, '', 1, 25, '0.00', 'out', NULL, NULL),
(159, 0, 1573546969, '', 1, 7, '0.00', 'out', NULL, NULL),
(160, 0, 1573567460, '', 1, 30, '0.00', 'out', NULL, NULL),
(161, 0, 1573567460, '', 1, 16, '0.00', 'out', NULL, NULL),
(162, 0, 1573567460, '', 1, 1, '0.00', 'out', NULL, NULL),
(163, 0, 1573604913, '', 1, 31, '0.00', 'out', NULL, NULL),
(164, 0, 1573604913, '', 1, 30, '0.00', 'out', NULL, NULL),
(165, 0, 1573604913, '', 1, 18, '0.00', 'out', NULL, NULL),
(166, 0, 1573626564, '', 1, 29, '0.00', 'out', NULL, NULL),
(167, 0, 1573717478, '', 1, 31, '0.00', 'out', NULL, NULL),
(168, 0, 1573717478, '', 1, 7, '0.00', 'out', NULL, NULL),
(169, 0, 1573786155, '', 2, 32, '0.00', 'out', NULL, NULL),
(170, 0, 1573786155, '', 1, 31, '0.00', 'out', NULL, NULL),
(171, 0, 1573836405, '', 1, 31, '0.00', 'out', NULL, NULL),
(172, 0, 1573836412, '', 1, 31, '0.00', 'out', NULL, NULL),
(173, 0, 1573847140, '', 1, 7, '0.00', 'out', NULL, NULL),
(174, 0, 1573862019, '', 2, 4, '0.00', 'out', NULL, NULL),
(175, 0, 1573900015, '', 1, 31, '0.00', 'out', NULL, NULL),
(176, 0, 1573904738, '', 1, 31, '0.00', 'out', NULL, NULL),
(177, 0, 1573987089, '', 1, 16, '0.00', 'out', NULL, NULL),
(178, 0, 1573990606, '', 1, 19, '0.00', 'out', NULL, NULL),
(179, 0, 1573998674, '', 1, 7, '0.00', 'out', NULL, NULL),
(180, 0, 1574000044, '', 1, 7, '0.00', 'out', NULL, NULL),
(181, 0, 1574016045, '', 1, 2, '0.00', 'out', NULL, NULL),
(182, 0, 1574073052, '', 1, 3, '0.00', 'out', NULL, NULL),
(183, 0, 1574094449, '', 1, 32, '0.00', 'out', NULL, NULL),
(184, 0, 1574169388, '', 16, 25, '0.00', 'out', NULL, NULL),
(185, 0, 1574179456, '', 1, 16, '0.00', 'out', NULL, NULL),
(186, 0, 1574179456, '', 1, 5, '0.00', 'out', NULL, NULL),
(187, 0, 1574203349, '', 2, 2, '0.00', 'out', NULL, NULL),
(188, 0, 1574235415, '', 2, 13, '0.00', 'out', NULL, NULL),
(189, 0, 1574235415, '', 2, 13, '0.00', 'out', NULL, NULL),
(190, 0, 1574235415, '', 2, 13, '0.00', 'out', NULL, NULL),
(191, 0, 1574235415, '', 1, 10, '0.00', 'out', NULL, NULL),
(192, 0, 1574241518, '', 1, 32, '0.00', 'out', NULL, NULL),
(193, 0, 1574241518, '', 1, 16, '0.00', 'out', NULL, NULL),
(194, 0, 1574247963, '', 1, 29, '0.00', 'out', NULL, NULL),
(195, 0, 1574268584, '', 1, 16, '0.00', 'out', NULL, NULL),
(196, 0, 1574289244, '', 1, 31, '0.00', 'out', NULL, NULL),
(197, 0, 1574407295, '', 1, 6, '0.00', 'out', NULL, NULL),
(198, 0, 1574407295, '', 1, 2, '0.00', 'out', NULL, NULL),
(199, 0, 1574407295, '', 1, 1, '0.00', 'out', NULL, NULL),
(200, 0, 1574407486, '', 1, 32, '0.00', 'out', NULL, NULL),
(201, 0, 1574407608, '', 1, 31, '0.00', 'out', NULL, NULL),
(202, 0, 1574426845, '', 1, 5, '0.00', 'out', NULL, NULL),
(203, 0, 1574439821, '', 1, 16, '0.00', 'out', NULL, NULL),
(204, 0, 1574491861, '', 1, 7, '0.00', 'out', NULL, NULL),
(205, 0, 1574498456, '', 1, 16, '0.00', 'out', NULL, NULL),
(206, 0, 1574501037, '', 1, 25, '0.00', 'out', NULL, NULL),
(207, 0, 1574501037, '', 1, 31, '0.00', 'out', NULL, NULL),
(208, 0, 1574502841, '', 1, 20, '0.00', 'out', NULL, NULL),
(209, 0, 1574525009, '', 1, 14, '0.00', 'out', NULL, NULL),
(210, 0, 1574549701, '', 2, 32, '0.00', 'out', NULL, NULL),
(211, 0, 1574600758, '', 1, 26, '0.00', 'out', NULL, NULL),
(212, 0, 1574600758, '', 1, 6, '0.00', 'out', NULL, NULL),
(213, 0, 1574600758, '', 1, 6, '0.00', 'out', NULL, NULL),
(214, 0, 1574600758, '', 1, 6, '0.00', 'out', NULL, NULL),
(215, 0, 1574617644, '', 1, 20, '0.00', 'out', NULL, NULL),
(216, 0, 1574617644, '', 6, 5, '0.00', 'out', NULL, NULL),
(217, 0, 1574660060, '', 1, 4, '0.00', 'out', NULL, NULL),
(218, 0, 1574671640, '', 1, 32, '0.00', 'out', NULL, NULL),
(219, 0, 1574672118, '', 1, 32, '0.00', 'out', NULL, NULL),
(220, 0, 1574672118, '', 1, 30, '0.00', 'out', NULL, NULL),
(221, 0, 1574708863, '', 10, 7, '0.00', 'out', NULL, NULL),
(222, 0, 1574708863, '', 1, 5, '0.00', 'out', NULL, NULL),
(223, 0, 1574817007, '', 1, 26, '0.00', 'out', NULL, NULL),
(224, 0, 1574817007, '', 2, 7, '0.00', 'out', NULL, NULL),
(225, 0, 1574837720, '', 2, 13, '0.00', 'out', NULL, NULL),
(226, 0, 1574837720, '', 1, 6, '0.00', 'out', NULL, NULL),
(227, 0, 1574837720, '', 2, 8, '0.00', 'out', NULL, NULL),
(228, 0, 1575042026, '', 1, 18, '0.00', 'out', NULL, NULL),
(229, 0, 1575042026, '', 1, 16, '0.00', 'out', NULL, NULL),
(230, 0, 1575279457, '', 1, 5, '0.00', 'out', NULL, NULL),
(231, 0, 1575282889, '', 3, 32, '0.00', 'out', NULL, NULL),
(232, 0, 1575282889, '', 1, 31, '0.00', 'out', NULL, NULL),
(233, 0, 1575282889, '', 1, 25, '0.00', 'out', NULL, NULL),
(234, 0, 1575282889, '', 1, 25, '0.00', 'out', NULL, NULL),
(235, 0, 1575284561, '', 1, 27, '0.00', 'out', NULL, NULL),
(236, 0, 1575310274, '', 2, 3, '0.00', 'out', NULL, NULL),
(237, 0, 1575320895, '', 5, 32, '0.00', 'out', NULL, NULL),
(238, 0, 1575389841, '', 1, 5, '0.00', 'out', NULL, NULL),
(239, 0, 1575391920, '', 1, 26, '0.00', 'out', NULL, NULL),
(240, 0, 1575511999, '', 1, 16, '0.00', 'out', NULL, NULL),
(241, 0, 1575516964, '', 1, 7, '0.00', 'out', NULL, NULL),
(242, 0, 1575516964, '', 1, 32, '0.00', 'out', NULL, NULL),
(243, 0, 1575639208, '', 1, 7, '0.00', 'out', NULL, NULL),
(244, 0, 1575651764, '', 5, 30, '0.00', 'out', NULL, NULL),
(245, 0, 1575707053, '', 2, 16, '0.00', 'out', NULL, NULL),
(246, 0, 1575735520, '', 1, 1, '0.00', 'out', NULL, NULL),
(247, 0, 1575785138, '', 1, 26, '0.00', 'out', NULL, NULL),
(248, 0, 1575785234, '', 1, 5, '0.00', 'out', NULL, NULL),
(249, 0, 1575912081, '', 1, 32, '0.00', 'out', NULL, NULL),
(250, 0, 1575912081, '', 1, 26, '0.00', 'out', NULL, NULL),
(251, 0, 1575977074, '', 1, 16, '0.00', 'out', NULL, NULL),
(252, 0, 1576021697, '', 1, 30, '0.00', 'out', NULL, NULL),
(253, 0, 1576021697, '', 1, 29, '0.00', 'out', NULL, NULL),
(254, 0, 1576021697, '', 1, 29, '0.00', 'out', NULL, NULL),
(255, 0, 1576021697, '', 1, 29, '0.00', 'out', NULL, NULL),
(256, 0, 1576021697, '', 1, 29, '0.00', 'out', NULL, NULL),
(257, 0, 1576021697, '', 1, 29, '0.00', 'out', NULL, NULL),
(258, 0, 1576021697, '', 1, 29, '0.00', 'out', NULL, NULL),
(259, 0, 1576021697, '', 10, 15, '0.00', 'out', NULL, NULL),
(260, 0, 1576021697, '', 1, 14, '0.00', 'out', NULL, NULL),
(261, 0, 1576021697, '', 1, 7, '0.00', 'out', NULL, NULL),
(262, 0, 1576039820, '', 1, 32, '0.00', 'out', NULL, NULL),
(263, 0, 1576039820, '', 1, 31, '0.00', 'out', NULL, NULL),
(264, 0, 1576040383, '', 1, 2, '0.00', 'out', NULL, NULL),
(265, 0, 1576059584, '', 1, 16, '0.00', 'out', NULL, NULL),
(266, 0, 1576087705, '', 1, 16, '0.00', 'out', NULL, NULL),
(267, 0, 1576087705, '', 1, 6, '0.00', 'out', NULL, NULL),
(268, 0, 1576087705, '', 1, 6, '0.00', 'out', NULL, NULL),
(269, 0, 1576087705, '', 1, 6, '0.00', 'out', NULL, NULL),
(270, 0, 1576087705, '', 1, 5, '0.00', 'out', NULL, NULL),
(271, 0, 1576088572, '', 1, 7, '0.00', 'out', NULL, NULL),
(272, 0, 1576113611, '', 3, 30, '0.00', 'out', NULL, NULL),
(273, 0, 1576165616, '', 1, 15, '0.00', 'out', NULL, NULL),
(274, 0, 1576166371, '', 1, 16, '0.00', 'out', NULL, NULL),
(275, 0, 1576194737, '', 1, 1, '0.00', 'out', NULL, NULL),
(276, 0, 1576254744, '', 1, 25, '0.00', 'out', NULL, NULL),
(277, 0, 1576255034, '', 1, 32, '0.00', 'out', NULL, NULL),
(278, 0, 1576275675, '', 1, 31, '0.00', 'out', NULL, NULL),
(279, 0, 1576275675, '', 1, 30, '0.00', 'out', NULL, NULL),
(280, 0, 1576387099, '', 1, 31, '0.00', 'out', NULL, NULL),
(281, 0, 1576400925, '', 1, 9, '0.00', 'out', NULL, NULL),
(282, 0, 1576488861, '', 1, 7, '0.00', 'out', NULL, NULL),
(283, 0, 1576561367, '', 1, 7, '0.00', 'out', NULL, NULL),
(284, 0, 1576647950, '', 1, 17, '0.00', 'out', NULL, NULL),
(285, 0, 1576647950, '', 1, 6, '0.00', 'out', NULL, NULL),
(286, 0, 1576647950, '', 1, 26, '0.00', 'out', NULL, NULL),
(287, 0, 1576648495, '', 1, 20, '0.00', 'out', NULL, NULL),
(288, 0, 1576777516, '', 1, 7, '0.00', 'out', NULL, NULL),
(289, 0, 1576784131, '', 1, 19, '0.00', 'out', NULL, NULL),
(290, 0, 1576855212, '', 1, 31, '0.00', 'out', NULL, NULL),
(291, 0, 1576855212, '', 1, 1, '0.00', 'out', NULL, NULL),
(292, 0, 1576887758, '', 2, 7, '0.00', 'out', NULL, NULL),
(293, 0, 1576919571, '', 1, 32, '0.00', 'out', NULL, NULL),
(294, 0, 1576919571, '', 1, 31, '0.00', 'out', NULL, NULL),
(295, 0, 1576919571, '', 1, 1, '0.00', 'out', NULL, NULL),
(296, 0, 1576952280, '', 1, 32, '0.00', 'out', NULL, NULL),
(297, 0, 1576995820, '', 2, 5, '0.00', 'out', NULL, NULL),
(298, 0, 1577084553, '', 4, 25, '0.00', 'out', NULL, NULL),
(299, 0, 1577084553, '', 1, 20, '0.00', 'out', NULL, NULL),
(300, 0, 1577084553, '', 1, 5, '0.00', 'out', NULL, NULL),
(301, 0, 1577084553, '', 1, 3, '0.00', 'out', NULL, NULL),
(302, 0, 1577092122, '', 1, 32, '0.00', 'out', NULL, NULL),
(303, 0, 1577165955, '', 1, 30, '0.00', 'out', NULL, NULL),
(304, 0, 1577165955, '', 1, 16, '0.00', 'out', NULL, NULL),
(305, 0, 1577165955, '', 1, 5, '0.00', 'out', NULL, NULL),
(306, 0, 1577183541, '', 1, 25, '0.00', 'out', NULL, NULL),
(307, 0, 1577183541, '', 1, 7, '0.00', 'out', NULL, NULL),
(308, 0, 1577183541, '', 1, 1, '0.00', 'out', NULL, NULL),
(309, 0, 1577220849, '', 1, 6, '0.00', 'out', NULL, NULL),
(310, 0, 1577220849, '', 1, 6, '0.00', 'out', NULL, NULL),
(311, 0, 1577220849, '', 1, 6, '0.00', 'out', NULL, NULL),
(312, 0, 1577220849, '', 1, 3, '0.00', 'out', NULL, NULL),
(313, 0, 1577232355, '', 1, 26, '0.00', 'out', NULL, NULL),
(314, 0, 1577309528, '', 1, 3, '0.00', 'out', NULL, NULL),
(315, 0, 1577309528, '', 1, 2, '0.00', 'out', NULL, NULL),
(316, 0, 1577399804, '', 1, 25, '0.00', 'out', NULL, NULL),
(317, 0, 1577427000, '', 7, 16, '0.00', 'out', NULL, NULL),
(318, 0, 1577694839, '', 1, 29, '0.00', 'out', NULL, NULL),
(319, 0, 1577879428, '', 1, 25, '0.00', 'out', NULL, NULL),
(320, 0, 1577899480, '', 1, 20, '0.00', 'out', NULL, NULL),
(321, 0, 1577962270, '', 1, 16, '0.00', 'out', NULL, NULL),
(322, 0, 1577999779, '', 1, 31, '0.00', 'out', NULL, NULL),
(323, 0, 1578004183, '', 1, 16, '0.00', 'out', NULL, NULL),
(324, 0, 1578004183, '', 1, 7, '0.00', 'out', NULL, NULL),
(325, 0, 1578009172, '', 1, 15, '0.00', 'out', NULL, NULL),
(326, 0, 1578009172, '', 1, 14, '0.00', 'out', NULL, NULL),
(327, 0, 1578047158, '', 2, 30, '0.00', 'out', NULL, NULL),
(328, 0, 1578091142, '', 1, 16, '0.00', 'out', NULL, NULL),
(329, 0, 1578121379, '', 1, 7, '0.00', 'out', NULL, NULL),
(330, 0, 1578176747, '', 3, 7, '0.00', 'out', NULL, NULL),
(331, 0, 1578178745, '', 1, 32, '0.00', 'out', NULL, NULL),
(332, 0, 1578178745, '', 1, 7, '0.00', 'out', NULL, NULL),
(333, 0, 1578243843, '', 1, 16, '0.00', 'out', NULL, NULL),
(334, 0, 1578243843, '', 1, 7, '0.00', 'out', NULL, NULL),
(335, 0, 1578255122, '', 1, 16, '0.00', 'out', NULL, NULL),
(336, 0, 1578255122, '', 7, 5, '0.00', 'out', NULL, NULL),
(337, 0, 1578257579, '', 1, 7, '0.00', 'out', NULL, NULL),
(338, 0, 1578257579, '', 1, 7, '0.00', 'out', NULL, NULL),
(339, 0, 1578309700, '', 1, 7, '0.00', 'out', NULL, NULL),
(340, 0, 1578318438, '', 1, 22, '0.00', 'out', NULL, NULL),
(341, 0, 1578319486, '', 4, 16, '0.00', 'out', NULL, NULL),
(342, 0, 1578319486, '', 1, 7, '0.00', 'out', NULL, NULL),
(343, 0, 1578319486, '', 1, 5, '0.00', 'out', NULL, NULL),
(344, 0, 1578329414, '', 1, 32, '0.00', 'out', NULL, NULL),
(345, 0, 1578329414, '', 1, 31, '0.00', 'out', NULL, NULL),
(346, 0, 1578397348, '', 1, 7, '0.00', 'out', NULL, NULL),
(347, 0, 1578405053, '', 1, 32, '0.00', 'out', NULL, NULL),
(348, 0, 1578405053, '', 1, 31, '0.00', 'out', NULL, NULL),
(349, 0, 1578416195, '', 1, 27, '0.00', 'out', NULL, NULL),
(350, 0, 1578416195, '', 1, 25, '0.00', 'out', NULL, NULL),
(351, 0, 1578417377, '', 1, 7, '0.00', 'out', NULL, NULL),
(352, 0, 1578428158, '', 1, 14, '0.00', 'out', NULL, NULL),
(353, 0, 1578428158, '', 1, 9, '0.00', 'out', NULL, NULL),
(354, 0, 1578428158, '', 1, 6, '0.00', 'out', NULL, NULL),
(355, 0, 1578430683, '', 1, 25, '0.00', 'out', NULL, NULL),
(356, 0, 1578466182, '', 1, 6, '0.00', 'out', NULL, NULL),
(357, 0, 1578501008, '', 1, 29, '0.00', 'out', NULL, NULL),
(358, 0, 1578501008, '', 1, 29, '0.00', 'out', NULL, NULL),
(359, 0, 1578501008, '', 1, 29, '0.00', 'out', NULL, NULL),
(360, 0, 1578501008, '', 1, 29, '0.00', 'out', NULL, NULL),
(361, 0, 1578501008, '', 1, 29, '0.00', 'out', NULL, NULL),
(362, 0, 1578501008, '', 1, 29, '0.00', 'out', NULL, NULL),
(363, 0, 1578573765, '', 1, 31, '0.00', 'out', NULL, NULL),
(364, 0, 1578581176, '', 1, 31, '0.00', 'out', NULL, NULL),
(365, 0, 1578586952, '', 1, 30, '0.00', 'out', NULL, NULL),
(366, 0, 1578732711, '', 1, 16, '0.00', 'out', NULL, NULL),
(367, 0, 1578732711, '', 1, 20, '0.00', 'out', NULL, NULL),
(368, 0, 1578740501, '', 2, 32, '0.00', 'out', NULL, NULL),
(369, 0, 1578740501, '', 2, 31, '0.00', 'out', NULL, NULL),
(370, 0, 1578811248, '', 1, 16, '0.00', 'out', NULL, NULL),
(371, 0, 1578903185, '', 1, 31, '0.00', 'out', NULL, NULL),
(372, 0, 1578976565, '', 1, 7, '0.00', 'out', NULL, NULL),
(373, 0, 1578977199, '', 1, 32, '0.00', 'out', NULL, NULL),
(374, 0, 1578998278, '', 1, 16, '0.00', 'out', NULL, NULL),
(375, 0, 1579000138, '', 1, 32, '0.00', 'out', NULL, NULL),
(376, 0, 1579021626, '', 1, 32, '0.00', 'out', NULL, NULL),
(377, 0, 1579021626, '', 1, 30, '0.00', 'out', NULL, NULL),
(378, 0, 1579021626, '', 1, 22, '0.00', 'out', NULL, NULL),
(379, 0, 1579021882, '', 1, 32, '0.00', 'out', NULL, NULL),
(380, 0, 1579021882, '', 1, 31, '0.00', 'out', NULL, NULL),
(381, 0, 1579041002, '', 10, 19, '0.00', 'out', NULL, NULL),
(382, 0, 1579041002, '', 10, 19, '0.00', 'out', NULL, NULL),
(383, 0, 1579041002, '', 10, 19, '0.00', 'out', NULL, NULL),
(384, 0, 1579083939, '', 1, 18, '0.00', 'out', NULL, NULL),
(385, 0, 1579088472, '', 1, 7, '0.00', 'out', NULL, NULL),
(386, 0, 1579088547, '', 3, 7, '0.00', 'out', NULL, NULL),
(387, 0, 1579157329, '', 2, 7, '0.00', 'out', NULL, NULL),
(388, 0, 1579157329, '', 1, 25, '0.00', 'out', NULL, NULL),
(389, 0, 1579175240, '', 1, 32, '0.00', 'out', NULL, NULL),
(390, 0, 1579183384, '', 1, 5, '0.00', 'out', NULL, NULL),
(391, 0, 1579244206, '', 1, 6, '0.00', 'out', NULL, NULL),
(392, 0, 1579244206, '', 1, 6, '0.00', 'out', NULL, NULL),
(393, 0, 1579244206, '', 1, 6, '0.00', 'out', NULL, NULL),
(394, 0, 1579271589, '', 1, 16, '0.00', 'out', NULL, NULL),
(395, 0, 1579517538, '', 1, 16, '0.00', 'out', NULL, NULL),
(396, 0, 1579543233, '', 1, 32, '0.00', 'out', NULL, NULL),
(397, 0, 1579545268, '', 1, 31, '0.00', 'out', NULL, NULL),
(398, 0, 1579545268, '', 3, 18, '0.00', 'out', NULL, NULL),
(399, 0, 1579591719, '', 1, 7, '0.00', 'out', NULL, NULL),
(400, 0, 1579629961, '', 1, 16, '0.00', 'out', NULL, NULL),
(401, 0, 1579659638, '', 1, 7, '0.00', 'out', NULL, NULL),
(402, 0, 1579729046, '', 1, 16, '0.00', 'out', NULL, NULL),
(403, 0, 1579729046, '', 2, 6, '0.00', 'out', NULL, NULL),
(404, 0, 1579729046, '', 2, 6, '0.00', 'out', NULL, NULL),
(405, 0, 1579729046, '', 2, 6, '0.00', 'out', NULL, NULL),
(406, 0, 1579792468, '', 1, 16, '0.00', 'out', NULL, NULL),
(407, 0, 1579830819, '', 1, 7, '0.00', 'out', NULL, NULL),
(408, 0, 1579861823, '', 1, 10, '0.00', 'out', NULL, NULL),
(409, 0, 1579861823, '', 4, 7, '0.00', 'out', NULL, NULL),
(410, 0, 1579883377, '', 1, 16, '0.00', 'out', NULL, NULL),
(411, 0, 1579883377, '', 1, 7, '0.00', 'out', NULL, NULL),
(412, 0, 1579938943, '', 1, 7, '0.00', 'out', NULL, NULL),
(413, 0, 1579946198, '', 1, 32, '0.00', 'out', NULL, NULL),
(414, 0, 1579995477, '', 4, 7, '0.00', 'out', NULL, NULL),
(415, 0, 1579995477, '', 2, 5, '0.00', 'out', NULL, NULL),
(416, 0, 1580100632, '', 2, 32, '0.00', 'out', NULL, NULL),
(417, 0, 1580177380, '', 1, 32, '0.00', 'out', NULL, NULL),
(418, 0, 1580229665, '', 1, 3, '0.00', 'out', NULL, NULL),
(419, 0, 1580240743, '', 1, 16, '0.00', 'out', NULL, NULL),
(420, 0, 1580374918, '', 1, 32, '0.00', 'out', NULL, NULL),
(421, 0, 1580374918, '', 2, 30, '0.00', 'out', NULL, NULL),
(422, 0, 1580374918, '', 1, 31, '0.00', 'out', NULL, NULL),
(423, 0, 1580390835, '', 1, 32, '0.00', 'out', NULL, NULL),
(424, 0, 1580606572, '', 1, 32, '0.00', 'out', NULL, NULL),
(425, 0, 1580638360, '', 1, 30, '0.00', 'out', NULL, NULL),
(426, 0, 1580652018, '', 1, 2, '0.00', 'out', NULL, NULL),
(427, 0, 1580652072, '', 1, 2, '0.00', 'out', NULL, NULL),
(428, 0, 1580813277, '', 1, 31, '0.00', 'out', NULL, NULL),
(429, 0, 1580814352, '', 1, 2, '0.00', 'out', NULL, NULL),
(430, 0, 1580816031, '', 1, 15, '0.00', 'out', NULL, NULL),
(431, 0, 1580816234, '', 1, 15, '0.00', 'out', NULL, NULL),
(432, 0, 1580816467, '', 1, 15, '0.00', 'out', NULL, NULL),
(433, 0, 1580816924, '', 1, 14, '0.00', 'out', NULL, NULL),
(434, 0, 1580817037, '', 1, 15, '0.00', 'out', NULL, NULL),
(435, 0, 1580904917, '', 1, 7, '0.00', 'out', NULL, NULL),
(436, 0, 1580905464, '', 1, 7, '0.00', 'out', NULL, NULL),
(437, 0, 1580932218, '', 1, 32, '0.00', 'out', NULL, NULL),
(438, 0, 1580940240, '', 1, 1, '0.00', 'out', NULL, NULL),
(439, 0, 1581033287, '', 1, 3, '0.00', 'out', NULL, NULL),
(440, 0, 1581090153, '', 1, 7, '0.00', 'out', NULL, NULL),
(441, 0, 1581233766, '', 1, 32, '0.00', 'out', NULL, NULL),
(442, 0, 1581247432, '', 2, 5, '0.00', 'out', NULL, NULL),
(443, 0, 1581303940, '', 1, 20, '0.00', 'out', NULL, NULL),
(444, 0, 1581303940, '', 1, 16, '0.00', 'out', NULL, NULL),
(445, 0, 1581343292, '', 2, 16, '0.00', 'out', NULL, NULL),
(446, 0, 1581366047, '', 1, 31, '0.00', 'out', NULL, NULL),
(447, 0, 1581384500, '', 1, 32, '0.00', 'out', NULL, NULL),
(448, 0, 1581405905, '', 1, 16, '0.00', 'out', NULL, NULL),
(449, 0, 1581405905, '', 1, 5, '0.00', 'out', NULL, NULL),
(450, 0, 1581411113, '', 1, 32, '0.00', 'out', NULL, NULL),
(451, 0, 1581411113, '', 1, 31, '0.00', 'out', NULL, NULL),
(452, 0, 1581456654, '', 1, 31, '0.00', 'out', NULL, NULL),
(453, 0, 1581456654, '', 1, 31, '0.00', 'out', NULL, NULL),
(454, 0, 1581517599, '', 1, 32, '0.00', 'out', NULL, NULL),
(455, 0, 1581517599, '', 1, 31, '0.00', 'out', NULL, NULL),
(456, 0, 1581518120, '', 1, 7, '0.00', 'out', NULL, NULL),
(457, 0, 1581535688, '', 1, 29, '0.00', 'out', NULL, NULL),
(458, 0, 1581535688, '', 1, 29, '0.00', 'out', NULL, NULL),
(459, 0, 1581535688, '', 1, 29, '0.00', 'out', NULL, NULL),
(460, 0, 1581535688, '', 1, 29, '0.00', 'out', NULL, NULL),
(461, 0, 1581535688, '', 1, 29, '0.00', 'out', NULL, NULL),
(462, 0, 1581535688, '', 1, 29, '0.00', 'out', NULL, NULL),
(463, 0, 1581584598, '', 1, 4, '0.00', 'out', NULL, NULL),
(464, 0, 1581599589, '', 5, 32, '0.00', 'out', NULL, NULL),
(465, 0, 1581622915, '', 1, 32, '0.00', 'out', NULL, NULL),
(466, 0, 1581623494, '', 1, 20, '0.00', 'out', NULL, NULL),
(467, 0, 1581623494, '', 3, 3, '0.00', 'out', NULL, NULL),
(468, 0, 1581675976, '', 1, 31, '0.00', 'out', NULL, NULL),
(469, 0, 1581675976, '', 1, 29, '0.00', 'out', NULL, NULL),
(470, 0, 1581675976, '', 1, 30, '0.00', 'out', NULL, NULL),
(471, 0, 1581705662, '', 1, 14, '0.00', 'out', NULL, NULL),
(472, 0, 1581706335, '', 1, 32, '0.00', 'out', NULL, NULL),
(473, 0, 1581706335, '', 1, 31, '0.00', 'out', NULL, NULL),
(474, 0, 1582020381, '', 14, 14, '0.00', 'out', NULL, NULL),
(475, 0, 1582138664, '', 1, 16, '0.00', 'out', NULL, NULL),
(476, 0, 1582172341, '', 1, 7, '0.00', 'out', NULL, NULL),
(477, 0, 1582172341, '', 1, 31, '0.00', 'out', NULL, NULL),
(478, 0, 1582172341, '', 1, 29, '0.00', 'out', NULL, NULL),
(479, 0, 1582194150, '', 1, 31, '0.00', 'out', NULL, NULL),
(480, 0, 1582194150, '', 1, 22, '0.00', 'out', NULL, NULL),
(481, 0, 1582218124, '', 1, 32, '0.00', 'out', NULL, NULL),
(482, 0, 1583205044, '', 1, 1, '0.00', 'out', NULL, NULL),
(483, 0, 1583230903, '', 1, 7, '0.00', 'out', NULL, NULL),
(484, 0, 1583247689, '', 1, 31, '0.00', 'out', NULL, NULL),
(485, 0, 1583337785, '', 1, 32, '0.00', 'out', NULL, NULL),
(486, 0, 1583838406, '', 1, 32, '0.00', 'out', NULL, NULL),
(487, 0, 1583846512, '', 1, 32, '0.00', 'out', NULL, NULL),
(488, 0, 1583846512, '', 1, 16, '0.00', 'out', NULL, NULL),
(489, 0, 1585679909, '', 1, 4, '0.00', 'out', NULL, NULL),
(490, 0, 1585679909, '', 2, 2, '0.00', 'out', NULL, NULL),
(491, 0, 1585752105, '', 1, 12, '0.00', 'out', NULL, NULL),
(492, 0, 1585752105, '', 60, 10, '0.00', 'out', NULL, NULL),
(493, 1, 0, '123', -920, 10, '10.00', 'in', '2020-03-31 20:54:08', NULL),
(494, 1, 0, '123', 20, 10, '10.00', 'in', '2020-03-31 20:55:22', NULL),
(495, 1, 0, '123', 11, 10, '2.00', 'in', '2020-03-31 20:56:49', NULL),
(496, 1, 0, '123', 1, 10, '1.00', 'in', '2020-03-31 20:57:27', NULL),
(497, 0, 1585753507, '', 1, 31, '0.00', 'out', NULL, NULL),
(498, 0, 1585753507, '', 1, 17, '0.00', 'out', NULL, NULL),
(499, 0, 1585756782, '', 1, 32, '0.00', 'out', NULL, NULL),
(500, 0, 1585757050, '', 1, 1, '0.00', 'out', NULL, NULL),
(501, 0, 1585765669, '', 6, 1, '0.00', 'out', NULL, NULL),
(502, 0, 1585766575, '', 1, 2, '0.00', 'out', NULL, NULL),
(503, 0, 1585766863, '', 1, 1, '0.00', 'out', NULL, NULL),
(504, 0, 1585828625, '', 1, 7, '0.00', 'out', NULL, NULL),
(505, 0, 1585845627, '', 1, 7, '0.00', 'out', NULL, NULL),
(506, 0, 1585845742, '', 1, 26, '0.00', 'out', NULL, NULL),
(507, 0, 1585846050, '', 1, 22, '0.00', 'out', NULL, NULL),
(508, 0, 1585846113, '', 1, 21, '0.00', 'out', NULL, NULL),
(509, 0, 1585846158, '', 1, 30, '0.00', 'out', NULL, NULL),
(510, 0, 1585846302, '', 1, 29, '0.00', 'out', NULL, NULL),
(511, 0, 1585846407, '', 1, 7, '0.00', 'out', NULL, NULL),
(512, 0, 1585847130, '', 3, 7, '0.00', 'out', NULL, NULL),
(513, 0, 1585925827, '', 1, 32, '0.00', 'out', NULL, NULL),
(514, 0, 1585925827, '', 1, 1, '0.00', 'out', NULL, NULL),
(515, 0, 1586019655, '', 1, 14, '0.00', 'out', NULL, NULL),
(516, 0, 1586019655, '', 1, 17, '0.00', 'out', NULL, NULL),
(517, 0, 1586022609, '', 1, 32, '0.00', 'out', NULL, NULL),
(518, 0, 1586022609, '', 1, 26, '0.00', 'out', NULL, NULL),
(519, 0, 1586022609, '', 1, 19, '0.00', 'out', NULL, NULL),
(520, 0, 1586022609, '', 1, 18, '0.00', 'out', NULL, NULL),
(521, 0, 1586022609, '', 1, 17, '0.00', 'out', NULL, NULL),
(522, 1, 0, NULL, 900, 36, '120.00', 'in', '2020-07-13 19:13:51', NULL),
(523, 1, 0, NULL, 400, 36, '150.00', 'in', '2020-07-13 19:15:03', NULL),
(524, 0, 1594901141, '', 1, 32, '0.00', 'out', '2020-07-16 12:05:41', NULL),
(525, 0, 1594901141, '', 2, 31, '0.00', 'out', '2020-07-16 12:05:41', NULL),
(526, 0, 1594901141, '', 1, 30, '0.00', 'out', '2020-07-16 12:05:41', NULL),
(527, 0, 1594901141, '', 1, 7, '0.00', 'out', '2020-07-16 12:05:41', NULL),
(528, 0, 1594901141, '', 2, 36, '0.00', 'out', '2020-07-16 12:05:41', NULL),
(529, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-07-19 12:17:29', NULL),
(530, 1, 0, NULL, 2, 31, '0.00', 'in', '2020-07-19 12:17:29', NULL),
(531, 1, 0, NULL, 1, 30, '0.00', 'in', '2020-07-19 12:17:30', NULL),
(532, 1, 0, NULL, 1, 7, '0.00', 'in', '2020-07-19 12:17:30', NULL),
(533, 1, 0, NULL, 2, 36, '0.00', 'in', '2020-07-19 12:17:30', NULL),
(534, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-07-19 12:17:37', NULL),
(535, 1, 0, NULL, 2, 31, '0.00', 'in', '2020-07-19 12:17:37', NULL),
(536, 1, 0, NULL, 1, 30, '0.00', 'in', '2020-07-19 12:17:37', NULL),
(537, 1, 0, NULL, 1, 7, '0.00', 'in', '2020-07-19 12:17:37', NULL),
(538, 1, 0, NULL, 2, 36, '0.00', 'in', '2020-07-19 12:17:37', NULL),
(539, 1, 0, NULL, 10, 43, '800.00', 'in', '2020-07-22 13:45:40', NULL),
(540, 1, 0, NULL, 3, 42, '1200.00', 'in', '2020-07-22 13:46:52', NULL),
(541, 1, 0, NULL, 1, 41, '1400.00', 'in', '2020-07-22 13:48:05', NULL),
(542, 1, 0, NULL, 3, 40, '1400.00', 'in', '2020-07-22 13:53:03', NULL),
(543, 1, 0, NULL, 1, 44, '800.00', 'in', '2020-07-22 13:57:18', NULL),
(544, 1, 0, NULL, 1, 45, '800.00', 'in', '2020-07-22 14:05:55', NULL),
(545, 1, 0, NULL, 1, 46, '800.00', 'in', '2020-07-22 14:08:35', NULL),
(546, 1, 0, NULL, 1, 47, '800.00', 'in', '2020-07-22 14:11:51', NULL),
(547, 1, 0, NULL, 1, 48, '800.00', 'in', '2020-07-22 14:13:11', NULL),
(548, 1, 0, NULL, 1, 49, '800.00', 'in', '2020-07-22 14:14:39', NULL),
(549, 1, 0, NULL, 2, 50, '700.00', 'in', '2020-07-23 14:43:14', NULL),
(550, 1, 0, NULL, 2, 51, '700.00', 'in', '2020-07-23 14:43:28', NULL),
(551, 1, 0, NULL, 2, 52, '700.00', 'in', '2020-07-23 14:43:39', NULL),
(552, 1, 0, NULL, 2, 53, '700.00', 'in', '2020-07-23 14:43:50', NULL),
(553, 1, 0, NULL, 10, 39, '85000.00', 'in', '2020-07-26 13:09:10', NULL),
(554, 1, 0, NULL, 50, 38, '2200.00', 'in', '2020-07-26 13:09:38', NULL),
(555, 1, 0, NULL, 50, 37, '2200.00', 'in', '2020-07-26 13:10:02', NULL),
(556, 1, 0, NULL, 2, 54, '700.00', 'in', '2020-07-26 14:29:46', NULL),
(557, 1, 0, NULL, 2, 55, '900.00', 'in', '2020-07-26 14:30:01', NULL),
(558, 1, 0, NULL, 2, 56, '750.00', 'in', '2020-07-26 14:30:22', NULL),
(559, 1, 0, NULL, 2, 57, '750.00', 'in', '2020-07-26 14:30:45', NULL),
(560, 1, 0, NULL, 2, 58, '800.00', 'in', '2020-07-26 14:31:05', NULL),
(561, 1, 0, NULL, 2, 59, '750.00', 'in', '2020-07-26 14:31:28', NULL),
(562, 1, 0, NULL, 2, 60, '750.00', 'in', '2020-07-26 14:31:43', NULL),
(563, 1, 0, NULL, 2, 61, '750.00', 'in', '2020-07-26 14:31:53', NULL),
(564, 1, 0, NULL, 2, 62, '900.00', 'in', '2020-07-26 14:32:18', NULL),
(565, 1, 0, NULL, 2, 63, '900.00', 'in', '2020-07-26 14:32:30', NULL),
(566, 1, 0, NULL, 2, 64, '900.00', 'in', '2020-07-26 14:32:39', NULL),
(567, 0, 1597043013, '', 2, 42, '0.00', 'out', '2020-08-10 07:03:33', NULL),
(568, 0, 1597043013, '', 2, 52, '0.00', 'out', '2020-08-10 07:03:33', NULL),
(569, 0, 1597043013, '', 2, 63, '0.00', 'out', '2020-08-10 07:03:33', NULL),
(570, 1, 0, NULL, 2, 42, '0.00', 'in', '2020-08-10 11:23:22', NULL),
(571, 1, 0, NULL, 2, 52, '0.00', 'in', '2020-08-10 11:23:22', NULL),
(572, 1, 0, NULL, 2, 63, '0.00', 'in', '2020-08-10 11:23:22', NULL),
(573, 1, 0, NULL, 2, 42, '0.00', 'in', '2020-08-10 11:23:38', NULL),
(574, 1, 0, NULL, 2, 52, '0.00', 'in', '2020-08-10 11:23:38', NULL),
(575, 1, 0, NULL, 2, 63, '0.00', 'in', '2020-08-10 11:23:38', NULL),
(576, 1, 0, NULL, 4, 54, '700.00', 'in', '2020-08-10 11:24:33', NULL),
(577, 0, 1597836089, '', 1, 61, '0.00', 'out', '2020-08-19 11:21:29', NULL),
(578, 1, 0, NULL, 5, 67, '700000.00', 'in', '2020-08-19 15:56:06', NULL),
(579, 1, 0, NULL, 5, 68, '1000000.00', 'in', '2020-08-19 15:56:33', NULL),
(580, 1, 0, NULL, 5, 65, '700000.00', 'in', '2020-08-19 15:56:57', NULL),
(581, 1, 0, NULL, 5, 66, '900000.00', 'in', '2020-08-19 15:57:20', NULL),
(582, 1, 0, NULL, 5, 69, '1300000.00', 'in', '2020-08-19 15:57:50', NULL),
(583, 1, 0, NULL, 5, 70, '1500000.00', 'in', '2020-08-19 15:58:27', NULL),
(584, 1, 0, NULL, 5, 71, '2000000.00', 'in', '2020-08-19 15:59:37', NULL),
(585, 1, 0, NULL, 5, 73, '3400000.00', 'in', '2020-08-19 16:00:05', NULL),
(586, 0, 1598356971, '', 1, 36, '0.00', 'out', '2020-08-25 12:02:51', NULL),
(587, 0, 1598356971, '', 1, 38, '0.00', 'out', '2020-08-25 12:02:51', NULL),
(588, 1, 0, NULL, 1, 61, '0.00', 'in', '2020-08-25 16:03:25', NULL),
(589, 1, 0, NULL, 1, 36, '0.00', 'in', '2020-08-25 16:03:48', NULL),
(590, 1, 0, NULL, 1, 38, '0.00', 'in', '2020-08-25 16:03:48', NULL),
(591, 1, 0, NULL, 1, 61, '0.00', 'in', '2020-08-25 16:04:01', NULL),
(592, 1, 0, NULL, 1, 36, '0.00', 'in', '2020-08-25 16:04:05', NULL),
(593, 1, 0, NULL, 1, 38, '0.00', 'in', '2020-08-25 16:04:05', NULL),
(594, 1, 0, NULL, 5, 72, '2000000.00', 'in', '2020-08-25 16:05:36', NULL),
(595, 0, 1598357933, '', 3, 70, '0.00', 'out', '2020-08-25 12:18:53', NULL),
(596, 0, 1598357933, '', 2, 73, '0.00', 'out', '2020-08-25 12:18:53', NULL),
(597, 0, 1598420251, '', 2, 60, '0.00', 'out', '2020-08-26 05:37:31', NULL),
(598, 0, 1598420251, '', 2, 61, '0.00', 'out', '2020-08-26 05:37:31', NULL),
(599, 0, 1598420965, '', 1, 36, '0.00', 'out', '2020-08-26 05:49:25', NULL),
(600, 0, 1599157534, '', 1, 53, '0.00', 'out', '2020-09-03 18:25:34', NULL),
(601, 1, 0, NULL, 1, 53, '0.00', 'in', '2020-09-05 08:09:27', NULL),
(602, 1, 0, NULL, 2, 60, '0.00', 'in', '2020-09-05 08:09:35', NULL),
(603, 1, 0, NULL, 2, 61, '0.00', 'in', '2020-09-05 08:09:35', NULL),
(604, 1, 0, NULL, 3, 70, '0.00', 'in', '2020-09-05 08:09:39', NULL),
(605, 1, 0, NULL, 2, 73, '0.00', 'in', '2020-09-05 08:09:39', NULL),
(606, 1, 0, NULL, 1, 36, '0.00', 'in', '2020-09-05 08:10:06', NULL),
(607, 1, 0, NULL, 1, 36, '0.00', 'in', '2020-09-05 08:10:12', NULL),
(608, 0, 0, NULL, 0, 0, '0.00', '', '2020-09-07 05:27:43', NULL),
(609, 0, 1599456889, '', 2, 26, '0.00', 'out', '2020-09-07 05:34:49', NULL),
(610, 0, 1599456889, '', 3, 27, '0.00', 'out', '2020-09-07 05:34:49', NULL),
(611, 0, 1599456889, '', 2, 28, '0.00', 'out', '2020-09-07 05:34:49', NULL),
(612, 0, 1599464485, '', 3, 27, '0.00', 'out', '2020-09-07 07:41:25', NULL),
(613, 0, 1599464555, '', 3, 27, '0.00', 'out', '2020-09-07 07:42:35', NULL),
(614, 0, 1599465776, '', 1, 14, '0.00', 'out', '2020-09-07 08:02:56', NULL),
(615, 0, 1599465776, '', 1, 15, '0.00', 'out', '2020-09-07 08:02:56', NULL),
(616, 0, 1599465776, '', 1, 16, '0.00', 'out', '2020-09-07 08:02:56', NULL),
(617, 0, 1599468076, '', 1, 16, '0.00', 'out', '2020-09-07 08:41:16', NULL),
(618, 0, 1599468076, '', 2, 15, '0.00', 'out', '2020-09-07 08:41:16', NULL),
(619, 0, 1599468076, '', 3, 14, '0.00', 'out', '2020-09-07 08:41:16', NULL),
(620, 0, 1599468076, '', 1, 46, '0.00', 'out', '2020-09-07 08:41:16', NULL),
(621, 0, 1599468076, '', 1, 54, '0.00', 'out', '2020-09-07 08:41:16', NULL),
(622, 0, 1599468076, '', 1, 10, '0.00', 'out', '2020-09-07 08:41:16', NULL),
(623, 0, 1599468727, '', 1, 27, '0.00', 'out', '2020-09-07 08:52:07', NULL),
(624, 0, 1599510479, '', 1, 27, '0.00', 'out', '2020-09-07 20:27:59', NULL),
(625, 1, 0, NULL, 2, 26, '0.00', 'in', '2020-09-08 09:34:19', NULL),
(626, 1, 0, NULL, 3, 27, '0.00', 'in', '2020-09-08 09:34:19', NULL),
(627, 1, 0, NULL, 2, 28, '0.00', 'in', '2020-09-08 09:34:19', NULL),
(628, 1, 0, NULL, 3, 27, '0.00', 'in', '2020-09-08 09:34:37', NULL),
(629, 1, 0, NULL, 3, 27, '0.00', 'in', '2020-09-08 09:34:48', NULL),
(630, 1, 0, NULL, 1, 14, '0.00', 'in', '2020-09-08 09:34:59', NULL),
(631, 1, 0, NULL, 1, 15, '0.00', 'in', '2020-09-08 09:34:59', NULL),
(632, 1, 0, NULL, 1, 16, '0.00', 'in', '2020-09-08 09:34:59', NULL),
(633, 1, 0, NULL, 1, 16, '0.00', 'in', '2020-09-08 09:35:13', NULL),
(634, 1, 0, NULL, 2, 15, '0.00', 'in', '2020-09-08 09:35:13', NULL),
(635, 1, 0, NULL, 3, 14, '0.00', 'in', '2020-09-08 09:35:13', NULL),
(636, 1, 0, NULL, 1, 46, '0.00', 'in', '2020-09-08 09:35:13', NULL),
(637, 1, 0, NULL, 1, 54, '0.00', 'in', '2020-09-08 09:35:13', NULL),
(638, 1, 0, NULL, 1, 10, '0.00', 'in', '2020-09-08 09:35:13', NULL),
(639, 1, 0, NULL, 0, 0, '0.00', 'in', '2020-09-08 09:35:23', NULL),
(640, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-09-08 09:35:41', NULL),
(641, 1, 0, NULL, 0, 0, '0.00', 'in', '2020-09-08 09:36:14', NULL),
(642, 1, 0, NULL, 2, 26, '0.00', 'in', '2020-09-08 09:36:31', NULL),
(643, 1, 0, NULL, 3, 27, '0.00', 'in', '2020-09-08 09:36:31', NULL),
(644, 1, 0, NULL, 2, 28, '0.00', 'in', '2020-09-08 09:36:31', NULL),
(645, 1, 0, NULL, 1, 14, '0.00', 'in', '2020-09-08 09:36:34', NULL),
(646, 1, 0, NULL, 1, 15, '0.00', 'in', '2020-09-08 09:36:34', NULL),
(647, 1, 0, NULL, 1, 16, '0.00', 'in', '2020-09-08 09:36:34', NULL),
(648, 1, 0, NULL, 1, 16, '0.00', 'in', '2020-09-08 09:36:37', NULL),
(649, 1, 0, NULL, 2, 15, '0.00', 'in', '2020-09-08 09:36:37', NULL),
(650, 1, 0, NULL, 3, 14, '0.00', 'in', '2020-09-08 09:36:37', NULL),
(651, 1, 0, NULL, 1, 46, '0.00', 'in', '2020-09-08 09:36:37', NULL),
(652, 1, 0, NULL, 1, 54, '0.00', 'in', '2020-09-08 09:36:37', NULL),
(653, 1, 0, NULL, 1, 10, '0.00', 'in', '2020-09-08 09:36:37', NULL),
(654, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-09-08 09:36:41', NULL),
(655, 1, 0, NULL, 3, 27, '0.00', 'in', '2020-09-08 09:36:44', NULL),
(656, 1, 0, NULL, 3, 27, '0.00', 'in', '2020-09-08 09:36:47', NULL),
(657, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-09-08 09:36:56', NULL),
(658, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-09-08 09:37:02', NULL),
(659, 1, 0, NULL, 0, 0, '0.00', 'in', '2020-09-08 09:37:06', NULL),
(660, 0, 1599887498, '', 3, 27, '0.00', 'out', '2020-09-12 05:11:38', NULL),
(661, 0, 1599887498, '', 7, 28, '0.00', 'out', '2020-09-12 05:11:38', NULL),
(662, 0, 1599887498, '', 9, 29, '0.00', 'out', '2020-09-12 05:11:38', NULL),
(663, 0, 1599887498, '', 2, 32, '0.00', 'out', '2020-09-12 05:11:38', NULL),
(664, 0, 1599887498, '', 2, 72, '0.00', 'out', '2020-09-12 05:11:38', NULL),
(665, 0, 1599948016, '', 1, 27, '0.00', 'out', '2020-09-12 22:00:16', NULL),
(666, 0, 1599990496, '', 1, 27, '0.00', 'out', '2020-09-13 09:48:16', NULL),
(667, 0, 1599990496, '', 1, 32, '0.00', 'out', '2020-09-13 09:48:16', NULL),
(668, 0, 1599990496, '', 1, 73, '0.00', 'out', '2020-09-13 09:48:16', NULL),
(669, 1, 0, NULL, 0, 0, '0.00', 'in', '2020-09-14 13:02:53', NULL),
(670, 1, 0, NULL, 3, 27, '0.00', 'in', '2020-09-14 13:03:21', NULL),
(671, 1, 0, NULL, 7, 28, '0.00', 'in', '2020-09-14 13:03:21', NULL),
(672, 1, 0, NULL, 9, 29, '0.00', 'in', '2020-09-14 13:03:21', NULL),
(673, 1, 0, NULL, 2, 32, '0.00', 'in', '2020-09-14 13:03:21', NULL),
(674, 1, 0, NULL, 2, 72, '0.00', 'in', '2020-09-14 13:03:21', NULL),
(675, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-09-14 13:03:49', NULL),
(676, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-09-14 13:32:55', NULL),
(677, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-09-14 13:32:55', NULL),
(678, 1, 0, NULL, 1, 73, '0.00', 'in', '2020-09-14 13:32:55', NULL),
(679, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-09-14 13:33:04', NULL),
(680, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-09-14 13:33:04', NULL),
(681, 1, 0, NULL, 1, 73, '0.00', 'in', '2020-09-14 13:33:04', NULL),
(682, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-09-14 13:33:59', NULL),
(683, 1, 0, NULL, 3, 27, '0.00', 'in', '2020-09-14 13:34:03', NULL),
(684, 1, 0, NULL, 7, 28, '0.00', 'in', '2020-09-14 13:34:03', NULL),
(685, 1, 0, NULL, 9, 29, '0.00', 'in', '2020-09-14 13:34:03', NULL),
(686, 1, 0, NULL, 2, 32, '0.00', 'in', '2020-09-14 13:34:03', NULL),
(687, 1, 0, NULL, 2, 72, '0.00', 'in', '2020-09-14 13:34:03', NULL),
(688, 1, 0, NULL, 0, 0, '0.00', 'in', '2020-09-14 13:36:52', NULL),
(689, 1, 0, NULL, 0, 0, '0.00', 'in', '2020-09-14 13:39:26', NULL),
(690, 1, 0, NULL, 0, 0, '0.00', 'in', '2020-09-14 13:39:45', NULL),
(691, 1, 0, NULL, 0, 0, '0.00', 'in', '2020-09-14 13:41:21', NULL),
(692, 0, 1600076588, '', 1, 47, '0.00', 'out', '2020-09-14 09:43:08', NULL),
(693, 1, 0, NULL, 1, 47, '0.00', 'in', '2020-09-14 13:43:23', NULL),
(694, 0, 1600076942, '', 1, 32, '0.00', 'out', '2020-09-14 09:49:02', NULL),
(695, 1, 0, NULL, 0, 0, '0.00', 'in', '2020-09-14 13:49:56', NULL),
(696, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-09-14 13:50:06', NULL),
(697, 0, 1600077046, '', 1, 27, '0.00', 'out', '2020-09-14 09:50:46', NULL),
(698, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-09-14 13:52:48', NULL),
(699, 1, 0, 'shari-00005', 5, 74, '1000.00', 'in', '2020-09-19 09:17:35', NULL),
(700, 1, 0, 'shari-00006', 5, 75, '950.00', 'in', '2020-09-19 09:17:59', NULL),
(701, 1, 0, 'shari-00007', 5, 76, '850.00', 'in', '2020-09-19 09:19:17', NULL),
(702, 1, 0, 'shari-00008', 5, 77, '1000.00', 'in', '2020-09-19 09:19:51', NULL),
(703, 1, 0, 'shari-00009', 5, 78, '650.00', 'in', '2020-09-19 09:20:11', NULL),
(704, 1, 0, NULL, 1000, 79, '100.00', 'in', '2020-09-26 14:50:02', NULL),
(705, 1, 0, NULL, 1000, 80, '250.00', 'in', '2020-09-26 14:50:28', NULL),
(706, 1, 0, NULL, 1000, 81, '400.00', 'in', '2020-09-26 14:50:46', NULL),
(707, 1, 0, NULL, 1000, 82, '550.00', 'in', '2020-09-26 14:51:13', NULL),
(708, 1, 0, NULL, 1000, 83, '280.00', 'in', '2020-09-26 14:51:37', NULL),
(709, 1, 0, NULL, 1000, 85, '500.00', 'in', '2020-09-26 14:52:00', NULL),
(710, 1, 0, NULL, 1000, 84, '550.00', 'in', '2020-09-26 14:52:23', NULL),
(711, 1, 0, NULL, 500, 86, '500.00', 'in', '2020-09-26 14:52:53', NULL),
(712, 1, 0, NULL, 1000, 87, '500.00', 'in', '2020-09-26 14:53:11', NULL),
(713, 0, 1601118446, '', 1, 38, '0.00', 'out', '2020-09-26 11:07:26', NULL),
(714, 0, 1601119606, '', 1, 36, '0.00', 'out', '2020-09-26 11:26:46', NULL),
(715, 0, 1601119806, '', 1, 36, '0.00', 'out', '2020-09-26 11:30:06', NULL),
(716, 0, 1601120059, '', 1, 36, '0.00', 'out', '2020-09-26 11:34:19', NULL),
(717, 0, 1601120410, '', 1, 36, '0.00', 'out', '2020-09-26 11:40:10', NULL),
(718, 0, 1601121312, '', 1, 86, '0.00', 'out', '2020-09-26 11:55:12', NULL),
(719, 0, 1601121511, '', 1, 86, '0.00', 'out', '2020-09-26 11:58:31', NULL),
(720, 0, 1601182119, '', 1, 36, '0.00', 'out', '2020-09-27 04:48:39', NULL),
(721, 0, 1601182315, '', 1, 36, '0.00', 'out', '2020-09-27 04:51:55', NULL),
(722, 0, 1601182388, '', 1, 36, '0.00', 'out', '2020-09-27 04:53:08', NULL),
(723, 0, 1601187397, '', 1, 36, '0.00', 'out', '2020-09-27 06:16:37', NULL),
(724, 0, 1601187636, '', 1, 36, '0.00', 'out', '2020-09-27 06:20:36', NULL),
(725, 0, 1601267066, '', 1, 22, '0.00', 'out', '2020-09-28 04:24:26', NULL),
(726, 0, 1601267847, '', 1, 36, '0.00', 'out', '2020-09-28 04:37:27', NULL),
(727, 0, 1601274923, '', 1, 36, '0.00', 'out', '2020-09-28 06:35:23', NULL),
(728, 0, 1601354404, '', 1, 36, '0.00', 'out', '2020-09-29 04:40:04', NULL),
(729, 0, 1601366708, '', 2, 87, '0.00', 'out', '2020-09-29 08:05:08', NULL),
(730, 0, 1601366837, '', 2, 87, '0.00', 'out', '2020-09-29 08:07:17', NULL),
(731, 0, 1601366929, '', 2, 87, '0.00', 'out', '2020-09-29 08:08:49', NULL),
(732, 0, 1601367089, '', 2, 87, '0.00', 'out', '2020-09-29 08:11:29', NULL),
(733, 0, 1601367658, '', 2, 87, '0.00', 'out', '2020-09-29 08:20:58', NULL),
(734, 0, 1601368041, '', 2, 87, '0.00', 'out', '2020-09-29 08:27:21', NULL),
(735, 0, 1601368095, '', 2, 87, '0.00', 'out', '2020-09-29 08:28:15', NULL),
(736, 0, 1601368225, '', 2, 87, '0.00', 'out', '2020-09-29 08:30:25', NULL),
(737, 0, 1601368282, '', 2, 87, '0.00', 'out', '2020-09-29 08:31:22', NULL),
(738, 0, 1601369205, '', 2, 87, '0.00', 'out', '2020-09-29 08:46:45', NULL),
(739, 0, 1601369590, '', 2, 87, '0.00', 'out', '2020-09-29 08:53:10', NULL),
(740, 0, 1601369712, '', 2, 87, '0.00', 'out', '2020-09-29 08:55:12', NULL),
(741, 0, 1601369902, '', 2, 87, '0.00', 'out', '2020-09-29 08:58:22', NULL),
(742, 0, 1601370021, '', 2, 87, '0.00', 'out', '2020-09-29 09:00:21', NULL),
(743, 0, 1601370203, '', 2, 87, '0.00', 'out', '2020-09-29 09:03:23', NULL),
(744, 0, 1601370846, '', 2, 87, '0.00', 'out', '2020-09-29 09:14:06', NULL),
(745, 0, 1601370935, '', 2, 87, '0.00', 'out', '2020-09-29 09:15:35', NULL),
(746, 0, 1601371178, '', 2, 87, '0.00', 'out', '2020-09-29 09:19:38', NULL),
(747, 0, 1601371248, '', 2, 87, '0.00', 'out', '2020-09-29 09:20:48', NULL),
(748, 0, 1601371396, '', 2, 87, '0.00', 'out', '2020-09-29 09:23:16', NULL),
(749, 0, 1601371402, '', 2, 87, '0.00', 'out', '2020-09-29 09:23:22', NULL),
(750, 0, 1601371535, '', 2, 87, '0.00', 'out', '2020-09-29 09:25:35', NULL),
(751, 0, 1601371689, '', 2, 87, '0.00', 'out', '2020-09-29 09:28:09', NULL),
(752, 0, 1601371744, '', 2, 87, '0.00', 'out', '2020-09-29 09:29:04', NULL),
(753, 0, 1601371988, '', 2, 87, '0.00', 'out', '2020-09-29 09:33:08', NULL),
(754, 0, 1601372140, '', 2, 87, '0.00', 'out', '2020-09-29 09:35:40', NULL),
(755, 0, 1601372231, '', 2, 87, '0.00', 'out', '2020-09-29 09:37:11', NULL),
(756, 0, 1601372307, '', 2, 87, '0.00', 'out', '2020-09-29 09:38:27', NULL),
(757, 0, 1601375033, '', 2, 87, '0.00', 'out', '2020-09-29 10:23:53', NULL),
(758, 0, 1601375112, '', 2, 87, '0.00', 'out', '2020-09-29 10:25:12', NULL),
(759, 0, 1601376778, '', 2, 87, '0.00', 'out', '2020-09-29 10:52:58', NULL),
(760, 0, 1601376969, '', 2, 87, '0.00', 'out', '2020-09-29 10:56:09', NULL),
(761, 0, 1601377070, '', 2, 87, '0.00', 'out', '2020-09-29 10:57:50', NULL),
(762, 0, 1601377153, '', 1, 86, '0.00', 'out', '2020-09-29 10:59:13', NULL),
(763, 0, 1601377557, '', 1, 86, '0.00', 'out', '2020-09-29 11:05:57', NULL),
(764, 0, 1601379153, '', 1, 86, '0.00', 'out', '2020-09-29 11:32:33', NULL),
(765, 0, 1601379364, '', 1, 86, '0.00', 'out', '2020-09-29 11:36:04', NULL),
(766, 0, 1601379471, '', 1, 86, '0.00', 'out', '2020-09-29 11:37:51', NULL),
(767, 0, 1601380401, '', 1, 86, '0.00', 'out', '2020-09-29 11:53:21', NULL),
(768, 0, 1601380448, '', 1, 86, '0.00', 'out', '2020-09-29 11:54:08', NULL),
(769, 0, 1601380600, '', 1, 86, '0.00', 'out', '2020-09-29 11:56:40', NULL),
(770, 0, 1601381858, '', 1, 86, '0.00', 'out', '2020-09-29 12:17:38', NULL),
(771, 0, 1601382429, '', 1, 86, '0.00', 'out', '2020-09-29 12:27:09', NULL),
(772, 0, 1601382429, '', 1, 87, '0.00', 'out', '2020-09-29 12:27:09', NULL),
(773, 0, 1601382429, '', 1, 85, '0.00', 'out', '2020-09-29 12:27:09', NULL),
(774, 0, 1601382429, '', 1, 84, '0.00', 'out', '2020-09-29 12:27:09', NULL),
(775, 0, 1601382429, '', 1, 79, '0.00', 'out', '2020-09-29 12:27:09', NULL),
(776, 0, 1601441314, '', 1, 27, '0.00', 'out', '2020-09-30 04:48:34', NULL),
(777, 0, 1601441314, '', 1, 28, '0.00', 'out', '2020-09-30 04:48:34', NULL),
(778, 0, 1601547814, '', 1, 14, '0.00', 'out', '2020-10-01 10:23:34', NULL),
(779, 0, 1601547814, '', 1, 27, '0.00', 'out', '2020-10-01 10:23:34', NULL),
(780, 0, 1601558475, '', 1, 14, '0.00', 'out', '2020-10-01 13:21:15', NULL),
(781, 0, 1601558475, '', 1, 27, '0.00', 'out', '2020-10-01 13:21:15', NULL),
(782, 0, 1601796317, '', 1, 32, '0.00', 'out', '2020-10-04 07:25:17', NULL),
(783, 0, 1601820370, '', 1, 32, '0.00', 'out', '2020-10-04 14:06:10', NULL),
(784, 0, 1601884932, '', 1, 87, '0.00', 'out', '2020-10-05 08:02:12', NULL),
(785, 0, 1601884932, '', 1, 86, '0.00', 'out', '2020-10-05 08:02:12', NULL),
(786, 0, 1601884932, '', 1, 84, '0.00', 'out', '2020-10-05 08:02:12', NULL),
(787, 0, 1601884932, '', 1, 83, '0.00', 'out', '2020-10-05 08:02:12', NULL),
(788, 0, 1601884932, '', 1, 82, '0.00', 'out', '2020-10-05 08:02:12', NULL),
(789, 1, 0, NULL, 1, 87, '0.00', 'in', '2020-10-11 09:27:15', NULL),
(790, 1, 0, NULL, 1, 86, '0.00', 'in', '2020-10-11 09:27:15', NULL);
INSERT INTO `inventory` (`inventory_ref_id`, `admin_id`, `added_date`, `reference_code`, `stock`, `products_id`, `purchase_price`, `stock_type`, `created_at`, `updated_at`) VALUES
(791, 1, 0, NULL, 1, 84, '0.00', 'in', '2020-10-11 09:27:15', NULL),
(792, 1, 0, NULL, 1, 83, '0.00', 'in', '2020-10-11 09:27:15', NULL),
(793, 1, 0, NULL, 1, 82, '0.00', 'in', '2020-10-11 09:27:15', NULL),
(794, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-10-11 09:27:19', NULL),
(795, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-10-11 09:27:25', NULL),
(796, 1, 0, NULL, 1, 14, '0.00', 'in', '2020-10-11 09:27:29', NULL),
(797, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-10-11 09:27:29', NULL),
(798, 1, 0, NULL, 1, 14, '0.00', 'in', '2020-10-11 09:27:34', NULL),
(799, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-10-11 09:27:34', NULL),
(800, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:21', NULL),
(801, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:21', NULL),
(802, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:21', NULL),
(803, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:24', NULL),
(804, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:24', NULL),
(805, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:27', NULL),
(806, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:27', NULL),
(807, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:27', NULL),
(808, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:30', NULL),
(809, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:30', NULL),
(810, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:30', NULL),
(811, 1, 0, NULL, 1, 36, '0.00', 'in', '2020-10-11 09:28:33', NULL),
(812, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:33', NULL),
(813, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:33', NULL),
(814, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:33', NULL),
(815, 1, 0, NULL, 1, 22, '0.00', 'in', '2020-10-11 09:28:37', NULL),
(816, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:37', NULL),
(817, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:37', NULL),
(818, 1, 0, NULL, 1, 36, '0.00', 'in', '2020-10-11 09:28:40', NULL),
(819, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:40', NULL),
(820, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:40', NULL),
(821, 1, 0, NULL, 1, 36, '0.00', 'in', '2020-10-11 09:28:44', NULL),
(822, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:44', NULL),
(823, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:44', NULL),
(824, 1, 0, NULL, 1, 36, '0.00', 'in', '2020-10-11 09:28:47', NULL),
(825, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:47', NULL),
(826, 1, 0, NULL, 1, 86, '0.00', 'in', '2020-10-11 09:28:47', NULL),
(827, 1, 0, NULL, 1, 27, '0.00', 'in', '2020-10-11 09:28:50', NULL),
(828, 1, 0, NULL, 1, 28, '0.00', 'in', '2020-10-11 09:28:50', NULL),
(829, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:54', NULL),
(830, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:54', NULL),
(831, 1, 0, NULL, 1, 86, '0.00', 'in', '2020-10-11 09:28:54', NULL),
(832, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:57', NULL),
(833, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:28:57', NULL),
(834, 1, 0, NULL, 1, 86, '0.00', 'in', '2020-10-11 09:28:57', NULL),
(835, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:29:00', NULL),
(836, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:29:00', NULL),
(837, 1, 0, NULL, 1, 86, '0.00', 'in', '2020-10-11 09:29:00', NULL),
(838, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:29:03', NULL),
(839, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:29:03', NULL),
(840, 1, 0, NULL, 1, 86, '0.00', 'in', '2020-10-11 09:29:03', NULL),
(841, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:29:07', NULL),
(842, 1, 0, NULL, 1, 86, '0.00', 'in', '2020-10-11 09:29:07', NULL),
(843, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:29:10', NULL),
(844, 1, 0, NULL, 1, 86, '0.00', 'in', '2020-10-11 09:29:10', NULL),
(845, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:29:13', NULL),
(846, 1, 0, NULL, 1, 86, '0.00', 'in', '2020-10-11 09:29:13', NULL),
(847, 1, 0, NULL, 2, 87, '0.00', 'in', '2020-10-11 09:29:17', NULL),
(848, 1, 0, NULL, 1, 86, '0.00', 'in', '2020-10-11 09:29:17', NULL),
(849, 1, 0, NULL, 1, 86, '0.00', 'in', '2020-10-11 09:29:20', NULL),
(850, 1, 0, NULL, 1, 87, '0.00', 'in', '2020-10-11 09:29:20', NULL),
(851, 1, 0, NULL, 1, 85, '0.00', 'in', '2020-10-11 09:29:20', NULL),
(852, 1, 0, NULL, 1, 84, '0.00', 'in', '2020-10-11 09:29:20', NULL),
(853, 1, 0, NULL, 1, 79, '0.00', 'in', '2020-10-11 09:29:20', NULL),
(854, 1, 0, NULL, 5, 88, '5000.00', 'in', '2020-10-11 13:02:36', NULL),
(855, 1, 0, NULL, 5, 89, '5000.00', 'in', '2020-10-11 13:02:52', NULL),
(856, 1, 0, NULL, 5, 90, '8000.00', 'in', '2020-10-11 13:03:14', NULL),
(857, 1, 0, NULL, 5, 91, '4000.00', 'in', '2020-10-11 13:03:32', NULL),
(858, 1, 0, NULL, 5, 92, '6500.00', 'in', '2020-10-11 13:03:51', NULL),
(859, 1, 0, NULL, 50, 93, '2000.00', 'in', '2020-10-11 13:17:13', NULL),
(860, 0, 1602573546, '', 1, 48, '0.00', 'out', '2020-10-13 07:19:06', NULL),
(861, 0, 1602665240, '', 1, 78, '0.00', 'out', '2020-10-14 08:47:20', NULL),
(862, 0, 1602665240, '', 1, 88, '0.00', 'out', '2020-10-14 08:47:20', NULL),
(863, 1, 0, NULL, 1, 48, '0.00', 'in', '2020-10-14 13:30:02', NULL),
(864, 1, 0, NULL, 1, 48, '0.00', 'in', '2020-10-14 13:30:16', NULL),
(865, 0, 1603187026, '', 6, 31, '0.00', 'out', '2020-10-20 09:43:46', NULL),
(866, 0, 1603187466, '', 2, 30, '0.00', 'out', '2020-10-20 09:51:06', NULL),
(867, 0, 1603190234, '', 2, 78, '0.00', 'out', '2020-10-20 10:37:14', NULL),
(868, 1, 0, NULL, 2, 78, '0.00', 'in', '2020-10-28 09:39:41', NULL),
(869, 1, 0, NULL, 2, 30, '0.00', 'in', '2020-10-28 09:39:44', NULL),
(870, 1, 0, NULL, 6, 31, '0.00', 'in', '2020-10-28 09:39:49', NULL),
(871, 1, 0, NULL, 1, 78, '0.00', 'in', '2020-10-28 09:39:52', NULL),
(872, 1, 0, NULL, 1, 88, '0.00', 'in', '2020-10-28 09:39:52', NULL),
(873, 1, 0, NULL, 2, 95, '1100.00', 'in', '2020-10-31 10:44:27', NULL),
(874, 1, 0, NULL, 2, 96, '1200.00', 'in', '2020-10-31 10:44:47', NULL),
(875, 1, 0, NULL, 2, 97, '750.00', 'in', '2020-10-31 10:44:59', NULL),
(876, 0, 1604294195, '', 1, 97, '0.00', 'out', '2020-11-02 05:16:35', NULL),
(877, 1, 0, NULL, 1, 97, '0.00', 'in', '2020-11-03 10:01:30', NULL),
(878, 1, 0, NULL, 1, 97, '0.00', 'in', '2020-11-03 10:01:38', NULL),
(879, 1, 0, NULL, 5000, 94, '190.00', 'in', '2020-11-04 11:57:13', NULL),
(880, 0, 1604911861, '', 1, 96, '0.00', 'out', '2020-11-09 08:51:01', NULL),
(881, 0, 1604914300, '', 1, 32, '0.00', 'out', '2020-11-09 09:31:40', NULL),
(882, 0, 1604920024, '', 1, 32, '0.00', 'out', '2020-11-09 11:07:04', NULL),
(883, 0, 1604920661, '', 1, 32, '0.00', 'out', '2020-11-09 11:17:41', NULL),
(884, 1, 0, NULL, 1, 96, '0.00', 'in', '2020-11-10 14:37:57', NULL),
(885, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-11-10 14:38:10', NULL),
(886, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-11-10 14:38:22', NULL),
(887, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-11-10 14:39:34', NULL),
(888, 0, 1605676365, '', 2, 78, '0.00', 'out', '2020-11-18 05:12:45', NULL),
(889, 0, 1605676400, '', 2, 32, '0.00', 'out', '2020-11-18 05:13:20', NULL),
(890, 0, 1605762857, '', 4, 78, '0.00', 'out', '2020-11-19 05:14:17', NULL),
(891, 0, 1605762990, '', 2, 78, '0.00', 'out', '2020-11-19 05:16:30', NULL),
(892, 1, 0, NULL, 1, 96, '0.00', 'in', '2020-12-09 15:11:22', NULL),
(893, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-12-09 15:11:26', NULL),
(894, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-12-09 15:11:29', NULL),
(895, 1, 0, NULL, 1, 32, '0.00', 'in', '2020-12-09 15:11:32', NULL),
(896, 1, 0, NULL, 2, 78, '0.00', 'in', '2020-12-09 15:16:28', NULL),
(897, 1, 0, NULL, 2, 32, '0.00', 'in', '2020-12-09 15:16:50', NULL),
(898, 1, 0, NULL, 4, 78, '0.00', 'in', '2020-12-09 15:17:15', NULL),
(899, 1, 0, NULL, 2, 78, '0.00', 'in', '2020-12-09 15:17:28', NULL),
(900, 1, 0, NULL, 2, 78, '0.00', 'in', '2020-12-09 15:17:37', NULL),
(901, 1, 0, NULL, 2, 32, '0.00', 'in', '2020-12-09 15:17:43', NULL),
(902, 1, 0, NULL, 4, 78, '0.00', 'in', '2020-12-09 15:17:46', NULL),
(903, 1, 0, NULL, 2, 78, '0.00', 'in', '2020-12-09 15:17:49', NULL),
(904, 1, 0, NULL, 5, 99, '700.00', 'in', '2020-12-09 15:50:29', NULL),
(905, 1, 0, NULL, 5, 100, '700.00', 'in', '2020-12-09 15:50:41', NULL),
(906, 1, 0, NULL, 5, 101, '700.00', 'in', '2020-12-09 15:50:55', NULL),
(907, 1, 0, NULL, 5, 102, '300.00', 'in', '2020-12-09 15:51:20', NULL),
(908, 1, 0, NULL, 5, 103, '300.00', 'in', '2020-12-09 15:51:33', NULL),
(909, 1, 0, NULL, 10, 106, '500.00', 'in', '2020-12-09 15:52:07', NULL),
(910, 1, 0, NULL, 5, 105, '1000.00', 'in', '2020-12-09 15:52:42', NULL),
(911, 1, 0, NULL, 5, 104, '900.00', 'in', '2020-12-09 15:53:15', NULL),
(912, 1, 0, NULL, 5, 98, '300.00', 'in', '2020-12-09 15:53:38', NULL),
(913, 1, 0, NULL, 5, 107, '550.00', 'in', '2020-12-10 11:13:56', NULL),
(914, 1, 0, NULL, 7, 111, '500.00', 'in', '2020-12-12 16:59:24', NULL),
(915, 1, 0, NULL, 7, 109, '450.00', 'in', '2020-12-12 16:59:38', NULL),
(916, 1, 0, NULL, 7, 110, '450.00', 'in', '2020-12-12 16:59:48', NULL),
(917, 1, 0, NULL, 7, 112, '450.00', 'in', '2020-12-12 17:00:22', NULL),
(918, 1, 0, NULL, 7, 113, '550.00', 'in', '2020-12-13 08:50:39', NULL),
(919, 1, 0, NULL, 7, 114, '650.00', 'in', '2020-12-13 08:50:59', NULL),
(920, 0, 1607849663, '', 2, 95, '0.00', 'out', '2020-12-13 08:54:23', NULL),
(921, 0, 1607851700, '', 1, 42, '0.00', 'out', '2020-12-13 09:28:20', NULL),
(922, 1, 0, NULL, 2, 95, '0.00', 'in', '2020-12-14 09:30:07', NULL),
(923, 1, 0, NULL, 1, 42, '0.00', 'in', '2020-12-14 09:30:19', NULL),
(924, 1, 0, NULL, 1, 42, '0.00', 'in', '2020-12-14 09:30:33', NULL),
(925, 1, 0, NULL, 7, 115, '550.00', 'in', '2020-12-14 09:38:16', NULL),
(926, 1, 0, NULL, 7, 116, '550.00', 'in', '2020-12-14 09:38:28', NULL),
(927, 1, 0, NULL, 7, 117, '550.00', 'in', '2020-12-14 09:38:40', NULL),
(928, 1, 0, NULL, 5, 118, '600.00', 'in', '2020-12-14 14:07:36', NULL),
(929, 1, 0, NULL, 5, 119, '600.00', 'in', '2020-12-14 14:07:54', NULL),
(930, 1, 0, NULL, 5, 120, '600.00', 'in', '2020-12-14 14:08:06', NULL),
(931, 1, 0, NULL, 5, 121, '600.00', 'in', '2020-12-14 14:08:27', NULL),
(932, 1, 0, NULL, 5, 122, '600.00', 'in', '2020-12-14 14:08:39', NULL),
(933, 0, 1608788899, '', 2, 79, '0.00', 'out', '2020-12-24 05:48:19', NULL),
(934, 0, 1608790001, '', 1, 49, '0.00', 'out', '2020-12-24 06:06:41', NULL),
(935, 0, 1608790223, '', 2, 79, '0.00', 'out', '2020-12-24 06:10:23', NULL),
(936, 0, 1608790500, '', 1, 96, '0.00', 'out', '2020-12-24 06:15:00', NULL),
(937, 0, 1608790588, '', 1, 48, '0.00', 'out', '2020-12-24 06:16:28', NULL),
(938, 1, 0, NULL, 2, 79, '0.00', 'in', '2021-01-05 09:31:30', NULL),
(939, 1, 0, NULL, 1, 49, '0.00', 'in', '2021-01-05 09:31:33', NULL),
(940, 1, 0, NULL, 2, 79, '0.00', 'in', '2021-01-05 09:31:37', NULL),
(941, 1, 0, NULL, 1, 96, '0.00', 'in', '2021-01-05 09:31:41', NULL),
(942, 1, 0, NULL, 1, 48, '0.00', 'in', '2021-01-05 09:31:44', NULL),
(943, 1, 0, NULL, 5, 127, '2000.00', 'in', '2021-01-05 10:05:21', NULL),
(944, 1, 0, NULL, 5, 128, '1500.00', 'in', '2021-01-05 10:05:40', NULL),
(945, 1, 0, NULL, 5, 129, '1200.00', 'in', '2021-01-05 10:06:10', NULL),
(946, 1, 0, NULL, 5, 130, '950.00', 'in', '2021-01-05 10:06:27', NULL),
(947, 1, 0, NULL, 5, 131, '950.00', 'in', '2021-01-05 10:06:47', NULL),
(948, 1, 0, NULL, 5, 123, '950.00', 'in', '2021-01-05 10:07:49', NULL),
(949, 1, 0, NULL, 5, 124, '950.00', 'in', '2021-01-05 10:08:15', NULL),
(950, 1, 0, NULL, 5, 125, '950.00', 'in', '2021-01-05 10:08:45', NULL),
(951, 1, 0, NULL, 5, 126, '950.00', 'in', '2021-01-05 10:14:50', NULL),
(952, 1, 0, NULL, 5, 132, '1200.00', 'in', '2021-01-20 13:11:48', NULL),
(953, 1, 0, NULL, 5, 133, '1200.00', 'in', '2021-01-20 13:12:20', NULL),
(954, 1, 0, NULL, 5, 134, '1200.00', 'in', '2021-01-20 13:12:31', NULL),
(955, 1, 0, NULL, 5, 135, '1200.00', 'in', '2021-01-20 13:12:50', NULL),
(956, 1, 0, NULL, 5, 136, '1200.00', 'in', '2021-01-24 11:45:03', NULL),
(957, 1, 0, NULL, 5, 137, '1200.00', 'in', '2021-01-24 11:57:42', NULL),
(958, 1, 0, NULL, 5, 139, '800.00', 'in', '2021-01-25 11:50:31', NULL),
(959, 1, 0, NULL, 5, 140, '800.00', 'in', '2021-01-25 11:50:57', NULL),
(960, 1, 0, NULL, 5, 141, '1300.00', 'in', '2021-01-25 16:49:52', NULL),
(961, 1, 0, NULL, 5, 142, '800.00', 'in', '2021-01-25 16:50:15', NULL),
(962, 1, 0, NULL, 5, 143, '250.00', 'in', '2021-01-28 15:24:45', NULL),
(963, 1, 0, NULL, 5, 144, '250.00', 'in', '2021-01-28 15:25:04', NULL),
(964, 1, 0, NULL, 5, 145, '350.00', 'in', '2021-01-28 15:25:30', NULL),
(965, 1, 0, NULL, 5, 146, '1200.00', 'in', '2021-01-28 15:25:49', NULL),
(966, 0, 1612337499, '', 1, 78, '0.00', 'out', '2021-02-03 07:31:39', NULL),
(967, 1, 0, NULL, 5, 152, '800.00', 'in', '2021-02-07 11:06:14', NULL),
(968, 1, 0, NULL, 5, 153, '800.00', 'in', '2021-02-07 11:13:02', NULL),
(969, 1, 0, NULL, 5, 154, '800.00', 'in', '2021-02-07 11:13:27', NULL),
(970, 1, 0, NULL, 5, 155, '800.00', 'in', '2021-02-07 11:13:42', NULL),
(971, 1, 0, NULL, 5, 156, '800.00', 'in', '2021-02-07 11:14:32', NULL),
(972, 1, 0, NULL, 5, 157, '800.00', 'in', '2021-02-07 11:15:04', NULL),
(973, 1, 0, NULL, 5, 158, '1200.00', 'in', '2021-02-07 12:13:04', NULL),
(974, 1, 0, NULL, 5, 159, '1700.00', 'in', '2021-02-07 12:15:07', NULL),
(975, 1, 0, NULL, 5, 160, '1200.00', 'in', '2021-02-07 12:15:59', NULL),
(976, 1, 0, NULL, 5, 161, '3000.00', 'in', '2021-02-07 12:16:46', NULL),
(977, 1, 0, NULL, 5, 162, '1100.00', 'in', '2021-02-07 12:17:25', NULL),
(978, 1, 0, NULL, 5, 163, '1200.00', 'in', '2021-02-07 12:17:51', NULL),
(979, 1, 0, NULL, 5, 164, '1200.00', 'in', '2021-02-07 12:18:12', NULL),
(980, 1, 0, NULL, 5, 165, '800.00', 'in', '2021-02-07 12:18:36', NULL),
(981, 1, 0, NULL, 5, 166, '900.00', 'in', '2021-02-07 12:19:02', NULL),
(982, 1, 0, NULL, 5, 167, '800.00', 'in', '2021-02-07 12:19:35', NULL),
(983, 1, 0, NULL, 5, 168, '800.00', 'in', '2021-02-07 12:20:06', NULL),
(984, 1, 0, NULL, 5, 169, '800.00', 'in', '2021-02-07 12:20:25', NULL),
(985, 1, 0, NULL, 5, 170, '800.00', 'in', '2021-02-07 12:22:10', NULL),
(986, 1, 0, NULL, 5, 171, '1500.00', 'in', '2021-02-07 12:35:03', NULL),
(987, 1, 0, NULL, 5, 172, '1700.00', 'in', '2021-02-07 12:35:30', NULL),
(988, 0, 1629259617, '', 1, 78, '0.00', 'out', '2021-08-18 04:06:57', NULL),
(989, 0, 1629692747, '', 1, 4, '0.00', 'out', '2021-08-23 04:25:47', NULL),
(990, 0, 1630139767, '', 1, 96, '0.00', 'out', '2021-08-28 08:36:07', NULL),
(991, 1, 0, NULL, 1, 78, '0.00', 'in', '2021-09-14 15:33:26', NULL),
(992, 1, 0, NULL, 1, 4, '0.00', 'in', '2021-09-14 15:37:42', NULL),
(993, 1, 0, NULL, 1, 96, '0.00', 'in', '2021-09-14 15:38:06', NULL),
(994, 1, 0, NULL, 100, 173, '280.00', 'in', '2021-12-01 17:16:16', NULL),
(995, 1, 0, NULL, 100, 173, '280.00', 'in', '2021-12-01 17:17:12', NULL),
(996, 1, 0, NULL, 100, 174, '280.00', 'in', '2021-12-01 17:20:11', NULL),
(997, 1, 0, NULL, 100, 175, '280.00', 'in', '2021-12-01 17:23:59', NULL),
(998, 1, 0, NULL, 100, 176, '280.00', 'in', '2021-12-04 14:00:37', NULL),
(999, 1, 0, NULL, 100, 177, '280.00', 'in', '2021-12-04 14:05:35', NULL),
(1000, 1, 0, NULL, 100, 177, '280.00', 'in', '2021-12-04 14:05:37', NULL),
(1001, 1, 0, NULL, 100, 179, '330.00', 'in', '2021-12-04 14:35:52', NULL),
(1002, 1, 0, NULL, 100, 182, '340.00', 'in', '2021-12-04 14:39:25', NULL),
(1003, 1, 0, NULL, 100, 183, '350.00', 'in', '2021-12-04 14:42:26', NULL),
(1004, 1, 0, NULL, 100, 184, '440.00', 'in', '2021-12-04 14:54:35', NULL),
(1005, 1, 0, NULL, 100, 185, '540.00', 'in', '2021-12-04 14:57:55', NULL),
(1006, 1, 0, NULL, 100, 186, '440.00', 'in', '2021-12-04 15:01:39', NULL),
(1007, 1, 0, NULL, 100, 187, '440.00', 'in', '2021-12-04 15:04:48', NULL),
(1008, 1, 0, NULL, 100, 188, '440.00', 'in', '2021-12-04 15:07:43', NULL),
(1009, 1, 0, NULL, 100, 189, '440.00', 'in', '2021-12-04 15:10:22', NULL),
(1010, 1, 0, NULL, 100, 190, '530.00', 'in', '2021-12-04 15:16:36', NULL),
(1011, 1, 0, NULL, 100, 191, '530.00', 'in', '2021-12-04 15:19:48', NULL),
(1012, 1, 0, NULL, 100, 192, '550.00', 'in', '2021-12-04 15:22:25', NULL),
(1013, 1, 0, NULL, 100, 193, '650.00', 'in', '2021-12-05 10:36:50', NULL),
(1014, 1, 0, NULL, 100, 194, '650.00', 'in', '2021-12-05 10:41:13', NULL),
(1015, 1, 0, NULL, 100, 195, '650.00', 'in', '2021-12-05 10:59:05', NULL),
(1016, 1, 0, NULL, 100, 196, '650.00', 'in', '2021-12-05 11:05:48', NULL),
(1017, 1, 0, NULL, 100, 197, '650.00', 'in', '2021-12-05 11:08:47', NULL),
(1018, 1, 0, NULL, 100, 198, '850.00', 'in', '2021-12-05 11:14:15', NULL),
(1019, 1, 0, NULL, 100, 199, '1500.00', 'in', '2021-12-05 11:20:08', NULL),
(1020, 1, 0, NULL, 100, 200, '800.00', 'in', '2021-12-06 10:12:03', NULL),
(1021, 1, 0, NULL, 100, 202, '800.00', 'in', '2021-12-06 10:18:28', NULL),
(1022, 1, 0, NULL, 100, 203, '800.00', 'in', '2021-12-06 10:23:03', NULL),
(1023, 1, 0, NULL, 100, 205, '2000.00', 'in', '2021-12-06 11:15:52', NULL),
(1024, 1, 0, NULL, 100, 206, '2000.00', 'in', '2021-12-06 11:17:35', NULL),
(1025, 1, 0, NULL, 100, 207, '2000.00', 'in', '2021-12-06 11:20:07', NULL),
(1026, 1, 0, NULL, 100, 208, '2000.00', 'in', '2021-12-06 11:24:13', NULL),
(1027, 1, 0, NULL, 100, 209, '2100.00', 'in', '2021-12-06 11:30:22', NULL),
(1028, 1, 0, NULL, 100, 210, '2100.00', 'in', '2021-12-06 11:32:10', NULL),
(1029, 1, 0, NULL, 100, 212, '1500.00', 'in', '2021-12-06 12:00:50', NULL),
(1030, 1, 0, NULL, 100, 213, '1500.00', 'in', '2021-12-06 12:06:07', NULL),
(1031, 1, 0, NULL, 100, 214, '1500.00', 'in', '2021-12-06 12:13:08', NULL),
(1032, 1, 0, NULL, 100, 215, '1500.00', 'in', '2021-12-06 13:49:02', NULL),
(1033, 1, 0, NULL, 100, 216, '1500.00', 'in', '2021-12-06 13:52:26', NULL),
(1034, 1, 0, NULL, 100, 217, '1500.00', 'in', '2021-12-06 14:02:59', NULL),
(1035, 1, 0, NULL, 100, 219, '5000.00', 'in', '2021-12-06 14:30:37', NULL),
(1036, 1, 0, NULL, 100, 219, '5000.00', 'in', '2021-12-06 14:41:36', NULL),
(1037, 1, 0, NULL, 100, 220, '5000.00', 'in', '2021-12-06 14:42:57', NULL),
(1038, 1, 0, NULL, 100, 221, '5000.00', 'in', '2021-12-06 15:00:46', NULL),
(1039, 1, 0, NULL, 100, 222, '5000.00', 'in', '2021-12-06 15:02:45', NULL),
(1040, 1, 0, NULL, 100, 223, '6000.00', 'in', '2021-12-06 15:28:46', NULL),
(1041, 1, 0, NULL, 100, 224, '6000.00', 'in', '2021-12-06 15:31:23', NULL),
(1042, 1, 0, NULL, 100, 226, '8000.00', 'in', '2021-12-06 15:41:58', NULL),
(1043, 1, 0, NULL, 100, 227, '8000.00', 'in', '2021-12-06 15:48:39', NULL),
(1044, 1, 0, NULL, 100, 228, '20000.00', 'in', '2021-12-06 16:06:27', NULL),
(1045, 1, 0, NULL, 100, 229, '20000.00', 'in', '2021-12-06 16:10:29', NULL),
(1046, 1, 0, NULL, 100, 230, '35000.00', 'in', '2021-12-06 16:13:10', NULL),
(1047, 1, 0, NULL, 100, 231, '40000.00', 'in', '2021-12-06 16:23:14', NULL),
(1048, 1, 0, NULL, 100, 232, '52000.00', 'in', '2021-12-06 16:27:08', NULL),
(1049, 1, 0, NULL, 100, 233, '65000.00', 'in', '2021-12-06 16:32:20', NULL),
(1050, 1, 0, NULL, 100, 234, '75000.00', 'in', '2021-12-06 16:37:16', NULL),
(1051, 1, 0, NULL, 100, 235, '120000.00', 'in', '2021-12-06 16:40:28', NULL),
(1052, 1, 0, NULL, 100, 236, '120000.00', 'in', '2021-12-06 16:44:18', NULL),
(1053, 1, 0, NULL, 100, 237, '180.00', 'in', '2021-12-08 10:34:45', NULL),
(1054, 1, 0, NULL, 100, 238, '180.00', 'in', '2021-12-08 10:38:19', NULL),
(1055, 1, 0, NULL, 100, 239, '180.00', 'in', '2021-12-08 10:40:05', NULL),
(1056, 1, 0, NULL, 100, 240, '180.00', 'in', '2021-12-08 10:45:32', NULL),
(1057, 1, 0, NULL, 100, 241, '180.00', 'in', '2021-12-08 10:49:43', NULL),
(1058, 1, 0, NULL, 100, 242, '180.00', 'in', '2021-12-08 10:51:29', NULL),
(1059, 1, 0, NULL, 100, 243, '200.00', 'in', '2021-12-08 10:55:06', NULL),
(1060, 1, 0, NULL, 100, 244, '200.00', 'in', '2021-12-08 10:58:41', NULL),
(1061, 1, 0, NULL, 100, 245, '200.00', 'in', '2021-12-08 11:04:19', NULL),
(1062, 1, 0, NULL, 100, 246, '220.00', 'in', '2021-12-08 11:21:02', NULL),
(1063, 1, 0, NULL, 100, 247, '220.00', 'in', '2021-12-08 11:23:03', NULL),
(1064, 1, 0, NULL, 100, 248, '220.00', 'in', '2021-12-08 11:25:54', NULL),
(1065, 1, 0, NULL, 100, 249, '250.00', 'in', '2021-12-09 11:30:09', NULL),
(1066, 1, 0, NULL, 100, 250, '250.00', 'in', '2021-12-09 11:35:01', NULL),
(1067, 1, 0, NULL, 100, 251, '250.00', 'in', '2021-12-09 11:37:52', NULL),
(1068, 1, 0, NULL, 100, 252, '300.00', 'in', '2021-12-09 11:59:03', NULL),
(1069, 1, 0, NULL, 100, 253, '300.00', 'in', '2021-12-09 12:01:02', NULL),
(1070, 1, 0, NULL, 100, 254, '400.00', 'in', '2021-12-09 12:07:37', NULL),
(1071, 1, 0, NULL, 100, 255, '500.00', 'in', '2021-12-09 12:11:24', NULL),
(1072, 1, 0, NULL, 100, 256, '500.00', 'in', '2021-12-09 12:16:19', NULL),
(1073, 1, 0, NULL, 100, 257, '500.00', 'in', '2021-12-09 12:31:16', NULL),
(1074, 1, 0, NULL, 100, 258, '500.00', 'in', '2021-12-09 12:33:38', NULL),
(1075, 1, 0, NULL, 100, 259, '500.00', 'in', '2021-12-09 13:53:46', NULL),
(1076, 1, 0, NULL, 100, 260, '500.00', 'in', '2021-12-09 13:56:24', NULL),
(1077, 1, 0, NULL, 100, 261, '520.00', 'in', '2021-12-09 13:58:46', NULL),
(1078, 1, 0, NULL, 100, 263, '520.00', 'in', '2021-12-09 14:03:03', NULL),
(1079, 1, 0, NULL, 100, 264, '500.00', 'in', '2021-12-09 14:09:03', NULL),
(1080, 1, 0, NULL, 100, 265, '500.00', 'in', '2021-12-09 14:12:58', NULL),
(1081, 1, 0, NULL, 100, 266, '500.00', 'in', '2021-12-09 14:49:51', NULL),
(1082, 1, 0, NULL, 100, 267, '500.00', 'in', '2021-12-09 14:51:36', NULL),
(1083, 1, 0, NULL, 100, 268, '500.00', 'in', '2021-12-09 14:53:44', NULL),
(1084, 1, 0, NULL, 100, 269, '500.00', 'in', '2021-12-09 14:55:52', NULL),
(1085, 1, 0, NULL, 100, 270, '510.00', 'in', '2021-12-09 14:58:19', NULL),
(1086, 1, 0, NULL, 100, 271, '510.00', 'in', '2021-12-09 15:01:04', NULL),
(1087, 1, 0, NULL, 100, 272, '510.00', 'in', '2021-12-09 15:03:21', NULL),
(1088, 1, 0, NULL, 100, 273, '800.00', 'in', '2021-12-09 15:06:43', NULL),
(1089, 1, 0, NULL, 100, 274, '800.00', 'in', '2021-12-09 15:16:25', NULL),
(1090, 1, 0, NULL, 100, 275, '800.00', 'in', '2021-12-09 15:20:54', NULL),
(1091, 1, 0, NULL, 100, 276, '800.00', 'in', '2021-12-09 15:25:18', NULL),
(1092, 1, 0, NULL, 100, 277, '800.00', 'in', '2021-12-09 15:58:56', NULL),
(1093, 1, 0, NULL, 100, 278, '800.00', 'in', '2021-12-09 16:01:48', NULL),
(1094, 1, 0, NULL, 100, 279, '820.00', 'in', '2021-12-09 16:05:12', NULL),
(1095, 1, 0, NULL, 100, 281, '800.00', 'in', '2021-12-09 16:18:07', NULL),
(1096, 1, 0, NULL, 100, 282, '820.00', 'in', '2021-12-09 16:20:37', NULL),
(1097, 1, 0, NULL, 100, 283, '820.00', 'in', '2021-12-09 16:25:01', NULL),
(1098, 1, 0, NULL, 100, 284, '820.00', 'in', '2021-12-09 16:32:53', NULL),
(1099, 1, 0, NULL, 100, 285, '820.00', 'in', '2021-12-09 16:35:06', NULL),
(1100, 1, 0, NULL, 100, 286, '820.00', 'in', '2021-12-11 15:07:35', NULL),
(1101, 1, 0, NULL, 100, 287, '820.00', 'in', '2021-12-11 15:10:02', NULL),
(1102, 1, 0, NULL, 100, 288, '850.00', 'in', '2021-12-11 15:11:51', NULL),
(1103, 1, 0, NULL, 100, 289, '850.00', 'in', '2021-12-11 15:13:44', NULL),
(1104, 1, 0, NULL, 100, 290, '1200.00', 'in', '2021-12-11 15:16:36', NULL),
(1105, 1, 0, NULL, 1, 78, '0.00', 'in', '2021-12-12 11:37:06', NULL),
(1106, 1, 0, NULL, 1, 4, '0.00', 'in', '2021-12-12 11:37:10', NULL),
(1107, 1, 0, NULL, 1, 96, '0.00', 'in', '2021-12-12 11:37:14', NULL),
(1108, 1, 0, NULL, 70, 291, '3200.00', 'in', '2021-12-12 15:57:38', NULL),
(1109, 1, 0, NULL, 70, 292, '3200.00', 'in', '2021-12-12 16:01:31', NULL),
(1110, 1, 0, NULL, 70, 293, '3200.00', 'in', '2021-12-12 16:10:14', NULL),
(1111, 1, 0, NULL, 70, 294, '3500.00', 'in', '2021-12-12 16:14:30', NULL),
(1112, 1, 0, NULL, 70, 295, '3500.00', 'in', '2021-12-12 16:17:01', NULL),
(1113, 1, 0, NULL, 70, 296, '3600.00', 'in', '2021-12-12 16:21:33', NULL),
(1114, 1, 0, NULL, 70, 297, '4500.00', 'in', '2021-12-12 16:25:44', NULL),
(1115, 1, 0, NULL, 70, 297, '4500.00', 'in', '2021-12-12 16:26:44', NULL),
(1116, 1, 0, NULL, 70, 298, '5500.00', 'in', '2021-12-12 16:30:19', NULL),
(1117, 1, 0, NULL, 70, 299, '8200.00', 'in', '2021-12-13 11:26:13', NULL),
(1118, 1, 0, NULL, 70, 300, '35000.00', 'in', '2021-12-13 11:58:57', NULL),
(1119, 1, 0, NULL, 70, 301, '35000.00', 'in', '2021-12-13 12:04:52', NULL),
(1120, 1, 0, NULL, 70, 302, '43000.00', 'in', '2021-12-13 12:40:48', NULL),
(1121, 1, 0, NULL, 70, 303, '52200.00', 'in', '2021-12-13 12:43:30', NULL),
(1122, 1, 0, NULL, 70, 304, '55200.00', 'in', '2021-12-13 12:47:12', NULL),
(1123, 1, 0, NULL, 70, 305, '5500.00', 'in', '2021-12-13 13:18:21', NULL),
(1124, 1, 0, NULL, 70, 305, '5500.00', 'in', '2021-12-13 13:19:08', NULL),
(1125, 1, 0, NULL, 70, 306, '5500.00', 'in', '2021-12-13 13:26:19', NULL),
(1126, 1, 0, NULL, 70, 307, '5500.00', 'in', '2021-12-13 14:09:37', NULL),
(1127, 1, 0, NULL, 70, 308, '5500.00', 'in', '2021-12-13 14:27:51', NULL),
(1128, 1, 0, NULL, 70, 309, '5500.00', 'in', '2021-12-13 14:35:16', NULL),
(1129, 1, 0, NULL, 70, 310, '5500.00', 'in', '2021-12-13 14:38:43', NULL),
(1130, 1, 0, NULL, 70, 311, '9000.00', 'in', '2021-12-13 14:45:39', NULL),
(1131, 1, 0, NULL, 70, 312, '13000.00', 'in', '2021-12-13 14:48:54', NULL),
(1132, 1, 0, NULL, 70, 312, '13000.00', 'in', '2021-12-13 14:48:55', NULL),
(1133, 1, 0, NULL, 70, 312, '13000.00', 'in', '2021-12-13 14:48:56', NULL),
(1134, 1, 0, NULL, 70, 313, '18000.00', 'in', '2021-12-14 14:27:02', NULL),
(1135, 1, 0, NULL, 20, 314, '43000.00', 'in', '2021-12-14 14:30:15', NULL),
(1136, 1, 0, NULL, 20, 315, '43000.00', 'in', '2021-12-14 14:32:54', NULL),
(1137, 1, 0, NULL, 20, 316, '45000.00', 'in', '2021-12-14 14:37:25', NULL),
(1138, 1, 0, NULL, 20, 318, '78000.00', 'in', '2021-12-14 14:48:18', NULL),
(1139, 1, 0, NULL, 30, 319, '100000.00', 'in', '2021-12-14 14:51:39', NULL),
(1140, 1, 0, NULL, 10, 320, '500.00', 'in', '2021-12-14 16:38:26', NULL),
(1141, 1, 0, NULL, 20, 321, '150000.00', 'in', '2021-12-15 10:43:30', NULL),
(1142, 1, 0, NULL, 100, 322, '1000.00', 'in', '2021-12-15 10:58:08', NULL),
(1143, 1, 0, NULL, 30, 323, '1000.00', 'in', '2021-12-15 11:23:14', NULL),
(1144, 1, 0, NULL, 100, 325, '1100.00', 'in', '2021-12-15 11:47:37', NULL),
(1145, 1, 0, NULL, 100, 326, '1400.00', 'in', '2021-12-15 11:55:34', NULL),
(1146, 1, 0, NULL, 100, 327, '1500.00', 'in', '2021-12-15 11:59:33', NULL),
(1147, 0, 1641114347, '', 1, 326, '0.00', 'out', '2022-01-02 09:05:47', NULL),
(1148, 0, 1641128263, '', 1, 323, '0.00', 'out', '2022-01-02 12:57:43', NULL),
(1149, 1, 0, NULL, 100, 2, '45.00', 'in', '2022-01-06 16:47:22', NULL),
(1150, 0, 1641814934, '', 1, 306, '0.00', 'out', '2022-01-10 11:42:14', NULL),
(1151, 0, 1642052489, '', 1, 325, '0.00', 'out', '2022-01-13 05:41:29', NULL),
(1152, 0, 1642442946, '', 1, 47, '0.00', 'out', '2022-01-17 18:09:06', NULL),
(1153, 0, 1648038281, '', 1, 36, '0.00', 'out', '2022-03-23 12:24:41', NULL),
(1154, 1, 0, NULL, 5, 328, '1600.00', 'in', '2022-04-09 10:20:30', NULL),
(1155, 1, 0, NULL, 1, 329, '1100.00', 'in', '2022-04-09 13:32:50', NULL),
(1156, 1, 0, NULL, 1, 330, '1100.00', 'in', '2022-04-09 13:33:07', NULL),
(1157, 1, 0, NULL, 1, 326, '0.00', 'in', '2022-11-03 11:14:14', NULL),
(1158, 1, 0, NULL, 1, 323, '0.00', 'in', '2022-11-03 11:14:23', NULL),
(1159, 1, 0, NULL, 1, 306, '0.00', 'in', '2022-11-03 11:14:26', NULL),
(1160, 1, 0, NULL, 1, 325, '0.00', 'in', '2022-11-03 11:14:29', NULL),
(1161, 1, 0, NULL, 1, 47, '0.00', 'in', '2022-11-03 11:14:33', NULL),
(1162, 1, 0, NULL, 1, 47, '0.00', 'in', '2022-11-03 11:15:21', NULL),
(1163, 1, 0, NULL, 1, 36, '0.00', 'in', '2022-11-03 11:15:42', NULL),
(1164, 1, 0, NULL, 10, 360, '180.00', 'in', '2022-11-06 14:47:06', NULL),
(1165, 1, 0, NULL, 10, 361, '210.00', 'in', '2022-11-06 15:11:34', NULL),
(1166, 1, 0, NULL, 10, 362, '270.00', 'in', '2022-11-06 15:11:58', NULL),
(1167, 1, 0, NULL, 10, 94, '265.00', 'in', '2022-11-13 14:43:17', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `inventory_detail`
--

CREATE TABLE `inventory_detail` (
  `inventory_ref_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `attribute_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `inventory_detail`
--

INSERT INTO `inventory_detail` (`inventory_ref_id`, `products_id`, `attribute_id`) VALUES
(3, 13, 11),
(4, 13, 12),
(5, 13, 13),
(10, 4, 1),
(11, 4, 2),
(12, 4, 4),
(15, 8, 5),
(16, 8, 6),
(17, 8, 7),
(20, 11, 9),
(22, 11, 10),
(30, 21, 14),
(31, 21, 15),
(33, 24, 19),
(34, 24, 18),
(38, 28, 20),
(39, 28, 21),
(64, 8, 6),
(85, 13, 12),
(87, 4, 1),
(103, 4, 1),
(137, 21, 14),
(146, 4, 1),
(174, 4, 1),
(188, 13, 13),
(189, 13, 13),
(190, 13, 13),
(217, 4, 1),
(225, 13, 13),
(227, 8, 7),
(463, 4, 1),
(489, 4, 1),
(508, 21, 14),
(989, 4, 1),
(992, 4, 1),
(1106, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `labels`
--

CREATE TABLE `labels` (
  `label_id` int(11) NOT NULL,
  `label_name` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `labels`
--

INSERT INTO `labels` (`label_id`, `label_name`) VALUES
(1, 'I\'ve forgotten my password?'),
(2, 'Creating an account means you’re okay with shopify\'s Terms of Service, Privacy Policy'),
(872, 'Login with'),
(873, 'or'),
(874, 'Email'),
(875, 'Password'),
(876, 'Register'),
(877, 'Forgot Password'),
(878, 'Send'),
(879, 'About Us'),
(880, 'Categories'),
(881, 'Contact Us'),
(882, 'Name'),
(883, 'Your Messsage'),
(884, 'Please connect to the internet'),
(885, 'Recently Viewed'),
(886, 'Products are available.'),
(887, 'Top Seller'),
(888, 'Special Deals'),
(889, 'Most Liked'),
(890, 'All Categories'),
(891, 'Deals'),
(892, 'REMOVE'),
(893, 'Intro'),
(894, 'Skip Intro'),
(895, 'Got It!'),
(896, 'Order Detail'),
(897, 'Price Detail'),
(898, 'Total'),
(899, 'Sub Total'),
(900, 'Shipping'),
(901, 'Product Details'),
(902, 'New'),
(903, 'Out of Stock'),
(904, 'In Stock'),
(905, 'Add to Cart'),
(906, 'ADD TO CART'),
(907, 'Product Description'),
(908, 'Techincal details'),
(909, 'OFF'),
(910, 'No Products Found'),
(911, 'Reset Filters'),
(912, 'Search'),
(913, 'Main Categories'),
(914, 'Sub Categories'),
(915, 'Shipping method'),
(916, 'Thank You'),
(917, 'Thank you for shopping with us.'),
(918, 'My Orders'),
(919, 'Continue Shopping'),
(920, 'Favourite'),
(921, 'Your wish List is empty'),
(922, 'Continue Adding'),
(923, 'Explore'),
(924, 'Word Press Post Detail'),
(925, 'Go Back'),
(926, 'Top Sellers'),
(927, 'News'),
(928, 'Enter keyword'),
(929, 'Settings'),
(930, 'Shop'),
(931, 'Reset'),
(932, 'Select Language'),
(933, 'OUT OF STOCK'),
(934, 'Newest'),
(935, 'Refund Policy'),
(936, 'Privacy Policy'),
(937, 'Term and Services'),
(938, 'Skip'),
(939, 'Top Dishes'),
(940, 'Recipe of Day'),
(941, 'Food Categories'),
(942, 'Coupon Code'),
(943, 'Coupon Amount'),
(944, 'coupon code'),
(945, 'Coupon'),
(946, 'Note to the buyer'),
(947, 'Explore More'),
(948, 'All'),
(949, 'A - Z'),
(950, 'Z - A'),
(951, 'Price : high - low'),
(952, 'Price : low - high'),
(953, 'Special Products'),
(954, 'Sort Products'),
(955, 'Cancel'),
(956, 'most liked'),
(957, 'special'),
(958, 'top seller'),
(959, 'newest'),
(960, 'Likes'),
(961, 'My Account'),
(962, 'Mobile'),
(963, 'Date of Birth'),
(964, 'Update'),
(965, 'Current Password'),
(966, 'New Password'),
(967, 'Change Password'),
(968, 'Customer Orders'),
(969, 'Order Status'),
(970, 'Orders ID'),
(971, 'Product Price'),
(972, 'No. of Products'),
(973, 'Date'),
(974, 'Customer Address'),
(975, 'Please add your new shipping address for the futher processing of the your order'),
(976, 'Add new Address'),
(977, 'Create an Account'),
(978, 'First Name'),
(979, 'Last Name'),
(980, 'Already Memeber?'),
(981, 'Billing Info'),
(982, 'Address'),
(983, 'Phone'),
(984, 'Same as Shipping Address'),
(985, 'Next'),
(986, 'Order'),
(987, 'Billing Address'),
(988, 'Shipping Method'),
(989, 'Products'),
(990, 'SubTotal'),
(991, 'Products Price'),
(992, 'Tax'),
(993, 'Shipping Cost'),
(994, 'Order Notes'),
(995, 'Payment'),
(996, 'Card Number'),
(997, 'Expiration Date'),
(998, 'Expiration'),
(999, 'Error: invalid card number!'),
(1000, 'Error: invalid expiry date!'),
(1001, 'Error: invalid cvc number!'),
(1002, 'Continue'),
(1003, 'My Cart'),
(1004, 'Your cart is empty'),
(1005, 'continue shopping'),
(1006, 'Price'),
(1007, 'Quantity'),
(1008, 'by'),
(1009, 'View'),
(1010, 'Remove'),
(1011, 'Proceed'),
(1012, 'Shipping Address'),
(1013, 'Country'),
(1014, 'other'),
(1015, 'Zone'),
(1016, 'City'),
(1017, 'Post code'),
(1018, 'State'),
(1019, 'Update Address'),
(1020, 'Save Address'),
(1021, 'Login & Register'),
(1022, 'Please login or create an account for free'),
(1023, 'Log Out'),
(1024, 'My Wish List'),
(1025, 'Filters'),
(1026, 'Price Range'),
(1027, 'Close'),
(1028, 'Apply'),
(1029, 'Clear'),
(1030, 'Menu'),
(1031, 'Home'),
(1033, 'Creating an account means you’re okay with our'),
(1034, 'Login'),
(1035, 'Turn on/off Local Notifications'),
(1036, 'Turn on/off Notifications'),
(1037, 'Change Language'),
(1038, 'Official Website'),
(1039, 'Rate Us'),
(1040, 'Share'),
(1041, 'Edit Profile'),
(1042, 'A percentage discount for the entire cart'),
(1043, 'A fixed total discount for the entire cart'),
(1044, 'A fixed total discount for selected products only'),
(1045, 'A percentage discount for selected products only'),
(1047, 'Network Connected Reloading Data'),
(1048, 'Sort by'),
(1049, 'Flash Sale'),
(1050, 'ok'),
(1051, 'Number'),
(1052, 'Expire Month'),
(1053, 'Expire Year'),
(1054, 'Payment Method'),
(1055, 'Status'),
(1056, 'And'),
(1057, 'cccc'),
(1058, 'Shop More'),
(1059, 'Me'),
(1060, 'View All'),
(1061, 'Featured'),
(1062, 'Shop Now'),
(1063, 'New Arrivals'),
(1064, 'Sort'),
(1065, 'Help & Support'),
(1066, 'Select Currency'),
(1067, 'Your Price'),
(1068, 'Billing'),
(1069, 'Ship to a different address?'),
(1070, 'Method'),
(1071, 'Summary'),
(1072, 'Discount'),
(1073, 'Error in initialization, maybe PayPal isnt supported or something else'),
(1074, 'Alert'),
(1075, 'Your Wishlist is Empty'),
(1076, 'Press heart icon on products to add them in wishlist'),
(1077, 'Wishlist'),
(1078, 'All Items'),
(1079, 'Account Info'),
(1080, 'You Must Be Logged in to use this Feature!'),
(1081, 'Remove from Wishlist'),
(1082, 'Sign Up'),
(1083, 'Reset Password'),
(1084, 'Invalid email or password'),
(1085, 'Recent Searches'),
(1086, 'Add to Wishlist'),
(1087, 'Discover Latest Trends'),
(1088, 'Add To My Wishlist'),
(1089, 'Start Shoping'),
(1090, 'A Smart Shopping Experience'),
(1091, 'Addresses'),
(1092, 'Account'),
(1093, 'DETAILS'),
(1094, 'Dark Mode'),
(1095, 'Enter a description'),
(1096, 'Grocery Store'),
(1097, 'Post Comment'),
(1098, 'Rate and write a review'),
(1099, 'Ratings & Reviews'),
(1100, 'Write a review'),
(1101, 'Your Rating'),
(1102, 'rating'),
(1103, 'rating and review'),
(1104, 'Coupon Codes List'),
(1105, 'Custom Orders'),
(1106, 'Ecommerce'),
(1107, 'Featured Products'),
(1108, 'House Hold 1'),
(1109, 'Newest Products'),
(1110, 'On Sale Products'),
(1111, 'Braintree'),
(1112, 'Hyperpay'),
(1113, 'Instamojo'),
(1114, 'PayTm'),
(1115, 'Paypal'),
(1116, 'Razor Pay'),
(1117, 'Stripe');

-- --------------------------------------------------------

--
-- Table structure for table `label_value`
--

CREATE TABLE `label_value` (
  `label_value_id` int(11) NOT NULL,
  `label_value` varchar(191) DEFAULT NULL,
  `language_id` int(11) DEFAULT NULL,
  `label_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `label_value`
--

INSERT INTO `label_value` (`label_value_id`, `label_value`, `language_id`, `label_id`) VALUES
(1297, 'Home', 1, 1031),
(1298, 'Menu', 1, 1030),
(1299, 'Clear', 1, 1029),
(1300, 'Apply', 1, 1028),
(1301, 'Close', 1, 1027),
(1302, 'Price Range', 1, 1026),
(1303, 'Filters', 1, 1025),
(1304, 'My Wish List', 1, 1024),
(1305, 'Log Out', 1, 1023),
(1306, 'Please login or create an account for free', 1, 1022),
(1307, 'login & Register', 1, 1021),
(1308, 'Save Address', 1, 1020),
(1309, 'State', 1, 1018),
(1310, 'Update Address', 1, 1019),
(1311, 'Post code', 1, 1017),
(1312, 'City', 1, 1016),
(1313, 'Zone', 1, 1015),
(1314, 'other', 1, 1014),
(1315, 'Country', 1, 1013),
(1316, 'Shipping Address', 1, 1012),
(1317, 'Proceed', 1, 1011),
(1318, 'Remove', 1, 1010),
(1319, 'by', 1, 1008),
(1320, 'View', 1, 1009),
(1321, 'Quantity', 1, 1007),
(1322, 'Price', 1, 1006),
(1323, 'continue shopping', 1, 1005),
(1324, 'Your cart is empty', 1, 1004),
(1325, 'My Cart', 1, 1003),
(1326, 'Continue', 1, 1002),
(1327, 'Error: invalid cvc number!', 1, 1001),
(1328, 'Error: invalid expiry date!', 1, 1000),
(1329, 'Error: invalid card number!', 1, 999),
(1330, 'Expiration', 1, 998),
(1331, 'Expiration Date', 1, 997),
(1332, 'Card Number', 1, 996),
(1333, 'Payment', 1, 995),
(1334, 'Order Notes', 1, 994),
(1335, 'Shipping Cost', 1, 993),
(1336, 'Tax', 1, 992),
(1337, 'Products Price', 1, 991),
(1338, 'SubTotal', 1, 990),
(1339, 'Products', 1, 989),
(1340, 'Shipping Method', 1, 988),
(1341, 'Billing Address', 1, 987),
(1342, 'Order', 1, 986),
(1343, 'Next', 1, 985),
(1344, 'Same as Shipping Address', 1, 984),
(1345, 'Billing Info', 1, 981),
(1346, 'Address', 1, 982),
(1347, 'Phone', 1, 983),
(1348, 'Already Memeber?', 1, 980),
(1349, 'Last Name', 1, 979),
(1350, 'First Name', 1, 978),
(1351, 'Create an Account', 1, 977),
(1352, 'Add new Address', 1, 976),
(1353, 'Please add your new shipping address for the futher processing of the your order', 1, 975),
(1354, 'Order Status', 1, 969),
(1355, 'Orders ID', 1, 970),
(1356, 'Product Price', 1, 971),
(1357, 'No. of Products', 1, 972),
(1358, 'Date', 1, 973),
(1359, 'Customer Address', 1, 974),
(1360, 'Customer Orders', 1, 968),
(1361, 'Change Password', 1, 967),
(1362, 'New Password', 1, 966),
(1363, 'Current Password', 1, 965),
(1364, 'Update', 1, 964),
(1365, 'Date of Birth', 1, 963),
(1366, 'Mobile', 1, 962),
(1367, 'My Account', 1, 961),
(1368, 'Likes', 1, 960),
(1369, 'Newest', 1, 959),
(1370, 'Top Seller', 1, 958),
(1371, 'Special', 1, 957),
(1372, 'Most Liked', 1, 956),
(1373, 'Cancel', 1, 955),
(1374, 'Sort Products', 1, 954),
(1375, 'Special Products', 1, 953),
(1376, 'Price : low - high', 1, 952),
(1377, 'Price : high - low', 1, 951),
(1378, 'Z - A', 1, 950),
(1379, 'A - Z', 1, 949),
(1380, 'All', 1, 948),
(1381, 'Explore More', 1, 947),
(1382, 'Note to the buyer', 1, 946),
(1383, 'Coupon', 1, 945),
(1384, 'coupon code', 1, 944),
(1385, 'Coupon Amount', 1, 943),
(1386, 'Coupon Code', 1, 942),
(1387, 'Food Categories', 1, 941),
(1388, 'Recipe of Day', 1, 940),
(1389, 'Top Dishes', 1, 939),
(1390, 'Skip', 1, 938),
(1391, 'Term and Services', 1, 937),
(1392, 'Privacy Policy', 1, 936),
(1393, 'Refund Policy', 1, 935),
(1394, 'Newest', 1, 934),
(1395, 'OUT OF STOCK', 1, 933),
(1396, 'Select Language', 1, 932),
(1397, 'Reset', 1, 931),
(1398, 'Shop', 1, 930),
(1399, 'Settings', 1, 929),
(1400, 'Enter keyword', 1, 928),
(1401, 'News', 1, 927),
(1402, 'Top Sellers', 1, 926),
(1403, 'Go Back', 1, 925),
(1404, 'Word Press Post Detail', 1, 924),
(1405, 'Explore', 1, 923),
(1406, 'Continue Adding', 1, 922),
(1407, 'Your wish List is empty', 1, 921),
(1408, 'Favourite', 1, 920),
(1409, 'Continue Shopping', 1, 919),
(1410, 'My Orders', 1, 918),
(1411, 'Thank you for shopping with us.', 1, 917),
(1412, 'Thank You', 1, 916),
(1413, 'Shipping method', 1, 915),
(1414, 'Sub Categories', 1, 914),
(1415, 'Main Categories', 1, 913),
(1416, 'Search', 1, 912),
(1417, 'Reset Filters', 1, 911),
(1418, 'No Products Found', 1, 910),
(1419, 'OFF', 1, 909),
(1420, 'Techincal details', 1, 908),
(1421, 'Product Description', 1, 907),
(1422, 'ADD TO CART', 1, 906),
(1423, 'Add to Cart', 1, 905),
(1424, 'In Stock', 1, 904),
(1425, 'Out of Stock', 1, 903),
(1426, 'New', 1, 902),
(1427, 'Product Details', 1, 901),
(1428, 'Shipping', 1, 900),
(1429, 'Sub Total', 1, 899),
(1430, 'Total', 1, 898),
(1431, 'Price Detail', 1, 897),
(1432, 'Order Detail', 1, 896),
(1433, 'Got It!', 1, 895),
(1434, 'Skip Intro', 1, 894),
(1435, 'Intro', 1, 893),
(1436, 'REMOVE', 1, 892),
(1437, 'Deals', 1, 891),
(1438, 'All Categories', 1, 890),
(1439, 'Most Liked', 1, 889),
(1440, 'Special Deals', 1, 888),
(1441, 'Top Seller', 1, 887),
(1442, 'Products are available.', 1, 886),
(1443, 'Recently Viewed', 1, 885),
(1444, 'Please connect to the internet', 1, 884),
(1445, 'Contact Us', 1, 881),
(1446, 'Name', 1, 882),
(1447, 'Your Message', 1, 883),
(1448, 'Categories', 1, 880),
(1449, 'About Us', 1, 879),
(1450, 'Send', 1, 878),
(1451, 'Forgot Password', 1, 877),
(1452, 'Register', 1, 876),
(1453, 'Password', 1, 875),
(1454, 'Email', 1, 874),
(1455, 'or', 1, 873),
(1456, 'Login with', 1, 872),
(1457, 'Creating an account means you\'re okay with shopify\'s Terms of Service, Privacy Policy', 1, 2),
(1458, 'I\'ve forgotten my password?', 1, 1),
(1459, NULL, 1, NULL),
(1462, 'Creating an account means you’re okay with our', 1, 1033),
(1465, 'Login', 1, 1034),
(1468, 'Turn on/off Local Notifications', 1, 1035),
(1471, 'Turn on/off Notifications', 1, 1036),
(1474, 'Change Language', 1, 1037),
(1477, 'Official Website', 1, 1038),
(1480, 'Rate Us', 1, 1039),
(1483, 'Share', 1, 1040),
(1486, 'Edit Profile', 1, 1041),
(1489, 'A percentage discount for the entire cart', 1, 1042),
(1492, 'A fixed total discount for the entire cart', 1, 1043),
(1495, 'A fixed total discount for selected products only', 1, 1044),
(1498, 'A percentage discount for selected products only', 1, 1045),
(1501, 'Network Connected Reloading Data', 1, 1047),
(1503, 'Sort by', 1, 1048),
(1505, 'Flash Sale', 1, 1049),
(1507, 'ok', 1, 1050),
(1509, 'Number', 1, 1051),
(1511, 'Expire Month', 1, 1052),
(1513, 'Expire Year', 1, 1053),
(1515, 'Payment Method', 1, 1054),
(1517, 'Status', 1, 1055),
(1519, 'And', 1, 1056),
(1520, 'نسيت كلمة المرور الخاصة بي؟', 4, 1),
(1521, 'إن إنشاء حساب يعني موافقتك على شروط الخدمة وسياسة الخصوصية', 4, 2),
(1522, 'تسجيل الدخول مع', 4, 872),
(1523, 'أو', 4, 873),
(1524, 'البريد الإلكتروني', 4, 874),
(1525, 'كلمه السر', 4, 875),
(1526, 'تسجيل', 4, 876),
(1527, 'هل نسيت كلمة المرور', 4, 877),
(1528, 'إرسال', 4, 878),
(1529, 'معلومات عنا', 4, 879),
(1530, 'التصنيفات', 4, 880),
(1531, 'اتصل بنا', 4, 881),
(1532, 'اسم', 4, 882),
(1533, 'رسالتك', 4, 883),
(1534, 'يرجى الاتصال بالإنترنت', 4, 884),
(1535, 'شوهدت مؤخرا', 4, 885),
(1536, 'المنتجات المتاحة.', 4, 886),
(1537, 'أعلى بائع', 4, 887),
(1538, 'صفقة خاصة', 4, 888),
(1539, 'الأكثر إعجابا', 4, 889),
(1540, 'جميع الفئات', 4, 890),
(1541, 'صفقات', 4, 891),
(1542, 'إزالة', 4, 892),
(1543, 'مقدمة', 4, 893),
(1544, 'تخطي المقدمة', 4, 894),
(1545, 'فهمتك!', 4, 895),
(1546, 'تفاصيل الطلب', 4, 896),
(1547, 'سعر التفاصيل', 4, 897),
(1548, 'مجموع', 4, 898),
(1549, 'المجموع الفرعي', 4, 899),
(1550, 'الشحن', 4, 900),
(1551, 'تفاصيل المنتج', 4, 901),
(1552, 'جديد', 4, 902),
(1553, 'إنتهى من المخزن', 4, 903),
(1554, 'في المخزن', 4, 904),
(1555, 'أضف إلى السلة', 4, 905),
(1556, 'أضف إلى السلة', 4, 906),
(1557, 'وصف المنتج', 4, 907),
(1558, 'تفاصيل تقنية', 4, 908),
(1559, 'إيقاف', 4, 909),
(1560, 'لا توجد منتجات', 4, 910),
(1561, 'إعادة تعيين المرشحات', 4, 911),
(1562, 'بحث', 4, 912),
(1563, 'الفئات الرئيسية', 4, 913),
(1564, 'الفئات الفرعية', 4, 914),
(1565, 'طريقة الشحن', 4, 915),
(1566, 'شكرا جزيلا', 4, 916),
(1567, 'شكرا للتسوق معنا.', 4, 917),
(1568, 'طلباتي', 4, 918),
(1569, 'مواصلة التسوق', 4, 919),
(1570, NULL, 4, NULL),
(1571, 'مفضل', 4, 920),
(1572, 'قائمة رغباتك فارغة', 4, 921),
(1573, 'متابعة الإضافة', 4, 922),
(1574, 'يكتشف', 4, 923),
(1575, 'وورد بوست التفاصيل', 4, 924),
(1576, 'عد', 4, 925),
(1577, 'أفضل البائعين', 4, 926),
(1578, 'أخبار', 4, 927),
(1579, 'أدخل الكلمة المفتاحية', 4, 928),
(1580, 'الإعدادات', 4, 929),
(1581, 'متجر', 4, 930),
(1582, 'إعادة تعيين', 4, 931),
(1583, 'اختار اللغة', 4, 932),
(1584, 'إنتهى من المخزن', 4, 933),
(1585, 'الأحدث', 4, 934),
(1586, 'سياسة الاسترجاع', 4, 935),
(1587, 'سياسة خاصة', 4, 936),
(1588, 'مصطلح والخدمات', 4, 937),
(1589, 'تخطى', 4, 938),
(1590, 'أطباق الأعلى', 4, 939),
(1591, 'وصفة اليوم', 4, 940),
(1592, 'فئات الغذاء', 4, 941),
(1593, 'رمز الكوبون', 4, 942),
(1594, 'مبلغ القسيمة', 4, 943),
(1595, 'رمز الكوبون', 4, 944),
(1596, 'كوبون', 4, 945),
(1597, 'ملاحظة للمشتري', 4, 946),
(1598, 'استكشاف المزيد', 4, 947),
(1599, 'الكل', 4, 948),
(1600, 'أ - ي', 4, 949),
(1601, 'ي - أ', 4, 950),
(1602, 'السعر مرتفع منخفض', 4, 951),
(1603, 'سعر منخفض مرتفع', 4, 952),
(1604, 'المنتجات الخاصة', 4, 953),
(1605, 'فرز المنتجات', 4, 954),
(1606, 'إلغاء', 4, 955),
(1607, 'الأكثر إعجابا', 4, 956),
(1608, 'خاص', 4, 957),
(1609, 'أعلى بائع', 4, 958),
(1610, 'الأحدث', 4, 959),
(1611, 'الإعجابات', 4, 960),
(1612, 'حسابي', 4, 961),
(1613, 'التليفون المحمول', 4, 962),
(1614, 'تاريخ الولادة', 4, 963),
(1615, 'تحديث', 4, 964),
(1616, 'كلمة المرور الحالية', 4, 965),
(1617, 'كلمة سر جديدة', 4, 966),
(1618, 'تغيير كلمة المرور', 4, 967),
(1619, 'طلبات العملاء', 4, 968),
(1620, 'حالة الطلب', 4, 969),
(1621, 'معرف الطلبات', 4, 970),
(1622, 'سعر المنتج', 4, 971),
(1623, 'عدد المنتجات', 4, 972),
(1624, 'تاريخ', 4, 973),
(1625, 'عنوان العميل', 4, 974),
(1626, 'يرجى إضافة عنوان الشحن الجديد لمزيد من المعالجة لطلبك', 4, 975),
(1627, 'إضافة عنوان جديد', 4, 976),
(1628, 'انشئ حساب', 4, 977),
(1629, 'الاسم الاول', 4, 978),
(1630, 'الكنية', 4, 979),
(1631, 'هل أنت عضو بالفعل؟', 4, 980),
(1632, 'معلومات الفواتير', 4, 981),
(1633, 'عنوان', 4, 982),
(1634, 'هاتف', 4, 983),
(1635, 'نفس عنوان الشحن', 4, 984),
(1636, 'التالى', 4, 985),
(1637, 'طلب', 4, 986),
(1638, 'عنوان وصول الفواتير', 4, 987),
(1639, 'طريقة الشحن', 4, 988),
(1640, 'منتجات', 4, 989),
(1641, 'حاصل الجمع', 4, 990),
(1642, 'سعر المنتجات', 4, 991),
(1643, 'ضريبة', 4, 992),
(1644, 'تكلفة الشحن', 4, 993),
(1645, 'ترتيب ملاحظات', 4, 994),
(1646, 'دفع', 4, 995),
(1647, 'رقم البطاقة', 4, 996),
(1648, 'تاريخ الإنتهاء', 4, 997),
(1649, 'انتهاء الصلاحية', 4, 998),
(1650, 'خطأ: رقم البطاقة غير صالح!', 4, 999),
(1651, 'خطأ: تاريخ انتهاء الصلاحية غير صحيح!', 4, 1000),
(1652, 'خطأ: رقم cvc غير صالح!', 4, 1001),
(1653, 'استمر', 4, 1002),
(1654, 'سلتي', 4, 1003),
(1655, 'عربة التسوق فارغة', 4, 1004),
(1656, 'مواصلة التسوق', 4, 1005),
(1657, 'السعر', 4, 1006),
(1658, 'كمية', 4, 1007),
(1659, 'بواسطة', 4, 1008),
(1660, 'رأي', 4, 1009),
(1661, 'إزالة', 4, 1010),
(1662, 'تقدم', 4, 1011),
(1663, 'عنوان الشحن', 4, 1012),
(1664, 'بلد', 4, 1013),
(1665, 'آخر', 4, 1014),
(1666, 'منطقة', 4, 1015),
(1667, 'مدينة', 4, 1016),
(1668, 'الرمز البريدي', 4, 1017),
(1669, 'حالة', 4, 1018),
(1670, 'تحديث العنوان', 4, 1019),
(1671, 'حفظ العنوان', 4, 1020),
(1672, 'دخولتسجيل', 4, 1021),
(1673, 'يرجى تسجيل الدخول أو إنشاء حساب مجانا', 4, 1022),
(1674, 'تسجيل خروج', 4, 1023),
(1675, 'قائمة امنياتي', 4, 1024),
(1676, 'مرشحات', 4, 1025),
(1677, 'نطاق السعر', 4, 1026),
(1678, 'قريب', 4, 1027),
(1679, 'تطبيق', 4, 1028),
(1680, 'واضح', 4, 1029),
(1681, 'قائمة طعام', 4, 1030),
(1682, 'الصفحة الرئيسية', 4, 1031),
(1683, 'إن إنشاء حساب يعني أنك بخير من خلال موقعنا', 4, 1033),
(1684, 'تسجيل الدخول', 4, 1034),
(1685, 'تشغيل / إيقاف الإشعارات', 4, 1035),
(1686, 'تشغيل / إيقاف الإشعارات', 4, 1036),
(1687, 'تغيير اللغة', 4, 1037),
(1688, 'الموقع الرسمي', 4, 1038),
(1689, 'قيمنا', 4, 1039),
(1690, 'شارك', 4, 1040),
(1691, 'تعديل الملف الشخصي', 4, 1041),
(1692, 'خصم النسبة المئوية للسلة بأكملها', 4, 1042),
(1693, 'خصم إجمالي ثابت للعربة بأكملها', 4, 1043),
(1694, 'خصم إجمالي ثابت للمنتجات المحددة فقط', 4, 1044),
(1695, 'خصم النسبة المئوية للمنتجات المختارة فقط', 4, 1045),
(1696, 'شبكة متصلة إعادة تحميل البيانات', 4, 1047),
(1697, 'صنف حسب', 4, 1048),
(1698, 'بيع مفاجئ', 4, 1049),
(1699, 'حسنا', 4, 1050),
(1700, 'رقم', 4, 1051),
(1701, 'انتهاء الشهر', 4, 1052),
(1702, 'انتهاء السنة', 4, 1053),
(1703, 'طريقة الدفع او السداد', 4, 1054),
(1704, 'الحالة', 4, 1055),
(1705, 'و', 4, 1056),
(1706, 'cccc', 1, 1057),
(1707, 'cccc', 4, 1057),
(1708, 'Shop More', 1, 1058),
(1709, 'عربي', 4, 1058),
(1710, 'Discount', 1, 1072),
(1711, 'خصم', 4, 1072),
(1712, 'Error in initialization, maybe PayPal isnt supported or something else', 1, 1073),
(1713, 'خطأ في التهيئة ، ربما لا يتم دعم PayPal أو أي شيء آخر', 4, 1073),
(1714, 'Alert', 1, 1074),
(1715, 'إنذار', 4, 1074),
(1716, 'Your Wishlist is Empty', 1, 1075),
(1717, 'قائمة رغباتك فارغة', 4, 1075),
(1718, 'Press heart icon on products to add them in wishlist', 1, 1076),
(1719, 'اضغط على أيقونة القلب على المنتجات لإضافتها إلى قائمة الرغبات', 4, 1076),
(1720, 'Wishlist', 1, 1077),
(1721, 'قائمة الرغبات', 4, 1077),
(1722, 'All Items', 1, 1078),
(1723, 'كل الاشياء', 4, 1078),
(1724, 'Account Info', 1, 1079),
(1725, 'معلومات الحساب', 4, 1079),
(1726, 'You Must Be Logged in to use this Feature!', 1, 1080),
(1727, 'يجب عليك تسجيل الدخول لاستخدام هذه الميزة!', 4, 1080),
(1728, 'Remove from Wishlist', 1, 1081),
(1729, 'إزالة من قائمة الرغبات', 4, 1081),
(1730, 'Sign Up', 1, 1082),
(1731, 'سجل', 4, 1082),
(1732, 'Reset Password', 1, 1083),
(1733, 'إعادة تعيين كلمة المرور', 4, 1083),
(1734, 'Invalid email or password', 1, 1084),
(1735, 'البريد الإلكتروني أو كلمة السر خاطئة', 4, 1084),
(1736, 'Recent Searches', 1, 1085),
(1737, 'عمليات البحث الأخيرة', 4, 1085),
(1738, 'Add to Wishlist', 1, 1086),
(1739, 'أضف إلى قائمة الامنيات', 4, 1086),
(1740, 'Discover Latest Trends', 1, 1087),
(1741, 'اكتشف أحدث الاتجاهات', 4, 1087),
(1742, 'Add To My Wishlist', 1, 1088),
(1743, 'أضف إلى قائمة أمنياتي', 4, 1088),
(1744, 'Start Shoping', 1, 1089),
(1745, 'ابدأ التسوق', 4, 1089),
(1746, 'A Smart Shopping Experience', 1, 1090),
(1747, 'تجربة تسوق ذكية', 4, 1090),
(1748, 'Addresses', 1, 1091),
(1749, 'عناوين', 4, 1091),
(1750, 'Account', 1, 1092),
(1751, 'الحساب', 4, 1092),
(1752, 'DETAILS', 1, 1093),
(1753, 'تفاصيل', 4, 1093),
(1754, 'Dark Mode', 1, 1094),
(1755, 'الوضع الداكن', 4, 1094),
(1756, 'Enter a description', 1, 1095),
(1757, 'أدخل وصفًا', 4, 1095),
(1758, 'Grocery Store', 1, 1096),
(1759, 'بقالة', 4, 1096),
(1760, 'Post Comment', 1, 1097),
(1761, 'أضف تعليقا', 4, 1097),
(1762, 'Rate and write a review', 1, 1098),
(1763, 'تقييم وكتابة مراجعة', 4, 1098),
(1764, 'Ratings & Reviews', 1, 1099),
(1765, 'التقييمات والمراجعات', 4, 1099),
(1766, 'Write a review', 1, 1100),
(1767, 'أكتب مراجعة', 4, 1100),
(1768, 'Your Rating', 1, 1101),
(1769, 'تقييمك', 4, 1101),
(1770, 'rating', 1, 1102),
(1771, 'تقييم', 4, 1102),
(1772, 'rating and review', 1, 1103),
(1773, 'تصنيف ومراجعة', 4, 1103),
(1774, 'Coupon Codes List', 1, 1104),
(1775, 'قائمة رموز القسيمة', 4, 1104),
(1776, 'Custom Orders', 1, 1105),
(1777, 'أوامر مخصصة', 4, 1105),
(1778, 'Ecommerce', 1, 1106),
(1779, 'التجارة الإلكترونية', 4, 1106),
(1780, 'Featured Products', 1, 1107),
(1781, 'منتجات مميزة', 4, 1107),
(1782, 'House Hold 1', 1, 1108),
(1783, 'المنزل عقد 1', 4, 1108),
(1784, 'Newest Products', 1, 1109),
(1785, 'أحدث المنتجات', 4, 1109),
(1786, 'On Sale Products', 1, 1110),
(1787, 'المنتجات المعروضة للبيع', 4, 1110),
(1788, 'Braintree', 1, 1111),
(1789, 'برينتري', 4, 1111),
(1790, 'Hyperpay', 1, 1112),
(1791, 'Hyperpay', 4, 1112),
(1792, 'Instamojo', 1, 1113),
(1793, 'Instamojo', 4, 1113),
(1794, 'PayTm', 1, 1114),
(1795, 'PayTm', 4, 1114),
(1796, 'Paypal', 1, 1115),
(1797, 'باي بال', 4, 1115),
(1798, 'Razor Pay', 1, 1116),
(1799, 'الحلاقة الدفع', 4, 1116),
(1800, 'Stripe', 1, 1117),
(1801, 'شريط', 4, 1117),
(1802, 'Me', 1, 1059),
(1803, 'أنا', 4, 1059),
(1804, 'View All', 1, 1060),
(1805, 'عرض الكل', 4, 1060),
(1806, 'Featured', 1, 1061),
(1807, 'متميز', 4, 1061),
(1808, 'Shop Now', 1, 1062),
(1809, 'تسوق الآن', 4, 1062),
(1810, 'New Arrivals', 1, 1063),
(1811, 'الوافدون الجدد', 4, 1063),
(1812, 'Sort', 1, 1064),
(1813, 'فرز', 4, 1064),
(1814, 'Help & Support', 1, 1065),
(1815, 'ساعد لدعم', 4, 1065),
(1816, 'Select Currency', 1, 1066),
(1817, 'اختر العملة', 4, 1066),
(1818, 'Your Price', 1, 1067),
(1819, 'السعر الخاص', 4, 1067),
(1820, 'Billing', 1, 1068),
(1821, 'الفواتير', 4, 1068),
(1822, 'Ship to a different address?', 1, 1069),
(1823, 'هل تريد الشحن إلى عنوان مختلف؟', 4, 1069),
(1824, 'Method', 1, 1070),
(1825, 'طريقة', 4, 1070),
(1826, 'Summary', 1, 1071),
(1827, 'ملخص', 4, 1071);

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `languages_id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `code` char(6) NOT NULL,
  `image` text DEFAULT NULL,
  `directory` varchar(32) DEFAULT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `direction` varchar(100) NOT NULL,
  `is_default` tinyint(1) DEFAULT 0,
  `status` int(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`languages_id`, `name`, `code`, `image`, `directory`, `sort_order`, `direction`, `is_default`, `status`) VALUES
(1, 'English', 'en', '1', NULL, 1, 'ltr', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `liked_products`
--

CREATE TABLE `liked_products` (
  `like_id` int(11) NOT NULL,
  `liked_products_id` int(11) NOT NULL,
  `liked_customers_id` int(11) NOT NULL,
  `date_liked` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `liked_products`
--

INSERT INTO `liked_products` (`like_id`, `liked_products_id`, `liked_customers_id`, `date_liked`) VALUES
(1, 14, 4, '2020-08-10 04:18:02');

-- --------------------------------------------------------

--
-- Table structure for table `manage_min_max`
--

CREATE TABLE `manage_min_max` (
  `min_max_id` int(11) NOT NULL,
  `min_level` int(11) NOT NULL,
  `max_level` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `inventory_ref_id` varchar(191) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `manage_role`
--

CREATE TABLE `manage_role` (
  `manage_role_id` int(11) NOT NULL,
  `user_types_id` tinyint(1) NOT NULL DEFAULT 0,
  `dashboard_view` tinyint(1) NOT NULL DEFAULT 0,
  `manufacturer_view` tinyint(1) NOT NULL DEFAULT 0,
  `manufacturer_create` tinyint(1) NOT NULL DEFAULT 0,
  `manufacturer_update` tinyint(1) NOT NULL DEFAULT 0,
  `manufacturer_delete` tinyint(1) NOT NULL DEFAULT 0,
  `categories_view` tinyint(1) NOT NULL DEFAULT 0,
  `categories_create` tinyint(1) NOT NULL DEFAULT 0,
  `categories_update` tinyint(1) NOT NULL DEFAULT 0,
  `categories_delete` tinyint(1) NOT NULL DEFAULT 0,
  `products_view` tinyint(1) NOT NULL DEFAULT 0,
  `products_create` tinyint(1) NOT NULL DEFAULT 0,
  `products_update` tinyint(1) NOT NULL DEFAULT 0,
  `products_delete` tinyint(1) NOT NULL DEFAULT 0,
  `news_view` tinyint(1) NOT NULL DEFAULT 0,
  `news_create` tinyint(1) NOT NULL DEFAULT 0,
  `news_update` tinyint(1) NOT NULL DEFAULT 0,
  `news_delete` tinyint(1) NOT NULL DEFAULT 0,
  `customers_view` tinyint(1) NOT NULL DEFAULT 0,
  `customers_create` tinyint(1) NOT NULL DEFAULT 0,
  `customers_update` tinyint(1) NOT NULL DEFAULT 0,
  `customers_delete` tinyint(1) NOT NULL DEFAULT 0,
  `tax_location_view` tinyint(1) NOT NULL DEFAULT 0,
  `tax_location_create` tinyint(1) NOT NULL DEFAULT 0,
  `tax_location_update` tinyint(1) NOT NULL DEFAULT 0,
  `tax_location_delete` tinyint(1) NOT NULL DEFAULT 0,
  `coupons_view` tinyint(1) NOT NULL DEFAULT 0,
  `coupons_create` tinyint(1) NOT NULL DEFAULT 0,
  `coupons_update` tinyint(1) NOT NULL DEFAULT 0,
  `coupons_delete` tinyint(1) NOT NULL DEFAULT 0,
  `notifications_view` tinyint(1) NOT NULL DEFAULT 0,
  `notifications_send` tinyint(1) NOT NULL DEFAULT 0,
  `orders_view` tinyint(1) NOT NULL DEFAULT 0,
  `orders_confirm` tinyint(1) NOT NULL DEFAULT 0,
  `shipping_methods_view` tinyint(1) NOT NULL DEFAULT 0,
  `shipping_methods_update` tinyint(1) NOT NULL DEFAULT 0,
  `payment_methods_view` tinyint(1) NOT NULL DEFAULT 0,
  `payment_methods_update` tinyint(1) NOT NULL DEFAULT 0,
  `reports_view` tinyint(1) NOT NULL DEFAULT 0,
  `website_setting_view` tinyint(1) NOT NULL DEFAULT 0,
  `website_setting_update` tinyint(1) NOT NULL DEFAULT 0,
  `application_setting_view` tinyint(1) NOT NULL DEFAULT 0,
  `application_setting_update` tinyint(1) NOT NULL DEFAULT 0,
  `general_setting_view` tinyint(1) NOT NULL DEFAULT 0,
  `general_setting_update` tinyint(1) NOT NULL DEFAULT 0,
  `manage_admins_view` tinyint(1) NOT NULL DEFAULT 0,
  `manage_admins_create` tinyint(1) NOT NULL DEFAULT 0,
  `manage_admins_update` tinyint(1) NOT NULL DEFAULT 0,
  `manage_admins_delete` tinyint(1) NOT NULL DEFAULT 0,
  `language_view` tinyint(1) NOT NULL DEFAULT 0,
  `language_create` tinyint(1) NOT NULL DEFAULT 0,
  `language_update` tinyint(1) NOT NULL DEFAULT 0,
  `language_delete` tinyint(1) NOT NULL DEFAULT 0,
  `profile_view` tinyint(1) NOT NULL DEFAULT 0,
  `profile_update` tinyint(1) NOT NULL DEFAULT 0,
  `admintype_view` tinyint(1) NOT NULL DEFAULT 0,
  `admintype_create` tinyint(1) NOT NULL DEFAULT 0,
  `admintype_update` tinyint(1) NOT NULL DEFAULT 0,
  `admintype_delete` tinyint(1) NOT NULL DEFAULT 0,
  `manage_admins_role` tinyint(1) NOT NULL DEFAULT 0,
  `add_media` tinyint(1) NOT NULL DEFAULT 0,
  `edit_media` tinyint(1) NOT NULL DEFAULT 0,
  `view_media` tinyint(1) NOT NULL DEFAULT 0,
  `delete_media` tinyint(1) NOT NULL DEFAULT 0,
  `edit_management` tinyint(1) NOT NULL DEFAULT 0,
  `reviews_view` tinyint(1) NOT NULL DEFAULT 0,
  `reviews_update` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `manage_role`
--

INSERT INTO `manage_role` (`manage_role_id`, `user_types_id`, `dashboard_view`, `manufacturer_view`, `manufacturer_create`, `manufacturer_update`, `manufacturer_delete`, `categories_view`, `categories_create`, `categories_update`, `categories_delete`, `products_view`, `products_create`, `products_update`, `products_delete`, `news_view`, `news_create`, `news_update`, `news_delete`, `customers_view`, `customers_create`, `customers_update`, `customers_delete`, `tax_location_view`, `tax_location_create`, `tax_location_update`, `tax_location_delete`, `coupons_view`, `coupons_create`, `coupons_update`, `coupons_delete`, `notifications_view`, `notifications_send`, `orders_view`, `orders_confirm`, `shipping_methods_view`, `shipping_methods_update`, `payment_methods_view`, `payment_methods_update`, `reports_view`, `website_setting_view`, `website_setting_update`, `application_setting_view`, `application_setting_update`, `general_setting_view`, `general_setting_update`, `manage_admins_view`, `manage_admins_create`, `manage_admins_update`, `manage_admins_delete`, `language_view`, `language_create`, `language_update`, `language_delete`, `profile_view`, `profile_update`, `admintype_view`, `admintype_create`, `admintype_update`, `admintype_delete`, `manage_admins_role`, `add_media`, `edit_media`, `view_media`, `delete_media`, `edit_management`, `reviews_view`, `reviews_update`) VALUES
(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers`
--

CREATE TABLE `manufacturers` (
  `manufacturers_id` int(10) UNSIGNED NOT NULL,
  `manufacturer_name` varchar(191) NOT NULL,
  `manufacturers_slug` varchar(191) NOT NULL,
  `date_added` varchar(191) DEFAULT NULL,
  `last_modified` varchar(191) DEFAULT NULL,
  `manufacturer_image` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `manufacturers`
--

INSERT INTO `manufacturers` (`manufacturers_id`, `manufacturer_name`, `manufacturers_slug`, `date_added`, `last_modified`, `manufacturer_image`, `created_at`, `updated_at`) VALUES
(1, 'Samsung', 'samsung', NULL, NULL, '777', '2022-01-06 16:11:08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `manufacturers_info`
--

CREATE TABLE `manufacturers_info` (
  `manufacturers_id` int(11) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `manufacturers_url` varchar(191) DEFAULT NULL,
  `url_clicked` int(11) NOT NULL DEFAULT 0,
  `date_last_click` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `manufacturers_info`
--

INSERT INTO `manufacturers_info` (`manufacturers_id`, `languages_id`, `manufacturers_url`, `url_clicked`, `date_last_click`) VALUES
(1, 1, '#', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(11) NOT NULL,
  `sort_order` int(11) DEFAULT NULL,
  `sub_sort_order` int(11) DEFAULT NULL,
  `parent_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `external_link` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `sort_order`, `sub_sort_order`, `parent_id`, `type`, `external_link`, `link`, `page_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 0, 5, '/', '/', 0, 1, NULL, NULL),
(2, 2, NULL, 0, 5, 'shop', '/shop', 0, 1, NULL, NULL),
(3, 4, NULL, 0, 1, NULL, '#', NULL, 1, NULL, NULL),
(18, 5, 2, 3, 2, '/page?name=about-us', 'about-us', 0, 1, NULL, NULL),
(19, 6, 4, 3, 2, '/page?name=privacy-policy', 'privacy-policy', 0, 1, NULL, NULL),
(20, 3, NULL, 0, 5, '/news', '/news', 0, 0, NULL, NULL),
(22, 7, NULL, 0, 5, 'contact', '/contact', 0, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `menu_translation`
--

CREATE TABLE `menu_translation` (
  `id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `menu_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_translation`
--

INSERT INTO `menu_translation` (`id`, `menu_id`, `language_id`, `menu_name`) VALUES
(2, 1, 1, 'Home'),
(3, 1, 4, 'منزل'),
(11, 2, 1, 'Shop'),
(12, 2, 4, 'تسوق'),
(25, 3, 1, 'Info'),
(26, 3, 4, 'صفحات المعلومات'),
(33, 18, 1, 'About Us'),
(34, 18, 4, 'معلومات عنا'),
(35, 19, 1, 'Privacy Policy'),
(36, 19, 4, 'سياسة خاصة'),
(37, 20, 1, 'News'),
(38, 20, 4, 'أخبار'),
(41, 22, 1, 'Contact Us'),
(42, 22, 4, 'اتصل بنا');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2019_09_24_122557_create_address_book_table', 1),
(2, '2019_09_24_122557_create_alert_settings_table', 1),
(3, '2019_09_24_122557_create_api_calls_list_table', 1),
(4, '2019_09_24_122557_create_banners_history_table', 1),
(5, '2019_09_24_122557_create_banners_table', 1),
(6, '2019_09_24_122557_create_block_ips_table', 1),
(7, '2019_09_24_122557_create_categories_description_table', 1),
(8, '2019_09_24_122557_create_categories_role_table', 1),
(9, '2019_09_24_122557_create_categories_table', 1),
(10, '2019_09_24_122557_create_compare_table', 1),
(11, '2019_09_24_122557_create_constant_banners_table', 1),
(12, '2019_09_24_122557_create_countries_table', 1),
(13, '2019_09_24_122557_create_coupons_table', 1),
(14, '2019_09_24_122557_create_currencies_table', 1),
(15, '2019_09_24_122557_create_currency_record_table', 1),
(16, '2019_09_24_122557_create_current_theme_table', 1),
(17, '2019_09_24_122557_create_customers_basket_attributes_table', 1),
(18, '2019_09_24_122557_create_customers_basket_table', 1),
(19, '2019_09_24_122557_create_customers_info_table', 1),
(20, '2019_09_24_122557_create_customers_table', 1),
(21, '2019_09_24_122557_create_devices_table', 1),
(22, '2019_09_24_122557_create_flash_sale_table', 1),
(23, '2019_09_24_122557_create_flate_rate_table', 1),
(24, '2019_09_24_122557_create_front_end_theme_content_table', 1),
(25, '2019_09_24_122557_create_geo_zones_table', 1),
(26, '2019_09_24_122557_create_http_call_record_table', 1),
(27, '2019_09_24_122557_create_image_categories_table', 1),
(28, '2019_09_24_122557_create_images_table', 1),
(29, '2019_09_24_122557_create_inventory_detail_table', 1),
(30, '2019_09_24_122557_create_inventory_table', 1),
(31, '2019_09_24_122557_create_label_value_table', 1),
(32, '2019_09_24_122557_create_labels_table', 1),
(33, '2019_09_24_122557_create_languages_table', 1),
(34, '2019_09_24_122557_create_liked_products_table', 1),
(35, '2019_09_24_122557_create_manage_min_max_table', 1),
(36, '2019_09_24_122557_create_manage_role_table', 1),
(37, '2019_09_24_122557_create_manufacturers_info_table', 1),
(38, '2019_09_24_122557_create_manufacturers_table', 1),
(39, '2019_09_24_122557_create_news_categories_description_table', 1),
(40, '2019_09_24_122557_create_news_categories_table', 1),
(41, '2019_09_24_122557_create_news_description_table', 1),
(42, '2019_09_24_122557_create_news_table', 1),
(43, '2019_09_24_122557_create_news_to_news_categories_table', 1),
(44, '2019_09_24_122557_create_orders_products_attributes_table', 1),
(45, '2019_09_24_122557_create_orders_products_table', 1),
(46, '2019_09_24_122557_create_orders_status_description_table', 1),
(47, '2019_09_24_122557_create_orders_status_history_table', 1),
(48, '2019_09_24_122557_create_orders_status_table', 1),
(49, '2019_09_24_122557_create_orders_table', 1),
(50, '2019_09_24_122557_create_orders_total_table', 1),
(51, '2019_09_24_122557_create_pages_description_table', 1),
(52, '2019_09_24_122557_create_pages_table', 1),
(53, '2019_09_24_122557_create_payment_description_table', 1),
(54, '2019_09_24_122557_create_payment_methods_detail_table', 1),
(55, '2019_09_24_122557_create_payment_methods_table', 1),
(56, '2019_09_24_122557_create_permissions_table', 1),
(57, '2019_09_24_122557_create_products_attributes_table', 1),
(58, '2019_09_24_122557_create_products_description_table', 1),
(59, '2019_09_24_122557_create_products_images_table', 1),
(60, '2019_09_24_122557_create_products_options_descriptions_table', 1),
(61, '2019_09_24_122557_create_products_options_table', 1),
(62, '2019_09_24_122557_create_products_options_values_descriptions_table', 1),
(63, '2019_09_24_122557_create_products_options_values_table', 1),
(64, '2019_09_24_122557_create_products_shipping_rates_table', 1),
(65, '2019_09_24_122557_create_products_table', 1),
(66, '2019_09_24_122557_create_products_to_categories_table', 1),
(67, '2019_09_24_122557_create_reviews_description_table', 1),
(68, '2019_09_24_122557_create_reviews_table', 1),
(69, '2019_09_24_122557_create_sessions_table', 1),
(70, '2019_09_24_122557_create_settings_table', 1),
(71, '2019_09_24_122557_create_shipping_description_table', 1),
(72, '2019_09_24_122557_create_shipping_methods_table', 1),
(73, '2019_09_24_122557_create_sliders_images_table', 1),
(74, '2019_09_24_122557_create_specials_table', 1),
(75, '2019_09_24_122557_create_tax_class_table', 1),
(76, '2019_09_24_122557_create_tax_rates_table', 1),
(77, '2019_09_24_122557_create_units_descriptions_table', 1),
(78, '2019_09_24_122557_create_units_table', 1),
(79, '2019_09_24_122557_create_ups_shipping_table', 1),
(80, '2019_09_24_122557_create_user_to_address_table', 1),
(81, '2019_09_24_122557_create_user_types_table', 1),
(82, '2019_09_24_122557_create_users_table', 1),
(83, '2019_09_24_122557_create_whos_online_table', 1),
(84, '2019_09_24_122557_create_zones_table', 1),
(85, '2019_09_24_122557_create_zones_to_geo_zones_table', 1),
(86, '2019_12_11_070737_create_menus_table', 1),
(87, '2019_12_11_070821_create_menu_translation_table', 1),
(88, '2020_02_04_121358_top_offers', 1),
(89, '2020_03_25_141022_create_home_banners', 1);

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `news_id` int(11) NOT NULL,
  `news_image` text DEFAULT NULL,
  `news_date_added` datetime NOT NULL,
  `news_last_modified` datetime DEFAULT NULL,
  `news_status` tinyint(1) NOT NULL,
  `is_feature` tinyint(1) NOT NULL DEFAULT 0,
  `news_slug` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`news_id`, `news_image`, `news_date_added`, `news_last_modified`, `news_status`, `is_feature`, `news_slug`, `created_at`, `updated_at`) VALUES
(1, '419', '2020-04-05 01:10:00', NULL, 1, 1, 'world-business-news', '2019-09-18 05:17:41', '2020-03-31 23:12:31'),
(2, '420', '2020-04-05 01:10:00', NULL, 1, 0, 'witn-news', '2019-09-18 05:23:26', '2019-10-01 06:25:20'),
(3, '421', '2020-04-05 01:10:00', NULL, 1, 0, 'stock-exchange', '2019-09-24 06:02:25', '2019-10-01 06:25:44'),
(4, '447', '2020-04-05 01:10:00', NULL, 1, 1, 'manufacturing-tools', '2019-09-24 06:03:19', '2019-10-01 06:26:07'),
(5, '449', '2020-04-05 01:10:00', NULL, 1, 1, 'fashion-week', '2019-09-24 06:31:11', '2019-10-01 06:26:45'),
(6, '448', '2020-04-05 01:10:00', NULL, 1, 1, 'world-wide-networking', '2019-09-24 06:33:17', '2019-10-01 06:27:01');

-- --------------------------------------------------------

--
-- Table structure for table `news_categories`
--

CREATE TABLE `news_categories` (
  `categories_id` int(11) NOT NULL,
  `categories_image` text DEFAULT NULL,
  `categories_icon` text NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `sort_order` int(11) DEFAULT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `news_categories_slug` varchar(191) NOT NULL,
  `categories_status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news_categories`
--

INSERT INTO `news_categories` (`categories_id`, `categories_image`, `categories_icon`, `parent_id`, `sort_order`, `date_added`, `last_modified`, `news_categories_slug`, `categories_status`, `created_at`, `updated_at`) VALUES
(3, '417', '', 0, 1, NULL, '2020-04-01 05:10:03', 'tools-and-technology', 1, '2019-09-24 05:56:31', NULL),
(4, '418', '', 0, 4, NULL, '2020-04-01 05:10:27', 'business', 1, '2019-09-24 05:57:08', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `news_categories_description`
--

CREATE TABLE `news_categories_description` (
  `categories_description_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL DEFAULT 0,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `categories_name` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news_categories_description`
--

INSERT INTO `news_categories_description` (`categories_description_id`, `categories_id`, `language_id`, `categories_name`) VALUES
(3, 3, 1, 'Tools and Technology'),
(4, 4, 1, 'Business'),
(5, 3, 4, 'الأدوات والتكنولوجيا'),
(6, 4, 4, 'اعمال');

-- --------------------------------------------------------

--
-- Table structure for table `news_description`
--

CREATE TABLE `news_description` (
  `language_id` int(11) NOT NULL DEFAULT 1,
  `news_name` varchar(64) NOT NULL DEFAULT '',
  `news_id` int(11) NOT NULL,
  `news_description` text DEFAULT NULL,
  `news_url` varchar(191) DEFAULT NULL,
  `news_viewed` int(11) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news_description`
--

INSERT INTO `news_description` (`language_id`, `news_name`, `news_id`, `news_description`, `news_url`, `news_viewed`) VALUES
(1, 'World Business', 1, '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', '0', 0),
(1, 'World Information Technology', 2, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '0', 0),
(1, 'Stock Exchange', 3, 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&amp;rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', '0', 0),
(1, 'Why to choose this app for your Project?', 4, '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&amp;rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', '0', 0),
(1, 'Fashion Week', 5, '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&amp;rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', '0', 0),
(1, 'Tool and Technology', 6, '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&amp;rsquo;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>', '0', 0),
(4, 'عالم الأعمال', 1, '<p>ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء. أم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم. ثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء. عرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل. مكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا. كان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل. حتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد. عدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات. كلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية. عن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء. أم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم. ثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء. عرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل. مكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا. كان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل. حتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد. عدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات. كلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية. عن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء. أم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم. ثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء. عرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل. مكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا. كان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل. حتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد. عدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات. كلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية. عن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.</p>', '0', 0),
(4, 'عالم تكنولوجيا المعلومات', 2, 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', '0', 0),
(4, 'تداول الاسهم', 3, 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', '0', 0),
(4, 'لماذا تختار هذا التطبيق لمشروعك؟', 4, 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', '0', 0),
(4, 'أسبوع الموضة', 5, 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', '0', 0),
(4, 'الأداة والتكنولوجيا', 6, 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', '0', 0);

-- --------------------------------------------------------

--
-- Table structure for table `news_to_news_categories`
--

CREATE TABLE `news_to_news_categories` (
  `news_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `news_to_news_categories`
--

INSERT INTO `news_to_news_categories` (`news_id`, `categories_id`, `created_at`, `updated_at`) VALUES
(1, 4, '2019-09-18 05:17:41', '2020-03-31 23:12:31'),
(2, 3, '2019-09-18 05:23:26', '2019-10-01 06:25:20'),
(3, 4, '2019-09-24 06:02:25', '2019-10-01 06:25:44'),
(4, 3, '2019-09-24 06:03:19', '2019-10-01 06:26:07'),
(5, 4, '2019-09-24 06:31:11', '2019-10-01 06:26:45'),
(6, 3, '2019-09-24 06:33:17', '2019-10-01 06:27:01');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('b47b4637656b2dfe061b22834ecb480c0384af7ede39636040813365e83ee848a35d12ecc27b43dd', 2, 1, 'knoprotec', '[]', 0, '2020-07-19 02:15:08', '2020-07-19 02:15:08', '2021-07-19 08:15:08'),
('ca09c4f860a283aed6d7d59cc9bcb10fd0658623899e2358f4b778f86cc880a9685691859b188c25', 2, 1, 'knoprotec', '[]', 0, '2020-07-19 12:00:58', '2020-07-19 12:00:58', '2021-07-19 18:00:58');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `secret` varchar(100) NOT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'knoprotec Personal Access Client', '6NoBlHRibJAId4W8gFHzgduCNeP7MyK3DvmufKEI', NULL, 'http://localhost', 1, 0, 0, '2020-07-19 01:09:02', '2020-07-19 01:09:02'),
(2, NULL, 'knoprotec Password Grant Client', 'dEacQZ7iEavC22Y0Xp2WVkF3ZqneNCdvcSXWkAjg', 'users', 'http://localhost', 0, 1, 0, '2020-07-19 01:09:02', '2020-07-19 01:09:02');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) UNSIGNED NOT NULL,
  `client_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-07-19 01:09:02', '2020-07-19 01:09:02');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orders_id` int(11) NOT NULL,
  `total_tax` decimal(7,2) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `customers_name` varchar(191) NOT NULL,
  `customers_company` varchar(191) DEFAULT NULL,
  `customers_street_address` varchar(191) NOT NULL,
  `customers_suburb` varchar(191) DEFAULT NULL,
  `customers_city` varchar(191) NOT NULL,
  `customers_postcode` varchar(191) NOT NULL,
  `customers_state` varchar(191) DEFAULT NULL,
  `customers_country` varchar(191) NOT NULL,
  `customers_telephone` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `customers_address_format_id` int(11) DEFAULT NULL,
  `delivery_name` varchar(191) NOT NULL,
  `delivery_company` varchar(191) DEFAULT NULL,
  `delivery_street_address` varchar(191) NOT NULL,
  `delivery_suburb` varchar(191) DEFAULT NULL,
  `delivery_city` varchar(191) NOT NULL,
  `delivery_postcode` varchar(191) NOT NULL,
  `delivery_state` varchar(191) DEFAULT NULL,
  `delivery_country` varchar(191) NOT NULL,
  `delivery_address_format_id` int(11) DEFAULT NULL,
  `billing_name` varchar(191) NOT NULL,
  `billing_company` varchar(191) DEFAULT NULL,
  `billing_street_address` varchar(191) NOT NULL,
  `billing_suburb` varchar(191) DEFAULT NULL,
  `billing_city` varchar(191) NOT NULL,
  `billing_postcode` varchar(191) NOT NULL,
  `billing_state` varchar(191) DEFAULT NULL,
  `billing_country` varchar(191) NOT NULL,
  `billing_address_format_id` int(11) NOT NULL,
  `payment_method` varchar(191) DEFAULT NULL,
  `cc_type` varchar(20) DEFAULT NULL,
  `cc_owner` varchar(191) DEFAULT NULL,
  `cc_number` varchar(32) DEFAULT NULL,
  `cc_expires` varchar(4) DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_purchased` datetime DEFAULT NULL,
  `orders_date_finished` datetime DEFAULT NULL,
  `currency` char(3) DEFAULT NULL,
  `currency_value` decimal(14,6) DEFAULT NULL,
  `order_price` decimal(10,2) NOT NULL,
  `shipping_cost` decimal(10,2) NOT NULL,
  `shipping_method` varchar(100) NOT NULL,
  `shipping_duration` int(11) DEFAULT NULL,
  `order_information` text NOT NULL,
  `is_seen` tinyint(1) NOT NULL DEFAULT 0,
  `coupon_code` text NOT NULL,
  `coupon_amount` int(11) NOT NULL,
  `exclude_product_ids` varchar(191) NOT NULL,
  `product_categories` varchar(191) NOT NULL,
  `excluded_product_categories` varchar(191) NOT NULL,
  `free_shipping` tinyint(1) NOT NULL DEFAULT 0,
  `product_ids` varchar(191) NOT NULL,
  `ordered_source` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1: Website, 2: App',
  `delivery_phone` varchar(30) NOT NULL,
  `billing_phone` varchar(30) NOT NULL,
  `transaction_id` text DEFAULT NULL,
  `transaction_status` varchar(255) DEFAULT NULL,
  `payment_details` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orders_id`, `total_tax`, `customers_id`, `customers_name`, `customers_company`, `customers_street_address`, `customers_suburb`, `customers_city`, `customers_postcode`, `customers_state`, `customers_country`, `customers_telephone`, `email`, `customers_address_format_id`, `delivery_name`, `delivery_company`, `delivery_street_address`, `delivery_suburb`, `delivery_city`, `delivery_postcode`, `delivery_state`, `delivery_country`, `delivery_address_format_id`, `billing_name`, `billing_company`, `billing_street_address`, `billing_suburb`, `billing_city`, `billing_postcode`, `billing_state`, `billing_country`, `billing_address_format_id`, `payment_method`, `cc_type`, `cc_owner`, `cc_number`, `cc_expires`, `last_modified`, `date_purchased`, `orders_date_finished`, `currency`, `currency_value`, `order_price`, `shipping_cost`, `shipping_method`, `shipping_duration`, `order_information`, `is_seen`, `coupon_code`, `coupon_amount`, `exclude_product_ids`, `product_categories`, `excluded_product_categories`, `free_shipping`, `product_ids`, `ordered_source`, `delivery_phone`, `billing_phone`, `transaction_id`, `transaction_status`, `payment_details`, `created_at`, `updated_at`) VALUES
(56, '0.00', 25, 'Adrik Das', NULL, 'House 80-111, Road 9/A, Flat - A5, Protik Korobi, West Dhanmondi, Dhaka.', '', 'Dhaka, Bangladesh', '1215', 'other', 'Bangladesh', '', 'adrikdasukto@gmail.com', NULL, 'Adrik Das', NULL, 'House 80-111, Road 9/A, Flat - A5, Protik Korobi, West Dhanmondi, Dhaka.', '', 'Dhaka, Bangladesh', '1215', 'other', 'Bangladesh', NULL, 'Adrik Das', NULL, 'House 80-111, Road 9/A, Flat - A5, Protik Korobi, West Dhanmondi, Dhaka.', '', 'Dhaka, Bangladesh', '1215', 'other', 'Bangladesh', 0, 'SSLCOMMERZ', '', '', '', '', '2022-01-17 18:09:06', '2022-01-17 18:09:06', NULL, 'BDT', NULL, '950.00', '0.00', 'Shipping By Weight', NULL, '\"\"', 1, '', 0, '', '', '', 0, '', 1, '+8801974655007', '+8801974655007', '61e5b0c7c8662', 'Completed', '{\"tran_id\":\"61e5b0c7c8662\",\"val_id\":\"22011800952Pp1TUwynzslNpam\",\"amount\":\"950.00\",\"card_type\":\"BKASH-BKash\",\"store_amount\":\"926.25\",\"card_no\":\"\",\"bank_tran_id\":\"2201180095200663t36rf0dRlh\",\"status\":\"VALID\",\"tran_date\":\"2022-01-18 00:09:12\",\"currency\":\"BDT\",\"card_issuer\":\"BKash Mobile Banking\",\"card_brand\":\"MOBILEBANKING\",\"card_issuer_country\":\"Bangladesh\",\"card_issuer_country_code\":\"BD\",\"store_id\":\"prote5f65b04074cd6\",\"verify_sign\":\"d4da1bb3890038fdd7e5bcc3c5d35623\",\"verify_key\":\"amount,bank_tran_id,base_fair,card_brand,card_issuer,card_issuer_country,card_issuer_country_code,card_no,card_type,currency,currency_amount,currency_rate,currency_type,risk_level,risk_title,status,store_amount,store_id,tran_date,tran_id,val_id,value_a,value_b,value_c,value_d\",\"verify_sign_sha2\":\"af9636e6666db699a3d70aaf7ad296d25f09a0c675e5d448ec5b028ff3d0308a\",\"currency_type\":\"BDT\",\"currency_amount\":\"950.00\",\"currency_rate\":\"1.0000\",\"base_fair\":\"0.00\",\"value_a\":\"\",\"value_b\":\"\",\"value_c\":\"\",\"value_d\":\"\",\"risk_level\":\"0\",\"risk_title\":\"Safe\"}', NULL, '2022-01-17 23:09:11'),
(57, '0.00', 27, 'Uttam Das das', NULL, '43R/5 Cns Tower West Panthapath', '', 'Dhaka', '1215', 'other', 'Bangladesh', '', 'uttamiub@gmail.com', NULL, 'Uttam Das das', NULL, '43R/5 Cns Tower West Panthapath', '', 'Dhaka', '1215', 'other', 'Bangladesh', NULL, 'Uttam Das das', NULL, '43R/5 Cns Tower West Panthapath', '', 'Dhaka', '1215', 'other', 'Bangladesh', 0, 'SSLCOMMERZ', '', '', '', '', '2022-03-23 12:24:41', '2022-03-23 12:24:41', NULL, 'BDT', NULL, '210.00', '60.00', 'flateRate', NULL, '\"\"', 1, '', 0, '', '', '', 0, '', 1, '01819073466', '01819073466', '623b118ea5712', 'Completed', '{\"tran_id\":\"623b118ea5712\",\"val_id\":\"220323182508oUBPQtd1scO8oBa\",\"amount\":\"210.00\",\"card_type\":\"VISA-Dutch Bangla\",\"store_amount\":\"204.75\",\"card_no\":\"418117XXXXXX7814\",\"bank_tran_id\":\"2203231825080fcO1ugpyYDrsJV\",\"status\":\"VALID\",\"tran_date\":\"2022-03-23 18:24:47\",\"currency\":\"BDT\",\"card_issuer\":\"TRUST BANK, LTD.\",\"card_brand\":\"VISA\",\"card_issuer_country\":\"Bangladesh\",\"card_issuer_country_code\":\"BD\",\"store_id\":\"prote5f65b04074cd6\",\"verify_sign\":\"38c33e88b670ffb3828de731ccf07e91\",\"verify_key\":\"amount,bank_tran_id,base_fair,card_brand,card_issuer,card_issuer_country,card_issuer_country_code,card_no,card_type,currency,currency_amount,currency_rate,currency_type,risk_level,risk_title,status,store_amount,store_id,tran_date,tran_id,val_id,value_a,value_b,value_c,value_d\",\"verify_sign_sha2\":\"d14f5c8f4dd160448ac5b12c708009d7d7dd8b89c3e53c5a5fa6db28d248f3a7\",\"currency_type\":\"BDT\",\"currency_amount\":\"210.00\",\"currency_rate\":\"1.0000\",\"base_fair\":\"0.00\",\"value_a\":\"\",\"value_b\":\"\",\"value_c\":\"\",\"value_d\":\"\",\"risk_level\":\"0\",\"risk_title\":\"Safe\"}', NULL, '2022-03-23 16:24:46');

-- --------------------------------------------------------

--
-- Table structure for table `orders_products`
--

CREATE TABLE `orders_products` (
  `orders_products_id` int(11) NOT NULL,
  `orders_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_model` varchar(12) DEFAULT NULL,
  `products_name` varchar(64) NOT NULL,
  `products_price` decimal(15,2) NOT NULL,
  `final_price` decimal(15,2) NOT NULL,
  `products_tax` decimal(7,0) NOT NULL,
  `products_quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders_products`
--

INSERT INTO `orders_products` (`orders_products_id`, `orders_id`, `products_id`, `products_model`, `products_name`, `products_price`, `final_price`, `products_tax`, `products_quantity`) VALUES
(100, 56, 47, NULL, 'Leather Belt  05', '950.00', '950.00', '1', 1),
(101, 57, 36, NULL, 'KN 95 Mask', '150.00', '150.00', '1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders_products_attributes`
--

CREATE TABLE `orders_products_attributes` (
  `orders_products_attributes_id` int(11) NOT NULL,
  `orders_id` int(11) NOT NULL,
  `orders_products_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `products_options` varchar(32) NOT NULL,
  `products_options_values` varchar(32) NOT NULL,
  `options_values_price` decimal(15,2) NOT NULL,
  `price_prefix` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders_products_attributes`
--

INSERT INTO `orders_products_attributes` (`orders_products_attributes_id`, `orders_id`, `orders_products_id`, `products_id`, `products_options`, `products_options_values`, `options_values_price`, `price_prefix`) VALUES
(1, 49, 94, 4, 'Color', 'Red', '0.00', '+');

-- --------------------------------------------------------

--
-- Table structure for table `orders_status`
--

CREATE TABLE `orders_status` (
  `orders_status_id` int(11) NOT NULL,
  `public_flag` int(11) DEFAULT 0,
  `downloads_flag` int(11) DEFAULT 0,
  `role_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders_status`
--

INSERT INTO `orders_status` (`orders_status_id`, `public_flag`, `downloads_flag`, `role_id`) VALUES
(1, 0, 0, 2),
(2, 0, 0, 2),
(3, 0, 0, 2),
(4, 0, 0, 2),
(5, 0, 0, 2);

-- --------------------------------------------------------

--
-- Table structure for table `orders_status_description`
--

CREATE TABLE `orders_status_description` (
  `orders_status_description_id` int(11) NOT NULL,
  `orders_status_id` int(11) NOT NULL,
  `orders_status_name` varchar(191) NOT NULL,
  `language_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders_status_description`
--

INSERT INTO `orders_status_description` (`orders_status_description_id`, `orders_status_id`, `orders_status_name`, `language_id`) VALUES
(1, 1, 'Pending', 1),
(2, 2, 'Completed', 1),
(3, 3, 'Cancel', 1),
(4, 4, 'Return', 1),
(5, 5, 'Confirm', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders_status_history`
--

CREATE TABLE `orders_status_history` (
  `orders_status_history_id` int(11) NOT NULL,
  `orders_id` int(11) NOT NULL,
  `orders_status_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL,
  `customer_notified` int(11) DEFAULT 0,
  `comments` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders_status_history`
--

INSERT INTO `orders_status_history` (`orders_status_history_id`, `orders_id`, `orders_status_id`, `date_added`, `customer_notified`, `comments`) VALUES
(5, 5, 1, '2020-09-27 06:20:36', 1, ''),
(6, 6, 1, '2020-09-28 04:24:25', 1, NULL),
(7, 7, 1, '2020-09-28 04:37:27', 1, ''),
(8, 8, 1, '2020-09-28 06:35:23', 1, ''),
(9, 9, 1, '2020-09-29 04:40:04', 1, ''),
(10, 10, 1, '2020-09-29 08:05:08', 1, NULL),
(11, 11, 1, '2020-09-29 08:07:17', 1, NULL),
(12, 12, 1, '2020-09-29 08:08:49', 1, NULL),
(13, 13, 1, '2020-09-29 08:11:29', 1, NULL),
(14, 1, 1, '2020-09-29 08:20:58', 1, NULL),
(15, 2, 1, '2020-09-29 08:27:21', 1, NULL),
(16, 3, 1, '2020-09-29 08:28:15', 1, NULL),
(17, 4, 1, '2020-09-29 08:30:25', 1, NULL),
(18, 5, 1, '2020-09-29 08:31:22', 1, NULL),
(19, 1, 1, '2020-09-29 08:46:45', 1, NULL),
(20, 2, 1, '2020-09-29 08:47:55', 1, NULL),
(21, 3, 1, '2020-09-29 08:53:10', 1, NULL),
(22, 4, 1, '2020-09-29 08:55:12', 1, NULL),
(23, 5, 1, '2020-09-29 08:58:22', 1, NULL),
(24, 6, 1, '2020-09-29 09:00:21', 1, NULL),
(25, 7, 1, '2020-09-29 09:03:23', 1, NULL),
(26, 8, 1, '2020-09-29 09:14:06', 1, NULL),
(27, 9, 1, '2020-09-29 09:15:35', 1, NULL),
(28, 10, 1, '2020-09-29 09:19:38', 1, NULL),
(29, 11, 1, '2020-09-29 09:20:48', 1, NULL),
(30, 12, 1, '2020-09-29 09:23:16', 1, NULL),
(31, 13, 1, '2020-09-29 09:23:22', 1, NULL),
(32, 14, 1, '2020-09-29 09:25:34', 1, NULL),
(33, 15, 1, '2020-09-29 09:28:09', 1, NULL),
(34, 16, 1, '2020-09-29 09:29:04', 1, NULL),
(35, 17, 1, '2020-09-29 09:33:08', 1, NULL),
(36, 1, 1, '2020-09-29 09:35:40', 1, NULL),
(37, 2, 1, '2020-09-29 09:37:11', 1, NULL),
(38, 3, 1, '2020-09-29 09:38:27', 1, NULL),
(39, 4, 1, '2020-09-29 10:23:53', 1, NULL),
(40, 5, 1, '2020-09-29 10:25:12', 1, NULL),
(41, 6, 1, '2020-09-29 10:52:58', 1, NULL),
(42, 7, 1, '2020-09-29 10:56:09', 1, NULL),
(43, 8, 1, '2020-09-29 10:57:50', 1, NULL),
(44, 9, 1, '2020-09-29 10:59:13', 1, NULL),
(45, 10, 1, '2020-09-29 11:05:57', 1, NULL),
(46, 11, 1, '2020-09-29 11:32:33', 1, NULL),
(47, 12, 1, '2020-09-29 11:36:04', 1, NULL),
(48, 13, 1, '2020-09-29 11:37:51', 1, NULL),
(49, 14, 1, '2020-09-29 11:53:21', 1, NULL),
(50, 15, 1, '2020-09-29 11:54:08', 1, NULL),
(51, 16, 1, '2020-09-29 11:56:40', 1, NULL),
(52, 17, 1, '2020-09-29 12:17:38', 1, NULL),
(53, 18, 1, '2020-09-29 12:27:09', 1, NULL),
(54, 19, 1, '2020-09-30 04:48:34', 1, NULL),
(55, 20, 1, '2020-10-01 10:23:34', 1, NULL),
(56, 21, 1, '2020-10-01 01:21:15', 1, NULL),
(57, 22, 1, '2020-10-04 07:25:17', 1, NULL),
(58, 23, 1, '2020-10-04 02:06:10', 1, NULL),
(59, 24, 1, '2020-10-05 08:02:12', 1, NULL),
(60, 25, 1, '2020-10-13 07:19:06', 1, ''),
(61, 26, 1, '2020-10-14 08:47:20', 1, ''),
(62, 25, 3, '2020-10-14 09:30:02', 1, NULL),
(63, 26, 2, '2020-10-14 01:13:43', 1, NULL),
(64, 27, 1, '2020-10-20 09:43:46', 1, NULL),
(65, 28, 1, '2020-10-20 09:51:06', 1, NULL),
(66, 29, 1, '2020-10-20 10:37:14', 1, NULL),
(67, 30, 1, '2020-11-02 05:16:35', 1, NULL),
(68, 30, 3, '2020-11-03 05:01:30', 1, NULL),
(69, 31, 1, '2020-11-09 08:51:01', 1, ''),
(70, 31, 5, '2020-11-09 08:52:04', 1, NULL),
(71, 31, 2, '2020-11-09 08:53:21', 1, NULL),
(72, 32, 1, '2020-11-09 09:31:40', 1, ''),
(73, 33, 1, '2020-11-09 11:07:04', 1, ''),
(74, 34, 1, '2020-11-09 11:17:41', 1, ''),
(75, 31, 3, '2020-11-10 09:37:57', 1, NULL),
(76, 32, 3, '2020-11-10 09:38:10', 1, NULL),
(77, 33, 3, '2020-11-10 09:38:22', 1, NULL),
(78, 34, 3, '2020-11-10 09:39:34', 1, NULL),
(79, 35, 1, '2020-11-18 05:12:45', 1, NULL),
(80, 36, 1, '2020-11-18 05:13:20', 1, NULL),
(81, 37, 1, '2020-11-19 05:14:17', 1, NULL),
(82, 38, 1, '2020-11-19 05:16:30', 1, NULL),
(83, 35, 3, '2020-12-09 10:16:28', 1, NULL),
(84, 36, 3, '2020-12-09 10:16:50', 1, NULL),
(85, 37, 3, '2020-12-09 10:17:15', 1, NULL),
(86, 38, 3, '2020-12-09 10:17:28', 1, NULL),
(87, 39, 1, '2020-12-13 08:54:23', 1, ''),
(88, 39, 3, '2020-12-13 09:02:34', 1, ''),
(89, 40, 1, '2020-12-13 09:28:20', 1, ''),
(90, 41, 1, '2020-12-13 09:29:10', 1, ''),
(91, 40, 3, '2020-12-14 04:30:19', 1, NULL),
(92, 41, 3, '2020-12-14 04:30:43', 1, NULL),
(93, 42, 1, '2020-12-24 05:48:19', 1, ''),
(94, 43, 1, '2020-12-24 06:06:41', 1, ''),
(95, 44, 1, '2020-12-24 06:10:23', 1, ''),
(96, 45, 1, '2020-12-24 06:15:00', 1, ''),
(97, 46, 1, '2020-12-24 06:16:28', 1, ''),
(98, 47, 1, '2021-02-03 07:31:39', 1, NULL),
(99, 48, 1, '2021-08-18 04:06:57', 1, ''),
(100, 49, 1, '2021-08-23 04:25:47', 1, ''),
(101, 50, 1, '2021-08-28 08:36:07', 1, ''),
(102, 48, 5, '2021-09-14 11:37:25', 1, NULL),
(103, 49, 3, '2021-09-14 11:37:42', 1, NULL),
(104, 50, 3, '2021-09-14 11:38:06', 1, 'Out of stock'),
(105, 51, 1, '2022-01-02 09:05:47', 1, ''),
(106, 52, 1, '2022-01-02 09:06:22', 1, ''),
(107, 52, 5, '2022-01-02 09:55:45', 1, NULL),
(108, 53, 1, '2022-01-02 12:57:43', 1, ''),
(109, 51, 5, '2022-01-06 11:48:59', 1, 'jhgf'),
(110, 54, 1, '2022-01-10 11:42:14', 1, ''),
(111, 55, 1, '2022-01-13 05:41:29', 1, ''),
(112, 56, 1, '2022-01-17 06:09:06', 1, ''),
(113, 57, 1, '2022-03-23 12:24:41', 1, ''),
(114, 56, 3, '2022-11-03 07:15:21', 1, NULL),
(115, 57, 3, '2022-11-03 07:15:42', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `orders_total`
--

CREATE TABLE `orders_total` (
  `orders_total_id` int(10) UNSIGNED NOT NULL,
  `orders_id` int(11) NOT NULL,
  `title` varchar(191) NOT NULL,
  `text` varchar(191) NOT NULL,
  `value` decimal(15,4) NOT NULL,
  `class` varchar(32) NOT NULL,
  `sort_order` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `page_id` int(11) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `type` tinyint(1) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`page_id`, `slug`, `status`, `type`) VALUES
(1, 'privacy-policy', 1, 1),
(2, 'term-services', 1, 1),
(3, 'refund-policy', 1, 1),
(4, 'about-us', 1, 1),
(5, 'privacy-policy', 1, 2),
(6, 'term-services', 1, 2),
(7, 'refund-policy', 1, 2),
(8, 'about-us', 1, 2),
(9, 'ssssss', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `pages_description`
--

CREATE TABLE `pages_description` (
  `page_description_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `language_id` int(11) NOT NULL,
  `page_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages_description`
--

INSERT INTO `pages_description` (`page_description_id`, `name`, `description`, `language_id`, `page_id`) VALUES
(1, 'Privacy Policy', '<div class=\"col-md-12 \">\r\n\r\n                    Priyojon Healthcare Ltd. (\"Priyojon\", \"Company\", \"We\", \"Our\" or \"Us\") is the owner of www.Priyojon.care and the Priyojon mobile application (the URLs and mobile application together referred to as \"Websites\" and individually a \"Website\"). The terms \'You\' or \'Your\' refer to You as the user (whether You are a Registered User, Unregistered user or an HCP) of the Website or of the services offered by the Website (\"Service\").\r\nPriyojon is committed to Your privacy. This privacy policy (\"Privacy Policy\") applies to the collection, use, storage, processing, disclosure and transfer of Your Information (defined below) when You use the Website and/or the Services.\r\n<br>\r\n1. CONSENT\r\n<br>\r\n1.1. By clicking on the \"I accept\' button at the end of page containing the Terms of Use or by providing us Your Personal Information or by making use of the features provided by the Website, You hereby consent to the collection, storage, processing, disclosure and transfer of Your Information in accordance with the provisions of this Privacy Policy.\r\n<br>\r\n1.2. You acknowledge that You are providing Your Personal Information out of Your free will.\r\n<br>\r\n1.3. You have the option not to provide us the Personal Information sought to be collected. You will also have an option to withdraw Your consent at any point, provided such withdrawal of consent is intimated to us in writing at hello@priyojon.care. If You do not provide us Your Personal Information or if You withdraw the consent at any point in time, We shall have the option not to fulfill the purposes for which the said Personal Information was sought and we may restrict You from using the Website.\r\n<br>\r\n2. CHANGES TO THE PRIVACY POLICY\r\n<br>\r\n2.1. We may update this Privacy Policy from time to time. There is a tab at the end of the Privacy Policy which indicates when the Privacy Policy was last updated.\r\n<br>\r\n2.2. When We update Our Privacy Policy, the next time You visit the Website, the Website will provide a message which will intimate You of the amendments to the Privacy Policy. You will be required to provide Your consent to the amendments before You proceed. If You do not agree to the amendments, please do not use the Website any further.\r\n<br>\r\n3. WHAT PERSONAL INFORMATION IS COLLECTED FROM YOU?\r\n<br>\r\n3.1. The kinds of information that We collect about You include Personal Information and Non-Personal Information. Personal Information and Non-Personal Information are collectively referred to as \"Information\".\r\n<br>\r\n3.2. Personal Information is data collected that can be used to uniquely identify or contact You. Personal Information for the purposes of this Privacy Policy shall include, but not be limited to:\r\n(i) Name,\r\n(ii) Birth date,\r\n(iii) Email address,\r\n(iv) Gender\r\n(v) financial information such as Bank account or credit card or debit card or other payment instrument details;\r\n(vi) physical, physiological and mental health condition;\r\n(vii) sexual orientation;\r\n(viii) medical records and history\r\n(ix) Login ID and password,\r\n(x) Location,\r\n<br>\r\n3.3. We may also seek permissions to use camera, microphone, and phonebook/contact data at points where required.\r\n<br>\r\n3.4. We may also collect information other than Personal Information from You through the Website when You visit and /or use the Website. Such information may be stored in server logs. Such Non-Personal Information would not assist us to identify You personally. Such Non-Personal Information may include\r\n(i) Your usage details such as time, frequency, duration and pattern of use, features used and the amount of storage used,\r\n(ii) Master and transaction data and other data stored in Your user account,\r\n(iii) Internet Protocol address, browser type, browser language, referring URL, files accessed, errors generated, time zone, operating system and other visitor details collected in Our log files,\r\n<br>\r\n4. HOW WE COLLECT INFORMATION?\r\nThe methods by which We collect Your Information include but are not limited to the following:\r\n(i) When You register on Our Website,\r\n(ii) When You create a profile on Our Website or as part of Services\r\n(iii) When You provide Your Information to us,\r\n(iv) When You use the features on Our Website and/or when You use Services,\r\n(v) When You access Website or Services,\r\n(vi) By use of cookies (discussed below).\r\n<br>\r\n5. HOW THE INFORMATION COLLECTED IS USED?\r\nWe collect Your Information for various purposes, including the following:\r\n(i) In order to enable You to use the Website and utilize the Services. For instance, You may provide Your health related information on the Website in order to consult privately with an HCP, or You may provide Your financial information in order to process a payment which You need to make on the Website.\r\n(ii) to respond to Your inquiries;\r\n(iii) to provide You with information about products and services available on the Website;\r\n(iv) to personalize Your experience on the Website;\r\n(v) to help You address Your problems incurred on the Website including addressing any technical problems;\r\n(vi) for proper administering of the Website;\r\n(vii) to conduct internal reviews and data analysis for the Website (e.g., to determine the number of visitors to specific pages within the Website);\r\n(viii) to improve the services, content and advertising on the Website;\r\n(ix) to protect the integrity of the Website; and\r\n(x) to respond to judicial process and provide information to law enforcement agencies or in connection with an investigation on matters related to public safety, as permitted by law.\r\n(xi) to conduct analytical studies on various aspects including user behaviour, user preferences etc.\r\n(xii) to make disclosures as may be required under applicable law.\r\n(above uses collectively referred to as \"Purpose(s)\")\r\n<br>\r\n6. HOW INFORMATION MAY BE SHARED AND TRANSFERRED?\r\n<br>\r\n6.1. We may exchange, transfer, share, part with all or any of Your Information, across borders and from Your country to any other countries across the world with Our affiliates / agents / third party service providers / partners / banks and financial institutions for the Purposes specified under this privacy Policy or as may be required by applicable law or in case of sale, acquisition, merger or bankruptcy involving Priyojon.\r\n<br>\r\n6.2. You acknowledge that some countries where We may transfer Your Information may not have data protection laws which are as stringent as the laws of Your own country.\r\n<br>\r\n6.3. You acknowledge that it is adequate that when Priyojon transfers Your Information to any other entity within or outside Your country of residence, Priyojon will place contractual obligations on the transferee which will oblige the transferee to adhere to the provisions of this Privacy Policy.\r\n<br>\r\n7. HOW WE PROTECT YOUR INFORMATION?\r\n<br>\r\n7.1. The security of Your Personal Information is important to us. We have adopted reasonable security practices and procedure to ensure that the Personal Information (protected health information) collected is secure. You agree that such measures are secured and adequate. We restrict access to Your Personal Information to Our and Our affiliates\' employees, agents, third party service providers, partners, and agencies who need to know such Personal Information in relation to the Purposes as specified above in this Privacy Policy and provided that such entities agree to abide by this Privacy Policy.\r\n<br>\r\n7.2. While We will endeavor to take all reasonable and appropriate steps to keep secure any information which We hold about You and prevent unauthorized access, You acknowledge that the internet is not 100% secure and that We cannot provide any absolute assurance regarding the security of Your Personal Information. We nor any of the HCP on Priyojon will not be liable in any way in relation to any breach of security or unintended loss or disclosure of information caused by Us in relation to Your Personal Information.\r\n<br>\r\n8. COOKIES\r\nWe may store temporary or permanent \'cookies\' on Your computer. A cookie is a small piece of data that is sent to Your browser from a web server and stored on Your computer\'s hard drive. A cookie cannot read data off Your hard disk or read cookie files created by other sites. Once You close Your browser, the cookie simply terminates. For instance, by setting a cookie on Your browser, You would not have to log in a password more than once, thereby saving time while on the Websites. You can choose whether to accept cookies by changing the settings of Your browser. You can reset Your browser to refuse all cookies or allow Your browser to show You when a cookie is being sent. If You reject the cookies on the websites, You may still be able to use the Websites, but it shall be limited to certain minimal functionality. The only drawback to this is that You may be limited only to some areas of the Websites or limited to certain functions of the Websites. Some of Our business partners may use cookies on the Websites. Please note that We have no access to or control over such cookies. Priyojon and Our business partners may use cookies to better personalize the content, banners, and promotions that You see on the Websites.\r\n<br>\r\n9. LINKS\r\nThe Websites may contain links to other third party sites. The third party sites are not under the control of Priyojon. Please note that Priyojon is not responsible for the privacy practices of such third party sites. Priyojon encourages You to be aware when You leave the Websites and to read the privacy policies of each and every third party site that collects personal information. If You decide to access any of the third-party sites linked to the Websites, You do this entirely at Your own risk. Any links to any partner of the Websites is the responsibility of the linking party, and Priyojon shall not be responsible for notification of any change in name or location of any information on the Websites.\r\n<br>\r\n10. CORRECTING INACCURACIES OR UPDATING PERSONAL INFORMATION\r\nIf Your Personal Information changes, or if You need to update or correct Your Personal Information or have any grievance with respect to the processing or use of Your Personal Information, for any reason, You may send updates and corrections to us at hello@priyojon.care and We will take all reasonable efforts to incorporate the changes within a reasonable period of time. If Your Personal Information is stored as part of Your profile on the Website, You can update Your profile on the profile pages of the Websites.\r\nYou are not allowed to use the Website or the Services of the Website if any of the terms of this Privacy Policy are not in accordance with the applicable laws of Your country.\r\n<br>\r\n11. COMPLIANCE WITH LAWS\r\nYou are not allowed to use the Website or the Services of the Website if any of the terms of this Privacy Policy are not in accordance with the applicable laws of Your country.\r\n<br>\r\n12. GRIEVANCE OFFICER\r\nWe have appointed a Grievance Officer to address any concerns or grievances that You may have regarding the processing of Your Personal Information. If You have any such grievances, please write to Our Grievance Officer at grievances@priyojon.care and Our officer will attempt to resolve Your issues in a timely manner.\r\nPriyojon reserves the right, in its sole discretion, to change, modify, add or delete portions of the terms of this Privacy Policy at any time.\r\n\r\n                </div>', 1, 1),
(4, 'Term & Services', '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy</p>\r\n\r\n<p>text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen</p>\r\n\r\n<p>book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially</p>\r\n\r\n<p>unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,</p>\r\n\r\n<p>and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem</p>\r\n\r\n<p>Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard</p>\r\n\r\n<p>dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type</p>\r\n\r\n<p>specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining</p>\r\n\r\n<p>essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum</p>\r\n\r\n<p>passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem</p>\r\n\r\n<p>Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s</p>\r\n\r\n<p>standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make</p>\r\n\r\n<p>a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,</p>\r\n\r\n<p>remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing</p>\r\n\r\n<p>Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions</p>\r\n\r\n<p>of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been</p>\r\n\r\n<p>the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled</p>\r\n\r\n<p>it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,</p>\r\n\r\n<p>remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing</p>\r\n\r\n<p>Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions</p>\r\n\r\n<p>of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been</p>\r\n\r\n<p>the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled</p>\r\n\r\n<p>it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,</p>\r\n\r\n<p>remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing</p>\r\n\r\n<p>Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions</p>\r\n\r\n<p>of Lorem Ipsum.</p>', 1, 2),
(7, 'Refund Policy', '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy</p>\r\n\r\n<p>text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen</p>\r\n\r\n<p>book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially</p>\r\n\r\n<p>unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,</p>\r\n\r\n<p>and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem</p>\r\n\r\n<p>Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard</p>\r\n\r\n<p>dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type</p>\r\n\r\n<p>specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining</p>\r\n\r\n<p>essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum</p>\r\n\r\n<p>passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem</p>\r\n\r\n<p>Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s</p>\r\n\r\n<p>standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make</p>\r\n\r\n<p>a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,</p>\r\n\r\n<p>remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing</p>\r\n\r\n<p>Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions</p>\r\n\r\n<p>of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been</p>\r\n\r\n<p>the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled</p>\r\n\r\n<p>it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,</p>\r\n\r\n<p>remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing</p>\r\n\r\n<p>Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions</p>\r\n\r\n<p>of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been</p>\r\n\r\n<p>the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled</p>\r\n\r\n<p>it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,</p>\r\n\r\n<p>remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing</p>\r\n\r\n<p>Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions</p>\r\n\r\n<p>of Lorem Ipsum.</p>', 1, 3),
(10, 'About Us', '<h2><strong>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</strong></h2>\r\n\r\n<p>Cras non justo sed nulla finibus pulvinar sit amet et neque. Duis et odio vitae orci mattis gravida. Nullam vel tincidunt ex. Praesent vel neque egestas arcu feugiat venenatis. Donec eget dolor quis justo tempus mattis. Phasellus dictum nunc ut dapibus dictum. Etiam vel leo nulla. Ut eu mi hendrerit, eleifend lacus sed, dictum neque.</p>\r\n\r\n<p>Aliquam non convallis nibh. Donec luctus purus magna, et commodo urna fermentum sed. Cras vel ex blandit, pretium nulla id, efficitur massa. Suspendisse potenti. Maecenas vel vehicula velit. Etiam quis orci molestie, elementum nisl eget, ultricies felis. Ut condimentum quam ut mi scelerisque accumsan. Suspendisse potenti. Etiam orci purus, iaculis sit amet ornare sit amet, finibus sed ligula. Quisque et mollis libero, sit amet consectetur augue. Vestibulum posuere pellentesque enim, in facilisis diam dictum eget. Phasellus sed vestibulum urna, in aliquet felis. Vivamus quis lacus id est ornare faucibus at id nulla.</p>\r\n\r\n<h2>Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.</h2>\r\n\r\n<p>Nulla justo lectus, sollicitudin at lorem eu, sollicitudin molestie augue. Maecenas egestas facilisis dolor mattis feugiat. Donec sed orci tellus. Maecenas tortor ipsum, varius vel dolor nec, bibendum porttitor felis. Mauris rutrum tristique vehicula. Sed ullamcorper nisl non erat pharetra, sit amet mattis enim posuere. Nulla convallis fringilla tortor, at vestibulum mauris cursus eget. Ut semper sollicitudin odio, sed molestie libero luctus quis. Integer viverra rutrum diam non maximus. Maecenas pellentesque tortor et sapien fermentum laoreet non et est. Phasellus felis quam, laoreet rhoncus erat eget, tempor condimentum massa. Integer gravida turpis id suscipit bibendum. Phasellus pellentesque venenatis erat, ut maximus justo vulputate sed. Vestibulum maximus enim ligula, non suscipit lectus dignissim vel. Suspendisse eleifend lorem egestas, tristique ligula id, condimentum est.</p>\r\n\r\n<p>Mauris nulla nulla, laoreet at auctor quis, bibendum rutrum neque. Donec eu ligula mi. Nam cursus vulputate semper. Phasellus facilisis mollis tellus, interdum laoreet justo rutrum pulvinar. Praesent molestie, nibh sed ultrices porttitor, nulla tortor volutpat enim, quis auctor est sem et orci. Proin lacinia vestibulum ex ut convallis. Phasellus tempus odio purus.</p>\r\n\r\n<ul>\r\n<li>Nam lacinia urna eu arcu auctor, eget euismod metus sagittis.</li>\r\n<li>Etiam eleifend ex eu interdum varius.</li>\r\n<li>Nunc dapibus purus eu felis tincidunt, vel rhoncus erat tristique.</li>\r\n<li>Aenean nec augue sit amet lorem blandit ultrices.</li>\r\n<li>Nullam at lacus eleifend, pulvinar velit tempor, auctor nisi.</li>\r\n</ul>\r\n\r\n<p>Nunc accumsan tincidunt augue sed blandit. Duis et dignissim nisi. Phasellus sed ligula velit. Etiam rhoncus aliquet magna, nec volutpat nulla imperdiet et. Nunc vel tincidunt magna. Vestibulum lacinia odio a metus placerat maximus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam et faucibus neque. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Aenean et metus malesuada, ullamcorper dui vel, convallis est. Donec congue libero sed turpis porta consequat. Suspendisse potenti. Aliquam pharetra nibh in magna iaculis, non elementum ipsum luctus.</p>\r\n\r\n<p>&nbsp;</p>', 1, 4),
(13, 'Privacy Policy', '<div class=\"col-md-12 \">\r\n\r\n                    KNOPROTEC Ltd. (\"KNOPROTEC\", \"Company\", \"We\", \"Our\" or \"Us\") is the owner of www.KNOPROTEC.com and the KNOPROTEC mobile application (the URLs and mobile application together referred to as \"Websites\" and individually a \"Website\"). The terms \'You\' or \'Your\' refer to You as the user (whether You are a Registered User, Unregistered user or an HCP) of the Website or of the services offered by the Website (\"Service\").\r\nKNOPROTEC is committed to Your privacy. This privacy policy (\"Privacy Policy\") applies to the collection, use, storage, processing, disclosure and transfer of Your Information (defined below) when You use the Website and/or the Services.\r\n<br>\r\n1. CONSENT\r\n<br>\r\n1.1. By clicking on the \"I accept\' button at the end of page containing the Terms of Use or by providing us Your Personal Information or by making use of the features provided by the Website, You hereby consent to the collection, storage, processing, disclosure and transfer of Your Information in accordance with the provisions of this Privacy Policy.\r\n<br>\r\n1.2. You acknowledge that You are providing Your Personal Information out of Your free will.\r\n<br>\r\n1.3. You have the option not to provide us the Personal Information sought to be collected. You will also have an option to withdraw Your consent at any point, provided such withdrawal of consent is intimated to us in writing at hello@KNOPROTEC.com. If You do not provide us Your Personal Information or if You withdraw the consent at any point in time, We shall have the option not to fulfill the purposes for which the said Personal Information was sought and we may restrict You from using the Website.\r\n<br>\r\n2. CHANGES TO THE PRIVACY POLICY\r\n<br>\r\n2.1. We may update this Privacy Policy from time to time. There is a tab at the end of the Privacy Policy which indicates when the Privacy Policy was last updated.\r\n<br>\r\n2.2. When We update Our Privacy Policy, the next time You visit the Website, the Website will provide a message which will intimate You of the amendments to the Privacy Policy. You will be required to provide Your consent to the amendments before You proceed. If You do not agree to the amendments, please do not use the Website any further.\r\n<br>\r\n3. WHAT PERSONAL INFORMATION IS COLLECTED FROM YOU?\r\n<br>\r\n3.1. The kinds of information that We collect about You include Personal Information and Non-Personal Information. Personal Information and Non-Personal Information are collectively referred to as \"Information\".\r\n<br>\r\n3.2. Personal Information is data collected that can be used to uniquely identify or contact You. Personal Information for the purposes of this Privacy Policy shall include, but not be limited to:\r\n(i) Name,\r\n(ii) Birth date,\r\n(iii) Email address,\r\n(iv) Gender\r\n(v) financial information such as Bank account or credit card or debit card or other payment instrument details;\r\n(vi) physical, physiological and mental health condition;\r\n(vii) sexual orientation;\r\n(viii) medical records and history\r\n(ix) Login ID and password,\r\n(x) Location,\r\n<br>\r\n3.3. We may also seek permissions to use camera, microphone, and phonebook/contact data at points where required.\r\n<br>\r\n3.4. We may also collect information other than Personal Information from You through the Website when You visit and /or use the Website. Such information may be stored in server logs. Such Non-Personal Information would not assist us to identify You personally. Such Non-Personal Information may include\r\n(i) Your usage details such as time, frequency, duration and pattern of use, features used and the amount of storage used,\r\n(ii) Master and transaction data and other data stored in Your user account,\r\n(iii) Internet Protocol address, browser type, browser language, referring URL, files accessed, errors generated, time zone, operating system and other visitor details collected in Our log files,\r\n<br>\r\n4. HOW WE COLLECT INFORMATION?\r\nThe methods by which We collect Your Information include but are not limited to the following:\r\n(i) When You register on Our Website,\r\n(ii) When You create a profile on Our Website or as part of Services\r\n(iii) When You provide Your Information to us,\r\n(iv) When You use the features on Our Website and/or when You use Services,\r\n(v) When You access Website or Services,\r\n(vi) By use of cookies (discussed below).\r\n<br>\r\n5. HOW THE INFORMATION COLLECTED IS USED?\r\nWe collect Your Information for various purposes, including the following:\r\n(i) In order to enable You to use the Website and utilize the Services. For instance, You may provide Your health related information on the Website in order to consult privately with an HCP, or You may provide Your financial information in order to process a payment which You need to make on the Website.\r\n(ii) to respond to Your inquiries;\r\n(iii) to provide You with information about products and services available on the Website;\r\n(iv) to personalize Your experience on the Website;\r\n(v) to help You address Your problems incurred on the Website including addressing any technical problems;\r\n(vi) for proper administering of the Website;\r\n(vii) to conduct internal reviews and data analysis for the Website (e.g., to determine the number of visitors to specific pages within the Website);\r\n(viii) to improve the services, content and advertising on the Website;\r\n(ix) to protect the integrity of the Website; and\r\n(x) to respond to judicial process and provide information to law enforcement agencies or in connection with an investigation on matters related to public safety, as permitted by law.\r\n(xi) to conduct analytical studies on various aspects including user behaviour, user preferences etc.\r\n(xii) to make disclosures as may be required under applicable law.\r\n(above uses collectively referred to as \"Purpose(s)\")\r\n<br>\r\n6. HOW INFORMATION MAY BE SHARED AND TRANSFERRED?\r\n<br>\r\n6.1. We may exchange, transfer, share, part with all or any of Your Information, across borders and from Your country to any other countries across the world with Our affiliates / agents / third party service providers / partners / banks and financial institutions for the Purposes specified under this privacy Policy or as may be required by applicable law or in case of sale, acquisition, merger or bankruptcy involving KNOPROTEC.\r\n<br>\r\n6.2. You acknowledge that some countries where We may transfer Your Information may not have data protection laws which are as stringent as the laws of Your own country.\r\n<br>\r\n6.3. You acknowledge that it is adequate that when KNOPROTEC transfers Your Information to any other entity within or outside Your country of residence, KNOPROTEC will place contractual obligations on the transferee which will oblige the transferee to adhere to the provisions of this Privacy Policy.\r\n<br>\r\n7. HOW WE PROTECT YOUR INFORMATION?\r\n<br>\r\n7.1. The security of Your Personal Information is important to us. We have adopted reasonable security practices and procedure to ensure that the Personal Information (protected health information) collected is secure. You agree that such measures are secured and adequate. We restrict access to Your Personal Information to Our and Our affiliates\' employees, agents, third party service providers, partners, and agencies who need to know such Personal Information in relation to the Purposes as specified above in this Privacy Policy and provided that such entities agree to abide by this Privacy Policy.\r\n<br>\r\n7.2. While We will endeavor to take all reasonable and appropriate steps to keep secure any information which We hold about You and prevent unauthorized access, You acknowledge that the internet is not 100% secure and that We cannot provide any absolute assurance regarding the security of Your Personal Information. We nor any of the HCP on KNOPROTEC will not be liable in any way in relation to any breach of security or unintended loss or disclosure of information caused by Us in relation to Your Personal Information.\r\n<br>\r\n8. COOKIES\r\nWe may store temporary or permanent \'cookies\' on Your computer. A cookie is a small piece of data that is sent to Your browser from a web server and stored on Your computer\'s hard drive. A cookie cannot read data off Your hard disk or read cookie files created by other sites. Once You close Your browser, the cookie simply terminates. For instance, by setting a cookie on Your browser, You would not have to log in a password more than once, thereby saving time while on the Websites. You can choose whether to accept cookies by changing the settings of Your browser. You can reset Your browser to refuse all cookies or allow Your browser to show You when a cookie is being sent. If You reject the cookies on the websites, You may still be able to use the Websites, but it shall be limited to certain minimal functionality. The only drawback to this is that You may be limited only to some areas of the Websites or limited to certain functions of the Websites. Some of Our business partners may use cookies on the Websites. Please note that We have no access to or control over such cookies. KNOPROTEC and Our business partners may use cookies to better personalize the content, banners, and promotions that You see on the Websites.\r\n<br>\r\n9. LINKS\r\nThe Websites may contain links to other third party sites. The third party sites are not under the control of KNOPROTEC. Please note that KNOPROTEC is not responsible for the privacy practices of such third party sites. KNOPROTEC encourages You to be aware when You leave the Websites and to read the privacy policies of each and every third party site that collects personal information. If You decide to access any of the third-party sites linked to the Websites, You do this entirely at Your own risk. Any links to any partner of the Websites is the responsibility of the linking party, and KNOPROTEC shall not be responsible for notification of any change in name or location of any information on the Websites.\r\n<br>\r\n10. CORRECTING INACCURACIES OR UPDATING PERSONAL INFORMATION\r\nIf Your Personal Information changes, or if You need to update or correct Your Personal Information or have any grievance with respect to the processing or use of Your Personal Information, for any reason, You may send updates and corrections to us at hello@KNOPROTEC.com and We will take all reasonable efforts to incorporate the changes within a reasonable period of time. If Your Personal Information is stored as part of Your profile on the Website, You can update Your profile on the profile pages of the Websites.\r\nYou are not allowed to use the Website or the Services of the Website if any of the terms of this Privacy Policy are not in accordance with the applicable laws of Your country.\r\n<br>\r\n11. COMPLIANCE WITH LAWS\r\nYou are not allowed to use the Website or the Services of the Website if any of the terms of this Privacy Policy are not in accordance with the applicable laws of Your country.\r\n<br>\r\n12. GRIEVANCE OFFICER\r\nWe have appointed a Grievance Officer to address any concerns or grievances that You may have regarding the processing of Your Personal Information. If You have any such grievances, please write to Our Grievance Officer at grievances@KNOPROTEC.com and Our officer will attempt to resolve Your issues in a timely manner.\r\nKNOPROTEC reserves the right, in its sole discretion, to change, modify, add or delete portions of the terms of this Privacy Policy at any time.\r\n\r\n                </div>\r\n', 1, 5);
INSERT INTO `pages_description` (`page_description_id`, `name`, `description`, `language_id`, `page_id`) VALUES
(16, 'Term & Services', '<p>Welcome to http://knoprotec.com . This website is operated by Powertrac. The terms &ldquo;We&rdquo;, &ldquo;Us&rdquo; and &ldquo;Our&rdquo; are used to refer to only Knoprotec. The following terms apply to you when you use our website.By visiting our website or purchasing something from us, you become a user of the website and engage in our &ldquo;Services&rdquo;.</p>\r\n\r\n<p>Section 1 &ndash; General Conditions</p>\r\n\r\n<p>We reserve the right to refuse service to anyone for any reason at any time.</p>\r\n\r\n<p>When you use Knoprotec.com, we collect and store your personal information which is provided by you from time to time. Our primary goal in doing so is to provide you a safe, efficient, and customized experience.</p>\r\n\r\n<p>You understand that your content (not including credit card information), may be transferred unencrypted and involve (a) transmissions over various networks; and (b) changes to conform and adapt to te/divical requirements of connecting networks or devices. Credit card information is always encrypted during transfer over networks.</p>\r\n\r\n<p>You agree not to reproduce, duplicate, copy, sell, resell or exploit any portion of the Service, use of the Service, or access to the Service on the website through which we provide the service, without express written permission.</p>\r\n\r\n<p>The headings used in this agreement are included for convenience only and will not limit or otherwise affect these Terms.</p>\r\n\r\n<p>Section 2 - Online Store Terms</p>\r\n\r\n<p>By agreeing to these Terms of Service, you represent that you are at least the age of majority or that you are the age of majority and you have given us your consent to allow any of your minor dependents to use this site.</p>\r\n\r\n<p>You may not use our products for any illegal or unauthorized purpose nor may you, in the use of the Service, violate any laws in your jurisdiction (including but not limited to copyright laws). You must not transmit any worms or viruses or any code of a destructive nature. A breach or violation of any of the Terms will result in an immediate termination of your Services.</p>\r\n\r\n<p>A breach or violation of any of the Terms will result in an immediate termination of your Services.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Section 3 - Modifications To The Service And Prices</p>\r\n\r\n<p>Prices for our products are subject to change without notice.</p>\r\n\r\n<p>Availability and pricing of all items are subject to availability. Knoprotec will inform you as soon as possible, if the product(s) and services you have ordered are not available. If not, then the Customer Care will offer similar alternatives.</p>\r\n\r\n<p>We reserve the right at any time to modify or discontinue any Service (or any part or content thereof) without notice at any time. We shall not be liable to any customer or to any third party for any modification, price change, suspension or discontinuance of the Service.</p>\r\n\r\n<p>As part of visiting and/or purchasing anything from Knoprotec, you warrant to agree to understand that due to the nature of the business, availability may change even after an order has been placed. In an event where the product is no longer available, the Customer Care will offer alternatives or the option to cancel your order.</p>\r\n\r\n<p>We shall not be liable to you or to any third-party for any modification, price change, suspension or discontinuance of the Service.</p>\r\n\r\n<p>Section 4 - Products Or Services</p>\r\n\r\n<p>Products are available exclusively online through Knoprotec. These products or services may have limited quantities and are subject to refund, return or exchange only according to our Return and Replacement Policy and Refund Policy.</p>\r\n\r\n<p>We have made every effort to display as accurately as possible the colors and images of our products that appear at the store. However, due to your device&rsquo;s display settings, technical issues and differences in display, variations may come to the product&rsquo;s color or size. Hence, Knoprotec cannot guarantee that the physical product will look exactly like it is displayed.</p>\r\n\r\n<p>We reserve the right, but are not obligated, to limit the sales of our products or Services to any person, geographic region or jurisdiction. We may exercise this right on a case-by-case basis. We reserve the right to limit the quantities of any products or services that we offer. All descriptions of products or product pricing are subject to change at any time without notice, at the sole discretion of us. We reserve the right to discontinue any product at any time. Any offer for any product or service made on this site is void where prohibited.</p>\r\n\r\n<p>We do not warrant that the quality of any products, services, information, or other material purchased or obtained by you will meet your expectations, or that any errors in the Service will be corrected.</p>\r\n\r\n<p>Section 5- Accuracy Of Billing And Account Information</p>\r\n\r\n<p>We reserve the right to refuse any order you place with us. We may, in our sole discretion, limit or cancel quantities purchased per person, per household or per order. These restrictions may include orders placed by or under the same customer account, the same credit card, and/or orders that use the same billing and/or shipping address. In the event that we make a change to or cancel an order, we may attempt to notify you by contacting the e-mail and/or billing address/phone number provided at the time the order was made. We reserve the right to limit or prohibit orders that, in our sole judgment, appear to be placed by dealers, resellers or distributors.</p>\r\n\r\n<p>As a customer, you agree to provide current, complete and accurate purchase and account information for all purchases made at our store. You agree to promptly update your account and other information, including your email address and credit card numbers and expiration dates, so that we can complete your transactions and contact you as needed.</p>\r\n\r\n<p>Each user accounts must be created under one distinctive registered Mobile Phone number, and email address of the user. Multiple accounts cannot be created under the same information as mentioned. In such an event the user cannot avail more than once any of the offers, deals, discount coupons, or Gift Coupons during campaigns or other occasional sales.</p>\r\n\r\n<p>For more detail, please review our Returns Policy</p>\r\n\r\n<p>Section 6 - Optional Tools</p>\r\n\r\n<p>We may provide you with access to third-party tools over which we neither monitor nor have any control nor input.</p>\r\n\r\n<p>You acknowledge and agree that we provide access to such tools &rdquo;as is&rdquo; and &ldquo;as available&rdquo; without any warranties, representations or conditions of any kind and without any endorsement. We shall have no liability whatsoever arising from or relating to your use of optional third-party tools.</p>\r\n\r\n<p>Any use by you of optional tools offered through the site is entirely at your own risk and discretion and you should ensure that you are familiar with and approve of the terms on which tools are provided by the relevant third-party provider(s).</p>\r\n\r\n<p>We may also, in the future, offer new services and/or features through the website (including, the release of new tools and resources). Such new features and/or services shall also be subject to these Terms of Service.</p>\r\n\r\n<p>Section 7 - Third-Party Links</p>\r\n\r\n<p>Certain content, products and services available via our Service may include materials from third-parties only for the purpose of providing you with better service.</p>\r\n\r\n<p>Third-party links on this site may direct you to third-party websites that are not affiliated with us. We are neither responsible for examining or evaluating the content or accuracy, nor do we warrant any liability for third-party materials, website content, services or any other materials from third-parties.</p>\r\n\r\n<p>We are not liable for any harm or damages related to the purchase or use of goods, services, resources, content, or any other transactions made in connection with any third-party websites. Please review carefully the third-party&#39;s policies and practices and make sure you understand them before you engage in any transaction. Complaints, claims, concerns, or questions regarding third-party products should be directed to the third-party.</p>\r\n\r\n<p>Section 8 - User Comments, Feedback And Other Submissions</p>\r\n\r\n<p>If, at our request, you send specific submissions (for example, for contest entries) or should you send creative ideas, suggestions, proposals, plans or any other material without our request, then &ndash; whether its online, via email, by postal mail or otherwise (collectively referred to as &#39;comments&#39;) &ndash; you agree that Made by True may, at any time and without restriction, edit, copy, publish, distribute, translate and otherwise use any and all comments that you may forward to us in any medium. Knoprotec is and shall be under no obligation (1) to maintain any Comments in confidence; (2) to pay to user any compensation for any Comments; or (3) to respond to any user Comments.</p>\r\n\r\n<p>We may, but have no obligation to, monitor, edit or remove content that we determine in our sole discretion are unlawful, offensive, threatening, libelous, defamatory, pornographic, obscene or otherwise objectionable or violates any party&rsquo;s intellectual property or these Terms of Service.</p>\r\n\r\n<p>You agree that your comments won&rsquo;t violate the rights of any third-party, including copyright, trademark, privacy, personality or other personal or proprietary rights. You further agree that your comments won&rsquo;t contain libelous or otherwise unlawful, abusive or obscene material, nor contain any computer virus or other malware that could in any way affect the operation of the Service or any related website.</p>\r\n\r\n<p>You may not use a false e-mail address, pretend to be someone other than yourself or otherwise mislead us or any third-party as to the origin of any comments.</p>\r\n\r\n<p>Section 09 - Personal Information</p>\r\n\r\n<p>Our submission of personal information through the store is governed by our Privacy Policy. To view our Privacy Policy.</p>\r\n\r\n<p>Section 10 - Errors, Inaccuracies and Omissions</p>\r\n\r\n<p>Occasionally there might be information on our site or in the Service that contains typographical errors, inaccuracies or omissions that may relate to product descriptions, pricing, promotions, offers, product shipping charges, transit times and availability.</p>\r\n\r\n<p>We reserve the right to correct any errors, inaccuracies or omissions and to change or update information or cancel orders if any info in the Service or on any related website is inaccurate at any time without prior notice (including after you&rsquo;ve submitted your order).</p>\r\n\r\n<p>We undertake no obligation to update, amend or clarify information in the Service or on any related website, including without limitation, pricing information, except as required by law. No specified update or refresh date applied in the Service or on any related website should be taken to indicate that all information in the aforementioned Service or website has been modified or updated.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Section 11 - Prohibited Uses</p>\r\n\r\n<p>In addition to other prohibitions as set forth in the Terms of Service, you are prohibited from using the website or its contents:</p>\r\n\r\n<ul>\r\n	<li>For any unlawful purpose.</li>\r\n	<li>To solicit others to perform or participate in any unlawful acts.</li>\r\n	<li>To violate any international, federal, provincial or national regulations, rules, laws, or local ordinances.</li>\r\n	<li>To infringe upon or violate our intellectual property rights or the intellectual property rights of others.</li>\r\n	<li>To harass, abuse, insult, harm, defame, slander, disparage, intimidate, or discriminate based on gender, sexual orientation, religion, ethnicity, race, age, national origin, or disability.</li>\r\n	<li>To submit false or misleading information.</li>\r\n	<li>To upload or transmit viruses or any other type of malicious code that will or may be used in any way that will affect the functionality or operation of the Service or of any related website, other websites, or the Internet.</li>\r\n	<li>To collect or track the personal information of others.</li>\r\n	<li>To spam, phish, pharm, pretext, spider crawl, or scrape.</li>\r\n	<li>For any obscene or immoral purpose.</li>\r\n	<li>To interfere with the security features of the Service or any related website, other websites, or the Internet.</li>\r\n</ul>\r\n\r\n<p>We reserve the right to terminate your use of the Service or any related website for violating any of the prohibited uses.</p>\r\n\r\n<p>Section 12 - Disclaimer of Warranties; Limitation of Liability</p>\r\n\r\n<p>We do not guarantee, represent or warrant that your use of our Service will be uninterrupted, timely, secure or error-free. We also do not warrant that the results that may be obtained from the use of the Service will be accurate or reliable. You agree that from time to time we may remove the Service for indefinite periods of time or cancel it at any time, without notice to you.</p>\r\n\r\n<p>You expressly agree that your use of, or inability to use, the service is at your sole risk. The service and all products and services delivered to you through the service are (except as expressly stated by us) provided &#39;as is&#39; and &#39;as available&#39; for your use, without any representation, warranties or conditions of any kind, either express or implied, including all implied warranties or conditions of merchantability, merchantable quality, fitness for a particular purpose, durability, title, and non-infringement.</p>\r\n\r\n<p>In no case shall Knopotec.com, our directors, officers, employees, affiliates, agents, contractors, interns, suppliers, service providers or licensors be liable for any injury, loss, claim, or any direct, indirect, incidental, punitive, special, or consequential damages of any kind, including, without limitation lost profits, lost revenue, lost savings, loss of data, replacement costs, or any similar damages, whether based in contract, tort (including negligence), strict liability or otherwise, arising from your use of any of the service or any products procured using the service, or for any other claim related in any way to your use of the service or any product, including, but not limited to, any errors or omissions in any content, or any loss or damage of any kind incurred as a result of the use of the service or any content (or product) posted, transmitted, or otherwise made available via the service, even if advised of their possibility. Because some states or jurisdictions do not allow the exclusion or the limitation of liability for consequential or incidental damages, in such states or jurisdictions, our liability shall be limited to the maximum extent permitted by law.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Section 13 &ndash; Indemnification</p>\r\n\r\n<p>As a user of the website and the services therein, you agree to indemnify, defend and hold Knoprotec harmless and our parent, subsidiaries, affiliates, partners, officers, directors, agents, contractors, licensors, service providers, subcontractors, suppliers, vendors, interns and employees, harmless from any claim or demand, including reasonable attorneys&rsquo; fees, made by any third-party due to or arising out of your breach of these Terms of Service or any documents they incorporate by reference, or your violation of any law or the rights of a third-party.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Section 14 &ndash; Severability</p>\r\n\r\n<p>In the event that any provision of these Terms of Service is determined to be unlawful, void or unenforceable, such provision shall nonetheless be enforceable to the fullest extent permitted by applicable law, and the unenforceable portion shall be deemed to be severed from these Terms of Service, such determination shall not affect the validity and enforceability of any other remaining provisions.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Section 15 &ndash; Termination</p>\r\n\r\n<p>The obligations and liabilities of the parties incurred prior to the termination date shall survive the termination of this agreement for all purposes.</p>\r\n\r\n<p>These Terms of Service are effective unless and until terminated by either you or us. You may terminate these Terms of Service at any time by notifying us that you no longer wish to use our Services, or when you cease using our site.</p>\r\n\r\n<p>If in our sole judgment you fail, or we suspect that you have failed, to comply with any term or provision of these Terms of Service, we also may terminate this agreement at any time without notice and you will remain liable for all amounts due up to and including the date of termination; and/or accordingly may deny you access to our Services (or any part thereof).</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Section 16 - Governing Law</p>\r\n\r\n<p>These terms and conditions are governed by and construed in accordance with the laws of The People&#39;s Republic of Bangladesh. You agree, as we do, to submit to the exclusive jurisdiction of the courts in Dhaka.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Section 17 - Changes to Terms Of Service</p>\r\n\r\n<p>You can review the most current version of the Terms of Service at any time at this page.</p>\r\n\r\n<p>We reserve the right, at our sole discretion, to update, change or replace any part of these Terms of Service by posting updates and changes to our website. It is your responsibility to check our website periodically for changes. Your continued use of or access to our website or the Service following the posting of any changes to these Terms of Service constitutes acceptance of those changes.</p>\r\n\r\n<p>Section 18 - Contact Information</p>\r\n\r\n<p>For more information regarding the Terms of Service or if you have any queries feel free to Contact with us.</p>', 1, 6),
(19, 'Refund Policy', '<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard dummy</p>\r\n\r\n<p>text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen</p>\r\n\r\n<p>book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially</p>\r\n\r\n<p>unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages,</p>\r\n\r\n<p>and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem</p>\r\n\r\n<p>Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s standard</p>\r\n\r\n<p>dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type</p>\r\n\r\n<p>specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining</p>\r\n\r\n<p>essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum</p>\r\n\r\n<p>passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem</p>\r\n\r\n<p>Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry&#39;s</p>\r\n\r\n<p>standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make</p>\r\n\r\n<p>a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,</p>\r\n\r\n<p>remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing</p>\r\n\r\n<p>Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions</p>\r\n\r\n<p>of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been</p>\r\n\r\n<p>the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled</p>\r\n\r\n<p>it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,</p>\r\n\r\n<p>remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing</p>\r\n\r\n<p>Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions</p>\r\n\r\n<p>of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been</p>\r\n\r\n<p>the industry&#39;s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled</p>\r\n\r\n<p>it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,</p>\r\n\r\n<p>remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing</p>\r\n\r\n<p>Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions</p>\r\n\r\n<p>of Lorem Ipsum.</p>', 1, 7),
(22, 'About Us', '<h1>The Story Of &ldquo;KnoPROTEC&rdquo;</h1>\r\n\r\n<p><a href=\\\"\\\\\\\" target=\\\"\\\\&quot;\\\\\\\\&quot;_blank\\\\\\\\&quot;\\\\&quot;\\\">www.knoprotec.com</a> is a concern of POWERtrac Group which provides you the power to buy your desired products from home with outstanding customer support. At Knoprotec.com we endeavor to utilize the power of the internet at its highest peak to fulfill the needs of your day to day life.</p>\r\n\r\n<p>Currently, we are providing our service all over Bangladesh, at the same time a person from outside of Bangladesh can also order our products using Bangladeshi shipping address.</p>\r\n\r\n<p>&ldquo;We endeavor to make our customers happy&rdquo;</p>\r\n\r\n<p><br />\r\n<br />\r\n&nbsp;</p>', 1, 8),
(23, 'cccd', '<p>ccddcdc</p>', 1, 9),
(24, 'سياسة خاصة', 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', 4, 1),
(25, 'مصطلح والخدمات', 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', 4, 2),
(26, 'سياسة الاسترجاع', 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', 4, 3),
(27, 'معلومات عنا', 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', 4, 4),
(28, 'سياسة خاصة', 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', 4, 5),
(29, 'معلومات عنا', '<p>ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء. أم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم. ثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء. عرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل. مكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا. كان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل. حتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد. عدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات. كلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية. عن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.</p>', 4, 8),
(30, 'سياسة الاسترجاع', 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', 4, 7),
(31, 'مصطلح والخدمات', 'ذلك وبعدما وقوعها، أم, تُصب ونتج حول عن. أن فرنسا لمحاكم تلك, يكن ان وتتحمّل الساحلية. يذكر الأول إتفاقية مما أي, كلّ ٣٠ دفّة العالم. بها بـ عقبت السفن الثالث, الأول الانجليزية أخر أي, فكان أفاق عدد بل. واتّجه قُدُماً التخطيط بل لان, والنفيس وبالتحديد، يتم عل, إذ بعد تحرير ترتيب الوزراء.\r\n\r\nأم السبب التّحول واشتدّت يتم, ٣٠ أضف ليركز قتيل، المعاهدات, أم مئات الشرق، أخر. أوسع الطريق هو جعل, كل وجهان الصين الضروري عرض. خيار قادة لعملة على ما, فسقط الشمال ما بعض. حتى في مليارات والإتحاد, هو كلا لفرنسا الخطّة, عرض أي المضي الصين. أضف تاريخ لإنعدام الولايات في. بعد ليرتفع التحالف التجارية هو, هو الذود لإعلان كلّ, ثمّة المجتمع الإكتفاء يبق ثم.\r\n\r\nثم جُل وترك وانتهاءً التقليدي. هو إيو محاولات البولندي. عرض عل كردة ميناء المنتصر, كان لدحر أوسع فرنسية ان. منتصف بالرّغم لم أخذ. بـ دون لهذه نهاية وباستثناء.\r\n\r\nعرض الآخر لليابان الأوروبية تم, قد التي كُلفة المتساقطة، ذلك. مرجع لكون سياسة مع أخر. وحتى النفط بالسيطرة مع ومن, وفي أم واحدة الشهير. أخذ عن وأزيز بمحاولة الأمريكية. بال كل ووصف منتصف ولاتّساع, يكن و الأول الإتحاد. حدى بـ ايطاليا، الأثناء،, هو بلاده العصبة فصل, والتي يعادل نفس بل.\r\n\r\nمكن المنتصر والروسية الموسوعة أم. أن بحق فقامت حادثة الرئيسية, هذه تعداد وعُرفت بتطويق أم. هذه أهّل مقاومة الاندونيسية قد, انه وبدون واستمرت كل. حتى وبدون فكانت الإطلاق في, بعد تصفح سكان وقامت أم, يكن الأمم إستعمل أم. وبعض الأمم بـ ذات, إجلاء استدعى الأوروبية، أما عن, ما جنوب الدول الأمور بلا.\r\n\r\nكان الخاسر الساحل أن, و أضف يتمكن مكثّفة. كلّ الجوي تجهيز الأوروبي في, سقطت الطريق أوراقهم في بين. هامش بالحرب الباهضة لكل قد. عل صفحة عُقر وتنامت أخذ. أطراف العناد كلّ بل.\r\n\r\nحتى للسيطرة المتاخمة عل. طوكيو الشهيرة جهة أن, من جعل يونيو الأولية, عن جعل سقطت الستار. بشكل بمعارضة بالمطالبة ٣٠ ذات, قد بعض إبّان ماليزيا، الأوروبي. ذات ما وجهان الأوروبيّون, يقوم استمرار وتم إذ, أوراقهم الانجليزية يبق عن. حدى ٣٠ الصفحات الأوربيين, أراض الأولى فقد ان, وبعد بتخصيص ثم بعد.\r\n\r\nعدم هو ساعة الساحلية, أن بينما السيطرة أضف. وبحلول استعملت تعد بـ. تم للصين أصقاع الفترة نفس. سابق لمحاكم عن حول, أي بلا جنوب والإتحاد التغييرات.\r\n\r\nكلّ ان مئات الأمور الشتاء،. عن بعض أحكم تكبّد العصبة, يتم ٢٠٠٤ بالمحور العالمية هو. رجوعهم الحدود الإتحاد لان عن, كما و مليون وهولندا،. بسبب استبدال وتتحمّل لم عدد, قائمة بتحدّي بالسيطرة الى ما. يقوم الشطر العمليات كما و, عل نفس لفشل نهاية.\r\n\r\nعن حكومة بتطويق أخذ, مايو مرجع معقل هو لكل. ذلك قد بتطويق الضغوط, مع تحت ودول تزامناً. يرتبط بالسيطرة حتى من, وتم عن ٢٠٠٤ الجنود بريطانيا-فرنسا. وبولندا الأرواح إذ أضف, نفس هو إبّان للمجهود بالمحور, قبل ثم معاملة بالمحور بالتوقيع.', 4, 6);

-- --------------------------------------------------------

--
-- Table structure for table `payment_description`
--

CREATE TABLE `payment_description` (
  `id` int(11) NOT NULL,
  `payment_methods_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `language_id` int(11) NOT NULL,
  `sub_name_1` varchar(100) NOT NULL,
  `sub_name_2` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payment_description`
--

INSERT INTO `payment_description` (`id`, `payment_methods_id`, `name`, `language_id`, `sub_name_1`, `sub_name_2`) VALUES
(1, 1, 'Braintree', 1, 'Credit Card', 'Paypal'),
(4, 2, 'Stripe', 1, '', ''),
(5, 3, 'Paypal', 1, '', ''),
(6, 4, 'Cash on Delivery', 1, '', ''),
(7, 5, 'Instamojo', 1, '', ''),
(8, 0, 'Cybersoure', 1, '', ''),
(9, 6, 'Hyperpay', 1, '', ''),
(10, 7, 'Razor Pay', 1, '', ''),
(11, 8, 'PayTm', 1, '', ''),
(12, 9, 'Direct Bank Transfer', 1, 'Make your payment directly into our bank account. Please use your Order ID as the payment reference.', ''),
(13, 10, 'Paystack', 1, '', ''),
(14, 11, 'Midtrans', 1, '', ''),
(15, 12, 'SSLCOMMERZ', 1, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `payment_methods_id` int(11) NOT NULL,
  `payment_method` varchar(191) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `environment` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`payment_methods_id`, `payment_method`, `status`, `environment`, `created_at`, `updated_at`) VALUES
(1, 'braintree', 0, 0, '2019-09-18 10:40:13', '0000-00-00 00:00:00'),
(2, 'stripe', 0, 0, '2019-09-18 10:56:17', '0000-00-00 00:00:00'),
(3, 'paypal', 0, 0, '2019-09-18 10:56:04', '0000-00-00 00:00:00'),
(4, 'cash_on_delivery', 1, 0, '2019-09-18 10:56:37', '0000-00-00 00:00:00'),
(5, 'instamojo', 0, 0, '2019-09-18 10:57:23', '0000-00-00 00:00:00'),
(6, 'hyperpay', 0, 0, '2019-09-18 10:56:44', '0000-00-00 00:00:00'),
(7, 'razor_pay', 0, 0, '2019-09-18 10:56:44', '0000-00-00 00:00:00'),
(8, 'pay_tm', 0, 0, '2019-09-18 10:56:44', '0000-00-00 00:00:00'),
(9, 'banktransfer', 0, 0, '2019-09-18 10:56:44', '0000-00-00 00:00:00'),
(10, 'paystack', 0, 0, '2019-09-18 10:56:44', '0000-00-00 00:00:00'),
(11, 'midtrans', 0, 0, '2019-09-18 10:56:44', '0000-00-00 00:00:00'),
(12, 'sslcommerz', 1, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods_detail`
--

CREATE TABLE `payment_methods_detail` (
  `id` int(11) NOT NULL,
  `payment_methods_id` int(11) NOT NULL,
  `key` varchar(191) NOT NULL,
  `value` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `payment_methods_detail`
--

INSERT INTO `payment_methods_detail` (`id`, `payment_methods_id`, `key`, `value`) VALUES
(3, 1, 'merchant_id', ''),
(4, 1, 'public_key', ''),
(5, 1, 'private_key', ''),
(9, 2, 'secret_key', ''),
(10, 2, 'publishable_key', ''),
(15, 3, 'id', ''),
(18, 3, 'payment_currency', 'USD'),
(21, 5, 'api_key', ''),
(22, 5, 'auth_token', ''),
(23, 5, 'client_id', ''),
(24, 5, 'client_secret', ''),
(32, 6, 'userid', ''),
(33, 6, 'password', ''),
(34, 6, 'entityid', ''),
(35, 7, 'RAZORPAY_KEY', ''),
(36, 7, 'RAZORPAY_SECRET', ''),
(37, 8, 'paytm_mid', ''),
(39, 8, 'paytm_key', 'w#'),
(40, 8, 'current_domain_name', ''),
(41, 9, 'account_name', ''),
(42, 9, 'account_number', ''),
(43, 9, 'bank_name', ''),
(44, 9, 'short_code', ''),
(45, 9, 'iban', ''),
(46, 9, 'swift', ''),
(47, 10, 'secret_key', ''),
(48, 10, 'public_key', ''),
(49, 11, 'merchant_id', ''),
(50, 11, 'server_key', ''),
(51, 11, 'client_key', ''),
(52, 12, 'userid', 'prote5f65b04074cd6'),
(53, 12, 'password', 'prote5f65b04074cd6@ssl');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL,
  `role_id` varchar(191) NOT NULL,
  `permissions` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `products_id` int(11) NOT NULL,
  `products_quantity` int(11) NOT NULL,
  `products_model` varchar(191) DEFAULT NULL,
  `products_image` text DEFAULT NULL,
  `products_video_link` text DEFAULT NULL,
  `products_price` decimal(15,2) NOT NULL,
  `products_date_added` datetime NOT NULL,
  `products_last_modified` datetime DEFAULT NULL,
  `products_date_available` datetime DEFAULT NULL,
  `products_weight` varchar(191) NOT NULL,
  `products_weight_unit` varchar(191) DEFAULT NULL,
  `products_status` tinyint(1) NOT NULL,
  `is_current` tinyint(1) NOT NULL,
  `products_tax_class_id` int(11) NOT NULL,
  `manufacturers_id` int(11) DEFAULT NULL,
  `products_ordered` int(11) NOT NULL DEFAULT 0,
  `products_liked` int(11) NOT NULL,
  `low_limit` int(11) NOT NULL,
  `is_feature` tinyint(1) NOT NULL DEFAULT 0,
  `products_slug` varchar(191) NOT NULL,
  `products_type` int(11) NOT NULL DEFAULT 0,
  `products_min_order` int(11) NOT NULL DEFAULT 1,
  `products_max_stock` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `currency` char(3) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`products_id`, `products_quantity`, `products_model`, `products_image`, `products_video_link`, `products_price`, `products_date_added`, `products_last_modified`, `products_date_available`, `products_weight`, `products_weight_unit`, `products_status`, `is_current`, `products_tax_class_id`, `manufacturers_id`, `products_ordered`, `products_liked`, `low_limit`, `is_feature`, `products_slug`, `products_type`, `products_min_order`, `products_max_stock`, `created_at`, `updated_at`, `currency`) VALUES
(104, 0, NULL, '689', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'pure-cotton-round-kuchi-dress', 0, 1, NULL, '2020-12-09 15:42:42', NULL, ''),
(94, 0, NULL, '670', NULL, '200.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'radiator', 0, 1, NULL, '2020-10-14 05:23:13', NULL, ''),
(95, 0, 'USA 2020', '671', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'usa-bag', 0, 1, NULL, '2020-10-31 10:37:04', NULL, ''),
(96, -1, NULL, '674', NULL, '1450.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 1, 0, 0, 0, 'fortune-bag', 0, 1, NULL, '2020-10-31 10:41:53', NULL, ''),
(97, 0, NULL, '677', NULL, '850.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'cinderella-bag', 0, 1, NULL, '2020-10-31 10:43:02', NULL, ''),
(98, 0, NULL, '687', NULL, '400.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'ladies-tops', 0, 1, NULL, '2020-12-09 15:25:40', NULL, ''),
(349, 0, NULL, '795', NULL, '1399.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-15', 0, 1, NULL, '2022-04-20 14:47:35', NULL, ''),
(100, 0, NULL, '690', NULL, '600.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'stylish-kurti-01', 0, 1, NULL, '2020-12-09 15:33:36', '2020-12-09 15:34:40', ''),
(101, 0, NULL, '691', NULL, '600.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'stylish-kurti-03', 0, 1, NULL, '2020-12-09 15:34:13', NULL, ''),
(336, 0, NULL, '791', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-2', 0, 1, NULL, '2022-04-20 12:43:43', NULL, ''),
(337, 0, NULL, '790', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-3', 0, 1, NULL, '2022-04-20 12:50:07', NULL, ''),
(338, 0, NULL, '789', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-4', 0, 1, NULL, '2022-04-20 12:52:41', NULL, ''),
(339, 0, NULL, '788', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-5', 0, 1, NULL, '2022-04-20 12:56:33', NULL, ''),
(340, 0, NULL, '787', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-6', 0, 1, NULL, '2022-04-20 13:03:47', NULL, ''),
(341, 0, NULL, '786', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-7', 0, 1, NULL, '2022-04-20 13:06:14', NULL, ''),
(118, 0, NULL, '707', NULL, '700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'stylish-kurti-04', 0, 1, NULL, '2020-12-14 14:02:17', NULL, ''),
(119, 0, NULL, '708', NULL, '700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'stylish-kurti-05', 0, 1, NULL, '2020-12-14 14:03:51', NULL, ''),
(342, 0, NULL, '785', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-8', 0, 1, NULL, '2022-04-20 13:09:49', NULL, ''),
(343, 0, NULL, '800', NULL, '1399.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-9', 0, 1, NULL, '2022-04-20 13:27:08', NULL, ''),
(344, 0, NULL, '799', NULL, '1399.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-10', 0, 1, NULL, '2022-04-20 14:14:48', NULL, ''),
(345, 0, NULL, '798', NULL, '1399.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-11', 0, 1, NULL, '2022-04-20 14:19:47', NULL, ''),
(346, 0, NULL, '797', NULL, '1399.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-12', 0, 1, NULL, '2022-04-20 14:29:32', NULL, ''),
(347, 0, NULL, '796', NULL, '1399.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-13', 0, 1, NULL, '2022-04-20 14:44:01', NULL, ''),
(348, 0, NULL, '794', NULL, '1399.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-14', 0, 1, NULL, '2022-04-20 14:46:08', NULL, ''),
(42, 0, NULL, '560', NULL, '2050.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'rouen-fabric-punjabi-navy-blue', 0, 1, NULL, '2020-07-22 13:25:12', '2020-07-22 13:35:12', ''),
(51, 0, NULL, '570', NULL, '700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'lunaa', 0, 1, NULL, '2020-07-23 14:40:59', NULL, ''),
(352, 0, NULL, '806', NULL, '1899.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-18', 0, 1, NULL, '2022-04-21 08:42:32', NULL, ''),
(353, 0, NULL, '805', NULL, '1899.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-19', 0, 1, NULL, '2022-04-21 09:17:28', NULL, ''),
(354, 0, NULL, '804', NULL, '1899.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-20', 0, 1, NULL, '2022-04-21 09:23:13', NULL, ''),
(355, 0, NULL, '803', NULL, '1899.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-21', 0, 1, NULL, '2022-04-21 09:25:26', NULL, ''),
(356, 0, NULL, '802', NULL, '1899.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-22', 0, 1, NULL, '2022-04-21 09:35:53', NULL, ''),
(357, 0, NULL, '801', NULL, '1899.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-23', 0, 1, NULL, '2022-04-21 09:39:42', NULL, ''),
(65, 0, NULL, '593', NULL, '765000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, '20kva-diesel-generator', 0, 1, NULL, '2020-08-19 15:18:08', '2020-08-19 15:24:30', ''),
(66, 0, NULL, '594', NULL, '955000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, '30kva-diesel-generator', 0, 1, NULL, '2020-08-19 15:24:27', NULL, ''),
(67, 0, NULL, '595', NULL, '1020000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, '45kva-diesel-generator', 0, 1, NULL, '2020-08-19 15:30:09', NULL, ''),
(68, 0, NULL, '595', NULL, '1150000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, '60kva-diesel-generator', 0, 1, NULL, '2020-08-19 15:32:53', NULL, ''),
(69, 0, NULL, '595', NULL, '1350000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, '80kva-diesel-generator', 0, 1, NULL, '2020-08-19 15:35:42', NULL, ''),
(70, 0, NULL, '625', NULL, '1580000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, '100kva-diesel-generator', 0, 1, NULL, '2020-08-19 15:38:28', '2020-09-22 07:56:56', ''),
(71, 0, NULL, '597', NULL, '2110000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, '150kva-diesel-generator', 0, 1, NULL, '2020-08-19 15:40:51', NULL, ''),
(72, 0, NULL, '598', NULL, '2700000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, '200kva-diesel-generator', 0, 1, NULL, '2020-08-19 15:45:55', NULL, ''),
(73, 0, NULL, '599', NULL, '3425000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, '250kva-diesel-generator', 0, 1, NULL, '2020-08-19 15:55:20', NULL, ''),
(351, 0, NULL, '807', NULL, '1899.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-17', 0, 1, NULL, '2022-04-21 08:38:20', NULL, ''),
(76, 0, NULL, '619', NULL, '950.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'shari-00007', 0, 1, NULL, '2020-09-19 09:15:58', NULL, ''),
(77, 0, NULL, '620', NULL, '1150.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'shari-00008', 0, 1, NULL, '2020-09-19 09:16:32', NULL, ''),
(350, 0, NULL, '808', NULL, '1899.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-16', 0, 1, NULL, '2022-04-21 08:28:19', NULL, ''),
(79, 0, 'S0011', '655', NULL, '130.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'one-gang', 0, 2, NULL, '2020-09-26 14:36:44', '2020-09-26 14:42:57', ''),
(80, 0, 'S0012', '657', NULL, '270.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'three-gang', 0, 1, NULL, '2020-09-26 14:38:09', '2020-09-26 14:42:12', ''),
(81, 0, 'S0013', '651', NULL, '430.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'four-gang', 0, 1, NULL, '2020-09-26 14:39:41', '2020-09-26 14:41:50', ''),
(82, 0, 'D0014', '648', NULL, '580.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'fan-dimmer', 0, 1, NULL, '2020-09-26 14:41:15', NULL, ''),
(83, 0, 'T0015', '656', NULL, '300.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'telephone-socket', 0, 1, NULL, '2020-09-26 14:44:28', NULL, ''),
(84, 0, 'M0016', '652', NULL, '580.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'multi-socket-with-switch', 0, 1, NULL, '2020-09-26 14:45:52', NULL, ''),
(85, 0, 'DP0017', '647', NULL, '520.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'dp-switch', 0, 1, NULL, '2020-09-26 14:47:21', NULL, ''),
(86, 0, 'MU0018', '661', NULL, '520.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'three-pin-usb-socket', 0, 1, NULL, '2020-09-26 14:48:21', NULL, ''),
(87, 0, 'R0019', '660', NULL, '545.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'three-pin-round-socket', 0, 1, NULL, '2020-09-26 14:49:25', NULL, ''),
(105, 0, NULL, '685', NULL, '1580.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indian-two-piece', 0, 1, NULL, '2020-12-09 15:43:44', NULL, ''),
(91, 0, NULL, '664', NULL, '4675.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'puja-couple-004', 0, 1, NULL, '2020-10-11 13:01:31', NULL, ''),
(92, 0, NULL, '665', NULL, '7725.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'puja-couple-005', 0, 1, NULL, '2020-10-11 13:02:11', NULL, ''),
(126, 0, NULL, '715', NULL, '1200.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'women-s-gold-white-heels', 0, 1, NULL, '2021-01-05 09:52:30', NULL, ''),
(131, 0, NULL, '716', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'stylish-kurti-13', 0, 1, NULL, '2021-01-05 10:04:36', NULL, ''),
(136, 0, NULL, '725', NULL, '1400.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'falgun-saree', 0, 1, NULL, '2021-01-24 11:43:38', NULL, ''),
(137, 0, NULL, '726', NULL, '1400.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'falgun-saree-2', 0, 1, NULL, '2021-01-24 11:56:54', NULL, ''),
(150, 0, NULL, '739', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'green-tat-saree', 0, 1, NULL, '2021-01-28 15:45:54', NULL, ''),
(151, 0, NULL, '740', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'red-tat-saree', 0, 1, NULL, '2021-01-28 15:54:13', NULL, ''),
(152, 0, NULL, '742', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'laser-cut-work-saree', 0, 1, NULL, '2021-02-07 11:02:59', NULL, ''),
(153, 0, NULL, '743', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'laser-cut-work-saree-2', 0, 1, NULL, '2021-02-07 11:07:38', NULL, ''),
(154, 0, NULL, '744', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'laser-cut-work-saree-3', 0, 1, NULL, '2021-02-07 11:09:06', NULL, ''),
(155, 0, NULL, '745', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'laser-cut-work-saree-4', 0, 1, NULL, '2021-02-07 11:10:27', NULL, ''),
(156, 0, NULL, '746', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'laser-cut-work-saree-5', 0, 1, NULL, '2021-02-07 11:11:27', NULL, ''),
(157, 0, NULL, '747', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'laser-cut-work-saree-6', 0, 1, NULL, '2021-02-07 11:12:22', NULL, ''),
(158, 0, NULL, '748', NULL, '1500.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'ekush-saree', 0, 1, NULL, '2021-02-07 11:58:06', NULL, ''),
(159, 0, NULL, '750', NULL, '2000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'ekush-saree-2', 0, 1, NULL, '2021-02-07 11:59:16', NULL, ''),
(160, 0, NULL, '749', NULL, '1400.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'fagun-saree-1', 0, 1, NULL, '2021-02-07 12:01:03', NULL, ''),
(161, 0, NULL, '758', NULL, '4000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'jamdani-saree', 0, 1, NULL, '2021-02-07 12:02:03', NULL, ''),
(162, 0, NULL, '759', NULL, '1300.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'fagun-sareee', 0, 1, NULL, '2021-02-07 12:03:23', NULL, ''),
(163, 0, NULL, '760', NULL, '1400.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'fagun-saree-2', 0, 1, NULL, '2021-02-07 12:04:16', NULL, ''),
(170, 0, NULL, '751', NULL, '1100.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'hand-paint-4', 0, 1, NULL, '2021-02-07 12:10:55', NULL, ''),
(171, 0, NULL, '761', NULL, '1900.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'ekush-saree-4', 0, 1, NULL, '2021-02-07 12:32:40', NULL, ''),
(172, 0, NULL, '762', NULL, '2100.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'fagun-saree-3', 0, 1, NULL, '2021-02-07 12:33:47', '2021-12-01 15:42:05', ''),
(334, 0, NULL, '793', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection', 0, 1, NULL, '2022-04-20 12:29:07', NULL, ''),
(335, 0, NULL, '792', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'eid-ul-fittar-2022-collection-1', 0, 1, NULL, '2022-04-20 12:41:13', NULL, ''),
(176, 0, 'mcbsp6-20', '765', NULL, '360.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-20a-6ka', 0, 1, NULL, '2021-12-04 13:59:24', NULL, ''),
(177, 0, 'mcbsp6-25', '765', NULL, '360.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-25a-6ka', 0, 1, NULL, '2021-12-04 14:04:56', NULL, ''),
(178, 0, 'mcbsp6KA-32A', '765', NULL, '360.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-32a-6ka', 0, 1, NULL, '2021-12-04 14:08:24', NULL, ''),
(179, 0, 'mcbsp6KA-40A', '765', NULL, '410.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-40a-6ka', 0, 1, NULL, '2021-12-04 14:08:26', '2021-12-04 14:31:30', ''),
(182, 0, 'mcbsp6-50A', '765', NULL, '420.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-50a-6ka', 0, 1, NULL, '2021-12-04 14:38:38', NULL, ''),
(183, 0, 'mcbsp6KA-63A', '765', NULL, '430.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-63a-6ka', 0, 1, NULL, '2021-12-04 14:41:19', NULL, ''),
(184, 0, 'mcbsp10-6A', '765', NULL, '540.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-6a-10ka', 0, 1, NULL, '2021-12-04 14:53:27', NULL, ''),
(185, 0, 'mcbsp10KA-6A', '765', NULL, '540.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-10a-10ka', 0, 1, NULL, '2021-12-04 14:56:57', NULL, ''),
(186, 0, 'mcbsp10KA-16A', '765', NULL, '540.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-16a-10ka', 0, 1, NULL, '2021-12-04 15:00:49', NULL, ''),
(187, 0, 'mcbsp10KA-20A', '765', NULL, '540.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-20a-10ka', 0, 1, NULL, '2021-12-04 15:03:49', NULL, ''),
(188, 0, 'mcbsp10KA-25A', '765', NULL, '540.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-25a-10ka', 0, 1, NULL, '2021-12-04 15:06:56', NULL, ''),
(189, 0, 'mcbsp10KA-32A', '765', NULL, '540.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-32a-10ka', 0, 1, NULL, '2021-12-04 15:09:37', NULL, ''),
(190, 0, 'mcbsp10KA-40A', '765', NULL, '630.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-40a-10ka', 0, 1, NULL, '2021-12-04 15:15:47', NULL, ''),
(191, 0, 'mcbsp10KA-50A', '765', NULL, '630.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-50a-10ka', 0, 1, NULL, '2021-12-04 15:18:50', NULL, ''),
(192, 0, 'mcbsp10KA-63A', '765', NULL, '700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-63a-10ka', 0, 1, NULL, '2021-12-04 15:21:47', NULL, ''),
(193, 0, 'MCB DP6KA-16A', '766', NULL, '800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-16a-6ka', 0, 1, NULL, '2021-12-05 10:36:00', NULL, ''),
(194, 0, 'MCB DP6KA-20A', '766', NULL, '800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-20a-6ka', 0, 1, NULL, '2021-12-05 10:40:32', NULL, ''),
(195, 0, 'MCB DP6KA-25A', '766', NULL, '800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-25a-6ka', 0, 1, NULL, '2021-12-05 10:55:36', NULL, ''),
(196, 0, 'MCB DP6KA-32A', '766', NULL, '800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-32a-6ka', 0, 1, NULL, '2021-12-05 11:05:05', NULL, ''),
(197, 0, 'MCB DP6KA-40A', '766', NULL, '800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-40a-6ka', 0, 1, NULL, '2021-12-05 11:08:11', NULL, ''),
(198, 0, 'MCB DP6KA-50A', '766', NULL, '1200.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-50a-6ka', 0, 1, NULL, '2021-12-05 11:12:57', NULL, ''),
(199, 0, 'MCB DP6KA-63A', '766', NULL, '1800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-63a-6ka', 0, 1, NULL, '2021-12-05 11:17:59', '2021-12-05 11:19:31', ''),
(200, 0, 'MCB DP10KA-16A', '766', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-16a-10ka', 0, 1, NULL, '2021-12-06 10:10:28', NULL, ''),
(201, 0, 'MCB DP10KA-20A', '766', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-20a-10ka', 0, 1, NULL, '2021-12-06 10:13:36', NULL, ''),
(202, 0, 'MCB DP10KA-25A', '766', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-25a-10ka', 0, 1, NULL, '2021-12-06 10:15:44', NULL, ''),
(203, 0, 'mcb-dp-10KA-32A', '766', NULL, '1000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-32a-10ka', 0, 1, NULL, '2021-12-06 10:20:03', NULL, ''),
(204, 0, 'mcb-dp-10ka-40a', '766', NULL, '1100.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-dp-40a-10ka', 0, 1, NULL, '2021-12-06 10:26:57', NULL, ''),
(205, 0, 'mcb-TP-6ka-20a', '767', NULL, '2500.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-20a-6ka', 0, 1, NULL, '2021-12-06 11:15:15', '2021-12-06 11:21:10', ''),
(206, 0, 'mcb-TP-6ka-25a', '767', NULL, '2500.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-25a-6ka', 0, 1, NULL, '2021-12-06 11:16:56', '2021-12-06 11:21:44', ''),
(207, 0, 'mcb-TP-6ka-32a', '767', NULL, '2500.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-32a-6ka', 0, 1, NULL, '2021-12-06 11:19:30', NULL, ''),
(208, 0, 'mcb-TP-6ka-40a', '767', NULL, '2500.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-40a-6ka', 0, 1, NULL, '2021-12-06 11:23:30', NULL, ''),
(209, 0, 'mcb-TP-6ka-50a', '767', NULL, '2700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-50a-6ka', 0, 1, NULL, '2021-12-06 11:29:36', NULL, ''),
(210, 0, 'mcb-TP-6ka-63a', '767', NULL, '2700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-63a-6ka', 0, 1, NULL, '2021-12-06 11:31:40', NULL, ''),
(211, 0, 'mcb-TP-10ka-20a', '767', NULL, '1700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-20a-6ka-1', 0, 1, NULL, '2021-12-06 11:58:36', NULL, ''),
(212, 0, 'mcb-TP-10ka-20a', '767', NULL, '1700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-20a-10ka', 0, 1, NULL, '2021-12-06 11:59:47', NULL, ''),
(213, 0, 'mcb-TP-10ka-25a', '767', NULL, '1700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-25a-10ka', 0, 1, NULL, '2021-12-06 12:05:27', NULL, ''),
(214, 0, 'mcb-TP-10ka-32a', '767', NULL, '1700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-32a-10ka', 0, 1, NULL, '2021-12-06 12:10:27', NULL, ''),
(215, 0, 'mcb-TP-10ka-40a', '767', NULL, '2000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-40a-10ka', 0, 1, NULL, '2021-12-06 13:47:02', NULL, ''),
(216, 0, 'mcb-TP-10ka-50a', '767', NULL, '2000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-50a-10ka', 0, 1, NULL, '2021-12-06 13:51:48', NULL, ''),
(217, 0, 'mcb-TP-10ka-63a', '767', NULL, '2000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-63a-10ka', 0, 1, NULL, '2021-12-06 14:02:26', NULL, ''),
(220, 0, 'mccb-25ka-20a', '768', NULL, '7200.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-20a-25ka', 0, 1, NULL, '2021-12-06 14:34:54', NULL, ''),
(219, 0, 'mccb-25ka-16a', '768', NULL, '7200.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-16a-25ka-1', 0, 1, NULL, '2021-12-06 14:10:07', '2021-12-06 14:31:34', ''),
(221, 0, 'mccb-25ka-32a', '768', NULL, '7200.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-32a-25ka', 0, 1, NULL, '2021-12-06 14:57:42', NULL, ''),
(222, 0, 'mccb-25ka-40a', '768', NULL, '7200.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-40a-25ka', 0, 1, NULL, '2021-12-06 15:02:10', NULL, ''),
(223, 0, 'mccb-25ka-63a', '768', NULL, '9000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-63a-25ka', 0, 1, NULL, '2021-12-06 15:27:18', NULL, ''),
(224, 0, 'mccb-25ka-70a', '768', NULL, '9000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-70a-25ka', 0, 1, NULL, '2021-12-06 15:30:48', NULL, ''),
(225, 0, 'mccb-25ka-100a', '768', NULL, '9000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-100a-25ka', 0, 1, NULL, '2021-12-06 15:33:31', NULL, ''),
(226, 0, 'mccb-36ka-125a', '768', NULL, '11000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-125a-36ka', 0, 1, NULL, '2021-12-06 15:38:17', NULL, ''),
(227, 0, 'mccb-36ka-160a', '768', NULL, '11000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-160a-36ka', 0, 1, NULL, '2021-12-06 15:48:00', NULL, ''),
(228, 0, 'mccb-36ka-200a', '768', NULL, '24000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-200a-36ka', 0, 1, NULL, '2021-12-06 16:05:41', NULL, ''),
(229, 0, 'mccb-36ka-250a', '768', NULL, '27000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-250a-36ka', 0, 1, NULL, '2021-12-06 16:07:53', NULL, ''),
(230, 0, 'mccb-65ka-315a', '768', NULL, '44000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-315a-65ka', 0, 1, NULL, '2021-12-06 16:12:12', NULL, ''),
(231, 0, 'mccb-65ka-400a', '768', NULL, '50000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-400a-65ka', 0, 1, NULL, '2021-12-06 16:18:50', NULL, ''),
(232, 0, 'mccb-65ka-500a', '768', NULL, '65000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-500a-65ka', 0, 1, NULL, '2021-12-06 16:24:49', NULL, ''),
(233, 0, 'mccb-65ka-630a', '768', NULL, '80000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-630a-65ka', 0, 1, NULL, '2021-12-06 16:29:25', NULL, ''),
(234, 0, 'mccb-85ka-800a', '768', NULL, '90000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-800a-85ka', 0, 1, NULL, '2021-12-06 16:35:33', NULL, ''),
(235, 0, 'mccb-85ka-1000a', '768', NULL, '150000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-1000a-85ka', 0, 1, NULL, '2021-12-06 16:39:04', NULL, ''),
(236, 0, 'mccb-85ka-1250a', '768', NULL, '150000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mccb-1250a-85ka', 0, 1, NULL, '2021-12-06 16:43:27', NULL, ''),
(237, 0, 'INmcb-sp-6k-6a', '769', NULL, '270.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-6a-6ka-1', 0, 1, NULL, '2021-12-08 10:33:48', '2021-12-09 09:23:09', ''),
(238, 0, 'INmcb-sp-6k-10a', '769', NULL, '270.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-10a-6ka-1', 0, 1, NULL, '2021-12-08 10:37:37', '2021-12-09 09:21:35', ''),
(239, 0, 'INmcb-sp-6k-16a', '769', NULL, '270.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-16a-6ka-1', 0, 1, NULL, '2021-12-08 10:39:30', '2021-12-09 09:21:02', ''),
(240, 0, 'INmcb-sp-6k-20a', '769', NULL, '270.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-20a-6ka-2', 0, 1, NULL, '2021-12-08 10:44:53', '2021-12-09 09:20:20', ''),
(241, 0, 'INmcb-sp-6k-25a', '769', NULL, '270.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-25a-6ka-1', 0, 1, NULL, '2021-12-08 10:48:56', '2021-12-09 09:19:36', ''),
(242, 0, 'INmcb-sp-6k-32a', '769', NULL, '270.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-32a-6ka-1', 0, 1, NULL, '2021-12-08 10:50:52', '2021-12-09 09:19:02', ''),
(243, 0, 'INmcb-sp-6k-40a', '769', NULL, '350.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-40a-6ka-1', 0, 1, NULL, '2021-12-08 10:54:27', '2021-12-09 09:18:28', ''),
(244, 0, 'INmcb-sp-6k-50a', '769', NULL, '350.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-50a-6ka-1', 0, 1, NULL, '2021-12-08 10:57:52', '2021-12-09 09:17:58', ''),
(245, 0, 'INmcb-sp-6k-63a', '769', NULL, '350.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-63a-6ka-1', 0, 1, NULL, '2021-12-08 11:03:38', '2021-12-09 09:16:15', ''),
(246, 0, 'INmcb-sp-10k-6a', '769', NULL, '340.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-6a-10ka-1', 0, 1, NULL, '2021-12-08 11:20:21', '2021-12-09 09:04:58', ''),
(247, 0, 'INmcb-sp-10k-10a', '769', NULL, '340.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-10a-10ka-1', 0, 1, NULL, '2021-12-08 11:22:24', '2021-12-08 17:24:53', ''),
(248, 0, 'INmcb-sp-10k-16a', '769', NULL, '340.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-sp-16a-10ka-1', 0, 1, NULL, '2021-12-08 11:24:20', '2021-12-08 17:22:27', ''),
(249, 0, 'INmcb-sp-10k-20a', '769', NULL, '340.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-sp-20a-10ka', 0, 1, NULL, '2021-12-09 11:23:52', NULL, ''),
(250, 0, 'INmcb-sp-10k-25a', '769', NULL, '340.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-sp-25a-10ka', 0, 1, NULL, '2021-12-09 11:34:17', NULL, ''),
(251, 0, 'INmcb-sp-10k-32a', '769', NULL, '340.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-sp-32a-10ka', 0, 1, NULL, '2021-12-09 11:37:14', NULL, ''),
(252, 0, 'INmcb-sp-10k-40a', '769', NULL, '425.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-sp-40a-10ka', 0, 1, NULL, '2021-12-09 11:58:19', NULL, ''),
(253, 0, 'INmcb-sp-10k-50a', '769', NULL, '425.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-sp-50a-10ka', 0, 1, NULL, '2021-12-09 12:00:24', NULL, ''),
(254, 0, 'INmcb-sp-10k-63a', '769', NULL, '625.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-sp-63a-10ka', 0, 1, NULL, '2021-12-09 12:06:40', NULL, ''),
(255, 0, 'INmcb-dp-6k-6a', '771', NULL, '700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-6a-6ka', 0, 1, NULL, '2021-12-09 12:10:21', NULL, ''),
(256, 0, 'INmcb-dp-6k-10a', '771', NULL, '700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-10a-6ka', 0, 1, NULL, '2021-12-09 12:15:14', NULL, ''),
(257, 0, 'INmcb-dp-6k-16a', '771', NULL, '700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-16a-6ka', 0, 1, NULL, '2021-12-09 12:17:51', NULL, ''),
(258, 0, 'INmcb-dp-6k-20a', '771', NULL, '700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-20a-6ka', 0, 1, NULL, '2021-12-09 12:32:59', NULL, ''),
(259, 0, 'INmcb-dp-6k-25a', '771', NULL, '700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-25a-6ka', 0, 1, NULL, '2021-12-09 13:52:59', NULL, ''),
(260, 0, 'INmcb-dp-6k-32a', '771', NULL, '700.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-32a-6ka', 0, 1, NULL, '2021-12-09 13:55:26', NULL, ''),
(261, 0, 'INmcb-dp-6k-40a', '771', NULL, '820.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-40a-6ka', 0, 1, NULL, '2021-12-09 13:57:48', NULL, ''),
(262, 0, 'INmcb-dp-6k-50a', '771', NULL, '820.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-50a-6ka', 0, 1, NULL, '2021-12-09 14:00:02', NULL, ''),
(263, 0, 'INmcb-dp-6k-63a', '771', NULL, '820.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-63a-6ka', 0, 1, NULL, '2021-12-09 14:02:16', NULL, ''),
(264, 0, 'INmcb-dp-10k-6a', '771', NULL, '800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-6a-10ka', 0, 1, NULL, '2021-12-09 14:08:12', NULL, ''),
(265, 0, 'INmcb-dp-10k-10a', '771', NULL, '800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-10a-10ka', 0, 1, NULL, '2021-12-09 14:12:14', NULL, ''),
(266, 0, 'INmcb-dp-10k-16a', '771', NULL, '800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-16a-10ka', 0, 1, NULL, '2021-12-09 14:49:19', NULL, ''),
(267, 0, 'INmcb-dp-10k-20a', '771', NULL, '800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-20a-10ka', 0, 1, NULL, '2021-12-09 14:51:03', NULL, ''),
(268, 0, 'INmcb-dp-10k-25a', '771', NULL, '800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-25a-10ka', 0, 1, NULL, '2021-12-09 14:53:10', NULL, ''),
(269, 0, 'INmcb-dp-10k-32a', '771', NULL, '800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-32a-10ka', 0, 1, NULL, '2021-12-09 14:55:10', NULL, ''),
(270, 0, 'INmcb-dp-10k-40a', '771', NULL, '950.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-40a-10ka', 0, 1, NULL, '2021-12-09 14:57:40', NULL, ''),
(271, 0, 'INmcb-dp-10k-50a', '771', NULL, '950.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-50a-10ka', 0, 1, NULL, '2021-12-09 15:00:21', NULL, ''),
(272, 0, 'INmcb-dp-10k-63a', '771', NULL, '1050.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-dp-63a-10ka', 0, 1, NULL, '2021-12-09 15:02:43', NULL, ''),
(273, 0, 'INmcb-tp-6k-6a', '770', NULL, '1160.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-6a-6ka', 0, 1, NULL, '2021-12-09 15:05:46', NULL, ''),
(274, 0, 'INmcb-tp-6k-10a', '770', NULL, '1160.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-10a-6ka', 0, 1, NULL, '2021-12-09 15:15:34', NULL, ''),
(275, 0, 'INmcb-tp-6k-16a', '770', NULL, '1160.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-16a-6ka', 0, 1, NULL, '2021-12-09 15:20:12', NULL, ''),
(276, 0, 'INmcb-tp-6k-20a', '770', NULL, '1160.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-20a-6ka', 0, 1, NULL, '2021-12-09 15:24:40', NULL, ''),
(277, 0, 'INmcb-tp-6k-25a', '770', NULL, '1160.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-25a-6ka', 0, 1, NULL, '2021-12-09 15:58:02', NULL, ''),
(278, 0, 'INmcb-tp-6k-32a', '770', NULL, '1160.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-32a-6ka', 0, 1, NULL, '2021-12-09 16:00:30', NULL, ''),
(279, 0, 'INmcb-tp-6k-40a', '770', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'mcb-tp-40a-6ka-1', 0, 1, NULL, '2021-12-09 16:03:13', '2021-12-09 16:04:18', ''),
(280, 0, 'INmcb-tp-6k-50a', '770', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-50a-6ka', 0, 1, NULL, '2021-12-09 16:07:27', NULL, ''),
(281, 0, 'INmcb-tp-6k-63a', '770', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-63a-6ka', 0, 1, NULL, '2021-12-09 16:13:52', NULL, ''),
(282, 0, 'INmcb-tp-10k-6a', '770', NULL, '1280.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-6a-10ka', 0, 1, NULL, '2021-12-09 16:19:57', NULL, ''),
(283, 0, 'INmcb-tp-10k-10a', '770', NULL, '1280.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-10a-10ka', 0, 1, NULL, '2021-12-09 16:22:28', NULL, ''),
(284, 0, 'INmcb-tp-10k-16a', '770', NULL, '1280.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-16a-10ka', 0, 1, NULL, '2021-12-09 16:28:13', NULL, ''),
(285, 0, 'INmcb-tp-10k-20a', '770', NULL, '1280.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-20a-10ka', 0, 1, NULL, '2021-12-09 16:34:27', NULL, ''),
(286, 0, 'INmcb-tp-10k-25a', '770', NULL, '1280.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-25a-10ka', 0, 1, NULL, '2021-12-11 15:06:39', NULL, ''),
(287, 0, 'INmcb-tp-10k-32a', '770', NULL, '1280.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-32a-10ka', 0, 1, NULL, '2021-12-11 15:08:57', NULL, ''),
(288, 0, 'INmcb-tp-10k-40a', '770', NULL, '1360.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-40a-10ka', 0, 1, NULL, '2021-12-11 15:11:13', NULL, ''),
(289, 0, 'INmcb-tp-10k-50a', '770', NULL, '1360.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-50a-10ka', 0, 1, NULL, '2021-12-11 15:13:08', NULL, ''),
(290, 0, 'INmcb-tp-10k-63a', '770', NULL, '1565.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mcb-tp-63a-10ka', 0, 1, NULL, '2021-12-11 15:15:41', NULL, ''),
(291, 0, 'INmccb,25k-32a', '773', NULL, '4680.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-32a-25ka', 0, 1, NULL, '2021-12-12 15:50:52', NULL, ''),
(292, 0, 'INmccb,25k-40a', '773', NULL, '4680.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-40a-25ka', 0, 1, NULL, '2021-12-12 15:59:24', NULL, ''),
(293, 0, 'INmccb,25k-63a', '773', NULL, '4680.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-63a-25ka', 0, 1, NULL, '2021-12-12 16:08:42', NULL, ''),
(294, 0, 'INmccb,25k-80a', '773', NULL, '5820.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-80a-25ka', 0, 1, NULL, '2021-12-12 16:12:52', NULL, ''),
(295, 0, 'INmccb,25k-100a', '773', NULL, '5820.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-100a-25ka', 0, 1, NULL, '2021-12-12 16:16:03', NULL, ''),
(296, 0, 'INmccb,25k-125a', '773', NULL, '6480.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-125a-25ka', 0, 1, NULL, '2021-12-12 16:19:25', NULL, ''),
(297, 0, 'INmccb,25k-160a', '773', NULL, '9340.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-160a-25ka', 0, 1, NULL, '2021-12-12 16:24:47', NULL, ''),
(298, 0, 'INmccb,25k-200a', '773', NULL, '11120.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-200a-25ka', 0, 1, NULL, '2021-12-12 16:28:50', NULL, ''),
(299, 0, 'INmccb,25k-250a', '773', NULL, '12800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-250a-25ka', 0, 1, NULL, '2021-12-12 16:32:08', NULL, ''),
(300, 0, 'INmccb,35k-350a', '773', NULL, '40240.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-350a-35ka', 0, 1, NULL, '2021-12-13 11:30:03', NULL, ''),
(301, 0, 'INmccb,35k-400a', '773', NULL, '40240.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-400a-35ka', 0, 1, NULL, '2021-12-13 12:03:50', NULL, ''),
(302, 0, 'INmccb,35k-500a', '773', NULL, '50160.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-500a-35ka', 0, 1, NULL, '2021-12-13 12:39:49', NULL, ''),
(303, 0, 'INmccb,35k-630a', '773', NULL, '60200.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-630a-35ka', 0, 1, NULL, '2021-12-13 12:42:31', NULL, ''),
(304, 0, 'INmccb,50k-800a', '773', NULL, '65200.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-800a-50ka', 0, 1, NULL, '2021-12-13 12:46:35', NULL, ''),
(305, 0, 'INmccb,35k-32a(adj)', '774', NULL, '9000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-32a-35ka-adj', 0, 1, NULL, '2021-12-13 13:17:19', NULL, ''),
(306, 0, 'INmccb,35k-40a(adj)', '774', NULL, '9000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-40a-35ka-adj', 0, 1, NULL, '2021-12-13 13:25:25', NULL, ''),
(307, 0, 'INmccb,35k-63a(adj)', '774', NULL, '9000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-63a-35ka-adj', 0, 1, NULL, '2021-12-13 14:05:10', NULL, ''),
(308, 0, 'INmccb,35k-80a(adj)', '774', NULL, '9000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-80a-35ka', 0, 1, NULL, '2021-12-13 14:12:17', '2021-12-13 14:13:14', ''),
(309, 0, 'INmccb,35k-100a(adj)', '774', NULL, '9000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-100a-35ka-adj', 0, 1, NULL, '2021-12-13 14:30:59', NULL, ''),
(310, 0, 'INmccb,35k-125a(adj)', '774', NULL, '9500.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-125a-35ka-adj', 0, 1, NULL, '2021-12-13 14:37:06', NULL, ''),
(311, 0, 'INmccb,35k-160a', '774', NULL, '13000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-160a-35ka-adj', 0, 1, NULL, '2021-12-13 14:43:15', NULL, ''),
(312, 0, 'INmccb,35k-200a(adj)', '774', NULL, '20000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-200a-35ka-adj', 0, 1, NULL, '2021-12-13 14:48:09', NULL, ''),
(313, 0, 'INmccb,35k-250a(adj)', '774', NULL, '25000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-250a-35ka-adj', 0, 1, NULL, '2021-12-14 14:17:23', NULL, ''),
(314, 0, 'INmccb,35k-350a(adj)', '774', NULL, '50000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-350a-35ka-adj', 0, 1, NULL, '2021-12-14 14:29:14', NULL, ''),
(315, 0, 'INmccb,35k-400a(adj)', '774', NULL, '50000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-400a-35ka-adj', 0, 1, NULL, '2021-12-14 14:32:02', NULL, ''),
(316, 0, 'INmccb,35k-500a(adj)', '774', NULL, '55000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-500a-35ka-adj', 0, 1, NULL, '2021-12-14 14:34:35', NULL, ''),
(317, 0, 'INmccb,35k-630a(adj)', '774', NULL, '60000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-630a-35ka-adj', 0, 1, NULL, '2021-12-14 14:43:07', NULL, ''),
(318, 0, 'INmccb,50k-800a(adj)', '774', NULL, '85000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-800a-50ka-adj', 0, 1, NULL, '2021-12-14 14:46:16', NULL, ''),
(319, 0, 'INmccb,50k-1000a(adj)', '774', NULL, '120000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-1000a-50ka-adj', 0, 1, NULL, '2021-12-14 14:50:05', NULL, ''),
(320, 0, 'DD,SPN-4way', '777', NULL, '950.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'double-door-spn-4-way', 0, 1, NULL, '2021-12-14 16:36:51', NULL, ''),
(321, 0, 'INmccb,50k-1250a(adj)', '774', NULL, '180000.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'indoasian-mccb-1250a-50ka-adj', 0, 1, NULL, '2021-12-15 10:42:32', NULL, ''),
(322, 0, 'DD-spn-6way', '777', NULL, '1500.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'double-door-spn-6-way', 0, 1, NULL, '2021-12-15 10:55:00', NULL, ''),
(323, 0, 'DD-spn-6way', '777', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'double-door-spn-6-way-1', 0, 1, NULL, '2021-12-15 11:16:57', NULL, ''),
(324, 0, 'DD-spn-8way', '777', NULL, '1250.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'double-door-spn-8-way', 0, 1, NULL, '2021-12-15 11:31:53', NULL, ''),
(325, 0, 'DD-spn-12way', '777', NULL, '1400.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'double-door-spn-12-way', 0, 1, NULL, '2021-12-15 11:39:39', NULL, ''),
(326, 0, 'DD-spn-16way', '777', NULL, '1800.00', '0000-00-00 00:00:00', NULL, NULL, '1', NULL, 1, 1, 0, NULL, 0, 0, 0, 0, 'double-door-spn-16-way', 0, 1, NULL, '2021-12-15 11:54:24', NULL, ''),
(327, 0, 'DD-spn-18way', '777', NULL, '2000.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'double-door-spn-18-way', 0, 1, NULL, '2021-12-15 11:58:39', '2022-01-06 16:43:57', ''),
(328, 0, NULL, '779', NULL, '2500.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'boishakhi-saree', 0, 1, NULL, '2022-04-09 10:03:55', '2022-04-09 10:17:43', ''),
(329, 0, NULL, '780', NULL, '2000.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'boishakhi-saree-2', 0, 1, NULL, '2022-04-09 13:12:31', NULL, ''),
(330, 0, NULL, '781', NULL, '2000.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'boishakhi-saree-3', 0, 1, NULL, '2022-04-09 13:29:54', NULL, ''),
(331, 0, NULL, '782', NULL, '2500.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'boishakhi-saree-4', 0, 1, NULL, '2022-04-09 13:51:20', NULL, ''),
(332, 0, NULL, '784', NULL, '2600.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'boishakhi-saree-5', 0, 1, NULL, '2022-04-09 13:53:04', NULL, ''),
(333, 0, NULL, '783', NULL, '2200.00', '0000-00-00 00:00:00', NULL, NULL, '1', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'boishakhi-saree-6', 0, 1, NULL, '2022-04-09 13:56:31', NULL, ''),
(361, 0, NULL, '820', NULL, '210.00', '0000-00-00 00:00:00', NULL, NULL, '34', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'protec-led-bulb-9w', 0, 1, NULL, '2022-11-06 15:06:07', NULL, ''),
(360, 0, NULL, '818', NULL, '180.00', '0000-00-00 00:00:00', NULL, NULL, '34', 'gm', 1, 1, 0, NULL, 0, 0, 0, 1, 'protec-led-bulb', 0, 1, NULL, '2022-11-06 14:40:34', '2022-11-06 14:49:49', ''),
(362, 0, NULL, '822', NULL, '270.00', '0000-00-00 00:00:00', NULL, NULL, '40', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'protec-led-bulb-12w', 0, 1, NULL, '2022-11-06 15:09:04', NULL, ''),
(363, 0, 'Radiator', '824', NULL, '265.00', '0000-00-00 00:00:00', NULL, NULL, '1000', 'gm', 1, 1, 0, NULL, 0, 0, 0, 0, 'transformer-radiator', 0, 1, 260, '2022-11-13 14:41:53', NULL, ''),
(364, 0, NULL, '828', NULL, '750.00', '0000-00-00 00:00:00', NULL, NULL, '300', 'gm', 1, 1, 0, NULL, 0, 0, 0, 1, 'pakistani-three-piece-white', 0, 1, NULL, '2022-11-23 16:43:08', NULL, ''),
(365, 0, NULL, '827', NULL, '750.00', '0000-00-00 00:00:00', NULL, NULL, '300', 'gm', 1, 1, 0, NULL, 0, 0, 0, 1, 'pakistani-three-piece-red', 0, 1, NULL, '2022-11-23 16:44:51', NULL, ''),
(366, 0, NULL, '826', NULL, '750.00', '0000-00-00 00:00:00', NULL, NULL, '300', 'gm', 1, 1, 0, NULL, 0, 0, 0, 1, 'pakistani-three-piece-green', 0, 1, NULL, '2022-11-23 16:46:11', NULL, ''),
(367, 0, NULL, '825', NULL, '750.00', '0000-00-00 00:00:00', NULL, NULL, '300', 'gm', 1, 1, 0, NULL, 0, 0, 0, 1, 'pakistani-three-piece-baby-pink', 0, 1, NULL, '2022-11-23 16:50:28', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `products_attributes`
--

CREATE TABLE `products_attributes` (
  `products_attributes_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `options_id` int(11) NOT NULL,
  `options_values_id` int(11) NOT NULL,
  `options_values_price` decimal(15,2) NOT NULL,
  `price_prefix` char(1) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products_attributes_download`
--

CREATE TABLE `products_attributes_download` (
  `products_attributes_id` int(11) NOT NULL,
  `products_attributes_filename` varchar(191) NOT NULL DEFAULT '',
  `products_attributes_maxdays` int(11) DEFAULT 0,
  `products_attributes_maxcount` int(11) DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products_description`
--

CREATE TABLE `products_description` (
  `id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL DEFAULT 1,
  `products_name` varchar(64) NOT NULL DEFAULT '',
  `products_description` text DEFAULT NULL,
  `products_url` varchar(191) DEFAULT NULL,
  `products_viewed` int(11) DEFAULT 0,
  `products_left_banner` text DEFAULT NULL,
  `products_left_banner_start_date` int(11) DEFAULT NULL,
  `products_left_banner_expire_date` int(11) DEFAULT NULL,
  `products_right_banner` text DEFAULT NULL,
  `products_right_banner_start_date` int(11) DEFAULT NULL,
  `products_right_banner_expire_date` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_description`
--

INSERT INTO `products_description` (`id`, `products_id`, `language_id`, `products_name`, `products_description`, `products_url`, `products_viewed`, `products_left_banner`, `products_left_banner_start_date`, `products_left_banner_expire_date`, `products_right_banner`, `products_right_banner_start_date`, `products_right_banner_expire_date`) VALUES
(184, 94, 4, 'Radiator', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(447, 354, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(446, 353, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(128, 66, 4, '30kVA Diesel Generator', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(129, 67, 1, '45kVA Diesel Generator', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(130, 67, 4, '45kVA Diesel Generator', '<p>Model:&nbsp;STRONG G45PS</p>\r\n\r\n<p>PRP Continous power kVA 45<br />\r\nPRP Continuous power kW 36<br />\r\nLTP Stand-by power kVA 50<br />\r\nLTP stand-by power kW 40<br />\r\nPower factor cos fi&phi; 0.8<br />\r\nVoltage VAC 400/230<br />\r\nFrecuency Hz 50<br />\r\nAmpere PRP/LTP 65 / 72<br />\r\nSpeed RPM 1500<br />\r\nFuel consumption:&nbsp;75% l./h 8.20<br />\r\nFuel Diesel<br />\r\nNr. cylinders 3<br />\r\nAir intake Turbocharged<br />\r\nCooling Water<br />\r\nMADE IN ITALY</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(131, 68, 1, '60kVA Diesel Generator', '<p>Model:&nbsp;STONE G60PS</p>\r\n\r\n<p>PRP Continous power kVA 60<br />\r\nPRP Continuous power kW 48<br />\r\nLTP Stand-by power kVA 66<br />\r\nLTP stand-by power kW 53<br />\r\nPower factor cos fi&phi; 0.8<br />\r\nVoltage VAC 400/230<br />\r\nFrecuency Hz 50<br />\r\nAmpere PRP/LTP 87 / 95<br />\r\nSpeed RPM 1500<br />\r\nFuel consumption:&nbsp;75% l./h 10.40<br />\r\nFuel Diesel<br />\r\nNr. cylinders 3<br />\r\nAir intake Turbocharged<br />\r\nCooling Water<br />\r\nMADE IN ITALY</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(79, 42, 1, 'Rouen Fabric Punjabi Navy Blue', '<p>Rouen Fabric Punjabi Aflatoon</p>\r\n\r\n<p>Hand Wash&nbsp;</p>\r\n\r\n<p>Normal Iron</p>\r\n\r\n<p>Payment Systems : Bkash, Rocket, Cradit/Debit Card or Cash on Delivery&nbsp;</p>\r\n\r\n<p>Inside Dhaka : 70TK</p>\r\n\r\n<p>Outside Dhaka : 120TK</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(80, 42, 4, 'Rouen Fabric Punjabi Navy Blue', '', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(448, 355, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(428, 335, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(211, 118, 1, 'Stylish Kurti -04', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(212, 119, 1, 'Stylish Kurti -05', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(450, 357, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(219, 126, 1, 'Women\'s Gold & White Heels', '<p>Women&#39;s Gold &amp; White Heels</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(224, 131, 1, 'Stylish Kurti -13', '<p>Stylish Kurti -13</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(229, 136, 1, 'Falgun saree', '<p>Half silk falgun saree</p>\r\n\r\n<p>&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(230, 137, 1, 'Falgun saree 2', '<p>Half Silk Falgun Saree</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(243, 150, 1, 'Green Tat Saree', '<p>&nbsp;Green Tat Saree</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(244, 151, 1, 'Red  Tat Saree', '<p>Exclusive Tat Saree</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(245, 152, 1, 'Laser Cut work Saree', '<p>Half silk Laser Cut work Saree</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(246, 153, 1, 'Laser Cut work Saree 2', '<p>Half silk Laser Cut work Saree</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(247, 154, 1, 'Laser Cut work Saree 3', '<p>Half silk Laser Cut work Saree-White&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(248, 155, 1, 'Laser Cut work Saree 4', '<p>Half silk Laser Cut work Saree- Red Black</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(249, 156, 1, 'Laser Cut work Saree 5', '<p>Half Silk Laser Cut work Saree - Ash</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(250, 157, 1, 'Laser Cut work Saree 6', '<p>Half silk Laser Cut work Saree - Black</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(251, 158, 1, 'ekush Saree', '<p>Half silk - black</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(252, 159, 1, 'ekush Saree 2', '<p>Pure Cotton with block print</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(253, 160, 1, 'Fagun saree 1', '<p>Haldloom pure cotton</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(254, 161, 1, 'Jamdani Saree', '<p>Pure Dhakay Jamdani</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(255, 162, 1, 'Fagun Sareee', '<p>Half silk</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(256, 163, 1, 'Fagun Saree 2', '<p>Cotton Block print</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(263, 170, 1, 'Hand Paint 4', '<p>Pure Cotton with hand painted</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(264, 171, 1, 'Ekush Saree  4', '<p>Full Cotton Block print</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(265, 172, 1, 'Fagun Saree 3', '<p>Pure Cotton Block Print</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(185, 95, 1, 'USA BAG', '<p>USA BAG&nbsp; W-12, H-15 inch</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(186, 95, 4, 'USA BAG', '<p>USA BAG&nbsp; W-12, H-15 inch</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(187, 96, 1, 'Fortune BAG', '<p>Fortune BAG&nbsp; W-12, H-15 inch</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(188, 96, 4, 'Fortune BAG', '<p>Fortune BAG&nbsp; W-12, H-15 inch</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(189, 97, 1, 'Cinderella BAG', '<p>Cinderella BAG&nbsp; W-11, H-13 inch</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(190, 97, 4, 'Cinderella BAG', '<p>Cinderella BAG&nbsp; W-11, H-13 inch</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(191, 98, 1, 'Ladies Tops', '<p>Size : M</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(193, 100, 1, 'Stylish Kurti-02', '<p>Size : M</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(194, 101, 1, 'Stylish Kurti -03', '<p>Size : M</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(132, 68, 4, 'MADE IN ITALY', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(133, 69, 1, '80kVA Diesel Generator', '<p>Model:&nbsp;KING G80PS</p>\r\n\r\n<p>PRP Continous power kVA 80<br />\r\nPRP Continuous power kW 64<br />\r\nLTP Stand-by power kVA 88<br />\r\nLTP stand-by power kW 70<br />\r\nPower factor cos fi&phi; 0.8<br />\r\nVoltage VAC 400/230<br />\r\nFrecuency Hz 50<br />\r\nAmpere PRP/LTP 116 / 127<br />\r\nSpeed RPM 1500<br />\r\nFuel consumption:&nbsp;75% l./h 14.00<br />\r\nFuel Diesel oil<br />\r\nNr. cylinders 4<br />\r\nAir intake Aspirated<br />\r\nCooling Water</p>\r\n\r\n<p>MADE IN ITALY</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(134, 69, 4, 'MADE IN ITALY', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(135, 70, 1, '100kVA Diesel Generator', '<p>Model:&nbsp;QUEEN G100PS</p>\r\n\r\n<p>PRP Continous power kVA 100<br />\r\nPRP Continuous power kW 80<br />\r\nLTP Stand-by power kVA 110<br />\r\nLTP stand-by power kW 88<br />\r\nPower factor cos fi&phi; 0.8<br />\r\nVoltage VAC 400/230<br />\r\nFrecuency Hz 50<br />\r\nAmpere PRP/LTP 145 / 159<br />\r\nSpeed RPM 1500<br />\r\nFuel consumption: 75% l./h 17.10<br />\r\nFuel Diesel<br />\r\nNr. cylinders 4<br />\r\nAir intake Turbocharged<br />\r\nCooling Water</p>\r\n\r\n<p>MADE IN ITALY</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(136, 70, 4, 'MADE IN ITALY', '', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(137, 71, 1, '150kVA Diesel Generator', '<p>Model:&nbsp;QUEEN G150PS</p>\r\n\r\n<p>PRP Continous power kVA 150<br />\r\nPRP Continuous power kW 120<br />\r\nLTP Stand-by power kVA 165<br />\r\nLTP stand-by power kW 132<br />\r\nPower factor cos fi&phi; 0.8<br />\r\nVoltage VAC 400/230<br />\r\nFrecuency Hz 50<br />\r\nAmpere PRP/LTP 217 / 238<br />\r\nSpeed RPM 1500<br />\r\nFuel consumption:&nbsp;75% l./h 24.70<br />\r\nFuel Diesel<br />\r\nNr. cylinders 6<br />\r\nAir intake Turbocharged<br />\r\nCooling Water</p>\r\n\r\n<p>MADE IN ITALY</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(138, 71, 4, 'MADE IN ITALY', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(139, 72, 1, '200kVA Diesel Generator', '<p>Model :&nbsp;QUEEN G200PS</p>\r\n\r\n<p>PRP Continous power kVA 200<br />\r\nPRP Continuous power kW 160<br />\r\nLTP Stand-by power kVA 220<br />\r\nLTP stand-by power kW 176<br />\r\nPower factor cos fi&phi; 0.8<br />\r\nVoltage VAC 400/230<br />\r\nFrecuency Hz 50<br />\r\nAmpere PRP/LTP 289 / 318<br />\r\nSpeed RPM 1500<br />\r\nFuel consumption:&nbsp;75% l./h 34.70<br />\r\nFuel Diesel<br />\r\nNr. cylinders 6<br />\r\nAir intake Turbocharged<br />\r\nCooling Water</p>\r\n\r\n<p>MADE IN ITALY</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(140, 72, 4, 'MADE IN ITALY', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(141, 73, 1, '250kVA Diesel Generator', '<p>Model :&nbsp;ROYAL G250PS</p>\r\n\r\n<p>PRP Continous power kVA 250<br />\r\nPRP Continuous power kW 200<br />\r\nLTP Stand-by power kVA 275<br />\r\nLTP stand-by power kW 220<br />\r\nPower factor cos fi&phi; 0.8<br />\r\nVoltage VAC 400/230<br />\r\nFrecuency Hz 50<br />\r\nAmpere PRP/LTP 361 / 397<br />\r\nSpeed RPM 1500<br />\r\nFuel consumption&nbsp;75% l./h 41.60<br />\r\nFuel Diesel<br />\r\nNr. cylinders 6<br />\r\nAir intake Turbo intercooler<br />\r\nCooling Water</p>\r\n\r\n<p>MADE IN ITALY</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(142, 73, 4, 'MADE IN ITALY', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(147, 76, 1, 'shari-00007', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(148, 76, 4, 'shari-00005', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(149, 77, 1, 'shari-00008', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(150, 77, 4, 'shari-00005', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(153, 79, 1, 'One Gang', '<p>One Gang</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(154, 79, 4, 'One Gang', '', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(155, 80, 1, 'Three Gang', '<p>Three Gang</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(156, 80, 4, 'Three Gang', '', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(157, 81, 1, 'Four Gang', '<p>Four Gang&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(158, 81, 4, 'Four Gang', '', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(159, 82, 1, 'Fan Dimmer', '<p>Fan Dimmer</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(160, 82, 4, 'Fan Dimmer', '<p>Fan Dimmer</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(161, 83, 1, 'Telephone Socket', '<p>Telephone Socket&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(162, 83, 4, 'Telephone Socket', '<p>Telephone Socket&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(449, 356, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(97, 51, 1, 'Lunaa', '<p>100% Cooton</p>\r\n\r\n<p>Only non-chlorine bleach when needed</p>\r\n\r\n<p>Medium iron if needed</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(98, 51, 4, 'l', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(431, 338, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(430, 337, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(125, 65, 1, '20kVA Diesel Generator', '<p>Model:&nbsp;INFINITY G20PS</p>\r\n\r\n<p>Fuel consumption:&nbsp;Consumption 75% l./h 4.00<br />\r\nEngine brand Perkins<br />\r\nPRP Continous power kVA 20<br />\r\nPRP Continuous power kW 16<br />\r\nLTP Stand-by power kVA 22<br />\r\nLTP stand-by power kW 18<br />\r\nPower factor cos&phi; 0.8<br />\r\nVoltage VAC 400/230<br />\r\nFrecuency Hz 50<br />\r\nAmpere PRP/LTP 29 / 32<br />\r\nSpeed RPM 1500<br />\r\nFuel Diesel oil<br />\r\nNr. cylinders 4<br />\r\nAir intake Aspirated<br />\r\nCooling Water</p>\r\n\r\n<p>MADE IN ITALY</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(126, 65, 4, '20kVA Diesel Generator', '', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(127, 66, 1, '30kVA Diesel Generator', '<p>Model: STRONG G30PS-E</p>\r\n\r\n<p>PRP Continous power kVA 30<br />\r\nPRP Continuous power kW 24<br />\r\nLTP Stand-by power kVA 33<br />\r\nLTP stand-by power kW 26<br />\r\nPower factor cos fi&phi; 0.8<br />\r\nVoltage VAC 400/230<br />\r\nFrecuency Hz 50<br />\r\nAmpere PRP/LTP 43 / 48<br />\r\nSpeed RPM 1500<br />\r\nFuel consumption:&nbsp;Consumption 75% l./h 6.10</p>\r\n\r\n<p>Fuel Diesel oil<br />\r\nNr. cylinders 4<br />\r\nAir intake Aspirated<br />\r\nCooling Water</p>\r\n\r\n<p>MADE IN ITALY<br />\r\n&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(441, 348, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(442, 349, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(443, 350, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(444, 351, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(445, 352, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(432, 339, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(433, 340, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(434, 341, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(435, 342, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(436, 343, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(437, 344, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(438, 345, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(439, 346, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(440, 347, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Biscos Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(183, 94, 1, 'Radiator', '<p>Item Name : Radiator (Corrugated)</p>\r\n\r\n<table border=\\\"1\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" style=\\\"width:681px\\\">\r\n	<tbody>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:58px\\\">\r\n			<p><strong>SL.NO</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Description</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:51px\\\">\r\n			<p><strong>Unit</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:259px\\\">\r\n			<p><strong>To be filled by bidder</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:58px\\\">\r\n			<p><strong>1</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Manufacturer </strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:51px\\\">\r\n			<p>&nbsp;</p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:259px\\\">\r\n			<p><strong>POWERtrac</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:58px\\\">\r\n			<p><strong>2</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Up to </strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:51px\\\">\r\n			<p><strong>kVA</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:259px\\\">\r\n			<p><strong>630</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:58px\\\">\r\n			<p><strong>3</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Type</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:51px\\\">\r\n			<p>&nbsp;</p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:259px\\\">\r\n			<p><strong>Corrugated</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:58px\\\">\r\n			<p><strong>4</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Ms sheet</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:51px\\\">\r\n			<p><strong>Swg</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:259px\\\">\r\n			<p><strong>17</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:58px\\\">\r\n			<p><strong>5</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Cooling</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:51px\\\">\r\n			<p>&nbsp;</p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:259px\\\">\r\n			<p><strong>ONAN</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:58px\\\">\r\n			<p><strong>6</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Dimension</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:51px\\\">\r\n			<p>&nbsp;</p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:259px\\\">\r\n			<p><strong>Depends On Customer</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:58px\\\">\r\n			<p><strong>7</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Fin to Fin Distance</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:51px\\\">\r\n			<p><strong>mm</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:259px\\\">\r\n			<p><strong>50</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:58px\\\">\r\n			<p><strong>8</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Fin Width</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:51px\\\">\r\n			<p><strong>mm</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:259px\\\">\r\n			<p><strong>180 (max)</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:58px\\\">\r\n			<p><strong>9</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Fin length</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:51px\\\">\r\n			<p><strong>mm</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:259px\\\">\r\n			<p><strong>1000 (max)</strong></p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<table border=\\\"0\\\" cellpadding=\\\"0\\\" cellspacing=\\\"0\\\" style=\\\"width:363px\\\">\r\n	<tbody>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:49px\\\">\r\n			<p>&nbsp;</p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>List of Accessories</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:49px\\\">\r\n			<p><strong>1) </strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Lifting Bar</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:49px\\\">\r\n			<p><strong>2)</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Drain Plug</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:49px\\\">\r\n			<p><strong>3)</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>Connecting Pipe with Flange</strong></p>\r\n			</td>\r\n		</tr>\r\n		<tr>\r\n			<td style=\\\"height:19px; width:49px\\\">\r\n			<p><strong>4)</strong></p>\r\n			</td>\r\n			<td style=\\\"height:19px; width:313px\\\">\r\n			<p><strong>After pretreatment Red Oxide primer on surface.</strong></p>\r\n			</td>\r\n		</tr>\r\n	</tbody>\r\n</table>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Price : 200/KG</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(163, 84, 1, 'Multi Socket with Switch', '<p>Multi Socket with Switch</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(164, 84, 4, 'Multi Socket with Switch', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(165, 85, 1, 'DP Switch', '<p>DP Switch</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(166, 85, 4, 'DP Switch', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(167, 86, 1, 'Three pin USB Socket', '<p>Three pin USB Socket</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(168, 86, 4, 'Three pin USB Socket', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(169, 87, 1, 'Three Pin Round Socket', '<p>Three Pin Round Socket</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(170, 87, 4, 'Three Pin Round Socket', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(198, 105, 1, 'Indian Two Piece', '<p>Size : L</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(197, 104, 1, 'Pure Cotton Round Kuchi Dress', '<p>Size : M</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(177, 91, 1, 'Puja Couple-004', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(178, 91, 4, 'Puja Couple-004', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(179, 92, 1, 'Puja Couple-005', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(180, 92, 4, 'Puja Couple-005', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(429, 336, 1, 'Eid-ul-fittar 2022 collection', '<p>Premium quality men&#39;s cotton Panjabi<br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(427, 334, 1, 'Eid-ul-fittar 2022 collection', '<p><strong>Premium quality men&#39;s cotton Panjabi</strong><br />\r\n&nbsp;<br />\r\ncolor- Multicolor<br />\r\n&bull;Main Material- 100% Pure Cotton<br />\r\n&bull;size: M, L XL<br />\r\nGender- man<br />\r\nFabric &ndash; Cotton Fabric<br />\r\n&bull; Designed according to the latest patterns<br />\r\n&bull; Offered in various sizes and colors<br />\r\n&bull; Easy to wash&bull; Perfect fitting<br />\r\n&bull; Comfortable &amp;amp; soft<br />\r\n&bull; High-quality fabric on the basis of price, stylish design, and comfortable. Picture Type-<br />\r\nThis Picture is a Real Picture of This Product Country Of Origin- Bangladesh<br />\r\nM : 28-30, length =36<br />\r\nL : 32-34 length =38<br />\r\nXL : 34 -36 length =40&nbsp;<br />\r\nproduct color in the image; The color of the image and the actual product may vary slightly for<br />\r\nYour computer or mobile resolution and lighting</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(269, 176, 1, 'MCB SP-20A, 6KA', '<p>Dorman Smith&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating:&nbsp;SP-20A</p>\r\n\r\n<p>Breaking Capacity : 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(270, 177, 1, 'MCB SP-25A, 6KA', '<p>Dorman Smith&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(271, 178, 1, 'MCB SP-32A, 6KA', '<p>Dorman Smith</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(272, 179, 1, 'MCB SP-40A, 6KA', '<p>Dorman Smith</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(275, 182, 1, 'MCB SP-50A, 6KA', '<p>Dorman Smith</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 50A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(276, 183, 1, 'MCB SP-63A, 6KA', '<p>Dorman Smith&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(277, 184, 1, 'MCB SP-6A, 10KA', '<p>Dorman Smith</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 6A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(278, 185, 1, 'MCB SP-10A, 10KA', '<p>Dorman Smith&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating - 10A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(279, 186, 1, 'MCB SP-16A, 10KA', '<p>Dorman Smith</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 16A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(280, 187, 1, 'MCB SP-20A, 10KA', '<p>Dorman Smith&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(281, 188, 1, 'MCB SP-25A, 10KA', '<p>Dorman Smith</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(282, 189, 1, 'MCB SP-32A,10KA', '<p>Dorman Smith</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(283, 190, 1, 'MCB SP-40A, 10KA', '<p>Dorman Smith&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(284, 191, 1, 'MCB SP-50A,10KA', '<p>Dorman Smith</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 50A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(285, 192, 1, 'MCB SP-63A, 10KA', '<p>Dorman Smith</p>\r\n\r\n<p>Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(286, 193, 1, 'MCB DP-16A, 6KA', '<p>Brand- Dorman Smith, UK</p>\r\n\r\n<p>Douple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating-16A</p>\r\n\r\n<p>Breaking Capacity-6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(287, 194, 1, 'MCB DP-20A, 6KA', '<p>Brand- Dorman Smith, UK</p>\r\n\r\n<p>Double Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(288, 195, 1, 'MCB DP-25A, 6KA', '<p>Brand- Dorman Smith, UK</p>\r\n\r\n<p>Double Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(289, 196, 1, 'MCB DP-32A, 6KA', '<p>Brand- Dorman Smith, Uk</p>\r\n\r\n<p>Double Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity-6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(290, 197, 1, 'MCB DP-40A, 6KA', '<p>Brand- Dorman Smith, UK</p>\r\n\r\n<p>Double Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(291, 198, 1, 'MCB DP-50A, 6KA', '<p>Brand- Dorman Smith, UK</p>\r\n\r\n<p>Double Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 50A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(292, 199, 1, 'MCB DP-63A, 6KA', '<p>Brand- Dorman Smith, UK</p>\r\n\r\n<p>Double Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(293, 200, 1, 'MCB DP-16A, 10KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Double Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 16A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(294, 201, 1, 'MCB DP-20A, 10KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Double Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(295, 202, 1, 'MCB DP-25A, 10KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Double Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(296, 203, 1, 'MCB DP-32A, 10KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Double Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(297, 204, 1, 'MCB DP-40A, 10KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Double Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(298, 205, 1, 'MCB TP-20A, 6KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple&nbsp;Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(299, 206, 1, 'MCB TP-25A, 6KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(300, 207, 1, 'MCB TP-32A, 6KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(301, 208, 1, 'MCB TP-40A, 6KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(302, 209, 1, 'MCB TP-50A, 6KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 50A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(303, 210, 1, 'MCB TP-63A, 6KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(304, 211, 1, 'MCB SP-20A, 6KA', '', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(305, 212, 1, 'MCB TP-20A, 10KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(306, 213, 1, 'MCB TP-25A, 10KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL);
INSERT INTO `products_description` (`id`, `products_id`, `language_id`, `products_name`, `products_description`, `products_url`, `products_viewed`, `products_left_banner`, `products_left_banner_start_date`, `products_left_banner_expire_date`, `products_right_banner`, `products_right_banner_start_date`, `products_right_banner_expire_date`) VALUES
(307, 214, 1, 'MCB TP-32A, 10KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(308, 215, 1, 'MCB TP-40A, 10KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(309, 216, 1, 'MCB TP-50A, 10KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 50A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(310, 217, 1, 'MCB TP-63A, 10KA', '<p>Brand- Dorman Smith</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker&nbsp;</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(313, 220, 1, 'MCCB-20A, 25KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(312, 219, 1, 'MCCB-16A, 25KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 16A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(314, 221, 1, 'MCCB-32A, 25KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(315, 222, 1, 'MCCB-40A, 25KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(316, 223, 1, 'MCCB-63A, 25KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(317, 224, 1, 'MCCB-70A, 25KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 70A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(318, 225, 1, 'MCCB-100A, 25KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 100A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(319, 226, 1, 'MCCB-125A, 36KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 125A</p>\r\n\r\n<p>Breaking Capacity- 36KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(320, 227, 1, 'MCCB-160A, 36KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 160A</p>\r\n\r\n<p>Breaking Capacity- 36KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(321, 228, 1, 'MCCB-200A, 36KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 200A</p>\r\n\r\n<p>Breaking Capacity- 36KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(322, 229, 1, 'MCCB-250A, 36KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 250A</p>\r\n\r\n<p>Breaking Capacity- 36KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(323, 230, 1, 'MCCB-315A, 65KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 315A</p>\r\n\r\n<p>Breaking Capacity- 65KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(324, 231, 1, 'MCCB-400A, 65KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 400A</p>\r\n\r\n<p>Breaking Capacity- 65KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(325, 232, 1, 'MCCB-500A, 65KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 500A</p>\r\n\r\n<p>Breaking Capacity- 65KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(326, 233, 1, 'MCCB-630A, 65KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 630A</p>\r\n\r\n<p>Breaking Capacity- 65KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(327, 234, 1, 'MCCB-800A, 85KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 800A</p>\r\n\r\n<p>Breaking Capacity- 85KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(328, 235, 1, 'MCCB-1000A, 85KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 1000A</p>\r\n\r\n<p>Breaking Capacity- 85KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(329, 236, 1, 'MCCB-1250A, 85KA', '<p>Brand- Dorman Smith&nbsp;</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 1250A</p>\r\n\r\n<p>Breaking Capacity- 85KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(330, 237, 1, 'INDOASIAN MCB SP-6A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 6A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(331, 238, 1, 'INDOASIAN MCB SP-10A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 10A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(332, 239, 1, 'INDOASIAN MCB SP-16A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 16A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(333, 240, 1, 'INDOASIAN MCB SP-20A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(334, 241, 1, 'INDOASIAN MCB SP-25A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(335, 242, 1, 'INDOASIAN MCB SP-32A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(336, 243, 1, 'INDOASIAN MCB SP-40A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(337, 244, 1, 'INDOASIAN MCB SP-50A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 50A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(338, 245, 1, 'INDOASIAN MCB SP-63A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(339, 246, 1, 'INDOASIAN MCB SP-6A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 6A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(340, 247, 1, 'INDOASIAN MCB SP-10A, 10KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 10A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(341, 248, 1, 'INDOASIAN MCB SP-16A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 16A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(342, 249, 1, 'INDOASIAN MCB SP-20A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(343, 250, 1, 'INDOASIAN MCB SP-25A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(344, 251, 1, 'INDOASIAN MCB SP-32A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(345, 252, 1, 'INDOASIAN MCB SP-40A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(346, 253, 1, 'INDOASIAN MCB SP-50A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 50A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(347, 254, 1, 'INDOASIAN MCB SP-63A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(348, 255, 1, 'INDOASIAN MCB DP-6A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 6A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(349, 256, 1, 'INDOASIAN MCB DP-10A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 10A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(350, 257, 1, 'INDOASIAN MCB DP-16A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 16A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(351, 258, 1, 'INDOASIAN MCB DP-20A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(352, 259, 1, 'INDOASIAN MCB DP-25A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(353, 260, 1, 'INDOASIAN MCB DP-32A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(354, 261, 1, 'INDOASIAN MCB DP-40A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(355, 262, 1, 'INDOASIAN MCB DP-50A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 50A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(356, 263, 1, 'INDOASIAN MCB DP-63A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(357, 264, 1, 'INDOASIAN MCB DP-6A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 6A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(358, 265, 1, 'INDOASIAN MCB DP-10A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 10A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(359, 266, 1, 'INDOASIAN MCB DP-16A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 16A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(360, 267, 1, 'INDOASIAN MCB DP-20A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(361, 268, 1, 'INDOASIAN MCB DP-25A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(362, 269, 1, 'INDOASIAN MCB DP-32A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(363, 270, 1, 'INDOASIAN MCB DP-40A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(364, 271, 1, 'INDOASIAN MCB DP-50A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 50A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(365, 272, 1, 'INDOASIAN MCB DP-63A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Double pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(366, 273, 1, 'INDOASIAN MCB TP-6A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple&nbsp;pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 6A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(367, 274, 1, 'INDOASIAN MCB TP-10A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 10A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(368, 275, 1, 'INDOASIAN MCB TP-16A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 16A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(369, 276, 1, 'INDOASIAN MCB TP-20A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(370, 277, 1, 'INDOASIAN MCB TP-25A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(371, 278, 1, 'INDOASIAN MCB TP-32A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(372, 279, 1, 'INDOASIAN MCB TP-40A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(373, 280, 1, 'INDOASIAN MCB TP-50A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 50A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(374, 281, 1, 'INDOASIAN MCB TP-63A, 6KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 6KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(375, 282, 1, 'INDOASIAN MCB TP-6A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 6A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(376, 283, 1, 'INDOASIAN MCB TP-10A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 10A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(377, 284, 1, 'INDOASIAN MCB TP-16A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 16A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(378, 285, 1, 'INDOASIAN MCB TP-20A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 20A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(379, 286, 1, 'INDOASIAN MCB TP-25A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 25A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(380, 287, 1, 'INDOASIAN MCB TP-32A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(381, 288, 1, 'INDOASIAN MCB TP-40A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(382, 289, 1, 'INDOASIAN MCB TP-50A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 50A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(383, 290, 1, 'INDOASIAN MCB TP-63A, 10KA', '<p>Brand- INDOASIAN&nbsp;</p>\r\n\r\n<p>Triple Pole, Miniature Circuit Breaker</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 10KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(384, 291, 1, 'INDOasian MCCB, 32A-25KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(385, 292, 1, 'INDOasian MCCB, 40A-25KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(386, 293, 1, 'INDOasian MCCB, 63A-25KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(387, 294, 1, 'INDOasian MCCB, 80A-25KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 80A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(388, 295, 1, 'INDOasian MCCB, 100A-25KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 100A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(389, 296, 1, 'INDOasian MCCB, 125A-25KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 125A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(390, 297, 1, 'INDOasian MCCB, 160A-25KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 160A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(391, 298, 1, 'INDOasian MCCB, 200A-25KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(392, 299, 1, 'INDOasian MCCB, 250A-25KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 225A</p>\r\n\r\n<p>Breaking Capacity- 25KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(393, 300, 1, 'INDOasian MCCB, 350A-35KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Fixed Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 350A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(394, 301, 1, 'INDOasian MCCB, 400A-35KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Fixed Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 400A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(395, 302, 1, 'INDOasian MCCB, 500A-35KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Fixed Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 500A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(396, 303, 1, 'INDOasian MCCB, 630A-35KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Fixed Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 630A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(397, 304, 1, 'INDOasian MCCB, 800A-50KA', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Fixed Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 800A</p>\r\n\r\n<p>Breaking Capacity- 50KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(398, 305, 1, 'INDOasian MCCB, 32A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 32A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(399, 306, 1, 'INDOasian MCCB, 40A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 40A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(400, 307, 1, 'INDOasian MCCB, 63A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 63A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(401, 308, 1, 'INDOasian MCCB, 80A-35KA (adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 80A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(402, 309, 1, 'INDOasian MCCB, 100A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 100A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(403, 310, 1, 'INDOasian MCCB, 125A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 125A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(404, 311, 1, 'INDOasian MCCB, 160A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 160A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(405, 312, 1, 'INDOasian MCCB, 200A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 200A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(406, 313, 1, 'INDOasian MCCB, 250A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 250A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(407, 314, 1, 'INDOasian MCCB, 350A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 350A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(408, 315, 1, 'INDOasian MCCB, 400A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 400A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(409, 316, 1, 'INDOasian MCCB, 500A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 500A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(410, 317, 1, 'INDOasian MCCB, 630A-35KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 630A</p>\r\n\r\n<p>Breaking Capacity- 35KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(411, 318, 1, 'INDOasian MCCB, 800A-50KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 800A</p>\r\n\r\n<p>Breaking Capacity- 50KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(412, 319, 1, 'INDOasian MCCB, 1000A-50KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 1000A</p>\r\n\r\n<p>Breaking Capacity- 50KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(413, 320, 1, 'Double Door, SPN, 4 way', '<p>Brand: ProtecBox( Indoasian)</p>\r\n\r\n<p>Double Door, SPN Type</p>\r\n\r\n<p>Way- 4</p>\r\n\r\n<p>Incoming+ Outgoing-4</p>\r\n\r\n<p>Dimension- 200*265*87</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(414, 321, 1, 'INDOasian MCCB, 1250A-50KA(adj)', '<p>Brand- INDOASIAN</p>\r\n\r\n<p>Adjustable Type, Moulded Case Circuit Breaker</p>\r\n\r\n<p>Rating- 1250A</p>\r\n\r\n<p>Breaking Capacity- 50KA&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(415, 322, 1, 'Double Door, SPN, 6 way', '<p>Brand: ProtecBox( Indoasian)</p>\r\n\r\n<p>Double Door, SPN Type</p>\r\n\r\n<p>Way- 6</p>\r\n\r\n<p>Incoming+ Outgoing-6</p>\r\n\r\n<p>Dimension- 265 x 300 x 87</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(416, 323, 1, 'Double Door, SPN, 6 way', '<p>Brand: ProtecBox( Indoasian)</p>\r\n\r\n<p>Double Door, SPN Type</p>\r\n\r\n<p>Way- 6</p>\r\n\r\n<p>Incoming+ Outgoing- 2+6</p>\r\n\r\n<p>Dimension- 265 x 300 x 87</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(417, 324, 1, 'Double Door, SPN, 8 way', '<p>Brand: ProtecBox( Indoasian)</p>\r\n\r\n<p>Double Door, SPN Type</p>\r\n\r\n<p>Way- 8</p>\r\n\r\n<p>Incoming+ Outgoing- 8</p>\r\n\r\n<p>Dimension- 265 x 300 x 87</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(418, 325, 1, 'Double Door, SPN, 12 way', '<p>Brand: ProtecBox( Indoasian)</p>\r\n\r\n<p>Double Door, SPN Type</p>\r\n\r\n<p>Way- 12</p>\r\n\r\n<p>Incoming+ Outgoing- 12</p>\r\n\r\n<p>Dimension- 275 x 405&nbsp;x 87</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(419, 326, 1, 'Double Door, SPN, 16 way', '<p>Brand: ProtecBox( Indoasian)</p>\r\n\r\n<p>Double Door, SPN Type</p>\r\n\r\n<p>Way- 16</p>\r\n\r\n<p>Incoming+ Outgoing- 16</p>\r\n\r\n<p>Dimension- 275 x 445&nbsp;x 87</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(420, 327, 1, 'Double Door, SPN, 18 way', '<p>Brand: ProtecBox( Indoasian)</p>\r\n\r\n<p>Double Door, SPN Type</p>\r\n\r\n<p>Way- 18</p>\r\n\r\n<p>Incoming+ Outgoing- 18</p>\r\n\r\n<p>Dimension- 275 x 445&nbsp;x 87</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(421, 328, 1, 'Boishakhi Saree', '<p>Pohela Boishakh Saree</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(422, 329, 1, 'Boishakhi Saree 2', '<p>Pohela Boishakh Saree</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(423, 330, 1, 'Boishakhi Saree 3', '<p>Pohela Boishakh Saree</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(424, 331, 1, 'Boishakhi Saree 4', '<p>Pohela Boishakh Saree</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(425, 332, 1, 'Boishakhi Saree 5', '<p>Pohela Boishakh Saree</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(426, 333, 1, 'Boishakhi Saree 6', '<p>Pohela Boishakh Saree</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(453, 360, 1, 'Protec LED Bulb 5w', '<p>Model : LED B22 E27</p>\r\n\r\n<p>Color Rendering Index : 80Ra</p>\r\n\r\n<p>Input Voltage : 85-265V AC</p>\r\n\r\n<p>Lumen Ourput : 250-600Lm</p>\r\n\r\n<p>Rated&nbsp; Frequency : 50/60Hz</p>', NULL, 0, NULL, 0, 0, NULL, 0, 0),
(454, 361, 1, 'Protec LED Bulb 9w', '<p>Model : LED B22 E27</p>\r\n\r\n<p>Color Rendering Index : 80Ra</p>\r\n\r\n<p>Input Voltage : 85-265V AC</p>\r\n\r\n<p>Lumen Ourput : 600-1050Lm</p>\r\n\r\n<p>Rated&nbsp;&nbsp;Frequency : 50/60Hz</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(455, 362, 1, 'Protec LED Bulb 12w', '<p>Model : LED B22 E27</p>\r\n\r\n<p>Color Rendering Index : 80Ra</p>\r\n\r\n<p>Input Voltage : 85-265V AC</p>\r\n\r\n<p>Lumen Ourput : 800-1125Lm</p>\r\n\r\n<p>Rated&nbsp;&nbsp;Frequency : 50/60Hz</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(456, 363, 1, 'Transformer Radiator', '<p>We can provide you the &ldquo;Best Quality Pressed Steel Radiator&rdquo;</p>\r\n\r\n<p>from our state of the art radiator plant for your full range Distribution and Power Transformers.</p>\r\n\r\n<p>The radiator of transformer accelerates the cooling rate of transformer. Radiator is very vital for heat dissipation and rating accuracy. Thirty companies of Bangladesh are our regular buyers of radiator.</p>\r\n\r\n<p>POWERtrac radiators are:</p>\r\n\r\n<p><img alt=\\\"✅\\\" src=\\\"https://static.xx.fbcdn.net/images/emoji.php/v9/t33/1/16/2705.png\\\" style=\\\"height:16px; width:16px\\\" /> Leakage test proof.</p>\r\n\r\n<p><img alt=\\\"✅\\\" src=\\\"https://static.xx.fbcdn.net/images/emoji.php/v9/t33/1/16/2705.png\\\" style=\\\"height:16px; width:16px\\\" /> Aesthetically better.</p>\r\n\r\n<p><img alt=\\\"✅\\\" src=\\\"https://static.xx.fbcdn.net/images/emoji.php/v9/t33/1/16/2705.png\\\" style=\\\"height:16px; width:16px\\\" /> Surface area and flow duct are best in dissipation and oil flow.</p>\r\n\r\n<p><img alt=\\\"✅\\\" src=\\\"https://static.xx.fbcdn.net/images/emoji.php/v9/t33/1/16/2705.png\\\" style=\\\"height:16px; width:16px\\\" /> We can make at your designed size.</p>\r\n\r\n<p><img alt=\\\"✅\\\" src=\\\"https://static.xx.fbcdn.net/images/emoji.php/v9/t33/1/16/2705.png\\\" style=\\\"height:16px; width:16px\\\" /> ORDER NOW!</p>\r\n\r\n<p><img alt=\\\"????\\\" src=\\\"https://static.xx.fbcdn.net/images/emoji.php/v9/t4d/1/16/1f4de.png\\\" style=\\\"height:16px; width:16px\\\" /> Call: 01974655043, 01974655007</p>\r\n\r\n<p><a href=\\\"https://www.facebook.com/hashtag/transformers?__eep__=6&amp;__cft__[0]=AZUii24WFJJt-4o9KcuDnkyT_cKEGOB-OVtYDgfUscpdqnPSBh6jxeRnvCcDrHkaryKozdzYYLxNwGCZSsPaw71tHSLzlUvrHWsShoDNk7fAXOKSPKySs3kUzZrGfaipt1YwAb66uTul63-MG9wRbUas&amp;__tn__=*NK-R\\\">#transformers</a> <a href=\\\"https://www.facebook.com/hashtag/transformerparts?__eep__=6&amp;__cft__[0]=AZUii24WFJJt-4o9KcuDnkyT_cKEGOB-OVtYDgfUscpdqnPSBh6jxeRnvCcDrHkaryKozdzYYLxNwGCZSsPaw71tHSLzlUvrHWsShoDNk7fAXOKSPKySs3kUzZrGfaipt1YwAb66uTul63-MG9wRbUas&amp;__tn__=*NK-R\\\">#transformerparts</a> <a href=\\\"https://www.facebook.com/hashtag/radiator?__eep__=6&amp;__cft__[0]=AZUii24WFJJt-4o9KcuDnkyT_cKEGOB-OVtYDgfUscpdqnPSBh6jxeRnvCcDrHkaryKozdzYYLxNwGCZSsPaw71tHSLzlUvrHWsShoDNk7fAXOKSPKySs3kUzZrGfaipt1YwAb66uTul63-MG9wRbUas&amp;__tn__=*NK-R\\\">#radiator</a> <a href=\\\"https://www.facebook.com/hashtag/radiatorfortransformer?__eep__=6&amp;__cft__[0]=AZUii24WFJJt-4o9KcuDnkyT_cKEGOB-OVtYDgfUscpdqnPSBh6jxeRnvCcDrHkaryKozdzYYLxNwGCZSsPaw71tHSLzlUvrHWsShoDNk7fAXOKSPKySs3kUzZrGfaipt1YwAb66uTul63-MG9wRbUas&amp;__tn__=*NK-R\\\">#radiatorfortransformer</a> <a href=\\\"https://www.facebook.com/hashtag/transformercoolingsystem?__eep__=6&amp;__cft__[0]=AZUii24WFJJt-4o9KcuDnkyT_cKEGOB-OVtYDgfUscpdqnPSBh6jxeRnvCcDrHkaryKozdzYYLxNwGCZSsPaw71tHSLzlUvrHWsShoDNk7fAXOKSPKySs3kUzZrGfaipt1YwAb66uTul63-MG9wRbUas&amp;__tn__=*NK-R\\\">#transformercoolingsystem</a> <a href=\\\"https://www.facebook.com/hashtag/transformercooling?__eep__=6&amp;__cft__[0]=AZUii24WFJJt-4o9KcuDnkyT_cKEGOB-OVtYDgfUscpdqnPSBh6jxeRnvCcDrHkaryKozdzYYLxNwGCZSsPaw71tHSLzlUvrHWsShoDNk7fAXOKSPKySs3kUzZrGfaipt1YwAb66uTul63-MG9wRbUas&amp;__tn__=*NK-R\\\">#transformercooling</a> <a href=\\\"https://www.facebook.com/hashtag/bangladesh?__eep__=6&amp;__cft__[0]=AZUii24WFJJt-4o9KcuDnkyT_cKEGOB-OVtYDgfUscpdqnPSBh6jxeRnvCcDrHkaryKozdzYYLxNwGCZSsPaw71tHSLzlUvrHWsShoDNk7fAXOKSPKySs3kUzZrGfaipt1YwAb66uTul63-MG9wRbUas&amp;__tn__=*NK-R\\\">#Bangladesh</a></p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(457, 364, 1, 'Pakistani Three piece , White', '<p>সকল প্রকার অরিজিনাল ইন্ডিয়ান ও পাকিস্তানি নিউ ড্রেস কালেকশন। স্বল্প মূল্যে সুন্দর পোশাক । সারাদেশে ডেলিভারিত করা হয়।<br />\r\nপাকিস্তানি লাখনৌ ড্রেস কালেকশন,থ্রি পিস।<br />\r\nপাকিস্তানি নিউ ড্রেস কালেকশন<br />\r\n#পাকিস্তানি #পাকিস্তানিড্রেস #পাকিস্তানিড্রেসকালেকশন #থ্রিপিস #পাকিস্তানিথ্রিপিস #pakistanidresscollection #ladiesdress #threepiece<br />\r\n&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(458, 365, 1, 'Pakistani Three piece , Red', '<p>সকল প্রকার অরিজিনাল ইন্ডিয়ান ও পাকিস্তানি নিউ ড্রেস কালেকশন। স্বল্প মূল্যে সুন্দর পোশাক । সারাদেশে ডেলিভারিত করা হয়।<br />\r\nপাকিস্তানি লাখনৌ ড্রেস কালেকশন,থ্রি পিস।<br />\r\nপাকিস্তানি নিউ ড্রেস কালেকশন<br />\r\n#পাকিস্তানি #পাকিস্তানিড্রেস #পাকিস্তানিড্রেসকালেকশন #থ্রিপিস #পাকিস্তানিথ্রিপিস #pakistanidresscollection #ladiesdress #threepiece<br />\r\n&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(459, 366, 1, 'Pakistani Three piece , Green', '<p>সকল প্রকার অরিজিনাল ইন্ডিয়ান ও পাকিস্তানি নিউ ড্রেস কালেকশন। স্বল্প মূল্যে সুন্দর পোশাক । সারাদেশে ডেলিভারিত করা হয়।<br />\r\nপাকিস্তানি লাখনৌ ড্রেস কালেকশন,থ্রি পিস।<br />\r\nপাকিস্তানি নিউ ড্রেস কালেকশন<br />\r\n#পাকিস্তানি #পাকিস্তানিড্রেস #পাকিস্তানিড্রেসকালেকশন #থ্রিপিস #পাকিস্তানিথ্রিপিস #pakistanidresscollection #ladiesdress #threepiece<br />\r\n&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL),
(460, 367, 1, 'Pakistani Three piece , Baby Pink', '<p>সকল প্রকার অরিজিনাল ইন্ডিয়ান ও পাকিস্তানি নিউ ড্রেস কালেকশন। স্বল্প মূল্যে সুন্দর পোশাক । সারাদেশে ডেলিভারিত করা হয়।<br />\r\nপাকিস্তানি লাখনৌ ড্রেস কালেকশন,থ্রি পিস।<br />\r\nপাকিস্তানি নিউ ড্রেস কালেকশন<br />\r\n#পাকিস্তানি #পাকিস্তানিড্রেস #পাকিস্তানিড্রেসকালেকশন #থ্রিপিস #পাকিস্তানিথ্রিপিস #pakistanidresscollection #ladiesdress #threepiece<br />\r\n&nbsp;</p>', NULL, 0, '', NULL, NULL, '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products_images`
--

CREATE TABLE `products_images` (
  `id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `image` text DEFAULT NULL,
  `htmlcontent` text DEFAULT NULL,
  `sort_order` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_images`
--

INSERT INTO `products_images` (`id`, `products_id`, `image`, `htmlcontent`, `sort_order`) VALUES
(1, 1, '413', NULL, 2),
(14, 4, '400', NULL, 1),
(15, 4, '401', NULL, 2),
(16, 4, '402', NULL, 3),
(17, 4, '403', NULL, 4),
(18, 4, '404', NULL, 5),
(19, 5, '395', NULL, 1),
(20, 5, '396', NULL, 2),
(21, 5, '398', NULL, 3),
(2, 1, '412', NULL, 1),
(3, 1, '414', NULL, 3),
(4, 1, '415', NULL, 4),
(6, 1, '416', NULL, 5),
(22, 5, '397', NULL, 4),
(23, 5, '399', NULL, 5),
(24, 6, '390', NULL, 1),
(25, 6, '393', NULL, 2),
(26, 6, '394', NULL, 3),
(27, 6, '392', NULL, 4),
(28, 6, '391', NULL, 5),
(29, 7, '385', NULL, 1),
(30, 7, '386', NULL, 2),
(31, 7, '387', NULL, 3),
(32, 7, '388', NULL, 4),
(33, 7, '389', NULL, 5),
(34, 8, '383', NULL, 1),
(35, 8, '384', NULL, 2),
(36, 8, '381', NULL, 3),
(37, 8, '382', NULL, 4),
(38, 9, '378', NULL, 1),
(39, 9, '379', NULL, 2),
(40, 9, '380', NULL, 3),
(41, 10, '375', NULL, 1),
(42, 10, '376', NULL, 2),
(43, 10, '377', NULL, 3),
(44, 11, '372', NULL, 1),
(45, 11, '374', NULL, 2),
(46, 11, '373', NULL, 3),
(47, 11, '371', NULL, 4),
(48, 12, '367', NULL, 1),
(49, 12, '370', NULL, 2),
(50, 12, '368', NULL, 3),
(51, 12, '369', NULL, 4),
(149, 13, '551', NULL, 1),
(150, 13, '550', NULL, 2),
(55, 14, '359', NULL, 1),
(56, 14, '361', NULL, 2),
(57, 14, '363', NULL, 3),
(58, 14, '360', NULL, 4),
(59, 14, '362', NULL, 5),
(60, 15, '355', NULL, 1),
(61, 15, '356', NULL, 2),
(62, 15, '358', NULL, 3),
(63, 15, '357', NULL, 4),
(64, 16, '350', NULL, 1),
(65, 16, '349', NULL, 2),
(66, 16, '352', NULL, 3),
(67, 16, '353', NULL, 4),
(68, 16, '354', NULL, 5),
(69, 16, '351', NULL, 6),
(70, 17, '344', NULL, 1),
(71, 17, '347', NULL, 2),
(72, 17, '348', NULL, 3),
(73, 17, '345', NULL, 4),
(74, 17, '346', NULL, 5),
(75, 18, '339', NULL, 1),
(76, 18, '341', NULL, 2),
(77, 18, '340', NULL, 3),
(78, 18, '342', NULL, 4),
(79, 18, '343', NULL, 5),
(80, 19, '337', NULL, 1),
(81, 19, '338', NULL, 2),
(82, 19, '336', NULL, 3),
(83, 20, '333', NULL, 1),
(84, 20, '334', NULL, 2),
(85, 20, '335', NULL, 3),
(86, 21, '330', NULL, 1),
(87, 21, '328', NULL, 2),
(88, 21, '329', NULL, 3),
(89, 21, '331', NULL, 4),
(90, 21, '332', NULL, 5),
(91, 22, '324', NULL, 1),
(92, 22, '325', NULL, 2),
(93, 22, '326', NULL, 3),
(94, 22, '327', NULL, 4),
(95, 23, '218', NULL, 1),
(96, 23, '219', NULL, 2),
(97, 23, '220', NULL, 3),
(98, 23, '217', NULL, 4),
(99, 23, '221', NULL, 5),
(100, 24, '319', NULL, 1),
(101, 24, '320', NULL, 2),
(102, 24, '321', NULL, 3),
(103, 24, '322', NULL, 4),
(104, 24, '323', NULL, 5),
(105, 25, '313', NULL, 1),
(106, 25, '314', NULL, 2),
(107, 25, '316', NULL, 3),
(108, 25, '312', NULL, 4),
(109, 25, '317', NULL, 5),
(110, 25, '318', NULL, 6),
(111, 25, '315', NULL, 7),
(112, 26, '310', NULL, 1),
(113, 26, '309', NULL, 2),
(114, 26, '308', NULL, 3),
(115, 26, '311', NULL, 4),
(116, 27, '307', NULL, 1),
(117, 27, '306', NULL, 2),
(118, 27, '305', NULL, 3),
(119, 28, '301', NULL, 1),
(120, 28, '303', NULL, 2),
(121, 28, '304', NULL, 3),
(122, 28, '302', NULL, 4),
(148, 32, '556', NULL, 2),
(152, 358, '814', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products_notifications`
--

CREATE TABLE `products_notifications` (
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) NOT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products_options`
--

CREATE TABLE `products_options` (
  `products_options_id` int(11) NOT NULL,
  `products_options_name` varchar(32) DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_options`
--

INSERT INTO `products_options` (`products_options_id`, `products_options_name`) VALUES
(1, 'Color'),
(2, 'Size'),
(3, 'Waist');

-- --------------------------------------------------------

--
-- Table structure for table `products_options_descriptions`
--

CREATE TABLE `products_options_descriptions` (
  `products_options_descriptions_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `options_name` varchar(191) DEFAULT NULL,
  `products_options_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_options_descriptions`
--

INSERT INTO `products_options_descriptions` (`products_options_descriptions_id`, `language_id`, `options_name`, `products_options_id`) VALUES
(1, 1, 'Color', 1),
(2, 1, 'Size', 2),
(3, 1, 'Waist', 3),
(5, 4, 'اللون', 1),
(6, 4, 'بحجم', 2),
(7, 4, 'وسط', 3);

-- --------------------------------------------------------

--
-- Table structure for table `products_options_values`
--

CREATE TABLE `products_options_values` (
  `products_options_values_id` int(11) NOT NULL,
  `products_options_id` int(11) NOT NULL,
  `products_options_values_name` varchar(64) NOT NULL DEFAULT ''
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_options_values`
--

INSERT INTO `products_options_values` (`products_options_values_id`, `products_options_id`, `products_options_values_name`) VALUES
(1, 1, 'Red'),
(2, 1, 'Pink'),
(3, 1, 'Sky Blue'),
(4, 1, 'Purple'),
(5, 2, 'Small'),
(6, 2, 'Medium'),
(7, 2, 'Large'),
(8, 2, 'XL'),
(9, 3, '28W'),
(10, 3, '30W'),
(11, 3, '32W'),
(12, 3, '34W'),
(13, 3, '36W'),
(14, 3, '38W');

-- --------------------------------------------------------

--
-- Table structure for table `products_options_values_descriptions`
--

CREATE TABLE `products_options_values_descriptions` (
  `products_options_values_descriptions_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `options_values_name` varchar(191) NOT NULL,
  `products_options_values_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_options_values_descriptions`
--

INSERT INTO `products_options_values_descriptions` (`products_options_values_descriptions_id`, `language_id`, `options_values_name`, `products_options_values_id`) VALUES
(1, 1, 'Red', 1),
(2, 1, 'Pink', 2),
(3, 1, 'Sky Blue', 3),
(4, 1, 'Purple', 4),
(5, 1, 'Small', 5),
(6, 1, 'Medium', 6),
(7, 1, 'Large', 7),
(8, 1, 'XL', 8),
(9, 1, '28W', 9),
(10, 1, '30W', 10),
(11, 1, '32W', 11),
(12, 1, '34W', 12),
(13, 1, '36W', 13),
(14, 1, '38W', 14),
(15, 4, 'أحمر', 1),
(16, 4, 'زهري', 2),
(17, 4, 'السماء الزرقاء', 3),
(18, 4, 'أرجواني', 4),
(19, 4, 'صغير', 5),
(20, 4, 'متوسط', 6),
(21, 4, 'كبير', 7),
(22, 4, 'كبير جدا', 8),
(23, 4, '28W', 9),
(24, 4, '30W', 10),
(25, 4, '32W', 11),
(26, 4, '34W', 12),
(27, 4, '36W', 13),
(28, 4, '38W', 14);

-- --------------------------------------------------------

--
-- Table structure for table `products_shipping_rates`
--

CREATE TABLE `products_shipping_rates` (
  `products_shipping_rates_id` int(11) NOT NULL,
  `weight_from` varchar(100) DEFAULT NULL,
  `weight_to` varchar(100) DEFAULT NULL,
  `weight_price` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `products_shipping_status` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products_to_categories`
--

CREATE TABLE `products_to_categories` (
  `products_to_categories_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `categories_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_to_categories`
--

INSERT INTO `products_to_categories` (`products_to_categories_id`, `products_id`, `categories_id`) VALUES
(492, 94, 52),
(491, 94, 31),
(1242, 349, 1),
(498, 96, 53),
(497, 96, 7),
(496, 96, 1),
(495, 95, 53),
(494, 95, 7),
(493, 95, 1),
(500, 97, 54),
(499, 97, 3),
(1244, 350, 1),
(1243, 349, 24),
(504, 98, 13),
(503, 98, 2),
(1241, 348, 24),
(1240, 348, 1),
(512, 100, 56),
(511, 100, 2),
(510, 101, 56),
(509, 101, 2),
(1222, 339, 1),
(1221, 338, 24),
(1224, 340, 1),
(1223, 339, 24),
(1226, 341, 1),
(520, 105, 58),
(1228, 342, 1),
(1225, 340, 24),
(1239, 347, 24),
(1227, 341, 24),
(555, 118, 2),
(557, 119, 2),
(556, 118, 56),
(558, 119, 56),
(1230, 343, 1),
(1229, 342, 24),
(1232, 344, 1),
(1231, 343, 24),
(1234, 345, 1),
(1233, 344, 24),
(1236, 346, 1),
(1235, 345, 24),
(338, 42, 24),
(337, 42, 1),
(362, 51, 3),
(363, 51, 5),
(1256, 356, 1),
(1255, 355, 24),
(1254, 355, 1),
(1259, 357, 24),
(1258, 357, 1),
(1257, 356, 24),
(417, 65, 33),
(416, 65, 31),
(414, 66, 31),
(415, 66, 33),
(418, 67, 31),
(419, 67, 33),
(420, 68, 31),
(421, 68, 33),
(422, 69, 31),
(423, 69, 33),
(443, 70, 33),
(442, 70, 31),
(426, 71, 31),
(427, 71, 33),
(428, 72, 31),
(429, 72, 33),
(430, 73, 31),
(431, 73, 33),
(1250, 353, 1),
(1249, 352, 24),
(1248, 352, 1),
(1247, 351, 24),
(436, 76, 2),
(437, 76, 47),
(438, 77, 2),
(439, 77, 47),
(1246, 351, 1),
(1245, 350, 24),
(464, 79, 45),
(463, 79, 44),
(462, 79, 31),
(461, 80, 45),
(460, 80, 44),
(459, 80, 31),
(458, 81, 45),
(457, 81, 44),
(456, 81, 31),
(453, 82, 31),
(454, 82, 44),
(455, 82, 45),
(465, 83, 31),
(466, 83, 44),
(467, 83, 45),
(468, 84, 31),
(469, 84, 44),
(470, 84, 45),
(471, 85, 31),
(472, 85, 44),
(473, 85, 45),
(474, 86, 31),
(475, 86, 44),
(476, 86, 45),
(477, 87, 31),
(478, 87, 44),
(479, 87, 45),
(517, 104, 2),
(518, 104, 58),
(519, 105, 2),
(1238, 347, 1),
(1237, 346, 24),
(1253, 354, 24),
(1252, 354, 1),
(1251, 353, 24),
(571, 126, 2),
(572, 126, 15),
(581, 131, 2),
(582, 131, 56),
(593, 136, 2),
(594, 136, 47),
(595, 137, 2),
(596, 137, 47),
(621, 150, 2),
(622, 150, 47),
(623, 151, 2),
(624, 151, 47),
(625, 152, 2),
(626, 152, 47),
(627, 153, 2),
(628, 153, 47),
(629, 154, 2),
(630, 154, 47),
(631, 155, 2),
(632, 155, 47),
(633, 156, 2),
(634, 156, 47),
(635, 157, 2),
(636, 157, 47),
(637, 158, 2),
(638, 158, 47),
(639, 159, 2),
(640, 159, 47),
(641, 160, 2),
(642, 160, 47),
(643, 161, 2),
(644, 161, 47),
(645, 162, 2),
(646, 162, 47),
(647, 163, 2),
(648, 163, 47),
(661, 170, 2),
(662, 170, 47),
(663, 171, 2),
(664, 171, 47),
(670, 172, 47),
(669, 172, 2),
(1217, 336, 24),
(1216, 336, 1),
(1215, 335, 24),
(1214, 335, 1),
(1213, 334, 24),
(1212, 334, 1),
(1220, 338, 1),
(1219, 337, 24),
(1218, 337, 1),
(680, 176, 31),
(681, 176, 44),
(682, 176, 46),
(683, 177, 31),
(684, 177, 44),
(685, 177, 46),
(686, 178, 31),
(687, 178, 44),
(688, 178, 46),
(703, 179, 46),
(702, 179, 44),
(701, 179, 31),
(706, 182, 46),
(705, 182, 44),
(704, 182, 31),
(709, 183, 46),
(708, 183, 44),
(707, 183, 31),
(710, 184, 31),
(711, 184, 44),
(712, 184, 46),
(713, 185, 31),
(714, 185, 44),
(715, 185, 46),
(716, 186, 31),
(717, 186, 44),
(718, 186, 46),
(719, 187, 31),
(720, 187, 44),
(721, 187, 46),
(722, 188, 31),
(723, 188, 44),
(724, 188, 46),
(725, 189, 31),
(726, 189, 44),
(727, 189, 46),
(728, 190, 31),
(729, 190, 44),
(730, 190, 46),
(731, 191, 31),
(732, 191, 44),
(733, 191, 46),
(734, 192, 31),
(735, 192, 44),
(736, 192, 46),
(737, 193, 31),
(738, 193, 44),
(739, 193, 46),
(740, 194, 31),
(741, 194, 44),
(742, 194, 46),
(743, 195, 31),
(744, 195, 44),
(745, 195, 46),
(746, 196, 31),
(747, 196, 44),
(748, 196, 46),
(749, 197, 31),
(750, 197, 44),
(751, 197, 46),
(752, 198, 31),
(753, 198, 44),
(754, 198, 46),
(760, 199, 46),
(759, 199, 44),
(758, 199, 31),
(761, 200, 31),
(762, 200, 44),
(763, 200, 46),
(764, 201, 31),
(765, 201, 44),
(766, 201, 46),
(767, 202, 31),
(768, 202, 44),
(769, 202, 46),
(770, 203, 31),
(771, 203, 44),
(772, 203, 46),
(773, 204, 31),
(774, 204, 44),
(775, 204, 46),
(787, 205, 46),
(786, 205, 44),
(785, 205, 31),
(790, 206, 46),
(789, 206, 44),
(788, 206, 31),
(782, 207, 31),
(783, 207, 44),
(784, 207, 46),
(791, 208, 31),
(792, 208, 44),
(793, 208, 46),
(794, 209, 31),
(795, 209, 44),
(796, 209, 46),
(797, 210, 31),
(798, 210, 44),
(799, 210, 46),
(800, 211, 31),
(801, 211, 44),
(802, 211, 46),
(803, 212, 31),
(804, 212, 44),
(805, 212, 46),
(806, 213, 31),
(807, 213, 44),
(808, 213, 46),
(809, 214, 31),
(810, 214, 44),
(811, 214, 46),
(812, 215, 31),
(813, 215, 44),
(814, 215, 46),
(815, 216, 31),
(816, 216, 44),
(817, 216, 46),
(818, 217, 31),
(819, 217, 44),
(820, 217, 46),
(832, 220, 46),
(831, 220, 44),
(830, 220, 31),
(829, 219, 46),
(828, 219, 44),
(827, 219, 31),
(833, 221, 31),
(834, 221, 44),
(835, 221, 46),
(836, 222, 31),
(837, 222, 44),
(838, 222, 46),
(839, 223, 31),
(840, 223, 44),
(841, 223, 46),
(842, 224, 31),
(843, 224, 44),
(844, 224, 46),
(845, 225, 31),
(846, 225, 44),
(847, 225, 46),
(848, 226, 31),
(849, 226, 44),
(850, 226, 46),
(851, 227, 31),
(852, 227, 44),
(853, 227, 46),
(854, 228, 31),
(855, 228, 44),
(856, 228, 46),
(857, 229, 31),
(858, 229, 44),
(859, 229, 46),
(860, 230, 31),
(861, 230, 44),
(862, 230, 46),
(863, 231, 31),
(864, 231, 44),
(865, 231, 46),
(866, 232, 31),
(867, 232, 44),
(868, 232, 46),
(869, 233, 31),
(870, 233, 44),
(871, 233, 46),
(872, 234, 31),
(873, 234, 44),
(874, 234, 46),
(875, 235, 31),
(876, 235, 44),
(877, 235, 46),
(878, 236, 31),
(879, 236, 44),
(880, 236, 46),
(955, 237, 46),
(954, 237, 44),
(953, 237, 31),
(952, 238, 46),
(951, 238, 44),
(950, 238, 31),
(949, 239, 46),
(948, 239, 44),
(947, 239, 31),
(946, 240, 46),
(945, 240, 44),
(944, 240, 31),
(943, 241, 46),
(942, 241, 44),
(941, 241, 31),
(940, 242, 46),
(939, 242, 44),
(938, 242, 31),
(937, 243, 46),
(936, 243, 44),
(935, 243, 31),
(934, 244, 46),
(933, 244, 44),
(932, 244, 31),
(931, 245, 46),
(930, 245, 44),
(929, 245, 31),
(928, 246, 46),
(927, 246, 44),
(926, 246, 31),
(925, 247, 46),
(924, 247, 44),
(923, 247, 31),
(922, 248, 46),
(921, 248, 44),
(920, 248, 31),
(956, 249, 31),
(957, 249, 44),
(958, 249, 46),
(959, 250, 31),
(960, 250, 44),
(961, 250, 46),
(962, 251, 31),
(963, 251, 44),
(964, 251, 46),
(965, 252, 31),
(966, 252, 44),
(967, 252, 46),
(968, 253, 31),
(969, 253, 44),
(970, 253, 46),
(971, 254, 31),
(972, 254, 44),
(973, 254, 46),
(974, 255, 31),
(975, 255, 44),
(976, 255, 46),
(977, 256, 31),
(978, 256, 44),
(979, 256, 46),
(980, 257, 31),
(981, 257, 44),
(982, 257, 46),
(983, 258, 31),
(984, 258, 44),
(985, 258, 46),
(986, 259, 31),
(987, 259, 44),
(988, 259, 46),
(989, 260, 31),
(990, 260, 44),
(991, 260, 46),
(992, 261, 31),
(993, 261, 44),
(994, 261, 46),
(995, 262, 31),
(996, 262, 44),
(997, 262, 46),
(998, 263, 31),
(999, 263, 44),
(1000, 263, 46),
(1001, 264, 31),
(1002, 264, 44),
(1003, 264, 46),
(1004, 265, 31),
(1005, 265, 44),
(1006, 265, 46),
(1007, 266, 31),
(1008, 266, 44),
(1009, 266, 46),
(1010, 267, 31),
(1011, 267, 44),
(1012, 267, 46),
(1013, 268, 31),
(1014, 268, 44),
(1015, 268, 46),
(1016, 269, 31),
(1017, 269, 44),
(1018, 269, 46),
(1019, 270, 31),
(1020, 270, 44),
(1021, 270, 46),
(1022, 271, 31),
(1023, 271, 44),
(1024, 271, 46),
(1025, 272, 31),
(1026, 272, 44),
(1027, 272, 46),
(1028, 273, 31),
(1029, 273, 44),
(1030, 273, 46),
(1031, 274, 31),
(1032, 274, 44),
(1033, 274, 46),
(1034, 275, 31),
(1035, 275, 44),
(1036, 275, 46),
(1037, 276, 31),
(1038, 276, 44),
(1039, 276, 46),
(1040, 277, 31),
(1041, 277, 44),
(1042, 277, 46),
(1043, 278, 31),
(1044, 278, 44),
(1045, 278, 46),
(1051, 279, 46),
(1050, 279, 44),
(1049, 279, 31),
(1052, 280, 31),
(1053, 280, 44),
(1054, 280, 46),
(1055, 281, 31),
(1056, 281, 44),
(1057, 281, 46),
(1058, 282, 31),
(1059, 282, 44),
(1060, 282, 46),
(1061, 283, 31),
(1062, 283, 44),
(1063, 283, 46),
(1064, 284, 31),
(1065, 284, 44),
(1066, 284, 46),
(1067, 285, 31),
(1068, 285, 44),
(1069, 285, 46),
(1070, 286, 31),
(1071, 286, 44),
(1072, 286, 46),
(1073, 287, 31),
(1074, 287, 44),
(1075, 287, 46),
(1076, 288, 31),
(1077, 288, 44),
(1078, 288, 46),
(1079, 289, 31),
(1080, 289, 44),
(1081, 289, 46),
(1082, 290, 31),
(1083, 290, 44),
(1084, 290, 46),
(1085, 291, 31),
(1086, 291, 44),
(1087, 291, 46),
(1088, 292, 31),
(1089, 292, 44),
(1090, 292, 46),
(1091, 293, 31),
(1092, 293, 44),
(1093, 293, 46),
(1094, 294, 31),
(1095, 294, 44),
(1096, 294, 46),
(1097, 295, 31),
(1098, 295, 44),
(1099, 295, 46),
(1100, 296, 31),
(1101, 296, 44),
(1102, 296, 46),
(1103, 297, 31),
(1104, 297, 44),
(1105, 297, 46),
(1106, 298, 31),
(1107, 298, 44),
(1108, 298, 46),
(1109, 299, 31),
(1110, 299, 44),
(1111, 299, 46),
(1112, 300, 31),
(1113, 300, 44),
(1114, 300, 46),
(1115, 301, 31),
(1116, 301, 44),
(1117, 301, 46),
(1118, 302, 31),
(1119, 302, 44),
(1120, 302, 46),
(1121, 303, 31),
(1122, 303, 44),
(1123, 303, 46),
(1124, 304, 31),
(1125, 304, 44),
(1126, 304, 46),
(1127, 305, 31),
(1128, 305, 44),
(1129, 305, 46),
(1130, 306, 31),
(1131, 306, 44),
(1132, 306, 46),
(1133, 307, 31),
(1134, 307, 44),
(1135, 307, 46),
(1141, 308, 46),
(1140, 308, 44),
(1139, 308, 31),
(1142, 309, 31),
(1143, 309, 44),
(1144, 309, 46),
(1145, 310, 31),
(1146, 310, 44),
(1147, 310, 46),
(1148, 311, 31),
(1149, 311, 44),
(1150, 311, 46),
(1151, 312, 31),
(1152, 312, 44),
(1153, 312, 46),
(1154, 313, 31),
(1155, 313, 44),
(1156, 313, 46),
(1157, 314, 31),
(1158, 314, 44),
(1159, 314, 46),
(1160, 315, 31),
(1161, 315, 44),
(1162, 315, 46),
(1163, 316, 31),
(1164, 316, 44),
(1165, 316, 46),
(1166, 317, 31),
(1167, 317, 44),
(1168, 317, 46),
(1169, 318, 31),
(1170, 318, 44),
(1171, 318, 46),
(1172, 319, 31),
(1173, 319, 44),
(1174, 319, 46),
(1175, 320, 31),
(1176, 320, 44),
(1177, 321, 31),
(1178, 321, 44),
(1179, 321, 46),
(1180, 322, 31),
(1181, 322, 44),
(1182, 323, 31),
(1183, 323, 44),
(1184, 324, 31),
(1185, 324, 44),
(1186, 325, 31),
(1187, 325, 44),
(1188, 326, 31),
(1189, 326, 44),
(1193, 327, 44),
(1192, 327, 31),
(1201, 328, 47),
(1200, 328, 2),
(1202, 329, 2),
(1203, 329, 47),
(1204, 330, 2),
(1205, 330, 47),
(1206, 331, 2),
(1207, 331, 47),
(1208, 332, 2),
(1209, 332, 47),
(1210, 333, 2),
(1211, 333, 47),
(1279, 361, 30),
(1278, 360, 44),
(1277, 360, 31),
(1276, 360, 30),
(1280, 361, 31),
(1281, 361, 44),
(1282, 362, 30),
(1283, 362, 31),
(1284, 362, 44),
(1285, 363, 31),
(1286, 363, 52),
(1287, 364, 2),
(1288, 364, 58),
(1289, 365, 2),
(1290, 365, 58),
(1291, 366, 2),
(1292, 366, 58),
(1293, 367, 2),
(1294, 367, 58);

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `reviews_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `customers_id` int(11) DEFAULT NULL,
  `customers_name` varchar(191) NOT NULL,
  `reviews_rating` int(11) DEFAULT NULL,
  `reviews_status` tinyint(1) NOT NULL DEFAULT 0,
  `reviews_read` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`reviews_id`, `products_id`, `customers_id`, `customers_name`, `reviews_rating`, `reviews_status`, `reviews_read`, `created_at`, `updated_at`) VALUES
(17, 4, 14, 'Rehan', 5, -1, 1, '2020-04-04 19:10:00', NULL),
(18, 4, 14, 'Rehan', 5, -1, 1, '2020-04-04 19:10:00', NULL),
(19, 24, 608, 'mubasher', 5, 1, 1, '2020-02-17 08:52:00', NULL),
(20, 5, 454, 'Angelo', 5, -1, 1, '2020-02-23 21:12:45', NULL),
(21, 14, 658, 'benito', 3, -1, 1, '2020-03-08 16:16:17', NULL),
(22, 12, 666, 'Mubasher', 3, 1, 1, '2020-04-01 08:28:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reviews_description`
--

CREATE TABLE `reviews_description` (
  `id` int(11) NOT NULL,
  `review_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `reviews_text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews_description`
--

INSERT INTO `reviews_description` (`id`, `review_id`, `language_id`, `reviews_text`) VALUES
(20, 17, 1, 'fdssdgsg sfsd fds gs g dsgds gsdgsdg s gds gsd gsdgs dgs sgds sgd sg dsg dsg sgs gdssdg sdgsdgsgdsgsgs gs sd gsgdsgsg sdgsd gsdsd gsgd sdg sdgsdgs gds gdsgsd gs gsgsdgsdgdsg sdgsd sddsgsgsd sdg dsgds gsgsgs gs dgs dg gd gsdgsd gsdgsg sdggsdgsdgsd gsdg gsdgdsg sdgsdgds dsgsdg dsgdsgsdgds d sgdgds gds gdgdsg dssdg ds gsdgdsgds gs gsdgsgdd  sdgdgds gdsgds gsd gdsgdsgdsgdsg sdg s'),
(21, 18, 1, 'fdssdgsg sfsd fds gs g dsgds gsdgsdg s gds gsd gsdgs dgs sgds sgd sg dsg dsg sgs gdssdg sdgsdgsgdsgsgs gs sd gsgdsgsg sdgsd gsdsd gsgd sdg sdgsdgs gds gdsgsd gs gsgsdgsdgdsg sdgsd sddsgsgsd sdg dsgds gsgsgs gs dgs dg gd gsdgsd gsdgsg sdggsdgsdgsd gsdg gsdgdsg sdgsdgds dsgsdg dsgdsgsdgds d sgdgds gds gdgdsg dssdg ds gsdgdsgds gs gsdgsgdd  sdgdgds gdsgds gsd gdsgdsgdsgdsg sdg s'),
(22, 19, 1, 'nice'),
(23, 20, 1, 'dwddsadsadsadsa'),
(24, 21, 1, 'oxsdcfvgbhjnk'),
(25, 22, 1, 'Nice');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `sesskey` varchar(32) NOT NULL,
  `expiry` int(10) UNSIGNED NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `value`, `created_at`, `updated_at`) VALUES
(1, 'facebook_app_id', 'FB_CLIENT_ID', '2018-04-26 18:00:00', '2020-11-09 16:27:47'),
(2, 'facebook_secret_id', 'FB_SECRET_KEY', '2018-04-26 18:00:00', '2020-11-09 16:27:47'),
(3, 'facebook_login', '0', '2018-04-26 18:00:00', '2020-11-09 16:27:47'),
(4, 'contact_us_email', 'info@knoprotec.com', '2018-04-26 18:00:00', '2022-04-06 09:24:32'),
(5, 'address', 'CNS Tower, 43/R/5-A, West Panthapath', '2018-04-26 18:00:00', '2022-04-06 09:24:32'),
(6, 'city', 'Dhaka', '2018-04-26 18:00:00', '2022-04-06 09:24:32'),
(7, 'state', '', '2018-04-26 18:00:00', '2022-04-06 09:24:32'),
(8, 'zip', '1215', '2018-04-26 18:00:00', '2022-04-06 09:24:32'),
(9, 'country', 'Bangladesh', '2018-04-26 18:00:00', '2022-04-06 09:24:32'),
(10, 'latitude', '23.752962', '2018-04-26 18:00:00', '2022-04-06 09:24:32'),
(11, 'longitude', '90.383697', '2018-04-26 18:00:00', '2022-04-06 09:24:32'),
(12, 'phone_no', '+88 01974655043', '2018-04-26 18:00:00', '2022-04-06 09:24:32'),
(13, 'fcm_android', '', '2018-04-26 18:00:00', '2019-02-05 05:42:15'),
(14, 'fcm_ios', NULL, '2018-04-26 18:00:00', NULL),
(15, 'fcm_desktop', NULL, '2018-04-26 18:00:00', NULL),
(16, 'website_logo', 'images/media/2020/07/MaBrR13309.png', '2018-04-26 18:00:00', '2020-07-13 03:58:46'),
(17, 'fcm_android_sender_id', NULL, '2018-04-26 18:00:00', NULL),
(18, 'fcm_ios_sender_id', '', '2018-04-26 18:00:00', '2019-02-05 05:42:15'),
(19, 'app_name', 'knoprotec', '2018-04-26 18:00:00', '2022-04-06 09:24:32'),
(20, 'currency_symbol', '$', '2018-04-26 18:00:00', '2018-11-19 01:26:01'),
(21, 'new_product_duration', '20', '2018-04-26 18:00:00', '2022-04-06 09:24:32'),
(22, 'notification_title', 'Ionic Ecommerce', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(23, 'notification_text', 'A bundle of products waiting for you!', '2018-04-26 18:00:00', NULL),
(24, 'lazzy_loading_effect', 'Detail', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(25, 'footer_button', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(26, 'cart_button', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(27, 'featured_category', NULL, '2018-04-26 18:00:00', NULL),
(28, 'notification_duration', 'year', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(29, 'home_style', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(30, 'wish_list_page', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(31, 'edit_profile_page', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(32, 'shipping_address_page', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(33, 'my_orders_page', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(34, 'contact_us_page', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(35, 'about_us_page', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(36, 'news_page', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(37, 'intro_page', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(38, 'setting_page', '1', '2018-04-26 18:00:00', NULL),
(39, 'share_app', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(40, 'rate_app', '1', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(41, 'site_url', 'URL', '2018-04-26 18:00:00', '2018-11-19 01:26:01'),
(42, 'admob', '0', '2018-04-26 18:00:00', '2019-05-15 04:58:05'),
(43, 'admob_id', 'ID', '2018-04-26 18:00:00', '2019-05-15 04:58:05'),
(44, 'ad_unit_id_banner', 'Unit ID', '2018-04-26 18:00:00', '2019-05-15 04:58:05'),
(45, 'ad_unit_id_interstitial', 'Indestrial', '2018-04-26 18:00:00', '2019-05-15 04:58:05'),
(46, 'category_style', '4', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(47, 'package_name', 'package name', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(48, 'google_analytic_id', 'test', '2018-04-26 18:00:00', '2019-05-15 04:58:30'),
(49, 'themes', 'themeone', '2018-04-26 18:00:00', NULL),
(50, 'company_name', '#', '2018-04-26 18:00:00', '2019-10-07 03:52:24'),
(51, 'facebook_url', 'https://www.facebook.com/knoprotec/', '2018-04-26 18:00:00', '2022-01-11 16:26:48'),
(52, 'google_url', 'https://www.google.com/knoprotec/', '2018-04-26 18:00:00', '2022-01-11 16:26:48'),
(53, 'twitter_url', 'https://www.twitter.com/knoprotec/', '2018-04-26 18:00:00', '2022-01-11 16:26:48'),
(54, 'linked_in', 'https://www.instragram.com/knoprotec/', '2018-04-26 18:00:00', '2022-01-11 16:26:48'),
(55, 'default_notification', 'onesignal', '2018-04-26 18:00:00', '2019-02-05 05:42:15'),
(56, 'onesignal_app_id', '6053d948-b8f6-472a-87e4-379fa89f78d8', '2018-04-26 18:00:00', '2019-02-05 05:42:15'),
(57, 'onesignal_sender_id', '', '2018-04-26 18:00:00', '2019-02-05 05:42:15'),
(58, 'ios_admob', '0', '2018-04-26 18:00:00', '2019-05-15 04:58:05'),
(59, 'ios_admob_id', 'AdMob ID', '2018-04-26 18:00:00', '2019-05-15 04:58:05'),
(60, 'ios_ad_unit_id_banner', 'Unit ID Banner', '2018-04-26 18:00:00', '2019-05-15 04:58:05'),
(61, 'ios_ad_unit_id_interstitial', 'ID Interstitial', '2018-04-26 18:00:00', '2019-05-15 04:58:05'),
(62, 'google_login', '0', NULL, '2019-11-01 00:58:36'),
(63, 'google_app_id', NULL, NULL, NULL),
(64, 'google_secret_id', NULL, NULL, NULL),
(65, 'google_callback_url', NULL, NULL, NULL),
(66, 'facebook_callback_url', NULL, NULL, NULL),
(67, 'is_app_purchased', '0', NULL, '2018-05-03 21:24:44'),
(68, 'is_web_purchased', '1', NULL, '2018-05-03 21:24:44'),
(69, 'consumer_key', 'dadb7a7c1557917902724bbbf5', NULL, '2019-05-15 04:58:22'),
(70, 'consumer_secret', '3ba77f821557917902b1d57373', NULL, '2019-05-15 04:58:22'),
(71, 'order_email', 'info@knoprotec.com', NULL, '2022-04-06 09:24:32'),
(72, 'website_themes', '1', NULL, NULL),
(73, 'seo_title', 'knoprotec Top bangladeshi E Commerce website', NULL, '2022-11-09 10:03:33'),
(74, 'seo_metatag', 'online shop', NULL, '2022-11-09 10:03:33'),
(75, 'seo_keyword', 'facebook, facebookshop, ecommerce business, onlineshop, buyonline,ecom, ecommerce website, shopping cart ,e business ,what is ecommerce, ecomerce comercio, electronico, e commerce definition, ecommerce platforms, e commerce business, e commerce meaning, ecommerce website design, wordpress ecommerce ,e commerce sites, ecommunity, ecommerce website development, ecommerce website templates, best ecommerce platform, magento ecommerce, free shopping ,cart, ecommerce solutions, ecommerce template, Saree, new design saree, women clothing, trending dresses, trending fashion, onepic dress, one piece dress,salwarkamiz, salowarkamij, anarkoli, best selling, blockprint, cotton,semicotton,tranding.', NULL, '2022-11-09 10:03:33'),
(76, 'seo_description', 'This is the official Facebook page of knoprotec, an online store in Bangladesh for Fashion, Beauty, Health care, and electronic components.\r\nknoprotec is an e-commerce platform that brings the latest trending products to your doorstep just in a few clicks. We provide a large selection of products in different categories with a promise of a fast, safe, and easy online shopping experience. From Fashion to Electronics, Healthcare to Beauty, we provide you with the products at the best possible prices.\r\nKnoprotec.com offers Nationwide shipping and FREE returns! For your convenience we have several payment options including credit/debit cards, bKash and cash on delivery.\r\nSaree, new design saree, women clothing, trending dresses, trending fashion, onepic dress, one piece dress,salwarkamiz, salowarkamij, anarkoli, best selling, blockprint, cotton,semicotton,tranding.', NULL, '2022-11-09 10:03:33'),
(77, 'before_head_tag', '', NULL, '2018-11-19 01:22:15'),
(78, 'end_body_tag', 'name', NULL, '2019-10-11 05:57:29'),
(79, 'sitename_logo', 'logo', NULL, '2022-01-11 16:26:48'),
(80, 'website_name', 'Knoprotec', NULL, '2022-01-11 16:26:48'),
(81, 'web_home_pages_style', 'two', NULL, '2018-11-19 01:22:25'),
(82, 'web_color_style', 'app.theme.2', NULL, '2020-07-13 02:13:12'),
(83, 'free_shipping_limit', '400', NULL, '2022-04-06 09:24:32'),
(84, 'app_icon_image', 'icon', NULL, '2019-02-05 04:12:59'),
(85, 'twilio_status', '0', NULL, NULL),
(86, 'twilio_authy_api_id', '', NULL, NULL),
(87, 'favicon', 'images/media/2020/07/h8bFO13309.png', NULL, '2020-07-13 03:58:13'),
(88, 'Thumbnail_height', '150', NULL, NULL),
(89, 'Thumbnail_width', '150', NULL, NULL),
(90, 'Medium_height', '400', NULL, NULL),
(91, 'Medium_width', '400', NULL, NULL),
(92, 'Large_height', '900', NULL, NULL),
(93, 'Large_width', '900', NULL, NULL),
(94, 'environmentt', 'production', NULL, '2022-04-06 09:24:32'),
(95, 'maintenance_text', 'Website is under maintenance', NULL, '2022-04-06 09:24:32'),
(96, 'package_charge_taxt', '0', NULL, NULL),
(97, 'order_commission', '0', NULL, NULL),
(98, 'all_items_price_included_tax', 'yes', NULL, NULL),
(99, 'all_items_price_included_tax_value', '0', NULL, NULL),
(100, 'driver_accept_multiple_order', '1', NULL, NULL),
(101, 'min_order_price', '20', NULL, '2022-04-06 09:24:32'),
(102, 'youtube_link', '0', NULL, NULL),
(103, 'external_website_link', 'http://localhost', NULL, '2022-04-06 09:24:32'),
(104, 'google_map_api', '', NULL, '2022-04-06 09:24:32'),
(105, 'is_pos_purchased', '0', NULL, NULL),
(106, 'admin_version', '4.0.17', NULL, NULL),
(107, 'app_version', '4.0.17', NULL, NULL),
(108, 'web_version', '4.0.17', NULL, NULL),
(109, 'pos_version', '0', NULL, NULL),
(110, 'android_app_link', '#', NULL, NULL),
(111, 'iphone_app_link', '#', NULL, NULL),
(112, 'about_content', 'www.knoprotec.com is a concern of POWERtrac Group which provides you the power to buy your desired products from home with outstanding customer support. At Knoprotec.com we endeavor to utilize the power of the internet at its highest peak to fulfill the needs of your day to day life. Currently, we are providing our service all over Bangladesh, at the same time a person from outside of Bangladesh can also order our products using Bangladeshi shipping address. “We endeavor to make our customers happy”', NULL, '2022-01-11 16:26:48'),
(113, 'contact_content', 'www.knoprotec.com is a concern of POWERtrac Group which provides you the power to buy your desired products from home with outstanding customer support. At Knoprotec.com we endeavor to utilize the power of the internet at its highest peak to fulfill the needs of your day to day life. Currently, we are providing our service all over Bangladesh, at the same time a person from outside of Bangladesh can also order our products using Bangladeshi shipping address. “We endeavor to make our customers happy”', NULL, '2022-01-11 16:26:48'),
(114, 'contents', NULL, NULL, NULL),
(115, 'fb_redirect_url', 'http://YOUR_DOMAIN_NAME/login/facebook/callback', NULL, '2020-11-09 16:27:47'),
(116, 'google_client_id', 'GOOGLE_CLIENT_ID', NULL, '2019-11-01 00:58:36'),
(117, 'google_client_secret', 'GOOGLE_SECRET_KEY', NULL, '2019-11-01 00:58:36'),
(118, 'google_redirect_url', 'http://YOUR_DOMAIN_NAME/login/google/callback', NULL, '2019-11-01 00:58:36'),
(119, 'newsletter', '0', NULL, '2019-11-01 00:58:36'),
(120, 'allow_cookies', '0', NULL, '2022-01-11 16:26:48'),
(121, 'card_style', '1', NULL, '2019-11-01 00:58:36'),
(122, 'banner_style', '1', NULL, '2019-11-01 00:58:36'),
(123, 'mail_chimp_api', '', NULL, '2019-11-01 00:58:36'),
(124, 'mail_chimp_list_id', '', NULL, '2019-11-01 00:58:36'),
(125, 'newsletter_image', 'images/media/2019/10/newsletter.jpg', NULL, '2019-11-01 00:58:36'),
(126, 'instauserid', '', NULL, '2019-11-01 00:58:36'),
(127, 'web_card_style', '4', NULL, '2020-07-13 04:08:19');

-- --------------------------------------------------------

--
-- Table structure for table `shipping_description`
--

CREATE TABLE `shipping_description` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `language_id` int(11) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  `sub_labels` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shipping_description`
--

INSERT INTO `shipping_description` (`id`, `name`, `language_id`, `table_name`, `sub_labels`) VALUES
(1, 'Free Shipping', 1, 'free_shipping', ''),
(4, 'Local Pickup', 1, 'local_pickup', ''),
(7, 'Flat Rate', 1, 'flate_rate', ''),
(10, 'UPS Shipping', 1, 'ups_shipping', '{\"nextDayAir\":\"Next Day Air\",\"secondDayAir\":\"2nd Day Air\",\"ground\":\"Ground\",\"threeDaySelect\":\"3 Day Select\",\"nextDayAirSaver\":\"Next Day AirSaver\",\"nextDayAirEarlyAM\":\"Next Day Air Early A.M.\",\"secondndDayAirAM\":\"2nd Day Air A.M.\"}'),
(13, 'Shipping Price', 1, 'shipping_by_weight', ''),
(14, 'سعر الشحن', 4, 'shipping_by_weight', ''),
(15, 'معدل', 4, 'flate_rate', ''),
(16, 'شاحنة محلية', 4, 'local_pickup', ''),
(17, 'الشحن مجانا', 4, 'free_shipping', ''),
(18, 'يو بي إس الشحن', 4, 'ups_shipping', '{\"nextDayAir\":\"\\u0627\\u0644\\u0647\\u0648\\u0627\\u0621 \\u0627\\u0644\\u064a\\u0648\\u0645 \\u0627\\u0644\\u062a\\u0627\\u0644\\u064a\",\"secondDayAir\":\"2nd \\u0627\\u0644\\u064a\\u0648\\u0645 \\u0627\\u0644\\u062c\\u0648\\u064a\\u0629\",\"ground\":\"\\u0623\\u0631\\u0636\",\"threeDaySelect\":\"\\u0627\\u062e\\u062a\\u0631 3 \\u0623\\u064a\\u0627\\u0645\",\"nextDayAirSaver\":\"\\u0641\\u064a \\u0627\\u0644\\u064a\\u0648\\u0645 \\u0627\\u0644\\u062a\\u0627\\u0644\\u064a \\u0644\\u062a\\u0648\\u0641\\u064a\\u0631 \\u0627\\u0644\\u0647\\u0648\\u0627\\u0621\",\"nextDayAirEarlyAM\":\"\\u0641\\u064a \\u0627\\u0644\\u064a\\u0648\\u0645 \\u0627\\u0644\\u062a\\u0627\\u0644\\u064a \\u0644\\u0644\\u0637\\u064a\\u0631\\u0627\\u0646 \\u0641\\u064a \\u0648\\u0642\\u062a \\u0645\\u0628\\u0643\\u0631 \\u0635\\u0628\\u0627\\u062d\\u0627\",\"secondndDayAirAM\":\"\\u0627\\u0644\\u064a\\u0648\\u0645 \\u0627\\u0644\\u062b\\u0627\\u0646\\u064a \\u0644\\u0644\\u0637\\u064a\\u0631\\u0627\\u0646\"}');

-- --------------------------------------------------------

--
-- Table structure for table `shipping_methods`
--

CREATE TABLE `shipping_methods` (
  `shipping_methods_id` int(11) NOT NULL,
  `methods_type_link` varchar(100) NOT NULL,
  `isDefault` tinyint(1) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `table_name` varchar(191) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shipping_methods`
--

INSERT INTO `shipping_methods` (`shipping_methods_id`, `methods_type_link`, `isDefault`, `status`, `table_name`) VALUES
(1, 'upsShipping', 0, 0, 'ups_shipping'),
(2, 'freeShipping', 0, 0, 'free_shipping'),
(3, 'localPickup', 0, 0, 'local_pickup'),
(4, 'flateRate', 1, 1, 'flate_rate'),
(5, 'shippingByWeight', 0, 1, 'shipping_by_weight');

-- --------------------------------------------------------

--
-- Table structure for table `sliders_images`
--

CREATE TABLE `sliders_images` (
  `sliders_id` int(11) NOT NULL,
  `sliders_title` varchar(64) NOT NULL,
  `sliders_url` varchar(191) NOT NULL,
  `carousel_id` int(11) DEFAULT NULL,
  `sliders_image` varchar(191) NOT NULL,
  `sliders_group` varchar(64) NOT NULL,
  `sliders_html_text` text NOT NULL,
  `expires_date` datetime NOT NULL,
  `date_added` datetime NOT NULL,
  `status` tinyint(1) NOT NULL,
  `type` varchar(64) NOT NULL,
  `date_status_change` datetime DEFAULT NULL,
  `languages_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sliders_images`
--

INSERT INTO `sliders_images` (`sliders_id`, `sliders_title`, `sliders_url`, `carousel_id`, `sliders_image`, `sliders_group`, `sliders_html_text`, `expires_date`, `date_added`, `status`, `type`, `date_status_change`, `languages_id`) VALUES
(36, 'Right Slider with Navigation (770x400)', 'generator', 4, '772', '', '', '2022-11-20 00:00:00', '2021-12-13 11:30:46', 1, 'category', NULL, 1),
(35, 'Right Slider with Navigation (770x400)', 'circuit-breaker', 4, '775', '', '', '2022-08-20 00:00:00', '2021-12-13 11:28:47', 1, 'category', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `specials`
--

CREATE TABLE `specials` (
  `specials_id` int(11) NOT NULL,
  `products_id` int(11) NOT NULL,
  `specials_new_products_price` decimal(15,2) NOT NULL,
  `specials_date_added` int(11) NOT NULL,
  `specials_last_modified` int(11) NOT NULL,
  `expires_date` int(11) NOT NULL,
  `date_status_change` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tax_class`
--

CREATE TABLE `tax_class` (
  `tax_class_id` int(11) NOT NULL,
  `tax_class_title` varchar(32) NOT NULL,
  `tax_class_description` varchar(191) NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tax_class`
--

INSERT INTO `tax_class` (`tax_class_id`, `tax_class_title`, `tax_class_description`, `last_modified`, `date_added`, `created_at`, `updated_at`) VALUES
(2, 'test', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley ', NULL, '2020-04-05 01:10:00', '2019-09-18 05:33:25', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tax_rates`
--

CREATE TABLE `tax_rates` (
  `tax_rates_id` int(11) NOT NULL,
  `tax_zone_id` int(11) NOT NULL,
  `tax_class_id` int(11) NOT NULL,
  `tax_priority` int(11) DEFAULT 1,
  `tax_rate` decimal(7,2) NOT NULL,
  `tax_description` varchar(191) NOT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `top_offers`
--

CREATE TABLE `top_offers` (
  `top_offers_id` int(11) NOT NULL,
  `top_offers_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `language_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `top_offers`
--

INSERT INTO `top_offers` (`top_offers_id`, `top_offers_text`, `created_at`, `updated_at`, `language_id`) VALUES
(1, '<div style=\\\"font-size:15px;\\\">\r\nGet<strong> UPTO 20% OFF </strong>on Covid-19 Product\r\n <div class=\\\"pro-link-dropdown js-toppanel-link-dropdown\\\">\r\n <a href=\\\"/shop\\\" class=\\\"pro-dropdown-toggle\\\">\r\nSHOP NOW\r\n</a>\r\n</div>\r\n</div>', '2020-04-02 05:56:52', '2020-07-16 06:35:06', 1),
(2, '<p>Get<strong> UPTO 40% OFF </strong>on your 1st order <strong> <a href=\\\"#\\\"> More details </a> </strong></p>', '2020-04-02 05:56:52', '2020-02-03 14:26:53', 2),
(3, 'احصل على <strong> خصم يصل إلى 40٪ </ strong> على طلبك الأول\r\n <div class = \\\"pro-link-dropdown js-toppanel-link-dropdown\\\">\r\n <a href=\\\"/shop\\\" class=\\\"pro-dropdown-toggle\\\">\r\nتسوق الآن\r\n</a>\r\n</div>', '2020-04-02 05:56:52', '2020-07-16 06:35:06', 4);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `unit_id` int(10) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_added` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`unit_id`, `is_active`, `date_added`, `last_modified`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, '2019-01-01 02:04:18', '2019-01-01 02:04:18'),
(2, 1, NULL, NULL, '2019-01-01 02:04:18', '2019-01-01 02:04:18'),
(6, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `units_descriptions`
--

CREATE TABLE `units_descriptions` (
  `units_description_id` int(10) UNSIGNED NOT NULL,
  `units_name` varchar(191) NOT NULL,
  `languages_id` int(11) NOT NULL,
  `unit_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `units_descriptions`
--

INSERT INTO `units_descriptions` (`units_description_id`, `units_name`, `languages_id`, `unit_id`, `created_at`, `updated_at`) VALUES
(1, 'kg', 1, 3, NULL, NULL),
(2, 'Gram', 1, 4, NULL, NULL),
(4, 'gm', 1, 6, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ups_shipping`
--

CREATE TABLE `ups_shipping` (
  `ups_id` int(11) NOT NULL,
  `pickup_method` varchar(191) NOT NULL,
  `isDisplayCal` varchar(191) NOT NULL,
  `serviceType` varchar(191) NOT NULL,
  `shippingEnvironment` varchar(191) NOT NULL,
  `user_name` varchar(191) NOT NULL,
  `access_key` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `person_name` varchar(191) NOT NULL,
  `company_name` varchar(191) NOT NULL,
  `phone_number` varchar(191) NOT NULL,
  `address_line_1` varchar(191) NOT NULL,
  `address_line_2` varchar(191) NOT NULL,
  `country` varchar(191) NOT NULL,
  `state` varchar(191) NOT NULL,
  `post_code` varchar(191) NOT NULL,
  `city` varchar(191) NOT NULL,
  `no_of_package` varchar(191) NOT NULL,
  `parcel_height` varchar(191) NOT NULL,
  `parcel_width` varchar(191) NOT NULL,
  `title` varchar(191) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ups_shipping`
--

INSERT INTO `ups_shipping` (`ups_id`, `pickup_method`, `isDisplayCal`, `serviceType`, `shippingEnvironment`, `user_name`, `access_key`, `password`, `person_name`, `company_name`, `phone_number`, `address_line_1`, `address_line_2`, `country`, `state`, `post_code`, `city`, `no_of_package`, `parcel_height`, `parcel_width`, `title`) VALUES
(1, '07', '', 'US_01,US_02,US_03,US_12,US_13,US_14,US_59', '0', 'nyblueprint', 'FCD7C8F94CB5EF46', 'delfia11', '', '', '', 'D Ground', '', 'US', 'NY', '10312', 'New York City', '', '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `user_name` varchar(191) DEFAULT NULL,
  `first_name` varchar(191) NOT NULL,
  `last_name` varchar(191) NOT NULL,
  `gender` varchar(191) DEFAULT NULL,
  `default_address_id` int(11) NOT NULL DEFAULT 0,
  `country_code` varchar(191) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `api_token` longtext DEFAULT NULL,
  `avatar` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT '1',
  `is_seen` tinyint(1) NOT NULL DEFAULT 0,
  `phone_verified` varchar(191) DEFAULT NULL,
  `remember_token` varchar(191) DEFAULT NULL,
  `auth_id_tiwilo` varchar(191) DEFAULT NULL,
  `dob` varchar(33) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `user_name`, `first_name`, `last_name`, `gender`, `default_address_id`, `country_code`, `phone`, `email`, `password`, `api_token`, `avatar`, `status`, `is_seen`, `phone_verified`, `remember_token`, `auth_id_tiwilo`, `dob`, `created_at`, `updated_at`) VALUES
(1, 1, 'Super Admin', 'Admin', 'Kno', NULL, 0, NULL, NULL, 'info@knoprotec.com', '$2y$10$DpJnqSw1iJGViJLUeaOa9OB/O3fJhIH6/ArNMcI/0318mkbqeZGkG', NULL, NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-07-13 13:07:44', '2022-11-03 11:16:48'),
(2, 2, NULL, 'shirjoy', 'malek', '0', 0, NULL, NULL, 'shirjoy.malek@gmail.com', '$2y$10$QG.l/WUzUH9QcQCPUTG2EOTNfrmO25QECumpeaAbPjIcapgUNVtqq', NULL, NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-07-13 02:59:15', '2020-07-13 02:59:15'),
(3, 2, NULL, 'Alauddin', 'Ahmed', '1', 0, NULL, '01771502075', 'a@a.com', '$2y$10$JIjdcnqNxj7fdwpUsAutNe8ai/efEsL6XBfiYJP1mp0mTbDRIFeKK', '4b8dDDrXVZGIgWkAk0Z0r8BTs0LRk4xTLm4SeVeoEWVotHWRbIbmCGWswSBF', NULL, '1', 0, NULL, NULL, NULL, '09/29/2020', '2020-07-19 12:29:08', '2020-08-23 14:31:35'),
(4, 2, NULL, 'Akib', 'Mostafa', '0', 0, NULL, NULL, 'akibmostafa.starit@gmail.com', '$2y$10$5LZSGNxGYDswResn9RsVH.JDaCDaKDZf9ayrqOdwJEucbGtXS8xyq', 'kvN33jhsxAcIXAXkaS34vMN7wIPlWeuN52wApFcMtPYZbLdqeDoi3gqEHmTF', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-08-10 08:13:35', '2020-08-10 08:13:35'),
(5, 2, NULL, 'akshor', 'rizoan', NULL, 0, NULL, '01790488740', 'akshor.1992@gmail.com', '$2y$10$TIZQnmcEryoZqZBITKVCru5qQxqHUTj9BTM6CC6iZ92cuBkFOMhfm', NULL, NULL, '1', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 2, NULL, 'asd', 'sadas', '0', 0, NULL, NULL, 'a@a.a', '$2y$10$ido2M5zx9dwk0YMxJ/Ix8euIOW40tq39h9WVMsQfcfhpC6E8mEcq.', 'csXcT1xI6lAnSGevPfbtYVZWCAlXIA5vTGQVQgdxKNkZrtXdPaXBb4LozYah', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-08-19 09:32:31', '2020-08-19 09:32:31'),
(7, 2, NULL, 'Abul', 'Kalam', '0', 0, NULL, NULL, 'a@k.com', '$2y$10$Tqw9JnSozqyGikNp9ZvWvOT6uauqUDs2RDfriwopu2TJ8.QnyA9yK', 'JHCPAQ8eUMr9rwQiIg60MO1HOmlTTNedp8N2sBzxWburh9e2dOEz0I9vubdQ', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-08-20 14:47:44', '2020-08-20 14:47:44'),
(8, 2, NULL, 'Abul', 'Kalam', '0', 0, NULL, NULL, 'a@x.com', '$2y$10$Jo68e66LdJI268enSIdv3eTW.qwDdxjhcQvYvLrj7a2UuL7U3xGkC', 'c9P0KT3bTIXyW7JyDLLA88rwbLTeSp2cPOpnCh5azVUUHGSQrhoiTDwDArwN', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-08-20 14:58:55', '2020-08-20 14:58:55'),
(9, 2, NULL, 'Arafat Zahan', 'Kuasha', 'Male', 0, NULL, NULL, 'kuasha420@gmail.com', '$2y$10$ztrRUaXu/N5f5OTRsnZfje6FoTVZAY59FM4XNsJvupn2iVRXQgUme', 'x4YwPf0UG08Hss69B2nfJesvVCmkR7PSKzE4C1sxNz4yLbB1xdzrShJaw3EC', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-08-20 15:07:23', '2020-08-20 15:07:23'),
(10, 2, NULL, 'Abul', 'Kalam', '0', 0, NULL, NULL, 'v@x.com', '$2y$10$Emx9Kp8Gv6wxLKIKAm1sp.hSsYQ7jttoAd8mrD.JL9j9ldZ/LhIyy', 'dV7Odvah1i5BpKF7z8nTT4PjO5vhWheF49YjNWYRNu0w8JPTyKOEXvefDyGJ', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-08-20 15:08:25', '2020-08-20 15:08:25'),
(11, 2, NULL, 'Arafat Zahan', 'Kuasha', 'Male', 0, NULL, NULL, 'arafatzahan.starit@gmail.com', '$2y$10$LLilzjDUM.okNSDe2kEdg.frQMXKrihW49uuDzLz8s0ldZOov/eVG', '9GFsw202jEdqczVB0VajD0jE9B17ACNfffterqARv6AX86Shc52aKeJngyiF', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-08-20 15:19:46', '2020-08-20 15:19:46'),
(12, 2, NULL, 'Arafat', 'Zahan', 'Male', 0, NULL, NULL, 'arafatzahan2016@gmail.com', '$2y$10$0qpSgyM7zCedOQOmne3dlu.yYFVPC0F/qkmNjBZRRvlw8/Bb4m5z.', 'k9Gw81yow6eGEpGnrtQMTiCit71UT6CDGEuNYv2QkMjOxCqvrQxKx3zbMJNm', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-08-20 15:23:12', '2020-08-20 15:23:12'),
(13, 2, NULL, 'Saif', 'Imran', '0', 0, NULL, NULL, 'imraneee132@gmail.com', '$2y$10$fZQj7Tjq1isXQKFdMpZVau1h4/gQwgSgQ1BygWqE7mzkMU8RTqm/m', 'DycToeFfYROCdFoUDXD3bXEg4IStzjOFe8B0zPR9VTq0nLi2b2CO6rk27OkE', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-08-29 11:25:39', '2020-08-29 11:25:39'),
(14, 2, NULL, 'Alauddin', 'Ahmed', 'Male', 0, NULL, NULL, 'Abc@gmail.com', '$2y$10$EkmAfanUj0p5USgB/Viw3uenppBVJ6ovYwQTjjhYYraYDc6yatJN.', 'wswBNoXiMt631Xor0Vg1EZf6qA10CzGoaSj14SwNNureEmEJSXX5jf3aUmOk', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-09-01 16:21:42', '2020-09-01 16:21:42'),
(15, 2, NULL, 'Test', 'Test', 'Female', 0, NULL, NULL, 'Test1234@test.com', '$2y$10$QYB85UwSn45DNx1xf7yFsuPNDeMKw4Om5QM2ECPSviPb6utK4d/9K', 'emOgZzJ2oQNlk9VirMNiW6G0wybB3aRQ5btEJq7KV0te5wtVVTDvkqWEeMe0', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-09-20 18:21:03', '2020-09-20 18:21:03'),
(16, 2, NULL, 'Tes', 'Tes', 'Other', 0, NULL, NULL, 't@es.x', '$2y$10$VnVaOCfBuomvjnrBnUfBUuVRmW2RseRRK.0XizUauNHw03f23a5fq', 'p1JJdgbf2poE98Rorl3LCa3aQASMM0C67D3sfb3nvr7Ys0p6aRWaoATRfnkn', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-09-26 13:21:20', '2020-09-26 13:21:20'),
(17, 2, NULL, 'Rahj', 'Vhh', 'Other', 0, NULL, NULL, 'Abnfgj@gmail.com', '$2y$10$XvARc1OHsYuYI3S0iciNpuZd8oUx/p6mAVGxJV46M1JYM.9t0IvIu', '3wNTKCsWbk9VERkl1ktR3WSb6Gj3WwyJnTV6pe6iGHLWAtLlAj0MfKhP2YPf', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-10-04 11:24:18', '2020-10-04 11:24:18'),
(18, 2, NULL, 'Joy', 'Adtiya', NULL, 0, NULL, '01975655579', 'palash_872000@yahoo.com', '$2y$10$uaDrfIaKYDCUwZYG59CIzuOHdaRiS5pRwq06otXdVYAEQsC5Eu4Ca', NULL, NULL, '1', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 2, NULL, 'Uddrity', 'Das', '1', 0, NULL, NULL, 'uddritydas009@gmail.com', '$2y$10$15LTt/48CJlhSMXLP9leh.yay3JjyDQWF1GCtE/GLwaE1BGQJ9d/i', 'D6ROvV2U0U7yf8jGhqEYG3rgKKLTOj53yvtC5JTPoEvRV4nUIsH4yLRZInA8', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-10-14 12:40:08', '2020-10-14 12:40:08'),
(20, 2, NULL, 'Ala', 'Ddin', 'Male', 0, NULL, NULL, '1234@gmail.con', '$2y$10$IXOtisvVW611ld8/1A6NgewBW8q5mwudtdTblIP1RHLX8qUbONJSG', 'plgXcSy5r33sgT4ePnD6VIQfBTjpPnjgj80NlWe5nM4FPmigxd67bhC6zhDL', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-10-20 13:41:53', '2020-10-20 13:41:53'),
(21, 2, NULL, 'test mail', 'email', '0', 0, NULL, NULL, 'bhuban.bogra@gmail.com', '$2y$10$lkvu8pr2lNC32vaKYjAM4.XKuafstyKwSTdFSu7nh9Rop5Z4EGi96', 'lVOg8bkDGQS6r59Pbq2lJbMI9duQ6YLPrwX4tbVy3H1z9loRjEwMmFAcqx8h', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-11-09 14:29:45', '2020-11-09 14:29:45'),
(22, 2, NULL, 'asd', 'asdfa', 'Other', 0, NULL, NULL, 'sdf@gmail.com', '$2y$10$HlKY5yzClQW4E1Rwjq/H1OK6FHhffHMsonGoC5Oe.STcAH.ZA3R9y', 'Ryrz9fCiX0vgEzZAkODxN8nkp5PCcB9892axI9J8S5KI5dYQVkIhv7oGtTUW', NULL, '1', 0, NULL, NULL, NULL, NULL, '2020-11-18 10:12:15', '2020-11-18 10:12:15'),
(23, 2, NULL, 'Md Ashiqur', 'Rahman', '0', 0, NULL, NULL, 'ashiq.starit@gmail.com', '$2y$10$6daqq520tZyE7BebhE6iHuJAVljhnFeeG2jcpwcISlf3/EDwgdIsy', 'auF9dW1clVQytI9xfi7tSLlpBieEVdLf7PcDpYEWlhiDKPbO5NmsyRDk0TCQ', NULL, '1', 0, NULL, NULL, NULL, NULL, '2021-08-18 08:05:34', '2021-08-18 08:05:34'),
(24, 2, NULL, 'Sajib Saha', 'Dip', '0', 0, NULL, NULL, 'dipsajibsaha@gmail.com', '$2y$10$QDcxhaSQADEgpO77F/N5l.e2DQ.L7WHjQYyfUxSCQPEsWqyxrzJwi', 'EUgzwxCiqSLJ03l5uHoE5adTtisyffMVBPgNRWFp0lzlukvTQSAnBRtOvLA2', NULL, '1', 0, NULL, NULL, NULL, NULL, '2022-01-02 13:54:40', '2022-01-02 13:54:40'),
(25, 2, NULL, 'Adrik', 'Das', '0', 0, NULL, NULL, 'adrikdasukto@gmail.com', '$2y$10$ihZMhiLhCrQfWh1LbzRz1.S9QxVYqhCqyPUlZaI/ToT79vK5OXbxG', 'lY3tf5K0mE8Zgdw7MyeUbGeOuQC6WoQv0vHdr3Pfs63HL0RVByowZwTtQ9KB', NULL, '1', 0, NULL, NULL, NULL, NULL, '2022-01-17 11:07:05', '2022-01-17 11:07:05'),
(26, 2, NULL, 'Mr', 'Misbah', '0', 0, NULL, NULL, 'misbah.powertrac@gmail.com', '$2y$10$w8.9k4BYEeFdn9xUOE0otO6dDrx9JzQzADAr71LW224lk0moLX8wq', 'geavbcSSezw8W9Gaj4rwM6jyPXCcTOHauuW0NLQk16HDBvMknz4YBQowSiCs', NULL, '1', 1, NULL, NULL, NULL, NULL, '2022-03-23 13:34:28', '2022-03-23 13:34:28'),
(27, 2, NULL, 'Uttam Das', 'das', NULL, 0, NULL, '01819073466', 'uttamiub@gmail.com', '$2y$10$irF5Vc1sE8x0xdHOAPLFiOjuaz2CtyfQSNfq2Kt.LPsDRnah2ab8m', NULL, NULL, '1', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(28, 2, NULL, 'protik', 'das', '0', 0, NULL, NULL, 'protikdas0912@gmail.com', '$2y$10$l632KU5rC6K1BBO9i4N6Xujd4wProMyXaA5c.ftteDCOOSSqCl9/i', 'B58x46R0UeGxAyw5NPvMOfuzPVZ6jz5zFsdW5E2otBbwAsXTHu5gawCLyZkD', NULL, '1', 1, NULL, NULL, NULL, NULL, '2022-11-03 12:21:37', '2022-11-03 12:21:37');

-- --------------------------------------------------------

--
-- Table structure for table `user_to_address`
--

CREATE TABLE `user_to_address` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address_book_id` int(11) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_to_address`
--

INSERT INTO `user_to_address` (`id`, `user_id`, `address_book_id`, `is_default`) VALUES
(19, 3, 19, 0),
(21, 3, 21, 0),
(31, 9, 31, 0),
(32, 9, 32, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_types`
--

CREATE TABLE `user_types` (
  `user_types_id` int(11) NOT NULL,
  `user_types_name` varchar(191) NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `isActive` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `user_types`
--

INSERT INTO `user_types` (`user_types_id`, `user_types_name`, `created_at`, `updated_at`, `isActive`) VALUES
(1, 'Super Admin', 1534774230, NULL, 1),
(2, 'Customers', 1534777027, NULL, 1),
(3, 'Vendors', 1538390209, NULL, 1),
(4, 'Delivery Guy', 1542965906, NULL, 1),
(5, 'Test 1', 1542965906, NULL, 1),
(6, 'Test 2', 1542965906, NULL, 1),
(7, 'Test 3', 1542965906, NULL, 1),
(8, 'Test 4', 1542965906, NULL, 1),
(9, 'Test 5', 1542965906, NULL, 1),
(10, 'Test 6', 1542965906, NULL, 1),
(11, 'Admin', 1542965906, NULL, 1),
(12, 'Manager', 1542965906, NULL, 1),
(13, 'Data Entry', 1542965906, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `whos_online`
--

CREATE TABLE `whos_online` (
  `customer_id` int(11) NOT NULL DEFAULT 0,
  `full_name` varchar(191) NOT NULL,
  `session_id` varchar(128) NOT NULL,
  `ip_address` varchar(15) NOT NULL,
  `time_entry` varchar(14) NOT NULL,
  `time_last_click` varchar(14) NOT NULL,
  `last_page_url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `zones`
--

CREATE TABLE `zones` (
  `zone_id` int(11) NOT NULL,
  `zone_country_id` int(11) NOT NULL,
  `zone_code` varchar(32) NOT NULL,
  `zone_name` varchar(191) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `zones`
--

INSERT INTO `zones` (`zone_id`, `zone_country_id`, `zone_code`, `zone_name`) VALUES
(1, 223, 'AL', 'Alabama'),
(2, 223, 'AK', 'Alaska'),
(3, 223, 'AS', 'American Samoa'),
(4, 223, 'AZ', 'Arizona'),
(5, 223, 'AR', 'Arkansas'),
(6, 223, 'AF', 'Armed Forces Africa'),
(7, 223, 'AA', 'Armed Forces Americas'),
(8, 223, 'AC', 'Armed Forces Canada'),
(9, 223, 'AE', 'Armed Forces Europe'),
(10, 223, 'AM', 'Armed Forces Middle East'),
(11, 223, 'AP', 'Armed Forces Pacific'),
(12, 223, 'CA', 'California'),
(13, 223, 'CO', 'Colorado'),
(14, 223, 'CT', 'Connecticut'),
(15, 223, 'DE', 'Delaware'),
(16, 223, 'DC', 'District of Columbia'),
(17, 223, 'FM', 'Federated States Of Micronesia'),
(18, 223, 'FL', 'Florida'),
(19, 223, 'GA', 'Georgia'),
(20, 223, 'GU', 'Guam'),
(21, 223, 'HI', 'Hawaii'),
(22, 223, 'ID', 'Idaho'),
(23, 223, 'IL', 'Illinois'),
(24, 223, 'IN', 'Indiana'),
(25, 223, 'IA', 'Iowa'),
(26, 223, 'KS', 'Kansas'),
(27, 223, 'KY', 'Kentucky'),
(28, 223, 'LA', 'Louisiana'),
(29, 223, 'ME', 'Maine'),
(30, 223, 'MH', 'Marshall Islands'),
(31, 223, 'MD', 'Maryland'),
(32, 223, 'MA', 'Massachusetts'),
(33, 223, 'MI', 'Michigan'),
(34, 223, 'MN', 'Minnesota'),
(35, 223, 'MS', 'Mississippi'),
(36, 223, 'MO', 'Missouri'),
(37, 223, 'MT', 'Montana'),
(38, 223, 'NE', 'Nebraska'),
(39, 223, 'NV', 'Nevada'),
(40, 223, 'NH', 'New Hampshire'),
(41, 223, 'NJ', 'New Jersey'),
(42, 223, 'NM', 'New Mexico'),
(43, 223, 'NY', 'New York'),
(44, 223, 'NC', 'North Carolina'),
(45, 223, 'ND', 'North Dakota'),
(46, 223, 'MP', 'Northern Mariana Islands'),
(47, 223, 'OH', 'Ohio'),
(48, 223, 'OK', 'Oklahoma'),
(49, 223, 'OR', 'Oregon'),
(50, 223, 'PW', 'Palau'),
(51, 223, 'PA', 'Pennsylvania'),
(52, 223, 'PR', 'Puerto Rico'),
(53, 223, 'RI', 'Rhode Island'),
(54, 223, 'SC', 'South Carolina'),
(55, 223, 'SD', 'South Dakota'),
(56, 223, 'TN', 'Tennessee'),
(57, 223, 'TX', 'Texas'),
(58, 223, 'UT', 'Utah'),
(59, 223, 'VT', 'Vermont'),
(60, 223, 'VI', 'Virgin Islands'),
(61, 223, 'VA', 'Virginia'),
(62, 223, 'WA', 'Washington'),
(63, 223, 'WV', 'West Virginia'),
(64, 223, 'WI', 'Wisconsin'),
(65, 223, 'WY', 'Wyoming'),
(66, 38, 'AB', 'Alberta'),
(67, 38, 'BC', 'British Columbia'),
(68, 38, 'MB', 'Manitoba'),
(69, 38, 'NF', 'Newfoundland'),
(70, 38, 'NB', 'New Brunswick'),
(71, 38, 'NS', 'Nova Scotia'),
(72, 38, 'NT', 'Northwest Territories'),
(73, 38, 'NU', 'Nunavut'),
(74, 38, 'ON', 'Ontario'),
(75, 38, 'PE', 'Prince Edward Island'),
(76, 38, 'QC', 'Quebec'),
(77, 38, 'SK', 'Saskatchewan'),
(78, 38, 'YT', 'Yukon Territory'),
(79, 81, 'NDS', 'Niedersachsen'),
(80, 81, 'BAW', 'Baden-Württemberg'),
(81, 81, 'BAY', 'Bayern'),
(82, 81, 'BER', 'Berlin'),
(83, 81, 'BRG', 'Brandenburg'),
(84, 81, 'BRE', 'Bremen'),
(85, 81, 'HAM', 'Hamburg'),
(86, 81, 'HES', 'Hessen'),
(87, 81, 'MEC', 'Mecklenburg-Vorpommern'),
(88, 81, 'NRW', 'Nordrhein-Westfalen'),
(89, 81, 'RHE', 'Rheinland-Pfalz'),
(90, 81, 'SAR', 'Saarland'),
(91, 81, 'SAS', 'Sachsen'),
(92, 81, 'SAC', 'Sachsen-Anhalt'),
(93, 81, 'SCN', 'Schleswig-Holstein'),
(94, 81, 'THE', 'Thüringen'),
(95, 14, 'WI', 'Wien'),
(96, 14, 'NO', 'Niederösterreich'),
(97, 14, 'OO', 'Oberösterreich'),
(98, 14, 'SB', 'Salzburg'),
(99, 14, 'KN', 'Kärnten'),
(100, 14, 'ST', 'Steiermark'),
(101, 14, 'TI', 'Tirol'),
(102, 14, 'BL', 'Burgenland'),
(103, 14, 'VB', 'Voralberg'),
(104, 204, 'AG', 'Aargau'),
(105, 204, 'AI', 'Appenzell Innerrhoden'),
(106, 204, 'AR', 'Appenzell Ausserrhoden'),
(107, 204, 'BE', 'Bern'),
(108, 204, 'BL', 'Basel-Landschaft'),
(109, 204, 'BS', 'Basel-Stadt'),
(110, 204, 'FR', 'Freiburg'),
(111, 204, 'GE', 'Genf'),
(112, 204, 'GL', 'Glarus'),
(113, 204, 'JU', 'Graubünden'),
(114, 204, 'JU', 'Jura'),
(115, 204, 'LU', 'Luzern'),
(116, 204, 'NE', 'Neuenburg'),
(117, 204, 'NW', 'Nidwalden'),
(118, 204, 'OW', 'Obwalden'),
(119, 204, 'SG', 'St. Gallen'),
(120, 204, 'SH', 'Schaffhausen'),
(121, 204, 'SO', 'Solothurn'),
(122, 204, 'SZ', 'Schwyz'),
(123, 204, 'TG', 'Thurgau'),
(124, 204, 'TI', 'Tessin'),
(125, 204, 'UR', 'Uri'),
(126, 204, 'VD', 'Waadt'),
(127, 204, 'VS', 'Wallis'),
(128, 204, 'ZG', 'Zug'),
(129, 204, 'ZH', 'Zürich'),
(130, 195, 'A Coruña', 'A Coruña'),
(131, 195, 'Alava', 'Alava'),
(132, 195, 'Albacete', 'Albacete'),
(133, 195, 'Alicante', 'Alicante'),
(134, 195, 'Almeria', 'Almeria'),
(135, 195, 'Asturias', 'Asturias'),
(136, 195, 'Avila', 'Avila'),
(137, 195, 'Badajoz', 'Badajoz'),
(138, 195, 'Baleares', 'Baleares'),
(139, 195, 'Barcelona', 'Barcelona'),
(140, 195, 'Burgos', 'Burgos'),
(141, 195, 'Caceres', 'Caceres'),
(142, 195, 'Cadiz', 'Cadiz'),
(143, 195, 'Cantabria', 'Cantabria'),
(144, 195, 'Castellon', 'Castellon'),
(145, 195, 'Ceuta', 'Ceuta'),
(146, 195, 'Ciudad Real', 'Ciudad Real'),
(147, 195, 'Cordoba', 'Cordoba'),
(148, 195, 'Cuenca', 'Cuenca'),
(149, 195, 'Girona', 'Girona'),
(150, 195, 'Granada', 'Granada'),
(151, 195, 'Guadalajara', 'Guadalajara'),
(152, 195, 'Guipuzcoa', 'Guipuzcoa'),
(153, 195, 'Huelva', 'Huelva'),
(154, 195, 'Huesca', 'Huesca'),
(155, 195, 'Jaen', 'Jaen'),
(156, 195, 'La Rioja', 'La Rioja'),
(157, 195, 'Las Palmas', 'Las Palmas'),
(158, 195, 'Leon', 'Leon'),
(159, 195, 'Lleida', 'Lleida'),
(160, 195, 'Lugo', 'Lugo'),
(161, 195, 'Madrid', 'Madrid'),
(162, 195, 'Malaga', 'Malaga'),
(163, 195, 'Melilla', 'Melilla'),
(164, 195, 'Murcia', 'Murcia'),
(165, 195, 'Navarra', 'Navarra'),
(166, 195, 'Ourense', 'Ourense'),
(167, 195, 'Palencia', 'Palencia'),
(168, 195, 'Pontevedra', 'Pontevedra'),
(169, 195, 'Salamanca', 'Salamanca'),
(170, 195, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife'),
(171, 195, 'Segovia', 'Segovia'),
(172, 195, 'Sevilla', 'Sevilla'),
(173, 195, 'Soria', 'Soria'),
(174, 195, 'Tarragona', 'Tarragona'),
(175, 195, 'Teruel', 'Teruel'),
(176, 195, 'Toledo', 'Toledo'),
(177, 195, 'Valencia', 'Valencia'),
(178, 195, 'Valladolid', 'Valladolid'),
(179, 195, 'Vizcaya', 'Vizcaya'),
(180, 195, 'Zamora', 'Zamora'),
(181, 195, 'Zaragoza', 'Zaragoza');

-- --------------------------------------------------------

--
-- Table structure for table `zones_to_geo_zones`
--

CREATE TABLE `zones_to_geo_zones` (
  `association_id` int(11) NOT NULL,
  `zone_country_id` int(11) NOT NULL,
  `zone_id` int(11) DEFAULT NULL,
  `geo_zone_id` int(11) DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `date_added` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address_book`
--
ALTER TABLE `address_book`
  ADD PRIMARY KEY (`address_book_id`),
  ADD KEY `idx_address_book_customers_id` (`user_id`);

--
-- Indexes for table `alert_settings`
--
ALTER TABLE `alert_settings`
  ADD PRIMARY KEY (`alert_id`);

--
-- Indexes for table `api_calls_list`
--
ALTER TABLE `api_calls_list`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`banners_id`),
  ADD KEY `idx_banners_group` (`banners_group`);

--
-- Indexes for table `banners_history`
--
ALTER TABLE `banners_history`
  ADD PRIMARY KEY (`banners_history_id`),
  ADD KEY `idx_banners_history_banners_id` (`banners_id`);

--
-- Indexes for table `block_ips`
--
ALTER TABLE `block_ips`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`categories_id`),
  ADD KEY `idx_categories_parent_id` (`parent_id`);

--
-- Indexes for table `categories_description`
--
ALTER TABLE `categories_description`
  ADD PRIMARY KEY (`categories_description_id`),
  ADD KEY `idx_categories_name` (`categories_name`);

--
-- Indexes for table `categories_role`
--
ALTER TABLE `categories_role`
  ADD PRIMARY KEY (`categories_role_id`);

--
-- Indexes for table `compare`
--
ALTER TABLE `compare`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `constant_banners`
--
ALTER TABLE `constant_banners`
  ADD PRIMARY KEY (`banners_id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`countries_id`),
  ADD KEY `IDX_COUNTRIES_NAME` (`countries_name`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`coupans_id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_currencies_code` (`code`);

--
-- Indexes for table `currency_record`
--
ALTER TABLE `currency_record`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `current_theme`
--
ALTER TABLE `current_theme`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customers_id`);

--
-- Indexes for table `customers_basket`
--
ALTER TABLE `customers_basket`
  ADD PRIMARY KEY (`customers_basket_id`),
  ADD KEY `idx_customers_basket_customers_id` (`customers_id`);

--
-- Indexes for table `customers_basket_attributes`
--
ALTER TABLE `customers_basket_attributes`
  ADD PRIMARY KEY (`customers_basket_attributes_id`),
  ADD KEY `idx_customers_basket_att_customers_id` (`customers_id`);

--
-- Indexes for table `customers_info`
--
ALTER TABLE `customers_info`
  ADD PRIMARY KEY (`customers_info_id`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flash_sale`
--
ALTER TABLE `flash_sale`
  ADD PRIMARY KEY (`flash_sale_id`),
  ADD KEY `products_id` (`products_id`);

--
-- Indexes for table `flate_rate`
--
ALTER TABLE `flate_rate`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `front_end_theme_content`
--
ALTER TABLE `front_end_theme_content`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `geo_zones`
--
ALTER TABLE `geo_zones`
  ADD PRIMARY KEY (`geo_zone_id`);

--
-- Indexes for table `http_call_record`
--
ALTER TABLE `http_call_record`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `image_categories`
--
ALTER TABLE `image_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_ref_id`);

--
-- Indexes for table `labels`
--
ALTER TABLE `labels`
  ADD PRIMARY KEY (`label_id`);

--
-- Indexes for table `label_value`
--
ALTER TABLE `label_value`
  ADD PRIMARY KEY (`label_value_id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`languages_id`),
  ADD KEY `IDX_LANGUAGES_NAME` (`name`);

--
-- Indexes for table `liked_products`
--
ALTER TABLE `liked_products`
  ADD PRIMARY KEY (`like_id`);

--
-- Indexes for table `manage_min_max`
--
ALTER TABLE `manage_min_max`
  ADD PRIMARY KEY (`min_max_id`);

--
-- Indexes for table `manage_role`
--
ALTER TABLE `manage_role`
  ADD PRIMARY KEY (`manage_role_id`);

--
-- Indexes for table `manufacturers`
--
ALTER TABLE `manufacturers`
  ADD PRIMARY KEY (`manufacturers_id`);

--
-- Indexes for table `manufacturers_info`
--
ALTER TABLE `manufacturers_info`
  ADD PRIMARY KEY (`manufacturers_id`,`languages_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_translation`
--
ALTER TABLE `menu_translation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`news_id`),
  ADD KEY `idx_products_date_added` (`news_date_added`);

--
-- Indexes for table `news_categories`
--
ALTER TABLE `news_categories`
  ADD PRIMARY KEY (`categories_id`),
  ADD KEY `idx_categories_parent_id` (`parent_id`);

--
-- Indexes for table `news_categories_description`
--
ALTER TABLE `news_categories_description`
  ADD PRIMARY KEY (`categories_description_id`),
  ADD KEY `idx_categories_name` (`categories_name`);

--
-- Indexes for table `news_description`
--
ALTER TABLE `news_description`
  ADD KEY `products_name` (`news_name`);

--
-- Indexes for table `news_to_news_categories`
--
ALTER TABLE `news_to_news_categories`
  ADD PRIMARY KEY (`news_id`,`categories_id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_personal_access_clients_client_id_index` (`client_id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orders_id`),
  ADD KEY `idx_orders_customers_id` (`customers_id`);

--
-- Indexes for table `orders_products`
--
ALTER TABLE `orders_products`
  ADD PRIMARY KEY (`orders_products_id`),
  ADD KEY `idx_orders_products_orders_id` (`orders_id`),
  ADD KEY `idx_orders_products_products_id` (`products_id`);

--
-- Indexes for table `orders_products_attributes`
--
ALTER TABLE `orders_products_attributes`
  ADD PRIMARY KEY (`orders_products_attributes_id`),
  ADD KEY `idx_orders_products_att_orders_id` (`orders_id`);

--
-- Indexes for table `orders_status`
--
ALTER TABLE `orders_status`
  ADD PRIMARY KEY (`orders_status_id`);

--
-- Indexes for table `orders_status_description`
--
ALTER TABLE `orders_status_description`
  ADD PRIMARY KEY (`orders_status_description_id`);

--
-- Indexes for table `orders_status_history`
--
ALTER TABLE `orders_status_history`
  ADD PRIMARY KEY (`orders_status_history_id`),
  ADD KEY `idx_orders_status_history_orders_id` (`orders_id`);

--
-- Indexes for table `orders_total`
--
ALTER TABLE `orders_total`
  ADD PRIMARY KEY (`orders_total_id`),
  ADD KEY `idx_orders_total_orders_id` (`orders_id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`page_id`);

--
-- Indexes for table `pages_description`
--
ALTER TABLE `pages_description`
  ADD PRIMARY KEY (`page_description_id`);

--
-- Indexes for table `payment_description`
--
ALTER TABLE `payment_description`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`payment_methods_id`);

--
-- Indexes for table `payment_methods_detail`
--
ALTER TABLE `payment_methods_detail`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`products_id`),
  ADD KEY `idx_products_model` (`products_model`),
  ADD KEY `idx_products_date_added` (`products_date_added`);

--
-- Indexes for table `products_attributes`
--
ALTER TABLE `products_attributes`
  ADD PRIMARY KEY (`products_attributes_id`),
  ADD KEY `idx_products_attributes_products_id` (`products_id`);

--
-- Indexes for table `products_attributes_download`
--
ALTER TABLE `products_attributes_download`
  ADD PRIMARY KEY (`products_attributes_id`);

--
-- Indexes for table `products_description`
--
ALTER TABLE `products_description`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_name` (`products_name`);

--
-- Indexes for table `products_images`
--
ALTER TABLE `products_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_images_prodid` (`products_id`);

--
-- Indexes for table `products_notifications`
--
ALTER TABLE `products_notifications`
  ADD PRIMARY KEY (`products_id`,`customers_id`);

--
-- Indexes for table `products_options`
--
ALTER TABLE `products_options`
  ADD PRIMARY KEY (`products_options_id`);

--
-- Indexes for table `products_options_descriptions`
--
ALTER TABLE `products_options_descriptions`
  ADD PRIMARY KEY (`products_options_descriptions_id`);

--
-- Indexes for table `products_options_values`
--
ALTER TABLE `products_options_values`
  ADD PRIMARY KEY (`products_options_values_id`);

--
-- Indexes for table `products_options_values_descriptions`
--
ALTER TABLE `products_options_values_descriptions`
  ADD PRIMARY KEY (`products_options_values_descriptions_id`);

--
-- Indexes for table `products_shipping_rates`
--
ALTER TABLE `products_shipping_rates`
  ADD PRIMARY KEY (`products_shipping_rates_id`);

--
-- Indexes for table `products_to_categories`
--
ALTER TABLE `products_to_categories`
  ADD PRIMARY KEY (`products_to_categories_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`reviews_id`),
  ADD KEY `idx_reviews_products_id` (`products_id`),
  ADD KEY `idx_reviews_customers_id` (`customers_id`);

--
-- Indexes for table `reviews_description`
--
ALTER TABLE `reviews_description`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`sesskey`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_name_unique` (`name`);

--
-- Indexes for table `shipping_description`
--
ALTER TABLE `shipping_description`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shipping_methods`
--
ALTER TABLE `shipping_methods`
  ADD PRIMARY KEY (`shipping_methods_id`);

--
-- Indexes for table `sliders_images`
--
ALTER TABLE `sliders_images`
  ADD PRIMARY KEY (`sliders_id`);

--
-- Indexes for table `specials`
--
ALTER TABLE `specials`
  ADD PRIMARY KEY (`specials_id`),
  ADD KEY `idx_specials_products_id` (`products_id`);

--
-- Indexes for table `tax_class`
--
ALTER TABLE `tax_class`
  ADD PRIMARY KEY (`tax_class_id`);

--
-- Indexes for table `tax_rates`
--
ALTER TABLE `tax_rates`
  ADD PRIMARY KEY (`tax_rates_id`);

--
-- Indexes for table `top_offers`
--
ALTER TABLE `top_offers`
  ADD PRIMARY KEY (`top_offers_id`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`unit_id`);

--
-- Indexes for table `units_descriptions`
--
ALTER TABLE `units_descriptions`
  ADD PRIMARY KEY (`units_description_id`);

--
-- Indexes for table `ups_shipping`
--
ALTER TABLE `ups_shipping`
  ADD PRIMARY KEY (`ups_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_to_address`
--
ALTER TABLE `user_to_address`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_types`
--
ALTER TABLE `user_types`
  ADD PRIMARY KEY (`user_types_id`);

--
-- Indexes for table `whos_online`
--
ALTER TABLE `whos_online`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `zones`
--
ALTER TABLE `zones`
  ADD PRIMARY KEY (`zone_id`),
  ADD KEY `idx_zones_country_id` (`zone_country_id`);

--
-- Indexes for table `zones_to_geo_zones`
--
ALTER TABLE `zones_to_geo_zones`
  ADD PRIMARY KEY (`association_id`),
  ADD KEY `idx_zones_to_geo_zones_country_id` (`zone_country_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `address_book`
--
ALTER TABLE `address_book`
  MODIFY `address_book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `alert_settings`
--
ALTER TABLE `alert_settings`
  MODIFY `alert_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `api_calls_list`
--
ALTER TABLE `api_calls_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `banners_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `banners_history`
--
ALTER TABLE `banners_history`
  MODIFY `banners_history_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `block_ips`
--
ALTER TABLE `block_ips`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `categories_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `categories_description`
--
ALTER TABLE `categories_description`
  MODIFY `categories_description_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT for table `categories_role`
--
ALTER TABLE `categories_role`
  MODIFY `categories_role_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `compare`
--
ALTER TABLE `compare`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `constant_banners`
--
ALTER TABLE `constant_banners`
  MODIFY `banners_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `countries_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=242;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `coupans_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `currency_record`
--
ALTER TABLE `currency_record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;

--
-- AUTO_INCREMENT for table `current_theme`
--
ALTER TABLE `current_theme`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52892;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customers_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customers_basket`
--
ALTER TABLE `customers_basket`
  MODIFY `customers_basket_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT for table `customers_basket_attributes`
--
ALTER TABLE `customers_basket_attributes`
  MODIFY `customers_basket_attributes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flash_sale`
--
ALTER TABLE `flash_sale`
  MODIFY `flash_sale_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `flate_rate`
--
ALTER TABLE `flate_rate`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `front_end_theme_content`
--
ALTER TABLE `front_end_theme_content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `geo_zones`
--
ALTER TABLE `geo_zones`
  MODIFY `geo_zone_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `http_call_record`
--
ALTER TABLE `http_call_record`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=829;

--
-- AUTO_INCREMENT for table `image_categories`
--
ALTER TABLE `image_categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1706;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_ref_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1168;

--
-- AUTO_INCREMENT for table `labels`
--
ALTER TABLE `labels`
  MODIFY `label_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1118;

--
-- AUTO_INCREMENT for table `label_value`
--
ALTER TABLE `label_value`
  MODIFY `label_value_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1828;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `languages_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `liked_products`
--
ALTER TABLE `liked_products`
  MODIFY `like_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `manage_min_max`
--
ALTER TABLE `manage_min_max`
  MODIFY `min_max_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `manage_role`
--
ALTER TABLE `manage_role`
  MODIFY `manage_role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `manufacturers`
--
ALTER TABLE `manufacturers`
  MODIFY `manufacturers_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `menu_translation`
--
ALTER TABLE `menu_translation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `news_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `news_categories`
--
ALTER TABLE `news_categories`
  MODIFY `categories_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `news_categories_description`
--
ALTER TABLE `news_categories_description`
  MODIFY `categories_description_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orders_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `orders_products`
--
ALTER TABLE `orders_products`
  MODIFY `orders_products_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `orders_products_attributes`
--
ALTER TABLE `orders_products_attributes`
  MODIFY `orders_products_attributes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders_status`
--
ALTER TABLE `orders_status`
  MODIFY `orders_status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders_status_description`
--
ALTER TABLE `orders_status_description`
  MODIFY `orders_status_description_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders_status_history`
--
ALTER TABLE `orders_status_history`
  MODIFY `orders_status_history_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT for table `orders_total`
--
ALTER TABLE `orders_total`
  MODIFY `orders_total_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `page_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `pages_description`
--
ALTER TABLE `pages_description`
  MODIFY `page_description_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `payment_description`
--
ALTER TABLE `payment_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `payment_methods_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `payment_methods_detail`
--
ALTER TABLE `payment_methods_detail`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `products_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=368;

--
-- AUTO_INCREMENT for table `products_attributes`
--
ALTER TABLE `products_attributes`
  MODIFY `products_attributes_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `products_description`
--
ALTER TABLE `products_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=461;

--
-- AUTO_INCREMENT for table `products_images`
--
ALTER TABLE `products_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `products_options`
--
ALTER TABLE `products_options`
  MODIFY `products_options_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products_options_descriptions`
--
ALTER TABLE `products_options_descriptions`
  MODIFY `products_options_descriptions_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `products_options_values`
--
ALTER TABLE `products_options_values`
  MODIFY `products_options_values_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `products_options_values_descriptions`
--
ALTER TABLE `products_options_values_descriptions`
  MODIFY `products_options_values_descriptions_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `products_shipping_rates`
--
ALTER TABLE `products_shipping_rates`
  MODIFY `products_shipping_rates_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products_to_categories`
--
ALTER TABLE `products_to_categories`
  MODIFY `products_to_categories_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1295;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `reviews_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `reviews_description`
--
ALTER TABLE `reviews_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=128;

--
-- AUTO_INCREMENT for table `shipping_description`
--
ALTER TABLE `shipping_description`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `shipping_methods`
--
ALTER TABLE `shipping_methods`
  MODIFY `shipping_methods_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `sliders_images`
--
ALTER TABLE `sliders_images`
  MODIFY `sliders_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `specials`
--
ALTER TABLE `specials`
  MODIFY `specials_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tax_class`
--
ALTER TABLE `tax_class`
  MODIFY `tax_class_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tax_rates`
--
ALTER TABLE `tax_rates`
  MODIFY `tax_rates_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `top_offers`
--
ALTER TABLE `top_offers`
  MODIFY `top_offers_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `unit_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `units_descriptions`
--
ALTER TABLE `units_descriptions`
  MODIFY `units_description_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `ups_shipping`
--
ALTER TABLE `ups_shipping`
  MODIFY `ups_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `user_to_address`
--
ALTER TABLE `user_to_address`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `user_types`
--
ALTER TABLE `user_types`
  MODIFY `user_types_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `zones`
--
ALTER TABLE `zones`
  MODIFY `zone_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=184;

--
-- AUTO_INCREMENT for table `zones_to_geo_zones`
--
ALTER TABLE `zones_to_geo_zones`
  MODIFY `association_id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
