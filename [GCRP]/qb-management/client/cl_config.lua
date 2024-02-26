-- Zones for Menues
Config = Config or {}

Config.UseTarget = GetConvar('UseTarget', 'false') == 'false' -- Use qb-target interactions (don't change this, go to your server.cfg and add `setr UseTarget true` to use this and just that from true to false or the other way around)

Config.BossMenus = {
    ['police'] = {
        vector3(362.34237670898, -1584.9725341797, 33.356426239014),
    },
    ['ambulance'] = {
        vector3(-508.67, -300.62, 69.52),
    },
    -- ['realestate'] = {
    --     vector3(-716.11, 261.21, 84.14),
    -- },
    ['taxi'] = {
        vector3(907.24, -150.19, 74.17),
    },
    ['cardealer'] = {
        vector3(-27.47, -1107.13, 27.27),
    },
    ['mechanic'] = {
        vector3(-339.53, -156.44, 44.59),
    },

    -- Extra Ub

    ['mechanicls'] = {
        vector3(-339.53, -156.44, 44.59),
    },
    ['mechanicimp'] = {
        vector3(835.89, -934.26, 32.39),
    },
    ['pizzathis'] = {
        vector3(796.19, -767.65, 30.77),
    },
    ['catcafe'] = {
        vector3(-578.23, -1067.65, 26.12),
    },
    -- ['burgershot'] = {
    --     vector3(-1177.79, -896.37, 14.0),
    -- },
    ['atoms'] = {
        vector3(81.602714538574, 296.23156738281, 110.2494430542),
    },
    ['cookies'] = {
        vector3(-934.1, -1168.34, 5.11),
    },
    ['realestate'] = {
        vector3(-528.19177246094, -190.08625793457, 38.227077484131),
    },
}

Config.BossMenuZones = {
    ['police'] = {
        { coords = vector3(461.45, -986.2, 30.73), length = 0.35, width = 0.45, heading = 351.0, minZ = 30.58, maxZ = 30.68 } ,
    },
    ['ambulance'] = {
        { coords = vector3(334.77, -594.26, 43.28), length = 1.2, width = 0.6, heading = 250.38, minZ = 42.88, maxZ = 44.98 },
    },
    -- ['realestate'] = {
    --     { coords = vector3(-528.19177246094, -190.08625793457, 38.227077484131), length = 0.6, width = 1.0, heading = 25.0, minZ = 83.943, maxZ = 84.74 },
    -- },
    ['taxi'] = {
        { coords = vector3(907.24, -150.19, 74.17), length = 1.0, width = 3.4, heading = 327.0, minZ = 73.17, maxZ = 74.57 },
    },
    ['cardealer'] = {
        { coords = vector3(-27.47, -1107.13, 27.27), length = 2.4, width = 1.05, heading = 340.0, minZ = 27.07, maxZ = 27.67 },
    },
    ['mechanic'] = {
        { coords = vector3(-339.53, -156.44, 44.59), length = 1.15, width = 2.6, heading = 353.0, minZ = 43.59, maxZ = 44.99 },
    },
    ['cookies'] = {
        {coords = vector3(-934.1, -1168.34, 5.11), length = 1.15, width = 2.6, heading = 353.0, minZ = 4.11, maxZ = 5.99},
    },
}

Config.GangMenus = {
   --[[  ['lostmc'] = {
        vector3(-2831.9782714844, 1420.9818115234, 87.880989074707),
    },
    ['ballas'] = {
        vector3(0, 0, 0),
    },
    ['vagos'] = {
        vector3(352.26885986328, -2054.6081542969, 22.245288848877),
    }, 
    ['cartel'] = {
        vector3(0, 0, 0),
    },
    ['families'] = {
        vector3(0, 0, 0),
    },
    ['unaverage'] = {
        vector3(-664.80395507813, -881.90655517578, 32.33031463623),
    },
    ['imperium'] = {
        vector3(1393.4117431641, 1160.1948242188, 114.33535766602),
    },
    ['nbz'] = {
        vector3(-1818.3715820313, 447.03359985352, 128.4073638916),
    },
    ['blackmafia'] = {
        vector3(-1569.4052, -233.2557, 49.4674),
    },
    ['aztecas'] = {
        vector3(1242.73, -1577.36, 58.22),
    },
    ['redmafia'] = {
        vector3(397.2463, -19.4058, 91.9354),
    },
    ['dope'] = {
        vector3(-1566.92, -232.71, 49.47),
    },
    ['sopranos'] = {
        vector3(-1569.3024, -233.1973, 49.4674),
    },
    ['outlawz'] = {
        vector3(100.94638061523, 3613.6162109375, 40.914745330811),
    }, ]]
}

Config.GangMenuZones = {
    --[[
    ['gangname'] = {
        { coords = vector3(0.0, 0.0, 0.0), length = 0.0, width = 0.0, heading = 0.0, minZ = 0.0, maxZ = 0.0 },
    },
    ]]
}
