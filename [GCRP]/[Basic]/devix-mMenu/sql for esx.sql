
CREATE TABLE IF NOT EXISTS `devixmmenu_tickets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticketid` text NOT NULL,
  `ticketOwnerID` text DEFAULT NULL,
  `ticketOwnerImage` text DEFAULT NULL,
  `ticketAdminID` text DEFAULT NULL,
  `ticketAdminImage` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `createDate` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `ticketid` (`ticketid`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `menu_player_times` (
	`id` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_general_ci',
	`Seconds` INT(10) NOT NULL,
	`Minutes` INT(10) NOT NULL,
	`Hours` INT(10) NOT NULL,
	`Days` INT(10) NOT NULL,
	PRIMARY KEY (`id`) USING BTREE
) COLLATE='utf8mb4_general_ci' ENGINE=InnoDB ;


ALTER TABLE `users` ADD `prime` INT(11) NOT NULL;
ALTER TABLE `users` ADD `coin` INT(11) NOT NULL;
ALTER TABLE `users` ADD `prisma` INT(11) NOT NULL;
ALTER TABLE `users` ADD `level` TEXT NOT NULL;
ALTER TABLE `users` ADD `primebought_date` TIMESTAMP NOT NULL DEFAULT current_timestamp();



-- qbcoreframework_eb5a66.devixmmenu_tickets: ~1 rows (yaklaşık) tablosu için veriler indiriliyor
DELETE FROM `devixmmenu_tickets`;
INSERT INTO `devixmmenu_tickets` (`id`, `ticketid`, `ticketOwnerID`, `ticketOwnerImage`, `ticketAdminID`, `ticketAdminImage`, `status`, `createDate`) VALUES
	(31, 'TICKET_405591246', 'ZEM48713', 'https://avatars.akamai.steamstatic.com/844c8fd34c892842da4d7e0a7bb897b7cf6be4b7_full.jpg', 'ZEM48713', NULL, 'open', '2023-04-30 19:39:53');

-- tablo yapısı dökülüyor qbcoreframework_eb5a66.devixmmenu_tickets_messages
CREATE TABLE IF NOT EXISTS `devixmmenu_tickets_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticketID` text DEFAULT NULL,
  `messages` text DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;

-- qbcoreframework_eb5a66.devixmmenu_tickets_messages: ~2 rows (yaklaşık) tablosu için veriler indiriliyor
DELETE FROM `devixmmenu_tickets_messages`;
INSERT INTO `devixmmenu_tickets_messages` (`id`, `ticketID`, `messages`, `date`) VALUES
	(34, 'TICKET_405591246', '{"TICKET_405591246":{"message":"sa","lastname":"Mae","firstname":"Zonzi","playerImage":"https://avatars.akamai.steamstatic.com/844c8fd34c892842da4d7e0a7bb897b7cf6be4b7_full.jpg","time":"22:29","grade":"normal","sender":"ZEM48713","ticketID":"TICKET_405591246","date":"30-3-2023"}}', '2023-04-30 19:29:00'),
	(35, 'TICKET_405591246', '{"TICKET_405591246":{"message":"sa","lastname":"Mae","firstname":"Zonzi","playerImage":"https://avatars.akamai.steamstatic.com/844c8fd34c892842da4d7e0a7bb897b7cf6be4b7_full.jpg","time":"22:31","grade":"normal","sender":"ZEM48713","ticketID":"TICKET_405591246","date":"30-3-2023"}}', '2023-04-30 19:31:14'),
	(36, 'TICKET_405591246', '{"TICKET_405591246":{"ticketID":"TICKET_405591246","grade":"normal","firstname":"Zonzi","lastname":"Mae","sender":"ZEM48713","message":"sa","time":"22:39","date":"30-3-2023"}}', '2023-04-30 19:39:30');

-- tablo yapısı dökülüyor qbcoreframework_eb5a66.devix_caseopening
CREATE TABLE IF NOT EXISTS `devix_caseopening` (
  `#` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL DEFAULT '0',
  `goldcoin` int(11) NOT NULL DEFAULT 0,
  `silvercoin` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`#`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- qbcoreframework_eb5a66.devix_caseopening: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
DELETE FROM `devix_caseopening`;
INSERT INTO `devix_caseopening` (`#`, `identifier`, `goldcoin`, `silvercoin`) VALUES
	(2, 'ZEM48713', 3972, 0);

-- tablo yapısı dökülüyor qbcoreframework_eb5a66.devix_caseopening_codes
CREATE TABLE IF NOT EXISTS `devix_caseopening_codes` (
  `code` varchar(255) DEFAULT NULL,
  `creditCount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- qbcoreframework_eb5a66.devix_caseopening_codes: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
DELETE FROM `devix_caseopening_codes`;

-- tablo yapısı dökülüyor qbcoreframework_eb5a66.devix_mmenu_tebexcodes
CREATE TABLE IF NOT EXISTS `devix_mmenu_tebexcodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tebexid` longtext NOT NULL,
  `mail` longtext NOT NULL,
  `type` longtext NOT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- qbcoreframework_eb5a66.devix_mmenu_tebexcodes: ~0 rows (yaklaşık) tablosu için veriler indiriliyor
DELETE FROM `devix_mmenu_tebexcodes`;
INSERT INTO `devix_mmenu_tebexcodes` (`id`, `tebexid`, `mail`, `type`, `amount`) VALUES
	(9, 'tbx-84711223a48098-ca63c9', 'test@mail.com', '', NULL),
	(10, 'tbx-66411223a48530-f92b6a', 'q@a.com', 'coin', 100);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
