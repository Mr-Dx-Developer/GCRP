Config = {}

Config.EnableDrift = true --if you want to enable the drift part of the plugin.
Config.DriftKey = 21 --This is the key that is used to start drift mode. Default is L-SHIFT. Control list - https://docs.fivem.net/docs/game-references/controls/
Config.TireDamage = false --If you would like for vehicles to be damaged if their tire/s are popped.
Config.DamagePerTire = 0.0125 --Higher number = more damage.

Config.TireDamageSpeed = 30 --Speed limit[KMH], if player goes above, cars engine will be damaged by popped tires.
Config.StopOffroad = false --If you want players to have worse handling while going offroad without a car prepared for it. 
Config.DamageOffroad = false --If you want vehicles to receive damage while going offroad.
Config.EngineDamageCoefficient = 0.0155 --Higher numbers will kill the engine faster. Remember, it is multiplied by the cars speed.
Config.MinCarHealth = 150 --Minimum car healt, it will no longe receive damage from offroad driving at this or below this level.
Config.OffroadLimit = 30	--Speed limit [KMH], if player goes above this limit while being offroad, their car will start to be affected by offroad pers/damages...

Config.DriftMaxSpeed = 90	--Speed limit [KMH], drift mode will not work above this speed.

Config.EnablePartOffroad = true --If not all vehicles that have offroad tires should be allowed to drive without problem offroad.
Config.EnablePartOffroadBadHandling = true --Applies for non offroad vehicles with offroad perks such as wheels. This will make car handling worse after they go past the part offroad speed limit.
Config.PartOffroadVehiclesSpeedLimit = 72 --Applies for offroad allowed vehicles. Speed limit [KMH], if player goes above this limit while being offroad, their car will start to be affected by offroad pers/damages...
Config.OffroadVehiclesSpeedLimit = 120  --Applies for non offroad vehicles with offroad perks such as wheels. Speed limit [KMH], if player goes above this limit while being offroad, their car will start to be affected by offroad pers/damages...
Config.EngineDamageCoefficientOffroadVehicles = 0.0105 -- Applies for offroad allowed vehicles after they go through the offroad speed limitHigher numbers will kill the engine faster. Remember, it is multiplied by the cars speed.


