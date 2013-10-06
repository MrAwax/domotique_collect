-- MySQL dump 10.13  Distrib 5.1.49
--
-- Host: databasehost    Database: homeauto
-- ------------------------------------------------------
-- Server version	5.1.49

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `current_power`
--

DROP TABLE IF EXISTS `current_power`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `current_rain`
--

DROP TABLE IF EXISTS `current_rain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `current_weather`
--

DROP TABLE IF EXISTS `current_weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `current_wind`
--

DROP TABLE IF EXISTS `current_wind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_copy`
--

DROP TABLE IF EXISTS `event_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `event_copy` (
  `event` datetime NOT NULL,
  `field` varchar(40) NOT NULL,
  `text` varchar(500) NOT NULL,
  `author` varchar(40) NOT NULL,
  `event_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `field_event`
--

DROP TABLE IF EXISTS `field_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `field_event` (
  `event_id` int(11) NOT NULL AUTO_INCREMENT,
  `event` datetime NOT NULL,
  `field` varchar(40) CHARACTER SET latin1 NOT NULL,
  `text` varchar(500) CHARACTER SET latin1 NOT NULL,
  `author` varchar(40) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`event_id`),
  KEY `event` (`event`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `power`
--

DROP TABLE IF EXISTS `power`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`databaseuser`@`databasehost`*/ /*!50003 TRIGGER `to_current_power` AFTER INSERT ON `power` FOR EACH ROW update current_power

set event = NEW.event,

power = NEW.power,

total = NEW.total,

battery = NEW.battery,

signal = NEW.signal

where id1 = NEW.id1 and id2 = NEW.id2 */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `power_day`
--

DROP TABLE IF EXISTS `power_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `power_five`
--

DROP TABLE IF EXISTS `power_five`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `power_five` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `power` double NOT NULL,
  `total` double NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `power_hour`
--

DROP TABLE IF EXISTS `power_hour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `power_hour` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `power` double NOT NULL,
  `total` double NOT NULL,
  KEY `id1` (`id1`,`id2`),
  KEY `event` (`event`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `power_week`
--

DROP TABLE IF EXISTS `power_week`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rain`
--

DROP TABLE IF EXISTS `rain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rain` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `event` datetime NOT NULL,
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `battery` int(11) NOT NULL,
  `signal` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`databasehost`*/ /*!50003 TRIGGER `to_current_rain` AFTER INSERT ON `rain` FOR EACH ROW update current_rain

set event = NEW.event,

rate = NEW.rate,

total = NEW.total,

battery = NEW.battery,

signal = NEW.signal

where id1 = NEW.id1 and id2 = NEW.id2 */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `sensor_type`
--

