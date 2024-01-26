Config = {}
Config.Sql = "oxmysql" -- oxmysql/ ghmattimysql/ mysql-async
Config.Framework = "new-qb" -- new-qb / old-qb / esx
Config.ProfilePicture = "steam" -- steam / discord
Config.Inventory = "ps-inventory" -- ox_inventory / default
Config.UseDiscordWebhooks = true -- if you wanna use discord webhook this option must be true
Config.PassIntervalDay = 30 -- days of pass's interval
Config.DefaultPicture = "https://cdn.discordapp.com/attachments/983471660684423240/1147567519712940044/example-pp.png"
Config.Commands = {
    ["addvcoin"] = "givevcoin",
    ["removevcoin"] = "removevcoin",
    ["givepass"] = "givepass",
    ["open"] = "vipmenu"
}

Config.EnableOpenKey = true
Config.OpenKey = 57 --  default F10 https://docs.fivem.net/docs/game-references/controls/


Config.SendMessage = function(message, isError, part, source)
    if part == nil then part = "client" end
    if part == "client" then
        if Config.Framework == "new-qb" or Config.Framework == "old-qb" then
            local p = nil
            if isError then p = "error" else p = "success" end
            TriggerEvent("QBCore:Notify", message, p)
        else
            TriggerEvent("esx:showNotification", message)
        end
    elseif part == "server" then
        if Config.Framework == "new-qb" or Config.Framework == "old-qb" then
            local p = nil
            if isError then p = "error" else p = "success" end
            TriggerClientEvent('QBCore:Notify', source, message, p)
        else
            TriggerClientEvent("esx:showNotification", source, message)
        end
    end
end

Config.Translate = {
    ["enoughmoney"] = "You don't have enough coin!",
    ["alreadyhavepass"] = "You have already have pass!",
    ["boughtpass"] = "You bought pass!",
    ["passexpired"] = "Your pass expired!",
    ["playercantfind"] = "Player can not find!",
    ["coinadd"] = "Coin added!",
    ["coinremove"] = "Coin removed!",
    ["gavepass"] = "You gave the pass to player!",
    ["invalidcode"] = "We cant find your tebex id please wait or contact server owner!",
    ["idused"] = "This tebex id used before!",
    ["succes"] = "Your payment succesfully!",
    ["boughthotdeal"] = "You bought = Hot Deal",
    ["vipmenu"] = "VIP MENU",
    ["vehicles"] = "VEHICLES",
    ["weapons"] = "WEAPONS",
    ["other"] = "OTHER",
    ["history"] = "Purchase History",
    ["viewpass"] = "View My Pass",
    ["needvcoin"] = "NEED VCOIN ?",
    ["visitstore"] = "To get VCoin you can visit our store",
    ["tebexid"] = "codem.tebex.io",
    ["info"] = "After the payment put your tbx-id to input down below",
    ["paymentid"] = "Tebex Payment ID",
    ["getvcoin"] = "Get VCoins",
    ["clickpreview"] = "Click to preview all details",
    ["hotdeals"] = "HOT DEALS",
    ["getdeal"] = "Get Deal Now",
    ["vippasses"] = "VIP PASSES",
    ["checkpasses"] = "Check Passes",
    ["timeforpass"] = "Passes are active after the payment for 30 days.",
    ["gobck"] = "GO BACK",
    ["pass"] = "PASS",
    ["getthepass"] = "Get The Pass",
    ["lessdetail"] = "Less Detail",
    ["getdealnow"] = "Get Deal Now",
    ["donthavepass"] = "You don't have any active VIP Pass.",
    ["currentpass"] = "Current Pass",
    ["getitem"] = "Get Item Now",
    ["cancel"] = "Cancel",
    ["boughtitem"] = "You bought the item!",
    -- Discord Logs
    ["buyitem"] = "Player **%s** bought **%s** - **%s**",
    ["buyitemtite"] = "Item Bought!",
    ["buypass"] = "Player **%s** bought pass == **%s**",
    ["buypasstitle"] = "Pass Bought!",
    ["vcoinlog"] = "New payment vcoin == **%s** amount = **%s**",
    ["vcoinlogtitle"] = "Vcoin Bought!"
 
}

