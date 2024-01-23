-- ak4y dev.

-- IF YOU HAVE ANY PROBLEM OR DO YOU NEED HELP PLS COME TO MY DISCORD SERVER AND CREATE A TICKET
-- IF YOU DONT HAVE ANY PROBLEM YET AGAIN COME TO MY DISCORD :)
-- https://discord.gg/kWwM3Bx


AK4Y = {}

AK4Y.Framework = "qb" -- qb / oldqb | qb = export system | oldqb = triggerevent system
AK4Y.Mysql = "oxmysql" -- Check fxmanifest.lua when you change it! |  oxmysql / mysql-async
AK4Y.OpenMenuCommand = "gcoin" -- code to open the donate menu
AK4Y.OpenKey = 'F2'
AK4Y.WeaponType = "item" -- weapon or item
AK4Y.CustomPlatePriceOnBuyVehicle = 20 -- Customization price at the time of vehicle purchase
AK4Y.Phone = "qb-phone" -- gcphone or qb-phone
AK4Y.MinCharForPhoneNumber = 1 -- Minimum number of characters required for a special number
AK4Y.MinCharForPlate = 1 -- Minimum number of characters required for a custom plate
AK4Y.MaxCharForPhoneNumber = 7 -- Minimum number of characters required for a special number
AK4Y.MaxCharForPlate = 8 -- Minimum number of characters required for a custom plate
AK4Y.DefaultGarage = 'pillboxgarage' -- Garage name where the vehicle will be sent after purchase
AK4Y.WeaponType = "item" -- item or weapon
AK4Y.UseTebex = true -- Do you use tebex to sell code?


---------------------------
------- TEST DRIVE --------
--------------------------- 
AK4Y.TestDriveBlip = true
AK4Y.TestDriveBlipText = "TEST DRIVE AREA"
AK4Y.TestDriveDrawText = "You can start the test drive from the Donate menu. ( /donate )"
AK4Y.TestDriveCoords = vector3(1219.88, -2934.43, 5.87)
AK4Y.TestDriveCarSpawnLocation = vector4(1216.51, -2918.03, 5.87, 37.31)
AK4Y.TestDriveTime = 0.5

AK4Y.GiveAddKeys = true -- Automatic key issuance after changing the license plate of the vehicle
AK4Y.GiveAddKeysFunction = function(newPlate)
    TriggerEvent("vehiclekeys:client:SetOwner", newPlate)
end

AK4Y.ClientNotify = function(text, NotifType)
    QBCore.Functions.Notify(text, NotifType)
end

AK4Y.Translate = {
    title1 = "Golden City",
    title2 = "DONATOR",

    speed = "km/h",
    credit = "CR",

    customizeTitle = "Customize",
    customizeInfo = "You have to in your car which is want to customize.",

    thanksForPurchasing = "Thanks for purchasing!",

    buyCreditButton = "BUY CREDIT",
    approveButton = "APPROVE",
    buyButtonText = "BUY",

    redeemCodeTitle1 = "REDEEM",
    redeemCodeTitle2 = "CODE",
    redeemCodeDesc = "Lorem ipsum",
    redeemCodeBelow = "YOU CAN ENTER TE CODE BELOW",

    carDoYouNeedTitle1 = "DO YOU NEED",
    carDoYouNeedTitle2 = "ITEMS?",
    carButtonBelow = "YOU CAN VIEW IT BY CLICKING THE BUTTON BELOW",
    carAreaDesc = "THEN YOU CAN BROWSE THE CARS BY CLICKING THE BUTTON BELOW.",
    carButtonText = "ITEMS",
    carButtonInfo = "CLICK THE BUTTON TO SEE THE WEAPONS",
    
    otherInfo = "Click for details",
    otherButton = "OTHER",
    otherDesc = "You can go to the customization menu by clicking the button above.",

    moneyInfo = "Click for details",
    moneyButtonText = "MONEY",
    moneyDesc = "You can go to the money purchase menu by clicking the button above.",

    gunTitle1 = "DO YOU NEED",
    gunTitle2 = "A GUN?",
    gunInfo = "YOU CAN VIEW IT BY CLICKING THE BUTTON BELOW",
    gunDesc = "THEN YOU CAN BROWSE THE WEAPONS BY CLICKING THE BUTTON BELOW.",
    gunButtonText = "GUN",
    gunTinyInfo = "CLICK THE BUTTON TO SEE WEAPONS.",

    vehBuyCustomPlateText = "Do you want a custom plate? <span id='cstmPltPrice'></span>",
    customPlateText = "Enter your custom plate (Max 6 char.)",
    privNumberText = "Enter your private number (Max 7 char.)<br>You will drop on game after purchasing!",
    dontHaveEnoughtCredit = "You dont have enough credit!",
    minimumChar = "Minimum Char: ",
    MaximumChar = " Maximum Char: ",
    typeNumber = "You have to type number!",
    errorDuringPurchase = "An error occurred during purchase",
    insideVehicle = "To buy this customization, you must be inside the vehicle!",

    openSpam = "Wait a while to open the menu again",
    spamNotify = "Spam protection, try again",

    testDriveStarted = "Vehicle test drive started!",
    testDriveEnded = "Vehicle test drive complete",
    youShouldbeInZone = "You should be in test drive zone",
    alreadyInTestDrive = "Already in test drive",
    testDriveRemaining = "TEST DRIVE TIME REMAINING: ",
}

