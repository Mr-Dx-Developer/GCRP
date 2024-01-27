

-- EMS1 created by Dx
Config.DoorList['EMS-EMS1'] = {
    doors = {
        {objName = -164945599, objYaw = 159.99998474121, objCoords = vec3(310.439758, -574.149048, 43.433281)},
        {objName = -164945599, objYaw = 340.0, objCoords = vec3(308.003357, -573.262268, 43.433281)}
    },
    distance = 1,
    doorRate = 1.0,
    authorizedJobs = { ['ambulance'] = 0 },
    locked = true,
    doorType = 'double',
}

-- EMS2 created by Dx
Config.DoorList['EMS-EMS2'] = {
    objYaw = 69.999969482422,
    pickable = true,
    authorizedJobs = { ['ambulance'] = 0 },
    objName = 2056450362,
    fixText = false,
    distance = 1,
    doorType = 'door',
    objCoords = vec3(323.368988, -574.604614, 48.351578),
    locked = false,
    doorRate = 1.0,
}

-- EMS3 created by Dx
Config.DoorList['EMS-EMS3'] = {
    objYaw = 69.999969482422,
    pickable = true,
    authorizedJobs = { ['ambulance'] = 0 },
    objName = 2056450362,
    fixText = false,
    distance = 1,
    doorType = 'door',
    objCoords = vec3(320.505463, -582.485901, 48.364807),
    locked = false,
    doorRate = 1.0,
}

-- EMS4 created by Dx
Config.DoorList['EMS-EMS4'] = {
    doors = {
        {objName = 1674378365, objYaw = 69.999588012695, objCoords = vec3(299.146118, -585.751892, 42.279427)},
        {objName = 1138474139, objYaw = 69.965194702148, objCoords = vec3(299.840973, -583.842834, 42.279427)}
    },
    doorRate = 1.0,
    distance = 1,
    doorType = 'doublesliding',
    pickable = true,
    locked = false,
    authorizedJobs = { ['ambulance'] = 0 },
}

-- EMSsur created by Dx
Config.DoorList['EMS-EMSsur'] = {
    fixText = false,
    objName = -1999925837,
    objYaw = 340.0,
    authorizedJobs = { ['ambulance'] = 0 },
    doorRate = 1.0,
    locked = true,
    distance = 1,
    doorType = 'door',
    objCoords = vec3(318.192932, -595.505310, 48.369148),
}