Config.Vehicles = {
    HotData = {
        title = "NISSAN",
        name = "SKYLINE R34 LBW",
        expiredtime = {day = 10,month = 3,year = 2025,hour = 21,minute = 17,second = 0}, -- month 11 == December / there are 11 moons in Javascript
        price = 12500,
        description = {
            [1] = {
                label = "SKYLINE R34 LBW",
                type = 'car',
                give = {
                    [1] = {
                        name = "sultan",
                    }
                }
            },
        }
    },
    items = {
        [0] = { 
            brand = "BMW",
            model = "M4 G80 Custom Build",
            price = 12500,
            image = 'bmw.png',
            reward = {
                type = 'car',
                model = 'sultanrs', 
            }
        },
        [1] = { 
            brand = "MERCEDES BENZ",
            model = "G Class AMG G63 BRABUS",
            price = 12500,
            image = 'mercedesbenz.png',
            reward = {
                type = 'car',
                model = 'sultanrs', 
            }
        },
        [2] = { 
            brand = "LAMBORGHINI",
            model = "Huracan V8 GT",
            price = 12500,
            image = 'huracan.png',
            reward = {
                type = 'car',
                model = 'sultanrs', 
            }
        },
        [3] = { 
            brand = "FORD",
            model = "Mustang 2018 Custom Build",
            price = 12500,
            image = 'mustang.png',
            reward = {
                type = 'car',
                model = 'rmodmustang', 
            }
        },
        [4] = { 
            brand = "NISSAN",
            model = "GTR R50 2023",
            price = 12500,
            image = 'gtr.png',
            reward = {
                type = 'car',
                model = 'sultanrs', 
            }
        },
        [5] = { 
            brand = "CHEVROLET",
            model = "Camaro SS CB",
            price = 12500,
            image = 'camaro.png',
            reward = {
                type = 'car',
                model = 'sultanrs', 
            }
        },
        [6] = { 
            brand = "BMW",
            model = "M4 G80 Custom Build",
            price = 12500,
            image = 'bmw.png',
            reward = {
                type = 'car',
                model = 'sultanrs', 
            }
        },
        [7] = { 
            brand = "MERCEDES BENZ",
            model = "G Class AMG G63 BRABUS",
            price = 12500,
            image = 'mercedesbenz.png',
            reward = {
                type = 'car',
                model = 'sultanrs', 
            }
        },
        [8] = { 
            brand = "LAMBORGHINI",
            model = "Huracan V8 GT",
            price = 12500,
            image = 'huracan.png',
            reward = {
                type = 'car',
                model = 'sultanrs', 
            }
        },
        [9] = { 
            brand = "FORD",
            model = "Mustang 2018 Custom Build",
            price = 12500,
            image = 'mustang.png',
            reward = {
                type = 'car',
                model = 'sultanrs', 
            }
        },
        [10] = { 
            brand = "NISSAN",
            model = "GTR R50 2023",
            price = 12500,
            image = 'gtr.png',
            reward = {
                type = 'car',
                model = 'sultanrs', 
            }
        },
        [11] = { 
            brand = "CHEVROLET",
            model = "Camaro SS CB",
            price = 12500,
            image = 'camaro.png',
            reward = {
                type = 'car',
                model = 'sultanrs', 
            }
        },
    },
    
}
Config.Weapons = {
    HotData = {
        title = "MAFIA",
        name = "STARTER PACK",
        price = 12500,
        expiredtime = {day = 10,month = 3,year = 2020,hour = 21,minute = 17,second = 0}, -- month 11 == December / there are 11 moons in Javascript
        description = {
            [1] = {
                label = "6x Pistol",
                type = 'item',
                give = {
                    [1] = {
                        name = "weapon_pistol",
                        count = 6
                    }
                }
            },
            [2] = {
                label = "6x SMG",
                type = 'item',
                give = {
                    [1] = {
                        name = "weapon_smg",
                        count = 6
                    }
                }
            },
            [3] = {
                label = "1x Sniper",
                type = 'item',
                give = {
                    [1] = {
                        name = "weapon_sniperrifle",
                        count = 1
                    }
                }
            },
            [4] = {
                label = "6x Tec-9",
                type = "item",
                give = {
                    [1] = {
                        name = "weapon_vintagepistol",
                        count = 6
                    }
                }
            },
            [5] = {
                label = "3x Assault Rifle",
                type = "item",
                give = {
                    [1] = {
                        name = "weapon_assaultrifle",
                        count = 3
                    }
                }
            },
            [6] = {
                label = "20x Molotov",
                type = "item",
                give = {
                    [1] = {
                        name = "weapon_molotov",
                        count = 20
                    }
                }
            },
            [7] = {
                label = "3x Granade",
                type = "item",
                give = {
                    [1] = {
                        name = "weapon_grenade",
                        count = 3
                    }
                }
            },
            [8] = {
                label = "1x Vintage Pistol",
                type = "item",
                give = {
                    [1] = {
                        name = "weapon_vintagepistol",
                        count = 6
                    }
                }
            },
        }
    },
    items = {
        [0] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
        [1] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
        [2] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
        [3] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
        [4] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
        [5] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
        [6] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
        [7] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
        [8] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
        [9] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
        [10] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
        [11] = { 
            brand = "RIFLES",
            model = "Carbine Rifle",
            price = 12500,
            image = 'carbinerifle.png',
            reward = {
                type = 'item',
                model = 'weapon_carbinerifle', 
            }
        },
    }
}

