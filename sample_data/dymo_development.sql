-- phpMyAdmin SQL Dump
-- version 3.3.7
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 17, 2011 at 05:18 PM
-- Server version: 5.1.49
-- PHP Version: 5.3.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `dymo_development`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE IF NOT EXISTS `appointments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_id` int(11) DEFAULT NULL,
  `physician_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=8 ;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `patient_id`, `physician_id`, `created_at`, `updated_at`) VALUES
(7, 2, 1, '2011-07-17 10:22:55', '2011-07-17 10:22:55');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE IF NOT EXISTS `patients` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middlename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `health_insurance_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `patient_unique_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `version_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `health_expiry_date` date DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `marital_status` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `province` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `home_phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=18 ;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `firstname`, `middlename`, `lastname`, `health_insurance_number`, `created_at`, `updated_at`, `patient_unique_id`, `version_code`, `health_expiry_date`, `birthdate`, `gender`, `marital_status`, `address1`, `address2`, `city`, `province`, `postal_code`, `home_phone`, `mobile`, `isactive`) VALUES
(2, 'Kunal ', 'Kasanjibhai', 'Chaudhari', '1234563', '2011-07-16 12:51:18', '2011-07-17 09:26:40', 'u123456d', 'vcode', '2048-07-17', '1983-10-01', 'M', 'N', 'A/20, Bhuvneshvarinagar', 'Shashtri Road, Opp. Narsinh Baug', 'Bardoli', 'Surat', '394602', '02622221204', '9913719765', 1),
(3, 'Divyesh', 'Chhibubhai ', 'Konkani', '1234569', '2011-07-16 12:52:21', '2011-07-16 12:52:21', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'Arpana', 'Kunalbhai', 'Chaudhari', '1234568', '2011-07-16 12:52:45', '2011-07-16 12:52:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'Sonal', 'Divyeshbhai', 'Konkani', '1234563', '2011-07-16 15:02:08', '2011-07-16 15:02:08', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'Hiral', 'Ghanshyambhai', 'Chaudhari', '28391812', '2011-07-16 15:02:34', '2011-07-16 15:02:34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'Hunny', 'Nimeshbhai', 'Chaudhari', '123123321', '2011-07-16 15:02:52', '2011-07-16 15:02:52', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'Hunny', 'Nimeshbhai', 'Chaudhari', '123123321', '2011-07-16 15:02:53', '2011-07-16 15:02:53', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'Raj', 'Babubhai', 'Chauhan', '21312312', '2011-07-16 15:03:33', '2011-07-16 15:03:33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'Bhavik', 'Arvindbhai', 'Chauhan', '31231231', '2011-07-16 15:03:45', '2011-07-16 15:03:45', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'Kareena', 'Raj', 'Kapoor', '31312', '2011-07-16 15:04:03', '2011-07-16 15:04:03', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'Ranbir', 'Raj', 'Kapoor', '2312312', '2011-07-16 15:04:16', '2011-07-16 15:04:16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'Vimal', 'Balvantbhai', 'Maisuria', '32112312', '2011-07-16 15:04:30', '2011-07-16 15:04:30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(14, 'Pratik', 'Babubhai', 'Shah', '3213123', '2011-07-16 15:04:48', '2011-07-16 15:04:48', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(15, 'Jhon', 'Phillip', 'Dyson', '321213', '2011-07-16 15:04:59', '2011-07-16 15:04:59', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 'Jhon', 'Joshep', 'smith', '2134123', '2011-07-16 15:05:13', '2011-07-16 15:05:13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `physicians`
--

CREATE TABLE IF NOT EXISTS `physicians` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `physician_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `middlename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastname` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cpso` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `physician_unique_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `province` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `postal_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `emergency_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `physicians`
--

INSERT INTO `physicians` (`id`, `physician_number`, `firstname`, `middlename`, `lastname`, `created_at`, `updated_at`, `gender`, `cpso`, `type`, `physician_unique_id`, `location`, `address1`, `address2`, `city`, `province`, `country`, `postal_code`, `phone`, `fax`, `emergency_number`, `email`, `isactive`) VALUES
(1, '342342', 'Alester', 'Phil', 'Cook', '2011-07-16 15:56:55', '2011-07-17 11:14:17', 'F', 'cpso', NULL, '432434', 'India', 'A/20, Bhuvneshvarinagar', 'Shashtri Road, Opp. Narsinh Baug', 'Bardoli', 'Surat', 'India', '394602', '02622221204', '02622221204', '02622221204', 'kunalchaudhari@gmail.com', 1),
(2, '2313', 'John', 'David', 'Smith', '2011-07-16 15:57:24', '2011-07-16 15:57:24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
