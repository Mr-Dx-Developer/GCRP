CREATE TABLE `multichar_tbx` (
	`tbx` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb3_general_ci',
	`active` TINYINT(2) NULL DEFAULT NULL
)
COLLATE='utf8mb3_general_ci'
ENGINE=InnoDB
;

ALTER TABLE `players`
	ADD `playtime` INT(11) NULL DEFAULT 0
;