Config.Other = {
    HotData = {
        title = "GANG",
        name = "CREATION PACKAGE",
        price = 12500,
        expiredtime = {day = 10,month = 3,year = 2024,hour = 21,minute = 17,second = 0}, -- month 11 == December / there are 11 moons in Javascript
        description = {
            [1] = {
                label = "Private Gang Location",
                type = 'unknown',
            },
            [2] = {
                label = "Gang MLO’S",
                type = 'unknown',
            },
            [3] = {
                label = "8x Gun Case",
                type = 'unknown',
            },
            [4] = {
                label = "Private Stash House",
                type = 'unknown',
            },
            [5] = {
                label = "Private Gang Garage",
                type = 'unknown',
            },
            [6] = {
                label = "Private Craft Desk",
                type = 'unknown',
            },
            [7] = {
                label = "Private Gang Bossmenu",
                type = 'unknown',
            },
            [8] = {
                label = "Custom Gang Outfits",
                type = 'unknown',
            },
        }
    },
    items = {
        [0] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            }
        },
        [1] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            }
        },
        [2] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            }
        },
        [3] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            }
        },
        [4] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            }
        },
        [5] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            }
        },
        [6] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            }
        },
        [7] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            }
        },
        [8] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            }
        },
        [9] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            }
        },
        [10] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            }
        },
        [11] = { 
            brand = "MONEY",
            model = "$150.000 Cash",
            price = 12500,
            image = 'moneybag.png',
            reward = {
                type = 'money',
                model = '', 
                count = 150000
            },
        },
    }
}

Config.HotDealData = {
    text = "42+ WEAPONS",
    price = 12500,
    rewards = {
        {
            name = "2 Import Vehicle",
            give = {
                [1] = {
                    type = "car",
                    model = "sultanrs",
                },
                [2] = {
                    type = "car",
                    model = "sultan",
                }
            }
        },
        {
            name= "1 Custom MLO"
        },
        {
            name= "$1.500.000 Cash",
            give = {
                [1] = {
                    type = "money",
                    count = 1500000,
                },
            }
        },
        {
            name = "5 Vanilla Vehicle",
            give = {
                [1] = {
                    type = "car",
                    model = "sultanrs",
                },
                [2] = {
                    type = "car",
                    model = "sultan",
                },
                [3] = {
                    type = "car",
                    model = "sultan",
                },
                [4] = {
                    type = "car",
                    model = "sultan",
                },
                [5] = {
                    type = "car",
                    model = "sultan",
                }
            }
        },
        {
            name = "3000 Craft Point",
        },
        {
            name = "Custom Blip",
        },
        {
            name = "Discord Role",
        },
        {
            name = "Daily Packages",
        },
        {
            name= "1 Custom MLO"
        },
    },
    SwiperData = {
        [0] = {
            image = "image.png",
            text = "5 IMPORT VEHICLE"
        },
        [1] = {
            image = "image2.png",
            text = "NISSAN"
        },
        [2] = {
            image = "image2.png",
            text = "NISSAN"
        },
        [3] = {
            image = "image2.png",
            text = "NISSAN"
        },
        [4] = {
            image = "image2.png",
            text = "NISSAN"
        },
        [5] = {
            image = "image2.png",
            text = "NISSAN"
        },
        [6] = {
            image = "image2.png",
            text = "NISSAN"
        },
        [7] = {
            image = "image2.png",
            text = "NISSAN"
        },
        [8] = {
            image = "image2.png",
            text = "NISSAN"
        },
        [9] = {
            image = "image2.png",
            text = "NISSAN"
        },
        [10] = {
            image = "image2.png",
            text = "NISSAN"
        },
    }
}

