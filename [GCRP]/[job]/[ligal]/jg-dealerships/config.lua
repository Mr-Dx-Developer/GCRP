Config = {}

Config.Locale = "en"
Config.NumberAndDateFormat = "en-US"
Config.Currency = "USD"
Config.SpeedUnit = "mph"
Config.Logging = false
Config.PlateFormat = "1AA111AA" -- 1 = number, A = letter (max 8 characters)

Config.Framework = "QBCore"  -- or "ESX"
Config.FuelSystem = "LegacyFuel" -- or "LegacyFuel", "ps-fuel", "lj-fuel", "ox_fuel", "cdn-fuel", "hyon_gas_station", "okokGasStation", "nd_fuel", "myFuel", "ti_fuel", "none"
Config.VehicleKeys = "qb-vehiclekeys" -- or "qb-vehiclekeys", "jaksam-vehicles-keys", "qs-vehiclekeys", "mk_vehiclekeys", "wasabi_carlock", "cd_garage", "okokGarage", "t1ger_keys", "none"
Config.Notifications = "ox_lib" -- or "okokNotify", "ox_lib", "ps-ui"

Config.DrawText = "ox_lib" -- or "qb-DrawText", "okokTextUI", "ox_lib", "ps-ui"
Config.OpenShowroomPrompt = "[E] Open Showroom"
Config.OpenShowroomKeyBind = 38
Config.ViewInShowroomPrompt = "[E] View in Showroom"
Config.ViewInShowroomKeyBind = 38
Config.OpenManagementPrompt = "[E] Dealership Management"
Config.OpenManagementKeyBind = 38
Config.SellVehiclePrompt = "[E] Sell Vehicle"
Config.SellVehicleKeyBind = 38

Config.FinancePayments = 12
Config.FinanceDownPayment = 0.1 -- 0.1 means 10%
Config.FinanceInterest = 0.1 -- 0.1 means 10%
Config.FinancePaymentInterval = 12 -- in hours
Config.FinancePaymentFailedHoursUntilRepo = 1 -- in hours
Config.MaxFinancedVehiclesPerPlayer = 5

Config.TestDrivePlate = "TESTER"
Config.TestDriveTimeSeconds = 60

Config.DisplayVehiclesPlate = "DEALER"
Config.DealerPurchasePrice = 0.8 -- 0.8 = Dealers pay 80% of vehicle price
Config.VehicleOrderTime = 1 -- in mins

Config.Categories = {
  planes = "Planes",
  sportsclassics = "Sports Classics",
  sedans = "Sedans",
  compacts = "Compacts",
  motorcycles = "Motorcycles",
  super = "Super",
  offroad = "Offroad",
  helicopters = "Helicopters",
  coupes = "Coupes",
  muscle = "Muscle",
  boats = "Boats",
  vans = "Vans",
  sports = "Sports",
  suvs = "SUVs",
  commercial = "Commercial",
  cycles = "Cycles",
  industrial = "Industrial",
  drift = "Drift Cars"
}

