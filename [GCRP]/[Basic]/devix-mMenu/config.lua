
MENU = { 
    Mysql  = "oxmysql",
    Framework = "qb", -- oldqb or qb , oldesx, esx
    sqltableName = "players", -- if using qb   users to players
    sqltableAltName = "citizenid", -- if using qb   identifier to citizenid
    debugMode = true,
    openMenuKey = 246, -- https://docs.fivem.net/docs/game-references/controls/ u can changed 
    Discord_Webhook = { -- Check the Locales File to change the content of the typed posts!
        ["cases"] = "https://discord.com/api/webhooks/1102116429668552745/F-1gkxD-vhNUKYlCr-Luby2y04Vchp8z24F35-TCPb8bX3-cz3-hJrVG0jc_Rt9X7bMk",
        ["ticket"] = "https://discord.com/api/webhooks/1102116429668552745/F-1gkxD-vhNUKYlCr-Luby2y04Vchp8z24F35-TCPb8bX3-cz3-hJrVG0jc_Rt9X7bMk",
        ["storebuy"] = "https://discord.com/api/webhooks/1102116429668552745/F-1gkxD-vhNUKYlCr-Luby2y04Vchp8z24F35-TCPb8bX3-cz3-hJrVG0jc_Rt9X7bMk",
        ["casesSelling"] = "https://discord.com/api/webhooks/1102116429668552745/F-1gkxD-vhNUKYlCr-Luby2y04Vchp8z24F35-TCPb8bX3-cz3-hJrVG0jc_Rt9X7bMk",
        ["buyCoin"] = "https://discord.com/api/webhooks/1102116429668552745/F-1gkxD-vhNUKYlCr-Luby2y04Vchp8z24F35-TCPb8bX3-cz3-hJrVG0jc_Rt9X7bMk",
        ["buyPrime"] = "https://discord.com/api/webhooks/1102116429668552745/F-1gkxD-vhNUKYlCr-Luby2y04Vchp8z24F35-TCPb8bX3-cz3-hJrVG0jc_Rt9X7bMk",
    },
    savePlayerInServerTime = 60, -- Save the time every 60 seconds 
    coinIMG = "./img/mv2p.png", -- coin Image
    prismaIMG = "./img/prismaimg.png", -- coin Image
    PRIME_TIME = 30, -- it will say for how many days the received premium is received
    -- Functions
    openInventorySide = function () --Example Codes 
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = "CLOSE_SCREEN"
        })
        print('Iventory System =>')
        -- there is ur open inventory functions
    end,

    openCrewMenu = function ()
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = "CLOSE_SCREEN"
        })
        TriggerEvent('devix-crew:client:openCrewMenu')
    end,

    openSkillSide  = function () --Example Codes 
        -- there is ur open skill functions
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = "CLOSE_SCREEN"
        })
        print('skill System =>')
        TriggerEvent('devix-skils:client:openScreen')
    end,


    TEBEX_SETTINGS = {
        status = true, -- Status "true" olursa direkt tebexSecret kontrolü yapacak yani satın alımların yapılması için
        command = "claim", -- Tebex'de satın aldığınız ürünün kodunu kontrolü için yer,
        tebexSendToServerCommand = "tebex_sendit", -- Tebex üzerinde satın alınacağı zaman sisteme işleyecek olan komut (tebex'de bölümde oluşturduğunuz komutla aynı olması gerekiyor)

    },
    ----
    TICKET_ADMINS = { -- Şimdilik ticket sisteminde atılan mesajlara bakacak.
        ["ZEM48713"] = {
            type = "admin",
            label = "ADMIN"
        },
    },



    -- *HOME PAGE =>
    HOMEPAGE = {
        menuServerLogo = "https://cdn.discordapp.com/attachments/801119508973748265/1097539277027553290/serverLogo.png", -- Direkt Olarak main menu'deki server logoyu değiştirmek için
        menuTopMenus = { -- Main page'de üst kutuların yerleri
            {
                boxName = "STORE", --BOX HEADER
                boxLabel = "In the shop you can access the products of the month, new cars, tops, items! Now the whole city will admire you!", --BOX LABEL
                boxStyle = "width: 22%; height: 86%; background: #48474733; border-radius: 9px; border-top: 1px solid #ffffff3f; border-right: 1px solid #ffffff21; border-left: 1px solid #ffffff21; margin:1vh; overflow: hidden;  transition: .1s all ; background-size: cover; background-repeat: no-repeat; background-position: center; float: left; margin-top: 0%;", -- Box Style css
                boxHeaderStyle = "width: 100%; height: 9%; font-weight: 200; font-size: 1.7vh; padding: 16px 10px;", -- Box Header Style css
                boxLabelStyle = "font-size: 1vh; font-weight: 300; width: 93%; margin: 0 auto;", -- Box Label Style css
                boxBGCharacter = "https://cdn.discordapp.com/attachments/720451568041984013/1097543187154862201/shop.png", -- Image URL (Discord must be)
                boxBGCharacterStyle = "width: 143%; height: 113%; background-repeat: no-repeat; background-size: contain; background-position: center; margin-top: 8%; position: relative; margin-left: -32%;", -- Image CSs
                boxEventName = "devix-mmenu:client:openStore",
            },
            {
                boxName = "PROFILE", --BOX HEADER
                boxLabel = "Here you can access your profile and check your online time, account id, phone number, profession, vehicles, prime and skill system", --BOX HEADER
                boxStyle = "width: 37%; height: 20%; background: #48474733; border-radius: 9px; border-top: 1px solid #ffffff3f; border-right: 1px solid #ffffff21; border-left: 1px solid #ffffff21; margin:1vh; overflow: hidden;  transition: .1s all ; background-size: cover; background-repeat: no-repeat; background-position: center; ", -- Box Style css
                boxHeaderStyle = "width: 100%; height: 9%; font-weight: 200; font-size: 1.7vh; padding: 16px 10px;", -- Box Header Style css
                boxLabelStyle = "font-size: 1vh; font-weight: 300; width: 59%; margin: 2% 2%; float: left;", -- Box Label Style css
                boxBGCharacter = "https://cdn.discordapp.com/attachments/720451568041984013/1097552278069727242/gtaonline-the-criminal-enterprises-executive-artwork-png-8677-1600.png", -- Image URL (Discord must be)
                boxBGCharacterStyle = "width: 120%; height: 171%; background-repeat: no-repeat; background-size: contain; background-position: center; margin-top: -22%; position: relative; margin-left: 18%;", -- Image CSs
                boxEventName = "devix-mmenu:client:openProfile",
            },
            {
                boxName = "CASES", --BOX HEADER
                boxLabel = "Are you feeling lucky? Then you've come to the right place, here you need to open the crates that are burning for you!", --BOX HEADER
                boxStyle = "width: 37%; height: 43%; background: #48474733; border-radius: 9px; border-top: 1px solid #ffffff3f; border-right: 1px solid #ffffff21; border-left: 1px solid #ffffff21; margin:1vh; overflow: hidden;  transition: .1s all ; background-size: cover; background-repeat: no-repeat; background-position: center; ", -- Box Style css
                boxHeaderStyle = "width: 100%; height: 9%; font-weight: 200; font-size: 1.7vh; padding: 16px 10px;", -- Box Header Style css
                boxLabelStyle = "font-size: 1vh; font-weight: 300; width: 59%; margin: 2% 2%; float: left;", -- Box Label Style css
                boxBGCharacter = "https://cdn.discordapp.com/attachments/1097613909298516018/1097875969072705546/cas.png", -- Image URL (Discord must be)
                boxBGCharacterStyle = "width: 100%;height: 166%; background-repeat: no-repeat; background-size: contain; background-position: center; margin-top: -20%; position: relative; margin-left: 0%;", -- Image CSs 
                boxEventName = "devix-mmenu:client:openCase",
            },
            {
                boxName = "CONTACT ADMIN", --BOX HEADER
                boxLabel = "Do you need help? Contact our admins on the server and see how they take care of you in a unique way!", --BOX HEADER
                boxStyle = "width: 18%; height: 20%; background: #48474733; border-radius: 9px; border-top: 1px solid #ffffff3f; border-right: 1px solid #ffffff21; border-left: 1px solid #ffffff21; overflow: hidden;  transition: .1s all ; background-size: cover; background-repeat: no-repeat; background-position: center; float: left; margin-top: 0%; margin-right: 1%; ", -- Box Style css
                boxHeaderStyle = "width: 100%; height: 9%; font-weight: 200; font-size: 1.7vh; padding: 16px 10px;", -- Box Header Style css
                boxLabelStyle = "font-size: 1vh; font-weight: 300; width: 59%; margin: 2% 2%; float: left;", -- Box Label Style css
                boxBGCharacter = "https://cdn.discordapp.com/attachments/1097613909298516018/1097874194097770626/4841548.webp", -- Image URL (Discord must be)
                boxBGCharacterStyle = "width: 105%; height: 95%; background-repeat: no-repeat; background-size: contain; background-position: center; margin-top: -8%; position: relative; margin-left: 28%;", -- Image CSs
                boxEventName = "devix-mmenu:client:openContact",
            },
            {
                boxName = "RULES", --BOX HEADER
                boxLabel = "Everywhere there is a need for rules, and everyone has to follow them. If you want to know the rules of your place, click here!", --BOX HEADER
                boxStyle = "width: 18%; height: 20%; background: #48474733; border-radius: 9px; border-top: 1px solid #ffffff3f; border-right: 1px solid #ffffff21; border-left: 1px solid #ffffff21; margin-right: 1%; overflow: hidden;  transition: .1s all ; background-size: cover; background-repeat: no-repeat; background-position: center;float:left; ", -- Box Style css
                boxHeaderStyle = "width: 100%; height: 9%; font-weight: 200; font-size: 1.7vh; padding: 16px 10px;", -- Box Header Style css
                boxLabelStyle = "font-size: 1vh; font-weight: 300; width: 59%; margin: 2% 2%; float: left;", -- Box Label Style css
                boxBGCharacter = "https://cdn.discordapp.com/attachments/1097613909298516018/1097874539486130266/law-book-3d-render-icon-illustration-png.png", -- Image URL (Discord must be)
                boxBGCharacterStyle = "width: 98%; height: 69%; background-repeat: no-repeat; background-size: contain; background-position: center; margin-top: -4%; position: relative; margin-left: 29%; transform: rotate(14deg);", -- Image CSs
                boxEventName = "devix-mmenu:client:openRule",
            },
            {
                boxName = "SETTINGS", --BOX HEADER
                boxLabel = "Click here to check your crosshair and graphics settings!", --BOX HEADER
                boxStyle = "width: 18%; height: 20%; background: #48474733; border-radius: 9px; border-top: 1px solid #ffffff3f; border-right: 1px solid #ffffff21; border-left: 1px solid #ffffff21; margin:1vh; overflow: hidden;  transition: .1s all ; background-size: cover; background-repeat: no-repeat; background-position: center; ", -- Box Style css
                boxHeaderStyle = "width: 100%; height: 9%; font-weight: 200; font-size: 1.7vh; padding: 16px 10px;", -- Box Header Style css
                boxLabelStyle = "font-size: 1vh; font-weight: 300; width: 59%; margin: 2% 2%; float: left;", -- Box Label Style css
                boxBGCharacter = "https://cdn.discordapp.com/attachments/1097613909298516018/1097875000742129794/settings-icon-gear-3d-render-png.png", -- Image URL (Discord must be)
                boxBGCharacterStyle = "width: 120%; height: 171%; background-repeat: no-repeat; background-size: contain; background-position: center; margin-top: -22%; position: relative; margin-left: 18%;", -- Image CSs
                boxEventName = "devix-mmenu:client:openSettings",
            },
            {
                boxName = "MY CREW", --BOX HEADER
                boxLabel = "If you want to access the crew you belong to and see where you are, click!", --BOX HEADER
                boxStyle = "width: 18%; height: 64%; background: #48474733; border-radius: 9px; border-top: 1px solid #ffffff3f; border-right: 1px solid #ffffff21; border-left: 1px solid #ffffff21; margin: -45% 1vh 1vh 61.5%; position:relative; overflow: hidden;  transition: .1s all ; background-size: cover; background-repeat: no-repeat; background-position: center; ", -- Box Style css
                boxHeaderStyle = "width: 100%; height: 9%; font-weight: 200; font-size: 1.7vh; padding: 16px 10px;", -- Box Header Style css
                boxLabelStyle = "font-size: 1vh; font-weight: 300; width: 100%; margin: 2% 2%; float: left;", -- Box Label Style css
                boxBGCharacter = "https://cdn.discordapp.com/attachments/1097613909298516018/1097616151472779274/gta-online-doomsdayheist-artwork-png.png", -- Image URL (Discord must be)
                boxBGCharacterStyle = "width: 234%; height: 174%; background-repeat: no-repeat; background-size: contain; background-position: center; margin-top: -41%; position: relative; margin-left: -80%;", -- Image CSs
                boxEventName = "devix-mmenu:client:openCrewMenu",
            },
            {
                boxName = "MY JOB", --BOX HEADER
                boxLabel = "Are you looking for a job? Here you can look at the jobs and see where and what is available!", --BOX HEADER
                boxStyle = "width: 18%; height: 86%; background: #48474733; border-radius: 9px; border-top: 1px solid #ffffff3f; border-right: 1px solid #ffffff21; border-left: 1px solid #ffffff21;    margin: -34% 1vh 1vh 80.5%; position:relative; overflow: hidden;  transition: .1s all ; background-size: cover; background-repeat: no-repeat; background-position: center; ", -- Box Style css
                boxHeaderStyle = "width: 100%; height: 9%; font-weight: 200; font-size: 1.7vh; padding: 16px 10px;", -- Box Header Style css
                boxLabelStyle = "font-size: 1vh; font-weight: 300; width: 100%; margin: 2% 2%; float: left;", -- Box Label Style css
                boxBGCharacter = "https://cdn.discordapp.com/attachments/1097613909298516018/1097873339718041611/gtaonline-after-hours-dixon-artwork-png.png", -- Image URL (Discord must be)
                boxBGCharacterStyle = "width: 352%; height: 190%; background-repeat: no-repeat; background-size: contain; background-position: center; margin-top: -89%; position: relative; margin-left: -67%;", -- Image CSs
                boxEventName = "devix-mmenu:client:openJobSection",
            },
        },
    },
    

    -- devix-mmenu:client:giveCar ==> (this event )Here exactly 4 more data comes as argüments and you can check them by printing them.
    -- *STORE PAGE > 
    storePages = {
        {
            storeBoxHeader = "HOME", -- For boxes on the left side
            storeBoxIcon = '<i class="fa-solid fa-house"></i>',-- For boxes on the left side ,ion
            storeBoxEvents = {-- Things that will appear on the right side of the screen when clicked
                { 
                    storeBoxEventHeader = "lore m loremlor emlo reml oremloremlor emloremlore mloremloremlo remloremloremlo rem loremlo remlorem loremlorem loremloremloremlore  mloremloremlorem", --The title of the box.
                    storeBoxEventHeaderStyle = "height: 14%; width: 100%; top: 82%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/948507510233526292/1076035202884845598/image.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:setMoney", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = 100, -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:100%;height:54%", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                },
                
            }
        },
        {
            storeBoxHeader = "VEHICLE", -- For boxes on the left side
            storeBoxIcon = '<i class="fa-solid fa-car"></i>',-- For boxes on the left side ,ion
            storeBoxEvents = {-- Things that will appear on the right side of the screen when clicked
                { 
                    storeBoxEventHeader = "ZENTORNO ", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 5%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1097613909298516018/1098164088879722557/cf47f8124888313.610d567f36db1.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveCar", -- (THIS EVENT GOING SERVER SIDE) Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "zentorno", -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash
                    storeBoxStyle = "width:27%;height:54%", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "height: 9%; width: 26%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 76%; left: 13%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "911RSR XX ", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 5%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1076836712178786364/image.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:setMoney", -- (THIS EVENT GOING SERVER SIDE  Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = 100, -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:27%;height:54%", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "height: 9%; width: 26%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 76%; left: 13%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "BRZ SUBARU  ", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 5%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1076836764515319889/image.png", --Box background image
                    storeBoxEventCoin = 100, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:setMoney", -- (THIS EVENT GOING SERVER SIDE Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = 100, -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:27%;height:54%", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "height: 9%; width: 26%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 76%; left: 13%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "MERCEDES AMG  ", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 5%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1076836677257015296/image.png", --Box background image
                    storeBoxEventCoin = 100, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:setMoney", -- (THIS EVENT GOING SERVER SIDE Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = 250, -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:83%;height:54%", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "height: 9%; width: 10%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 113%; left: 33%; padding: 5px 25px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "MINI COOPER  ", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 5%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1076836799856513115/image.png", --Box background image
                    storeBoxEventCoin = 20, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:setMoney", -- (THIS EVENT GOING SERVER SIDE Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = 100, -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:27%;height:54%", -- The desired size of the normal box width:100%;height:24%
                   storeCoinBoxStyle = "height: 9%; width: 26%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 76%; left: 13%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "SUPRA A XX  ", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 5%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1076836835508113448/image.png", --Box background image
                    storeBoxEventCoin = 20, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:setMoney", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = 100, -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:27%;height:54%", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "height: 9%; width: 26%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 76%; left: 13%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
            },
        },
        {
            storeBoxHeader = "FOOD", -- For boxes on the left side
            storeBoxIcon = '<i class="fa-solid fa-burger"></i>',-- For boxes on the left side ,ion
            storeBoxEvents = {-- Things that will appear on the right side of the screen when clicked
                { 
                    storeBoxEventHeader = "Fried potato 100 pieces per field", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 5%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1076837547054989392/image.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveItem", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "100", -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:27%;height:54%", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "height: 9%; width: 26%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 76%; left: 13%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "25X HAMBURGERS ", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 5%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1076837619998134372/image.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:setMoney", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = 100, -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:27%;height:54%", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "height: 9%; width: 26%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 76%; left: 13%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "ROCKET HAMUBERGER ETHICS MORE  ", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 5%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1076837903239487588/image.png", --Box background image
                    storeBoxEventCoin = 100, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:setMoney", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = 100, -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:27%;height:85%", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "height: 6%; width: 26%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 76%; left: 13%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "PIZZA                                                   FESTIVAL  ", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 5%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1076838070936162345/image.png", --Box background image
                    storeBoxEventCoin = 100, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:setMoney", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = 250, -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:56%;height:54%; top:-33%; position:relative;", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "height: 9%; width: 14%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 85%; left: 30%; padding: 5px 25px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "CHASING FAST FOOD  ", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: -4%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1076837746120867961/image.png", --Box background image
                    storeBoxEventCoin = 20, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:setMoney", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = 100, -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:27%;height:21%", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "height: 25%; width: 26%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 55%; left: 13%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
            },
        },
        {
            storeBoxHeader = "PRIME", -- For boxes on the left side
            storeBoxIcon = '<i class="fa-solid fa-p"></i>',-- For boxes on the left side ,ion
            storeBoxEvents = {-- Things that will appear on the right side of the screen when clicked
                { 
                    storeBoxEventHeader = "PRIME", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 5%;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1077615924040958012/7ce6a4163463417.63e6191e459ab.jpg", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:setMoney", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = 100, -- an arguments to be sent with the event
                    storeBoxEventType = "car", -- car,item,cash

                    storeBoxStyle = "width:100%;height:97%", -- The desired size of the normal box width:100%;height:24%
                    storeCoinBoxStyle = "display:none;height: 9%; width: 26%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 76%; left: 13%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
            }
        },
        {
            storeBoxHeader = "SHOP", -- For boxes on the left side
            storeBoxIcon = '<i class="fa-solid fa-shop"></i>',-- For boxes on the left side ,ion
            storeBoxEvents = {-- Things that will appear on the right side of the screen when clicked
                { 
                    storeBoxEventHeader = "(G)OLD CHAIN", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 0%; font-size:1.2vh;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1077622630456229979/10kgoldchain.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveItem", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "10kgoldchain", -- an arguments to be sent with the event
                    storeBoxEventType = "item", -- car,item,cash

                    storeBoxStyle = "width: 12%; height: 22%; background-size: auto; background-color: transparent;%", -- The desired size of the normal box width:100%;height:24%

                    storeCoinBoxStyle = "height: 15%; width: 49%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 19%; left: -6%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "ACETONE 10X", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 0%; font-size:1.2vh;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1077622630691123301/acetone.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveItem", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "acetone", -- an arguments to be sent with the event
                    storeBoxEventType = "item", -- car,item,cash

                    storeBoxStyle = "width: 12%; height: 22%; background-size: auto; background-color: transparent;%", -- The desired size of the normal box width:100%;height:24%

                    storeCoinBoxStyle = "height: 15%; width: 49%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 19%; left: -6%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "ADVANCED KIT", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 0%; font-size:1.2vh;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1077622630951161857/advancedkit.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveItem", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "advancedkit", -- an arguments to be sent with the event
                    storeBoxEventType = "item", -- car,item,cash

                    storeBoxStyle = "width: 12%; height: 22%; background-size: auto; background-color: transparent;%", -- The desired size of the normal box width:100%;height:24%

                    storeCoinBoxStyle = "height: 15%; width: 49%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 19%; left: -6%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "ADVANCED LOCKPICK", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 0%; font-size:1.2vh;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1077622631395754034/advancedlockpick.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveItem", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "advancedlockpick", -- an arguments to be sent with the event
                    storeBoxEventType = "item", -- car,item,cash

                    storeBoxStyle = "width: 12%; height: 22%; background-size: auto; background-color: transparent;%", -- The desired size of the normal box width:100%;height:24%

                    storeCoinBoxStyle = "height: 15%; width: 49%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 19%; left: -6%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "BINOCULARS", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 0%; font-size:1.2vh;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1077622644855291944/binoculars.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveItem", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "binoculars", -- an arguments to be sent with the event
                    storeBoxEventType = "item", -- car,item,cash

                    storeBoxStyle = "width: 12%; height: 22%; background-size: auto; background-color: transparent;%", -- The desired size of the normal box width:100%;height:24%

                    storeCoinBoxStyle = "height: 15%; width: 49%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 19%; left: -6%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "HEAVY ARMOR", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 0%; font-size:1.2vh;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1077622645610266695/armor.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveItem", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "armor", -- an arguments to be sent with the event
                    storeBoxEventType = "item", -- car,item,cash

                    storeBoxStyle = "width: 12%; height: 22%; background-size: auto; background-color: transparent;%", -- The desired size of the normal box width:100%;height:24%

                    storeCoinBoxStyle = "height: 15%; width: 49%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 19%; left: -6%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "COLLAR PET", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 0%; font-size:1.2vh;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1077622677759590480/collarpet.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveItem", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "collarpet", -- an arguments to be sent with the event
                    storeBoxEventType = "item", -- car,item,cash

                    storeBoxStyle = "width: 12%; height: 22%; background-size: auto; background-color: transparent;%", -- The desired size of the normal box width:100%;height:24%

                    storeCoinBoxStyle = "height: 15%; width: 49%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 19%; left: -6%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "COOLA", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 0%; font-size:1.2vh;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1077622677579251823/cola.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveItem", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "cola", -- an arguments to be sent with the event
                    storeBoxEventType = "item", -- car,item,cash

                    storeBoxStyle = "width: 12%; height: 22%; background-size: auto; background-color: transparent;%", -- The desired size of the normal box width:100%;height:24%

                    storeCoinBoxStyle = "height: 15%; width: 49%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 19%; left: -6%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "SMALL BRICK", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 0%; font-size:1.2vh;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1077622677323382844/coke_small_brick.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveItem", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "coke_small_brick", -- an arguments to be sent with the event
                    storeBoxEventType = "item", -- car,item,cash

                    storeBoxStyle = "width: 12%; height: 22%; background-size: auto; background-color: transparent;%", -- The desired size of the normal box width:100%;height:24%

                    storeCoinBoxStyle = "height: 15%; width: 49%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 19%; left: -6%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
                { 
                    storeBoxEventHeader = "CRYPTO STICK", --The title of the box.
                    storeBoxEventHeaderStyle = "height: AUTO; width: 100%; top: 78%; text-align: left; overflow: hidden; text-overflow: ellipsis; position: relative; text-align: center; font-weight: 700; font-style: italic; margin-top: 0%; font-size:1.2vh;",-- If you want to adjust how the header looks, you can change it via css.

                    storeBoxEventLabel = "Click to results.", -- Sub title
                    storeBoxEventLabelStyle = "height: 14%; width: 100%; top: 80%; text-align: left; text-overflow: ellipsis; position: relative; font-size: 1vh; opacity: 0.8; overflow: hidden; text-align: center;", ---- If you want to adjust how the subtitle looks, you can change it via css.

                    storeBoxEventImage = "https://cdn.discordapp.com/attachments/1053660049391767552/1077622677059145818/cryptostick.png", --Box background image
                    storeBoxEventCoin = 12, -- Coin,  I mean, how many coins to buy

                    storeBoxEventTrigger = "devix-mmenu:client:giveItem", -- Event that will be triggered when purchased, So when the purchase is made, this trigger will be played and you can do whatever you want.
                    storeBoxEventargs = "cryptostick", -- an arguments to be sent with the event
                    storeBoxEventType = "item", -- car,item,cash

                    storeBoxStyle = "width: 12%; height: 22%; background-size: auto; background-color: transparent;%", -- The desired size of the normal box width:100%;height:24%

                    storeCoinBoxStyle = "height: 15%; width: 49%; position: relative; background: #0000009e; border: 1px solid #ffffff3b; border-radius: 3px; top: 19%; left: -6%; padding: 5px 19px;", -- Here is the style of the box that shows how many coins there are, you can play on the css as you want.
                    storeCoinBoxICONStyle = "background-position: center; background-repeat: no-repeat; background-size: cover; width: 32%; height: 100%;", -- You can set the type of VIP icon in the box.
                    storeCoinBoxTEXTtyle = "width: 61%; height: 65%; font-size: 1.5vh; margin: 0; font-weight: 300; margin-top:-43%; float:right;", -- You can set the type of VIP text in the box. 

                },
            },
        },
    },

    -- 


    --  *CASES 
    CASE = {
        ["SETTINGS"] = {
            variableTypes = {
                ["normal"] = {
                    variableLabel = "RARE",
                    color = "gray", -- orange or #21001 etc.
                    costMultiplier = 1, -- 1x , eğer ki satılan item legendary olursa itemin satılacağı coin örneğin 12 x 1 şeklinde gözükecektir.
                },
                ["rare"] = {
                    variableLabel = "RARE",
                    color = "#d21fff", -- orange or #21001 etc.
                    costMultiplier = 1, -- 1x , eğer ki satılan item legendary olursa itemin satılacağı coin örneğin 12 x 1 şeklinde gözükecektir.
                },
                ["legendary"] = {
                    variableLabel = "LEGENDARY",
                    color = "#fffb00", -- orange or #21001 etc.
                    costMultiplier = 1, -- 1x , eğer ki satılan item legendary olursa itemin satılacağı coin örneğin 12 x 1 şeklinde gözükecektir.
                },
            }, 
            advirsmentIMG = "https://cdn.discordapp.com/attachments/1080339362211963002/1109392725947715654/Main-1920px.673bc180.png", -- Kasa ekranındaki ilk kısmındaki pano'ya resim koymanız için bir alan
            WeaponsAreItem = true,
        },
        ["CASE_DATA"] = {
            ["limited_edition"] = { -- Kasa isimlerini unique koymanız gerekiyor bu isimler üzerinden appenleme süreci gerçekleşiyor
            ["casePartOfName"] = "LIMITED EDITION", -- Sekmenin bölüneceği kısımdaki header olacak
            cases = { -- içeriklerin bulunduğu kısım
                {
                    {
                        casesHeader = "WEAPON", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110854704302395402/box1.png", -- tam ekran bir fotoğraf
                        casesAreNew = true,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "COMBAT PISTOL",
                                casesItemArg = "weapon_combatpistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_combatpistol.png",-- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 2,
                            },
                            {
                                caseItemLabel = "HEAVY PISTOL",
                                casesItemArg = "weapon_heavypistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_heavypistol.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 2,
                            },
                            {
                                caseItemLabel = "COMPACT LAUNCHER",
                                casesItemArg = "weapon_compactlauncher",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_compactlauncher.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 2,
                            },
                            {
                                caseItemLabel = "REVOLVER",
                                casesItemArg = "weapon_revolver",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_revolver.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 2,
                            },
                            {
                                caseItemLabel = "REVOLVER MK2",
                                casesItemArg = "weapon_revolver_mk2",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_revolver_mk2.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 2,
                            },
                            {
                                caseItemLabel = "AMMO",
                                casesItemArg = "pistol_extendedclip",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/pistol_extendedclip.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 2,
                            },
                            {
                                caseItemLabel = "SAWN OFF SHOTGUN",
                                casesItemArg = "weapon_sawnoffshotgun",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_sawnoffshotgun.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 2,
                            },
                            {
                                caseItemLabel = "STUNGUN",
                                casesItemArg = "weapon_stungun",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_stungun.png", -- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "HEAVY PISTOL MK2",
                                casesItemArg = "weapon_pistol_mk2",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_pistol_mk2.png", -- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "NAVY REVOLVER",
                                casesItemArg = "weapon_navyrevolver",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_navyrevolver.png", -- item image path
                                casesItemVariable = "legendary",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "CERAMIC PISTOL",
                                casesItemArg = "weapon_ceramicpistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_ceramicpistol.png", -- item image path
                                casesItemVariable = "legendary",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "CONTAINER CASE", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110855260844601415/box2.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "BLUE CONTAINER MID",
                                casesItemArg = "container_blue_mid",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/container_blue_mid.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "CONTAINER GREEN SMALL",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/container_green_small.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "CONTAINER GREEN SMALL",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/container_green_small.png", -- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "CONTAINER OLD MID",
                                casesItemArg = "container_old_mid",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/container_old_mid.png", -- item image path
                                casesItemVariable = "legandry",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "MERCH", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110855642454970389/box3.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "AMMO CASES", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110856129644351498/box4.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {-----------
                    {
                        casesHeader = "MONEY CASE", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110856573779193936/box5.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "TEST CASE 1", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110857245257895986/box67.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "COMBAT PISTOL",
                                casesItemArg = "weapon_combatpistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_combatpistol.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "HEAVY PISTOL",
                                casesItemArg = "weapon_heavypistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_heavypistol.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "HEAVY PISTOL MK2",
                                casesItemArg = "weapon_pistol_mk2",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/weapon_pistol_mk2.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "TEST CASE 1", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110857245257895986/box67.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "TEST CASE 1", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110857245257895986/box67.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
            },
            },  
            ["sad_edition"] = { -- Kasa isimlerini unique koymanız gerekiyor bu isimler üzerinden appenleme süreci gerçekleşiyor
            ["casePartOfName"] = "LIMITED SAD EDITION", -- Sekmenin bölüneceği kısımdaki header olacak
            cases = { -- içeriklerin bulunduğu kısım
                {
                    {
                        casesHeader = "TEST CASE 1", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110857245257895986/box67.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "TEST CASE 1", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110857245257895986/box67.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "TEST CASE 1", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110857245257895986/box67.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "TEST CASE 1", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110857245257895986/box67.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
            },
            }, 
            ["car_edition"] = { -- Kasa isimlerini unique koymanız gerekiyor bu isimler üzerinden appenleme süreci gerçekleşiyor
            ["casePartOfName"] = "CAR CASES", -- Sekmenin bölüneceği kısımdaki header olacak
            cases = { -- içeriklerin bulunduğu kısım
                {
                    {
                        casesHeader = "TEST CASE 1", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110857245257895986/box67.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "TEST CASE 1", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110857245257895986/box67.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "TEST CASE 1", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110857245257895986/box67.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
                {
                    {
                        casesHeader = "TEST CASE 1", -- Kasanın başlığı
                        casesBackgroundImage = "https://cdn.discordapp.com/attachments/1106256169296724059/1110857245257895986/box67.png", -- tam ekran bir fotoğraf
                        casesAreNew = false,  -- Kasa eğer ki yeni etiketi gelmesini istiyorsanız bunu true yapın
                        casesOpeningPrice = 1, -- Kasanın açılış paraıs
                        casesType = "coin", --prisma or coin
                        casesItem = { -- Kasa içeriği 
                            {
                                caseItemLabel = "TEST ITEM",
                                casesItemArg = "weapon_pistol",
                                caseItemType = "item", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/advancedlockpick.png",-- item image path
                                casesItemVariable = "rare",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1,
                                casesItemChance = 1,
                            },
                            {
                                caseItemLabel = "TEST CAR",
                                casesItemArg = "zentorno",
                                caseItemType = "vehicle", -- item, vehicle, weapon
                                casesItemImage = "./img/case/items/baller.png", -- item image path
                                casesItemVariable = "normal",
                                casesItemSellCoin = 12, -- Item fiyatı variableTypes ile çarparak oyuncuya sağlar
                                casesItemCount = 1, -- Eğer oluşturduğunuz kısım araç ise bunun sayısı asla fark etmez sadece 1 adet vericektir, ancak item veya para gibi eşyalar belirttiğiniz kadar eklenecekt
                                casesItemChance = 1,
                            },
                        },
                    },
                },
            },
            },       
        },
    },
    -- *JOB
    JOBSCREEN = {
        Menus = {
            {
                ["buttonText"] = "FISHERMAN",--What to write directly on the right buttons
                ["buttonIcon"] = "<i class='fa-solid fa-fish'></i>", --What icon to have on the right button, for icons: https://fontawesome.com/
                ["jobHeader"] = "FISHERMAN JOB", -- What to write in the header on the main screen
                ["jobLabel"] = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", -- What to write in the label on the main screen
                ["jobCoordsX"] = -189.28, --Which coordinate the location will be marked when the button is pressed.
                ["jobCoordsY"] = 972.58, --Which coordinate the location will be marked when the button is pressed.
                ["jobImages"] = "https://cdn.discordapp.com/attachments/1080339362211963002/1085562262154121297/jobfish.png", -- If you put the image link on the right side of the screen, it will be automatically placed there. (must be png)
            },
            {
                ["buttonText"] = "TEST SEC",--What to write directly on the right buttons
                ["buttonIcon"] = "<i class='fa-solid fa-fish'></i>", --What icon to have on the right button, for icons: https://fontawesome.com/
                ["jobHeader"] = "FISHERasdasdasdasdMAN JOB", -- What to write in the header on the main screen
                ["jobLabel"] = "Lorem ssIpsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", -- What to write in the label on the main screen
                ["jobCoordsX"] = -189.28, --Which coordinate the location will be marked when the button is pressed.
                ["jobCoordsY"] = 972.58, --Which coordinate the location will be marked when the button is pressed.
                ["jobImages"] = "", -- If you put the image link on the right side of the screen, it will be automatically placed there. (must be png)
            },
        }
    },
    -- *SCREEN
    SETTINGS_SCREEN = {
        ["CROSSHAIR"] = {
            {name = 'Crosshair1',  label = 'Clear Crosshair',  img = ""},
            {name = 'Crosshair2',  label = 'Crosshair 2',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955011337329729606/Cyan.png"},
            {name = 'Crosshair3',  label = 'Crosshair 3',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955011337501671434/Green.png"},
            {name = 'Crosshair4',  label = 'Crosshair 4',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955011337744945182/Orange.png"},
            {name = 'Crosshair5',  label = 'Crosshair 5',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955011337942085652/Pink.png"},
            {name = 'Crosshair6',  label = 'Crosshair 6',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955011338143416401/Purple.png"},
            {name = 'Crosshair7',  label = 'Crosshair 7',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955011338143416401/Purple.png"},
            {name = 'Crosshair8',  label = 'Crosshair 8',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955011338327969812/Red.png"},
            {name = 'Crosshair9',  label = 'Crosshair 9',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955011338533470228/White.png"},
            {name = 'Crosshair10', label = 'Crosshair 10',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955011338755776512/Yellow.png"},
            {name = 'Crosshair11', label = 'Crosshair 11',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955027980034408448/Black.png"},
            {name = 'Crosshair12', label = 'Crosshair 12',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955027980260884550/Blue.png"},
            {name = 'Crosshair13', label = 'Crosshair 13',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955027980525129738/Cyan.png"},
            {name = 'Crosshair14', label = 'Crosshair 14',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955027980780969984/Green.png"},
            {name = 'Crosshair15', label = 'Crosshair 15',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955027981036830730/Orange.png"},
            {name = 'Crosshair16', label = 'Crosshair 16',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955027981334638642/Pink.png"},
            {name = 'Crosshair17', label = 'Crosshair 17',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955027981649186816/Purple.png"},
            {name = 'Crosshair18', label = 'Crosshair 18',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955027981972144178/Red.png"},
            {name = 'Crosshair19', label = 'Crosshair 19',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955027982257369149/White.png"},
            {name = 'Crosshair20', label = 'Crosshair 20',  img = "https://cdn.discordapp.com/attachments/955010615003459624/955027982647451688/Yellow.png"},
        }
    },

    --[[   -- *BATTLEPASS COMING SOON !
        BATTLEPASS  = {
        ["lastDay"] = {day = 10, month = 03, year = 2023} , -- only day
        ["Pasfree"] = { -- dont change it
            {
                itemLabel = "TELEFON", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "phone", -- (item, car , money)  |    You decide what is to be gained 
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "folder", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "phone", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
            {
                itemLabel = "TELEFON", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "phone", -- (item, car , money)  |    You decide what is to be gained 
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "folder", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "phone", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
            {
                itemLabel = "TELEFON", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "phone", -- (item, car , money)  |    You decide what is to be gained 
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "folder", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "phone", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
            {
                itemLabel = "TELEFON", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "phone", -- (item, car , money)  |    You decide what is to be gained 
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "folder", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "phone", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
            {
                itemLabel = "TELEFON", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "phone", -- (item, car , money)  |    You decide what is to be gained 
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "folder", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "phone", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
        },
        ["premium"] = {  -- dont change it
            {
                itemLabel = "BANDAGE", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "bandage", -- (item, car , money)  |    You decide what is to be gained
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "link", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "https://cdn.discordapp.com/attachments/1026124533830275223/1026145085714342018/0resmonpng.png", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
            {
                itemLabel = "BANDAGE", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "bandage", -- (item, car , money)  |    You decide what is to be gained
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "link", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "https://cdn.discordapp.com/attachments/1026124533830275223/1026145085714342018/0resmonpng.png", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
            {
                itemLabel = "BANDAGE", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "bandage", -- (item, car , money)  |    You decide what is to be gained
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "link", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "https://cdn.discordapp.com/attachments/1026124533830275223/1026145085714342018/0resmonpng.png", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
            {
                itemLabel = "BANDAGE", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "bandage", -- (item, car , money)  |    You decide what is to be gained
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "link", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "https://cdn.discordapp.com/attachments/1026124533830275223/1026145085714342018/0resmonpng.png", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
            {
                itemLabel = "BANDAGE", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "bandage", -- (item, car , money)  |    You decide what is to be gained
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "link", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "https://cdn.discordapp.com/attachments/1026124533830275223/1026145085714342018/0resmonpng.png", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
            {
                itemLabel = "BANDAGE", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "bandage", -- (item, car , money)  |    You decide what is to be gained
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "link", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "https://cdn.discordapp.com/attachments/1026124533830275223/1026145085714342018/0resmonpng.png", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
            {
                itemLabel = "BANDAGE", -- (item, car , money)  |    You decide what the title of the Battlepass box will say
                itemName = "bandage", -- (item, car , money)  |    You decide what is to be gained
                itemAmount = 2, -- (item, car , money)  |   You decide how much is to be earned
                itemStatus = "item", -- (item, car , money)  |    You decide what's to be gained
                itemImageStatus = "link", -- (folder Or link) If you want to take the picture of the item from a file, type folder, if you want to take it from a link like discord link, just fill in here.
                itemImage =  "https://cdn.discordapp.com/attachments/1026124533830275223/1026145085714342018/0resmonpng.png", --( If you want to take a picture of the item etc., the nui/img/itemimage image must be the same as the name you specified.)
            },
        },
        ["missions"] = {
        },
    },
    ]]
}

