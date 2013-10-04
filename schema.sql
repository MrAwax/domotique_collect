-- MySQL dump 10.9
--
-- Host: localhost    Database: homeauto
-- ------------------------------------------------------
-- Server version	5.1.49

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `current_power`
--

DROP TABLE IF EXISTS `current_power`;
CREATE TABLE `current_power` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `power` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `battery` int(11) NOT NULL,
  `signal` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `old_event` datetime NOT NULL,
  PRIMARY KEY (`id1`,`id2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `current_rain`
--

DROP TABLE IF EXISTS `current_rain`;
CREATE TABLE `current_rain` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `battery` int(11) NOT NULL,
  `signal` int(11) NOT NULL,
  `old_event` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `current_weather`
--

DROP TABLE IF EXISTS `current_weather`;
CREATE TABLE `current_weather` (
  `event` datetime NOT NULL,
  `old_event` datetime NOT NULL,
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `temp` double DEFAULT NULL,
  `humi` double DEFAULT NULL,
  `humi_level` int(11) DEFAULT NULL,
  `battery` int(11) NOT NULL,
  `signal` int(11) NOT NULL,
  PRIMARY KEY (`id1`,`id2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `current_wind`
--

DROP TABLE IF EXISTS `current_wind`;
CREATE TABLE `current_wind` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `direction` int(11) NOT NULL,
  `wind` double NOT NULL,
  `gust` double NOT NULL,
  `event` datetime NOT NULL,
  `battery` int(11) NOT NULL,
  `signal` int(11) NOT NULL,
  `old_event` datetime NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `event_copy`
--

DROP TABLE IF EXISTS `event_copy`;
CREATE TABLE `event_copy` (
  `event` datetime NOT NULL,
  `field` varchar(40) NOT NULL,
  `text` varchar(500) NOT NULL,
  `author` varchar(40) NOT NULL,
  `event_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `field_event`
--

DROP TABLE IF EXISTS `field_event`;
CREATE TABLE `field_event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event` datetime NOT NULL,
  `field` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(500) CHARACTER SET latin1 NOT NULL,
  `author` varchar(40) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `event` (`event`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

--
-- Table structure for table `power`
--

DROP TABLE IF EXISTS `power`;
CREATE TABLE `power` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `power` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `battery` int(11) NOT NULL,
  `signal` int(11) NOT NULL,
  `event` datetime NOT NULL,
  KEY `event` (`event`),
  KEY `id1` (`id1`,`id2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `power_day`
--

DROP TABLE IF EXISTS `power_day`;
CREATE TABLE `power_day` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `power` double NOT NULL,
  `power_h` double NOT NULL,
  `power_l` double NOT NULL,
  `total` double NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `power_five`
--

DROP TABLE IF EXISTS `power_five`;
CREATE TABLE `power_five` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `power` double NOT NULL,
  `total` double NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `power_hour`
--

DROP TABLE IF EXISTS `power_hour`;
CREATE TABLE `power_hour` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `power` double NOT NULL,
  `total` double NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `power_week`
--

DROP TABLE IF EXISTS `power_week`;
CREATE TABLE `power_week` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `power` double NOT NULL,
  `power_h` double NOT NULL,
  `power_l` double NOT NULL,
  `total` double NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `rain`
--

DROP TABLE IF EXISTS `rain`;
CREATE TABLE `rain` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `battery` int(11) NOT NULL,
  `signal` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `sensor_type`
--

DROP TABLE IF EXISTS `sensor_type`;
CREATE TABLE `sensor_type` (
  `name` varchar(200) NOT NULL,
  `fields` varchar(200) NOT NULL,
  `default_field` varchar(40) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `sondes`
--

DROP TABLE IF EXISTS `sondes`;
CREATE TABLE `sondes` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `location` varchar(200) NOT NULL,
  `index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id1`,`id2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `stats_compute`
--

DROP TABLE IF EXISTS `stats_compute`;
CREATE TABLE `stats_compute` (
  `table_name` varchar(80) NOT NULL,
  `event` datetime NOT NULL,
  PRIMARY KEY (`table_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `weather`
--

DROP TABLE IF EXISTS `weather`;
CREATE TABLE `weather` (
  `event` datetime NOT NULL,
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `temp` double DEFAULT NULL,
  `humi` double DEFAULT NULL,
  `humi_level` int(11) DEFAULT NULL,
  `battery` int(11) NOT NULL,
  `signal` int(11) NOT NULL,
  KEY `event` (`event`),
  KEY `id1` (`id1`,`id2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `weather_day`
--

DROP TABLE IF EXISTS `weather_day`;
CREATE TABLE `weather_day` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `temp` double NOT NULL,
  `humi` double NOT NULL,
  `humi_level` double NOT NULL,
  `temp_h` double NOT NULL,
  `temp_l` double NOT NULL,
  `humi_h` double NOT NULL,
  `humi_l` double NOT NULL,
  `humi_level_h` double NOT NULL,
  `humi_level_l` double NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `id1_2` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `weather_five`
--

DROP TABLE IF EXISTS `weather_five`;
CREATE TABLE `weather_five` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `temp` double NOT NULL,
  `humi` double NOT NULL,
  `humi_level` double NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `weather_five_stats`
--

DROP TABLE IF EXISTS `weather_five_stats`;
CREATE TABLE `weather_five_stats` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `temp` double NOT NULL,
  `humi` double NOT NULL,
  `humi_level` double NOT NULL,
  `temp_h` double NOT NULL,
  `temp_l` double NOT NULL,
  `humi_h` double NOT NULL,
  `humi_l` double NOT NULL,
  `humi_level_h` double NOT NULL,
  `humi_level_l` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `weather_hour`
--

DROP TABLE IF EXISTS `weather_hour`;
CREATE TABLE `weather_hour` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `temp` double NOT NULL,
  `humi` double NOT NULL,
  `humi_level` double NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `weather_hour_stats`
--

DROP TABLE IF EXISTS `weather_hour_stats`;
CREATE TABLE `weather_hour_stats` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `temp` double NOT NULL,
  `humi` double NOT NULL,
  `humi_level` double NOT NULL,
  `temp_h` double NOT NULL,
  `temp_l` double NOT NULL,
  `humi_h` double NOT NULL,
  `humi_l` double NOT NULL,
  `humi_level_h` double NOT NULL,
  `humi_level_l` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `weather_week`
--

DROP TABLE IF EXISTS `weather_week`;
CREATE TABLE `weather_week` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `temp` double NOT NULL,
  `humi` double NOT NULL,
  `humi_level` double NOT NULL,
  `temp_h` double NOT NULL,
  `temp_l` double NOT NULL,
  `humi_h` double NOT NULL,
  `humi_l` double NOT NULL,
  `humi_level_h` double NOT NULL,
  `humi_level_l` double NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Table structure for table `wind`
--

DROP TABLE IF EXISTS `wind`;
CREATE TABLE `wind` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `direction` int(11) NOT NULL,
  `wind` double NOT NULL,
  `gust` double NOT NULL,
  `event` datetime NOT NULL,
  `battery` int(11) NOT NULL,
  `signal` int(11) NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

