#INSTALLATION#
https://taha-esgn.gitbook.io/flab/guides/projects/devix-mmenu/installation


#FOR ADD GOLD AND PRISMA

If you want to give coins or prisma to players in other ways, you can use these events.
-- Server side
TriggerServerEvent or TriggerEvent('devix-mmmenu:server:addPlayerTheCoin', playerSourceID, amount) -- You can instantly update the table with the player's serverID
TriggerServerEvent or TriggerEvent('devix-mmmenu:server:addPlayerThePrisma', playerSourceID, amount)  -- You can instantly update the table with the player's serverID

if u use the esx
```
ALTER TABLE `users` ADD `prime` INT(11) NOT NULL;
ALTER TABLE `users` ADD `coin` INT(11) NOT NULL;
ALTER TABLE `users` ADD `prisma` INT(11) NOT NULL;
ALTER TABLE `users` ADD `level` TEXT NOT NULL;
ALTER TABLE `users` ADD `primebought_date` TIMESTAMP NOT NULL DEFAULT current_timestamp();
```

if use  qbcore
```
ALTER TABLE `players` ADD `prime` INT(11) NOT NULL;
ALTER TABLE `players` ADD `coin` INT(11) NOT NULL;
ALTER TABLE `players` ADD `prisma` INT(11) NOT NULL;
ALTER TABLE `players` ADD `level` TEXT NOT NULL;
ALTER TABLE `players` ADD `primebought_date` TIMESTAMP NOT NULL DEFAULT current_timestamp();
```



FOR PROBLEM : 'zhonnz#2373
