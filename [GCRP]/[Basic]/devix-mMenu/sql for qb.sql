
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


ALTER TABLE `players` ADD `prime` INT(11) NOT NULL;
ALTER TABLE `players` ADD `coin` INT(11) NOT NULL;
ALTER TABLE `players` ADD `prisma` INT(11) NOT NULL;
ALTER TABLE `players` ADD `level` TEXT NOT NULL;
ALTER TABLE `players` ADD `primebought_date` TIMESTAMP NOT NULL DEFAULT current_timestamp();


DELETE FROM `devixmmenu_tickets`;
INSERT INTO `devixmmenu_tickets` (`id`, `ticketid`, `ticketOwnerID`, `ticketOwnerImage`, `ticketAdminID`, `ticketAdminImage`, `status`, `createDate`) VALUES
	(31, 'TICKET_405591246', 'ZEM48713', 'https://avatars.akamai.steamstatic.com/844c8fd34c892842da4d7e0a7bb897b7cf6be4b7_full.jpg', 'ZEM48713', NULL, 'open', '2023-04-30 19:39:53');

CREATE TABLE IF NOT EXISTS `devixmmenu_tickets_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ticketID` text DEFAULT NULL,
  `messages` text DEFAULT NULL,
  `date` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;

DELETE FROM `devixmmenu_tickets_messages`;
INSERT INTO `devixmmenu_tickets_messages` (`id`, `ticketID`, `messages`, `date`) VALUES
	(34, 'TICKET_405591246', '{"TICKET_405591246":{"message":"sa","lastname":"Mae","firstname":"Zonzi","playerImage":"https://avatars.akamai.steamstatic.com/844c8fd34c892842da4d7e0a7bb897b7cf6be4b7_full.jpg","time":"22:29","grade":"normal","sender":"ZEM48713","ticketID":"TICKET_405591246","date":"30-3-2023"}}', '2023-04-30 19:29:00'),
	(35, 'TICKET_405591246', '{"TICKET_405591246":{"message":"sa","lastname":"Mae","firstname":"Zonzi","playerImage":"https://avatars.akamai.steamstatic.com/844c8fd34c892842da4d7e0a7bb897b7cf6be4b7_full.jpg","time":"22:31","grade":"normal","sender":"ZEM48713","ticketID":"TICKET_405591246","date":"30-3-2023"}}', '2023-04-30 19:31:14'),
	(36, 'TICKET_405591246', '{"TICKET_405591246":{"ticketID":"TICKET_405591246","grade":"normal","firstname":"Zonzi","lastname":"Mae","sender":"ZEM48713","message":"sa","time":"22:39","date":"30-3-2023"}}', '2023-04-30 19:39:30');



CREATE TABLE IF NOT EXISTS `devix_mmenu_tebexcodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tebexid` longtext NOT NULL,
  `mail` longtext NOT NULL,
  `type` longtext NOT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

DELETE FROM `devix_mmenu_tebexcodes`;
INSERT INTO `devix_mmenu_tebexcodes` (`id`, `tebexid`, `mail`, `type`, `amount`) VALUES
	(9, 'tbx-84711223a48098-ca63c9', 'test@mail.com', '', NULL),
	(10, 'tbx-66411223a48530-f92b6a', 'q@a.com', 'coin', 100);
