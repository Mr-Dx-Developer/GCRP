Config = {}

-- FiveM controls
-- https://docs.fivem.net/docs/game-references/controls/

Config.Speed = "MPH" --MPH or KMH
Config.Notif = "CONSOLE" --CONSOLE or MYTHIC

--Fixes/repairs vehicle
Config.FixVehicle = 26 --Currently "C"
Config.FixVehicleLabel = "C" --Only for visuals. Replace with "nil" if you dont want it to show

--Reset the numbers
Config.Reset = 20 --Currently "Z"
Config.ResetLabel = "Z" --Only for visuals. Replace with "nil" if you dont want it to show

--Configure teleport key.
Config.UseTeleport = true --Or false to disable
Config.TeleportToCoords = vector3(773.05822753906, -19.399797439575, 61.715209960938) --Teleport location
Config.TeleportToCoordsHeading = 328.05331420898 --Which way you are looking after being teleported
Config.TeleportToCoordsKey = 306 --Currently "N"
Config.TeleportToCoordsLabel = "N" -- Only for visuals. Replace with "nil" if you dont want it to show

--Delete vehicle
Config.UseDeleteVehicle = false --Or false to disable
Config.DeleteVehicleKey = 301--Currently "N"
Config.DeleteVehicleKeyLabel = "M" -- Only for visuals. Replace with "nil" if you dont want it to show