Config.DealershipLocations = {
  ["pdm"] = {
    type = "self-service", -- or "owned", "self-service"
    openShowroom = vector3(-32.99, -1097.097, 27.274),
    openManagement = vector3(-31.5, -1117.4, 26.44),
    purchaseSpawn = vector4(-13.68, -1092.31, 26.67, 159.82),
    testDriveSpawn = vector4(-49.77, -1110.83, 26.44, 75.94),
    camera = {
      name = "Car",
      coords = vector4(-146.6166, -596.6301, 166.0000, 120.0),
      positions = {5.0, 8.0, 12.0, 8.0}
    },
    --categories = {"sedans", "compacts", "motorcycles", "offroad", "coupes", "muscle", "suvs", "sportsclassics", "super", "sports", "cycles"},
    categories = {"drift", "sedans", "compacts", "motorcycles", "offroad", "coupes", "muscle", "suvs", "sportsclassics", "super", "sports", "cycles"},
    enableTestDrive = true,
    hideBlip = false,
    blip = {
      id = 326,
      color = 2,
      scale = 0.6
    },
    enableSellVehicle = true, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    sellVehicle = vector3(-27.89, -1082.1, 26.64),
    enableFinance = false,
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
    disableShowroomPurchase = false,
    job = "cardealer", -- Owned dealerships only
    directSaleDistance = 50,
  },
  ["luxury"] = {
    type = "owned", -- or "owned", "self-service"
    openShowroom = vector3(-1247.676, -359.742, 36.962),
    openManagement = vector3(-1231.767, -346.019, 36.962),
    purchaseSpawn = vector4(-1264.231, -341.379, 35.992, 299.353),
    testDriveSpawn = vector4(-1267.428, -382.219, 35.649, 118.669),
    sellVehicle = {},
    camera = {
      name = "Car",
      coords = vector4(-146.6166, -596.6301, 166.0000, 120.0),
      positions = {5.0, 8.0, 12.0, 8.0}
    },
    categories = {"custom"},
    enableSellVehicle = false, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    enableTestDrive = true,
    enableFinance = false,
    hideBlip = false,
    blip = {
      id = 523,
      color = 2,
      scale = 0.6
    },
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
  },
  ["boats"] = {
    type = "self-service", -- or "owned", "self-service"
    openShowroom = vector3(-734.786, -1337.662, 1.595),
    openManagement = vector3(-731.37, -1310.35, 5.0),
    purchaseSpawn = vector4(-714.42, -1340.01, -0.18, 139.38),
    testDriveSpawn = vector4(-714.42, -1340.01, -0.18, 139.38),
    sellVehicle = vector4(-732.099, -1336.187, -0.474, 341.838),
    camera = {
      name = "Sea",
      coords = vector4(-808.28, -1491.19, -0.47, 113.53),
      positions = {5.0, 8.0, 12.0, 8.0}
    },
    categories = {"boats"},
    enableSellVehicle = true, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    enableTestDrive = false,
    hideBlip = false,
    blip = {
      id = 410,
      color = 2,
      scale = 0.6
    },
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
  },
  ["air"] = {
    type = "self-service", -- or "owned", "self-service"
    openShowroom = vector3(-1623.0, -3151.56, 13.99),
    openManagement = vector3(-1637.78, -3177.94, 13.99),
    purchaseSpawn = vector4(-1654.9, -3147.58, 13.99, 324.78),
    testDriveSpawn = vector4(-1654.9, -3147.58, 13.99, 324.78),
    sellVehicle = vector4(-1654.9, -3147.58, 13.99, 324.78),
    camera = {
      name = "Air",
      coords = vector4(-1267.0, -3013.14, -48.5, 310.96),
      positions = {12.0, 15.0, 20.0, 15.0}
    },
    categories = {"planes", "helicopters"},
    enableSellVehicle = true, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    enableTestDrive = false,
    hideBlip = false,
    blip = {
      id = 423,
      color = 2,
      scale = 0.6
    },
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
  },
  ["truck"] = {
    type = "self-service", -- or "owned", "self-service"
    openShowroom = vector3(1214.37, -3204.53, 6.03),
    openManagement = vector3(1184.45, -3179.27, 7.1),
    purchaseSpawn = vector4(1196.75, -3205.31, 6.0, 91.12),
    testDriveSpawn = vector4(1196.75, -3205.31, 6.0, 91.12),
    sellVehicle = vector4(1196.75, -3205.31, 6.0, 91.12),
    camera = {
      name = "Truck",
      coords = vector4(-1267.0, -3013.14, -48.5, 310.96),
      positions = {7.5, 12.0, 15.0, 12.0}
    },
    categories = {"vans", "commercial", "industrial"},
    enableSellVehicle = true, -- Allow players to sell vehicles back to dealer
    sellVehiclePercent = 0.6,  -- 60% of current sale price
    enableTestDrive = true,
    enableFinance = true,
    hideBlip = false,
    blip = {
      id = 477,
      color = 2,
      scale = 0.6
    },
    hideMarkers = false,
    markers = { id = 21, size = { x = 0.3, y = 0.3, z = 0.3 }, color = { r = 255, g = 255, b = 255, a = 120 }, bobUpAndDown = 0, faceCamera = 0, rotate = 1, drawOnEnts = 0 },
    showroomJobWhitelist = {},
    showroomGangWhitelist = {},
    societyPurchaseJobWhitelist = {},
    societyPurchaseGangWhitelist = {},
  },
}