AK4Y.BuyCredits = {
    [1] = {
        title = "25$",
        image = "./images/firstBoxCash.png",
        credit = "25 CR",
        extraCredit = "+0 Bonus CR",
        link = "https://-store.tebex.io/package/5821226",
    },
    [2] = {
        title = "50$",
        image = "./images/secondBoxCash.png",
        credit = "55 CR",
        extraCredit = "+5 Bonus CR",
        link = "https://-store.tebex.io/package/5986129",
    },
    [3] = {
        title = "200$",
        image = "./images/thirtBoxCash.png",
        credit = "225 CR",
        extraCredit = "+25 Bonus CR",
        link = "https://-store.tebex.io/package/5986131",
    },
    [4] = {
        title = "100$",
        image = "./images/fourBoxCash.png",
        credit = "110 CR",
        extraCredit = "+10 Bonus CR",
        link = "https://-store.tebex.io/package/5986130",
    },
}

-- Do not add new categories
-- If you want to remove a category, you can put it in the comment line
-- If you put a category in the comment line, put the products sold in that category in the comment line
-- you should not change categoryId
AK4Y.Categories = {
    --{ label = "VEHICLE", categoryId = "vehicle" },
    --{ label = "AIR", categoryId = "helicopters" },
    { label = "WEAPON", categoryId = "weapon" },
    { label = "ITEMS", categoryId = "items" },
    
    --{ label = "MONEY", categoryId = "money" },
    { label = "Others", categoryId = "other" },
}

AK4Y.Vehicles = {
    {
        id = 1,
        spawnName = "zentorno", -- Spawn code of the vehicle that will be given when the product is received
        brand = "Zentorno",
        model = "",
        year = "2022 MODEL",
        costCredit = 2450, -- The price to be paid for the product
        topSpeed = 310, -- Top speed of the product
        topSpeedGraph = 90, -- Percentage of product top speed
        brakingPower = 50, -- Percentage of braking power of the product
        robustness = 90, -- Percentage of product robustness
        vehType = "car", -- do not change
        carImage = "./images/Zentorno.png",
    },
}

AK4Y.Helicopters = {
    {
        id = 1,
        spawnName = "frogger", -- Spawn code of the vehicle that will be given when the product is received
        brand = "Frogger",
        model = "",
        year = "2022 MODEL",
        costCredit = 2850, -- The price to be paid for the product
        topSpeed = 250, -- Top speed of the product
        topSpeedGraph = 60, -- Percentage of product top speed
        brakingPower = 30, -- Percentage of braking power of the product
        robustness = 90, -- Percentage of product robustness
        vehType = "air", -- do not change
        carImage = "./images/helicopter.png",
    },
}

