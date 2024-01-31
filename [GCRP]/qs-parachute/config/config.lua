Config = {}
Locales = {}

Config.Language = 'en' -- You can choose between 'en', 'es' or another custom language

Config.ParachuteItems = {
    ['parachute_rainbow'] = { type = 5, color = 0 }, -- Rainbow parachute
    ['parachute_darkred'] = { type = 5, color = 1 }, -- Dark red parachute
    ['parachute_yellow'] = { type = 5, color = 2 },  -- Yellow parachute
    ['parachute_red'] = { type = 5, color = 3 },     -- Red parachute
    ['parachute_white'] = { type = 5, color = 4 },   -- White parachute
    ['parachute_blue'] = { type = 5, color = 5 },    -- Blue parachute
    ['parachute_black'] = { type = 5, color = 6 },   -- Black parachute
    -- You can add more parachute types as needed.
}

-- If you are going to use the command, remember to use the pronoun of the item, eg rainbow, darkred, yellow.
Config.ResetParachute = 'resetparachute' -- Name of the command to remove the parachute!
