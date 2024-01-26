CREATE TABLE `mvip_tebex` (
	`tbxid` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`amount` INT(11) NULL DEFAULT NULL,
	`used` INT(11) NULL DEFAULT NULL
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB
;


CREATE TABLE `mvip` (
	`identifier` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`activepass` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`purchasehistory` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`coin` INT(11) NULL DEFAULT NULL,
	`activepasstime` BIGINT(20) NULL DEFAULT NULL
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB
;