AK4Y.Items = {
    { 
        id = 1,
        itemName = "keepcompanionhusky",
        itemCount = 1,
        label = "Husky",
        costCredit = 50, 
        image = "./images/A_C_Husky.png",
    },
    { 
        id = 2,
        itemName = "keepcompanioncat",
        itemCount = 1,
        label = "Cat",
        costCredit = 50, 
        image = "./images/A_C_Cat_01.png",
    },
    { 
        id = 3,
        itemName = "keepcompanionpoodle",
        itemCount = 1,
        label = "Poodle",
        costCredit = 50, 
        image = "./images/A_C_Poodle.png",
    },
    { 
        id = 4,
        itemName = "keepcompanionrottweiler",
        itemCount = 1,
        label = "Rottweiler",
        costCredit = 50, 
        image = "./images/A_Rottweiler.png",
    },
    { 
        id = 5,
        itemName = "keepcompanionpug",
        itemCount = 1,
        label = "Pug",
        costCredit = 50, 
        image = "./images/A_C_Pug.png",
    },
    { 
        id = 6,
        itemName = "keepcompanionretriever",
        itemCount = 1,
        label = "Retriever",
        costCredit = 50, 
        image = "./images/A_C_Retriever.png",
    },
}

AK4Y.Weapons = {
    { 
        id = 1,
        weaponName = "WEAPON_NEVA",
        label = "NEVA",
        costCredit = 40, 
        image = "./images/WEAPON_NEVA.png",
    },
    { 
        id = 2,
        weaponName = "WEAPON_M416P",
        label = "M416P",
        costCredit = 40, 
        image = "./images/WEAPON_M416P.png",
    },
    { 
        id = 3,
        weaponName = "WEAPON_M133",
        label = "M 133",
        costCredit = 40, 
        image = "./images/WEAPON_M133.png",
    },
    { 
        id = 4,
        weaponName = "WEAPON_JRBAK",
        label = "JRBAK",
        costCredit = 40, 
        image = "./images/WEAPON_JRBAK.png",
    },
    { 
        id = 5,
        weaponName = "WEAPON_GALILAR",
        label = "GALILAR",
        costCredit = 40, 
        image = "./images/WEAPON_GALILAR.png",
    },
    { 
        id = 6,
        weaponName = "WEAPON_FAMASU1",
        label = "FAMASU1",
        costCredit = 40, 
        image = "./images/WEAPON_FAMASU1.png",
    },
    { 
        id = 7,
        weaponName = "WEAPON_FN42",
        label = "FN 42",
        costCredit = 40, 
        image = "./images/WEAPON_FN42.png",
    },
    { 
        id = 8,
        weaponName = "WEAPON_DRH",
        label = "DRH",
        costCredit = 40, 
        image = "./images/WEAPON_DRH.png",
    },
    { 
        id = 9,
        weaponName = "WEAPON_CFS",
        label = "CFS",
        costCredit = 40, 
        image = "./images/WEAPON_CFS.png",
    },
    { 
        id = 10,
        weaponName = "weapon_katana",
        label = "Katana",
        costCredit = 80, 
        image = "./images/katana.png",
    },
    { 
        id = 11,
        weaponName = "weapon_thermal_katana",
        label = "Thermal Katana",
        costCredit = 100, 
        image = "./images/weapon_thermal_katana.png",
    },
    { 
        id = 11,
        weaponName = "weapon_katana_r",
        label = "Katan Red (With Effects)",
        costCredit = 160, 
        image = "./images/weapon_katana_r.png",
    },
    { 
        id = 11,
        weaponName = "weapon_katana_b",
        label = "Katana Blue (With Effects)",
        costCredit = 160, 
        image = "./images/weapon_katana_b.png",
    },
    { 
        id = 11,
        weaponName = "weapon_katana_y",
        label = "Katana Yellow (With Effects)",
        costCredit = 160, 
        image = "./images/weapon_katana_y.png",
    },
    { 
        id = 11,
        weaponName = "weapon_katana_g",
        label = "Katana Green (With Effects)",
        costCredit = 160, 
        image = "./images/weapon_katana_g.png",
    },

}

AK4Y.Money = {
    {
        id = 1,
        label = "100.000 DOLLAR",
        costCredit = 100, -- Credit to be paid for the product
        inGameMoney = 100000, -- In-game money to be given to the character after purchase
        image = "./images/moneyImage.png",
    },
}


-- do not change
-- do not change
-- If you want to close it, put it in the comment line
AK4Y.Customize = {
    {id = 1, label = "PLATE CUSTOMIZATION", costCredit = 50, IType = "licenseplate", image = "./images/platee.png"}
}

