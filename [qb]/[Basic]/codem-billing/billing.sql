
CREATE TABLE IF NOT EXISTS `codem_billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` char(50) DEFAULT NULL,
  `name` char(50) DEFAULT NULL,
  `targetidentifier` char(50) DEFAULT NULL,
  `targetname` char(50) DEFAULT NULL,
  `amount` char(50) DEFAULT NULL,
  `invoicelabel` char(50) DEFAULT NULL,
  `status` char(50) DEFAULT NULL,
  `societyname` char(50) DEFAULT NULL,
  `uniqueid` char(50) DEFAULT NULL,
  `date` char(50) DEFAULT NULL,
  `dateupdate` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniqueid` (`uniqueid`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