Config.Passes = {
    ["platinum"]= {
        title = "PLATINUM",
        price = 12500,
        rewards = {
            {
                name= "2 IMPORT VEHICLE",
                give = {
                    [1] = {
                        type = "car",
                        model = "sultanrs",
                    },
                    [2] = {
                        type = "car",
                        model = "sultan",
                    }
                }
            },
            {
                name= "1 CUSTOM MLO"
            },
            {
                name= "$1.500.000 CASH",
                give = {
                    [1] = {
                        type = 'money',
                        model = '', 
                        count = 1500000
                    }
                }
            },
            {
                name = "5 Vanilla Vehicle",
                give = {
                    [1] = {
                        type = "car",
                        model = "sultanrs",
                    },
                    [2] = {
                        type = "car",
                        model = "sultan",
                    },
                    [3] = {
                        type = "car",
                        model = "sultan",
                    },
                    [4] = {
                        type = "car",
                        model = "sultan",
                    },
                    [5] = {
                        type = "car",
                        model = "sultan",
                    },
                }
            },
            {
                name = "3000 Craft Point",
            },
            {
                name = "Custom Blip",
            },
            {
                name = "Discord Role",
            },
            {
                name = "Daily Packages",
            },
            {
                name = "150 VCoin",
            }
        }
    },
    ["diamond"] = {
        title  = "DIAMOND",
        price  = 20000,
        rewards  = {
            {
                name = "2 Import Vehicle",
                give = {
                    [1] = {
                        type = "car",
                        model = "sultanrs",
                    },
                    [2] = {
                        type = "car",
                        model = "sultan",
                    }
                }
            },
            {
                name = "1 Custom MLO",
            },
            {
                name = "$1.500.000 Cash",
                give = {
                    [1] = {
                        type = 'money',
                        model = '', 
                        count = 1500000
                    }
                }
            },
            {
                name = "5 Vanilla Vehicle",
                give = {
                    [1] = {
                        type = "car",
                        model = "sultanrs",
                    },
                    [2] = {
                        type = "car",
                        model = "sultan",
                    },
                    [3] = {
                        type = "car",
                        model = "sultan",
                    },
                    [4] = {
                        type = "car",
                        model = "sultan",
                    },
                    [5] = {
                        type = "car",
                        model = "sultan",
                    },
                }
            },
            {
                name = "3000 Craft Point",
            },
            {
                name = "Custom Blip",
            },
            {
                name = "Discord Role",
            },
            {
                name = "Daily Packages",
            },
            {
                name = "150 VCoin",
            }
        }
    },
    ["golden"] = {
        title  = "GOLDEN",
        price  = 7500,
        rewards  = {
            {
                name = "2 Import Vehicle",
                give = {
                    [1] = {
                        type = "car",
                        model = "sultanrs",
                    },
                    [2] = {
                        type = "car",
                        model = "sultan",
                    }
                }
            },
            {
                name = "1 Custom MLO",
            },
            {
                name = "$1.500.000 Cash",
                give = {
                    [1] = {
                        type = 'money',
                        model = '', 
                        count = 1500000
                    }
                }
            },
            {
                name = "5 Vanilla Vehicle",
                give = {
                    [1] = {
                        type = "car",
                        model = "sultanrs",
                    },
                    [2] = {
                        type = "car",
                        model = "sultan",
                    },
                    [3] = {
                        type = "car",
                        model = "sultan",
                    },
                    [4] = {
                        type = "car",
                        model = "sultan",
                    },
                    [5] = {
                        type = "car",
                        model = "sultan",
                    },
                }
            },
            {
                name = "3000 Craft Point",
            },
            {
                name = "Custom Blip",
            },
            {
                name = "Discord Role",
            },
            {
                name = "Daily Packages",
            },
            {
                name = "150 VCoin",
            }
        }
    }
}