DROP TABLE IF EXISTS `sensor_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sensor_type` (
  `name` varchar(200) NOT NULL,
  `fields` varchar(200) NOT NULL,
  `default_field` varchar(40) NOT NULL,
  `table_name` varchar(100) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sondes`
--

DROP TABLE IF EXISTS `sondes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sondes` (
  `id1` int(11) NOT NULL,
  `id2` int(11) NOT NULL,
  `type` varchar(20) NOT NULL,
  `name` varchar(200) NOT NULL,
  `location` varchar(200) NOT NULL,
  `index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id1`,`id2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stats_compute`
--

DROP TABLE IF EXISTS `stats_compute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stats_compute` (
  `table_name` varchar(80) NOT NULL,
  `event` datetime NOT NULL,
  PRIMARY KEY (`table_name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather`
--

DROP TABLE IF EXISTS `weather`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`databaseuser`@`databasehost`*/ /*!50003 TRIGGER `to_current_weather` AFTER INSERT ON `weather` FOR EACH ROW update current_weather

set event = NEW.event,

temp = NEW.temp,

humi = NEW.humi,

humi_level = NEW.humi_level,

battery = NEW.battery,

signal = NEW.signal

where id1 = NEW.id1 and id2 = NEW.id2 */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `weather_day`
--

DROP TABLE IF EXISTS `weather_day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather_five`
--

DROP TABLE IF EXISTS `weather_five`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather_five_stats`
--

DROP TABLE IF EXISTS `weather_five_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather_hour`
--

DROP TABLE IF EXISTS `weather_hour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather_hour_stats`
--

DROP TABLE IF EXISTS `weather_hour_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `weather_week`
--

DROP TABLE IF EXISTS `weather_week`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `wind`
--

DROP TABLE IF EXISTS `wind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`databasehost`*/ /*!50003 TRIGGER `to_current_wind` AFTER INSERT ON `wind` FOR EACH ROW update current_wind

set event = NEW.event,

direction = NEW.direction,

wind = NEW.wind,

gust = NEW.gust,

battery = NEW.battery,

signal = NEW.signal

where id1 = NEW.id1 and id2 = NEW.id2 */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping events for database 'homeauto'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
/*!50106 DROP EVENT IF EXISTS `update_stats` */;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = utf8 */ ;;
/*!50003 SET character_set_results = utf8 */ ;;
/*!50003 SET collation_connection  = utf8_general_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = '' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE EVENT `update_stats` ON SCHEDULE EVERY 5 MINUTE STARTS '2012-10-25 21:32:03' ON COMPLETION NOT PRESERVE ENABLE DO begin



call update_weather_five();

call update_weather_hour();

call update_weather_day();

call update_power_five();

call update_power_hour();

call update_power_day();



end */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'homeauto'
--
/*!50003 DROP PROCEDURE IF EXISTS `update_power_day` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`databasehost`*/ /*!50003 PROCEDURE `update_power_day`()
    NO SQL
BEGIN



declare maxEvent DATETIME;

declare lastEvent DATETIME;

declare deltaEvent INT;

declare isNull INT;



set isNull = 0;

        

select event from stats_compute where table_name = 'power_day' into lastEvent;



if lastEvent is NULL then

  set isNull = 1;

  select from_unixtime(0) from dual into lastEvent;

end if;



select max(event) from power where event > lastEvent into maxEvent;



if maxEvent is NULL then

  select now() from dual into maxEvent;

end if;



select unix_timestamp(maxEvent) - unix_timestamp(lastEvent) from dual into deltaEvent;



if deltaEvent > 24 * 60 * 60 + 5 * 60 then



  select from_unixtime(floor(unix_timestamp(maxEvent)/(24*60*60)) * 24*60*60) from dual into maxEvent;



  insert into power_day

  (id1, id2, event, power, power_h, power_l, total)

  select

  id1, id2, from_unixtime(event), (max(total)-min(total))*1000/24, max(power), min(power), max(total)

  from (

    select id1, id2, floor(unix_timestamp(event)/(24*60*60))*24*60*60 as event,

    power, total from power

    where event between lastEvent and maxEvent) as w

  group by id1, id2, event;



  if isNull > 0 then

    insert into stats_compute (table_name, event) values ('power_day', maxEvent);

  else

    update stats_compute

    set event = maxEvent

    where table_name = 'power_day';

  end if;



end if;



end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_power_five` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`databasehost`*/ /*!50003 PROCEDURE `update_power_five`()
    MODIFIES SQL DATA
BEGIN



declare maxEvent DATETIME;

declare lastEvent DATETIME;

declare deltaEvent INT;

declare isNull INT;



set isNull = 0;

        

select event from stats_compute where table_name = 'power_five' into lastEvent;



if lastEvent is NULL then

  set isNull = 1;

  select from_unixtime(0) from dual into lastEvent;

end if;



select max(event) from power where event > lastEvent into maxEvent;



if maxEvent is NULL then

  select now() from dual into maxEvent;

end if;



select unix_timestamp(maxEvent) - unix_timestamp(lastEvent) from dual into deltaEvent;



if deltaEvent > 6 * 60 then



  select from_unixtime(floor(unix_timestamp(maxEvent)/(5*60)) * 5*60) from dual into maxEvent;



  insert into power_five

  (id1, id2, event, power, total)

  select

  id1, id2, from_unixtime(event), (max(total)-min(total))*12*1000, max(total)

  from (

    select id1, id2, floor(unix_timestamp(event)/(5*60))*5*60 as event,

    power, total from power

    where event between lastEvent and maxEvent) as w

  group by id1, id2, event;



  if isNull > 0 then

    insert into stats_compute (table_name, event) values ('power_five', maxEvent);

  else

    update stats_compute

    set event = maxEvent

    where table_name = 'power_five';

  end if;



end if;



end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_power_hour` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`databasehost`*/ /*!50003 PROCEDURE `update_power_hour`()
    MODIFIES SQL DATA
BEGIN



declare maxEvent DATETIME;

declare lastEvent DATETIME;

declare deltaEvent INT;

declare isNull INT;



set isNull = 0;

        

select event from stats_compute where table_name = 'power_hour' into lastEvent;



if lastEvent is NULL then

  set isNull = 1;

  select from_unixtime(0) from dual into lastEvent;

end if;



select max(event) from power where event > lastEvent into maxEvent;



if maxEvent is NULL then

  select now() from dual into maxEvent;

end if;



select unix_timestamp(maxEvent) - unix_timestamp(lastEvent) from dual into deltaEvent;



if deltaEvent > 61 * 60 then



  select from_unixtime(floor(unix_timestamp(maxEvent)/(60*60)) * 60*60) from dual into maxEvent;



  insert into power_hour

  (id1, id2, event, power, total)

  select

   id1, id2, from_unixtime(event), max(total)-min(total)*1000, max(total)

  from (

    select id1, id2, floor(unix_timestamp(event)/(60*60))*60*60 as event,

    power, total from power

    where event between lastEvent and maxEvent) as w

  group by id1, id2, event;



  if isNull > 0 then

    insert into stats_compute (table_name, event) values ('power_hour', maxEvent);

  else

    update stats_compute

    set event = maxEvent

    where table_name = 'power_hour';

  end if;



end if;



end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_weather_day` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`databasehost`*/ /*!50003 PROCEDURE `update_weather_day`()
    MODIFIES SQL DATA
BEGIN



declare maxEvent DATETIME;

declare lastEvent DATETIME;

declare deltaEvent INT;

declare isNull INT;



set isNull = 0;

        

select event from stats_compute where table_name = 'weather_day' into lastEvent;



if lastEvent is NULL then

  set isNull = 1;

  select from_unixtime(0) from dual into lastEvent;

end if;



select max(event) from weather where event > lastEvent into maxEvent;



if maxEvent is NULL then

  select now() from dual into maxEvent;

end if;



select unix_timestamp(maxEvent) - unix_timestamp(lastEvent) from dual into deltaEvent;



select lastEvent, maxEvent, deltaEvent;



if deltaEvent > 24 * 60 * 60 + 5 * 60 then



  select from_unixtime(floor(unix_timestamp(maxEvent)/(24*60*60)) * 24*60*60) from dual into maxEvent;



  insert into weather_day

  (id1, id2, event, temp, temp_h, temp_l, humi, humi_h, humi_l, humi_level, humi_level_h, humi_level_l)

  select

  id1, id2, from_unixtime(event), avg(temp), max(temp), min(temp), avg(humi), max(humi), min(humi), avg(humi_level), max(humi_level), min(humi_level)

  from (

    select id1, id2, floor(unix_timestamp(event)/(24*60*60))*24*60*60 as event,

    temp, humi, humi_level from weather

    where event between lastEvent and maxEvent) as w

  group by id1, id2, event;



  if isNull > 0 then

    insert into stats_compute (table_name, event) values ('weather_day', maxEvent);

  else

    update stats_compute

    set event = maxEvent

    where table_name = 'weather_day';

  end if;



end if;



end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_weather_five` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`databasehost`*/ /*!50003 PROCEDURE `update_weather_five`()
    MODIFIES SQL DATA
BEGIN



declare maxEvent DATETIME;

declare lastEvent DATETIME;

declare deltaEvent INT;

declare isNull INT;



set isNull = 0;

        

select event from stats_compute where table_name = 'weather_five' into lastEvent;



if lastEvent is NULL then

  set isNull = 1;

  select from_unixtime(0) from dual into lastEvent;

end if;



select max(event) from weather where event > lastEvent into maxEvent;



if maxEvent is NULL then

  select now() from dual into maxEvent;

end if;



select unix_timestamp(maxEvent) - unix_timestamp(lastEvent) from dual into deltaEvent;



if deltaEvent > 6 * 60 then



  select from_unixtime(floor(unix_timestamp(maxEvent)/(5*60)) * 5*60) from dual into maxEvent;



  insert into weather_five

  (id1, id2, event, temp, humi, humi_level)

  select

  id1, id2, from_unixtime(event), avg(temp), avg(humi), avg(humi_level)

  from (

    select id1, id2, floor(unix_timestamp(event)/(5*60))*5*60 as event,

    temp, humi, humi_level from weather

    where event between lastEvent and maxEvent) as w

  group by id1, id2, event;



  if isNull > 0 then

    insert into stats_compute (table_name, event) values ('weather_five', maxEvent);

  else

    update stats_compute

    set event = maxEvent

    where table_name = 'weather_five';

  end if;



end if;



end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_weather_hour` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`databasehost`*/ /*!50003 PROCEDURE `update_weather_hour`()
    MODIFIES SQL DATA
BEGIN



declare maxEvent DATETIME;

declare lastEvent DATETIME;

declare deltaEvent INT;

declare isNull INT;



set isNull = 0;

        

select event from stats_compute where table_name = 'weather_hour' into lastEvent;



if lastEvent is NULL then

  set isNull = 1;

  select from_unixtime(0) from dual into lastEvent;

end if;



select max(event) from weather where event > lastEvent into maxEvent;



if maxEvent is NULL then

  select now() from dual into maxEvent;

end if;



select unix_timestamp(maxEvent) - unix_timestamp(lastEvent) from dual into deltaEvent;



if deltaEvent > 61 * 60 then



  select from_unixtime(floor(unix_timestamp(maxEvent)/(60*60)) * 60*60) from dual into maxEvent;



  insert into weather_hour

  (id1, id2, event, temp, humi, humi_level)

  select

  id1, id2, from_unixtime(event), avg(temp), avg(humi), avg(humi_level)

  from (

    select id1, id2, floor(unix_timestamp(event)/(60*60))*60*60 as event,

    temp, humi, humi_level from weather

    where event between lastEvent and maxEvent) as w

  group by id1, id2, event;



  if isNull > 0 then

    insert into stats_compute (table_name, event) values ('weather_hour', maxEvent);

  else

    update stats_compute

    set event = maxEvent

    where table_name = 'weather_hour';

  end if;



end if;



end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

