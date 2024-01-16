local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {

    ['qbjobs'] = 'https://canary.discord.com/api/webhooks/1084832401567518822/MBeVOs9noJVL-wcV2toxy_97ZTrq3ulqcRtXBBBstCUsIfilKYPJPoUANoDyAougwnaL',
    ['humanelabs'] = 'https://canary.discord.com/api/webhooks/1084832527488913469/jH26tFbt1pblxFovjy1BibXkyjbJI9sk0Pq9Hw-WRnbpZg23Sf2ihe38PV-ra1I2Cg51',
    ['default'] = 'https://discord.com/api/webhooks/1056689979574726738/JabaqrHTcz-Hn4McdjheVCj1ZwyCb4KaX1DT1BRfEvdmQfUxrBHXuakJu5Dg5kRmrBe9',
    ['testwebhook'] = 'https://discord.com/api/webhooks/1056712321600331779/_IFQaWFIa_UbceDdxmpa8OyjTp7Ugi0B2mRuKtW9FDeeOzGLLj9qB_4VBdUDatAPcSJj',
    ['playermoney'] = 'https://discord.com/api/webhooks/1056690336476446742/UKZTs2r7Nc4iwkkXc18zA10KkCwe3iwbgYPUbfRNSI5vQM6fsYaQa04icFb61jSK4knl',
    ['playerinventory'] = 'https://discord.com/api/webhooks/1056690536037220352/O44ekHrGuyy2qUUUQX9aeVZENozgpvWn2oZthKtfkike5oHxGFhxUHwB2gJhCAaMs_fR',
    ['robbing'] = 'https://discord.com/api/webhooks/1056691434494894090/E3HJPu-BSrMeooCVOuWrqd6eOqj-DuHQbOOERAouaIU40sNelua9HTr1pdO9OfE92LUB',
    ['cuffing'] = 'https://discord.com/api/webhooks/1056691628141723738/H-jOY_uNqvzzFsaMSXbhk3vUc7b14_cdnhuOyHx5UizOJBR6P9LiWXrHlvkuTqw4r9NA',
    ['drop'] = 'https://discord.com/api/webhooks/1056691825802481735/LIzWu-guFlp10ih2XmqYbH2DNycYHZd62oFLxa6_OcUyJOsErURlPP3fu8Ej-ASfPbIr',
    ['trunk'] = 'https://discord.com/api/webhooks/1056692064932343910/6MruSzQG2jwOLFroYN-v7RpG5qOyRn3RWfh87ZaV8QXZI2ErcTk0PaFjyfg3665ciLzv',
    ['stash'] = 'https://discord.com/api/webhooks/1056692244310130809/AwaBinuS6lwpPuVOGJO8wRvbrcESZ1L0dgW1o81I-NuivodZ8_zQtQMSb9334jsHlpGg',
    ['glovebox'] = 'https://discord.com/api/webhooks/1056692429467693066/gmgpza_iOMCIs3FqFH3BMssoio4FFjQkcIIwLAuxlq63G_nz2lakbkSPZF3dzJRRUotx',
    ['banking'] = 'https://discord.com/api/webhooks/1056692804643987496/3vDH6Igif0qciaJ1sjEWz9iUCppYNm07RV9MxxgBX7dc9IH-9IoNIbef0L74CpSjwUr_',
    ['vehicleshop'] = 'https://discord.com/api/webhooks/1056693278692605982/0B6_gafcFsF60pVXf9avn6x828tXnwWfh_NgSUsPhiZrCpzVbrIIlkI6bpS2exRXH_57',
    ['vehicleupgrades'] = 'https://discord.com/api/webhooks/1056693458162696312/eTY7hLUciGRiQMftJhkQzfkzzp_HVKttU8z1MmSJ-WkVb6un2HqZW6heWfnVNA-6l8ee',
    ['shops'] = 'https://discord.com/api/webhooks/1056693665675878420/cD66A4lFc85WCyvz4PVmMImqbJVBbyr1INWFaBE-cjZNJHr7yoiDLHrLoAL5V6vniQLM',
    ['dealers'] = 'https://discord.com/api/webhooks/1056693866704687236/47EofbcNFNfrZfWIWRC4dcavwW-igBIW6wFv2W9FL3Bp3SlL6JrqhVZHTyrVCcZsnxzU',
    ['storerobbery'] = 'https://discord.com/api/webhooks/1056694082614870036/K4XivaSuAkgieRaNq4rewb7kHoRIjmjLbtcS_BlqXTf2Iv1xCqGmLuHa25ttO92gjO_b',
    ['bankrobbery'] = 'https://discord.com/api/webhooks/1056694082614870036/K4XivaSuAkgieRaNq4rewb7kHoRIjmjLbtcS_BlqXTf2Iv1xCqGmLuHa25ttO92gjO_b',
    ['powerplants'] = 'https://discord.com/api/webhooks/1056694380553043968/PAK2od0nBUAM4psOgcQLRVSfghVyZNx0EKlqyv9ktns5i-5Z6e9Sxm9Od7Wwbh6sMdTo',
    ['death'] = 'https://discord.com/api/webhooks/1056694551210893412/op7Gk-FwLov4AY8ozxYuWLCRkd6uAseto-aninFeyhukz-lNh8a_94Uil46Lz4Tjk6ev',
    ['joinleave'] = 'https://discord.com/api/webhooks/1056694760036900944/BZMBCAUa4Y2IV3jAa8L_udCCqTmUejgG0yx1Xd8eZYTqrd-omafMcIRThbu_TTx0I35v',
    ['ooc'] = 'https://discord.com/api/webhooks/1056694951775322152/UP-XiLSfEo7kZ4YtNBX1rO8WeLHfUPKyIi0uxjOGkeJ7GRcu1dWT5Tx-O1rocWbIQ2z-',
    ['report'] = 'https://discord.com/api/webhooks/1056695414339928114/QL2CTAz5gpN2LeT1_4d56WZl-aiWmK5tl28KcoklaLt-6x2GUoGskfw8sQbfrXbe7zBi',
    ['me'] = 'https://discord.com/api/webhooks/1056696440212176906/bBPyfkbmqbYeU5RfQsyhXe0yphiF8H3SWEkt0nCgd4cUv_TH_EzA1C0bxWdpyi_Yy95d',
    ['pmelding'] = 'https://discord.com/api/webhooks/1056698003953557546/6oUXqu2Edg-oKEHKv19J_WtxyB2Cie3-Zn9Hvl1Q3-bYIszMw3_XHSJux2c9tHpZz5cL',
    ['112'] = 'https://discord.com/api/webhooks/1056698195394183268/gjDSADozW5GiOvvVeq6jdhgSq6k-on2Izi4PDxQBCLlnWP-7JrG5h79CxzV9Cef0IR_a',
    ['bans'] = 'https://discord.com/api/webhooks/1056699664746958910/eyfpE463Mt8SXy6kLS3qf1tfWp3yRcnD_1amXI1JUIMCqqFcEaugEyJwKCCUh9nCSDK-',
    ['anticheat'] = 'https://discord.com/api/webhooks/1056700703067885689/WU5i6PHb45frAlKZEnO4QPUFTfvKLg4CTIbqecHg9GfTREDhgQOqT-lt-HbzZ_ld2nGz',
    ['weather'] = 'https://discord.com/api/webhooks/1056702294609121352/2buG8gceE2ARGJiP01FYhfv0-rU9FtpXmqZWS-A6uT9GbGSUN_sse_h8dnwmZB9HZO4s',
    ['moneysafes'] = 'https://discord.com/api/webhooks/1056703381357469726/Mm7LvKEPTpiEY3NHgyJKoznTmEO0dTgOoz1HHBOCT4yMFC4aQtdALfxJQCa8lz2uyL9L',
    ['bennys'] = 'https://discord.com/api/webhooks/1056704128484659220/R8FgfipsCrjjxN2TNFAGNkE8JHkg_AmmpKCwwQ5wfj2YKknk_6o4utqwhB0tp7ab2SmI',
    ['bossmenu'] = 'https://discord.com/api/webhooks/1056705777764667442/H9EgxYukmGXd2DbuELE_U9I6l9bgAK2C66AFQyTqNKi_cM5MbhqbSyNdcE72IF4VGBOJ',
    ['robbery'] = 'https://discord.com/api/webhooks/1056704936311787561/s77hq4OmsarogdPBZ2oKhOwWQSxdnkzj55lKcG1VpZkwMZRefKxBK0UzpMka3SAlPN_4',
    ['casino'] = 'https://discord.com/api/webhooks/1056706737060708455/-VLx6vEGpzFMM22jJ9jEeQMQm48u-Vf886Q5P-0t0hNMEdgKJC1vVGKSSbYqxldLYG9l',
    ['traphouse'] = 'https://discord.com/api/webhooks/1056707675112611960/MGAjPJnTh9Sv2_b4_ucA-u6EKm8qZNwHDn_AqxQ0K5l-TmEW9jeVyDF4xz4-c03taAgx',
    ['911'] = 'https://discord.com/api/webhooks/1056708292468035756/rBHL3pyxyDmcuN53HJ1FnNJsUUc8tXE3uf2dht0DP-7CuTrtf-1WqxwhMDpEb4aN0HE6',
    ['palert'] = 'https://discord.com/api/webhooks/1056709401702055956/9tOzHkB0ZlUXomouMf-2S3rT9P1zJCQRSem6Kw3XtKstV5w0NdvUBBi14oudi8UKBYLm',
    ['house'] = 'https://discord.com/api/webhooks/1056710140780363856/wZwMiIapQJePQndvBZIREDzaCHQ6js4zESa-oc35G7NcqZh2pmcocDsirm3O7o7N9UGL',
    ['granny'] = 'https://discord.com/api/webhooks/1056711375268888767/HyzIQb7-CdcTDQXRNIqOokWl2ZVm0s09Lk6DvN9prdXcytXGldrVtXWeKiTGV-ggHbCP',
    ['truckrobbery'] = 'https://discord.com/api/webhooks/1056711740424982548/BkvpGzoY4R4TJ61ORE-V36ceR5dC3SVd9kB8PPfh89xGL_fC_wmBk_Rc6LNS_XSLjSD6',
    ['varheist'] = 'https://discord.com/api/webhooks/1069262418049515601/ccf-cVE_MEzAddYTLhUO4qB6gWCqVEUYiAFFTvNFVQ7K_NRh9q2BhisU0oQN_ootYzhN',
    ['hunting'] = '',
    ['gamble'] = '',
    ['scenes'] = 'https://discord.com/api/webhooks/1133407305308835911/fCjl0HEqG6kOWTS_w7QiZUFPrp9xuIIaDkSh6nALb1CpWcnMuk69kZ4ZQ4xRPFP6fcxr',
    ['gundrop'] = 'https://discord.com/api/webhooks/1128986456363380796/cEfgrnxV7k6BwsLkf5uvR7X2EbSJ0SNl0o1wX4roF5fOMzNIa0ZZIZRUKbmrT05-bnse',
    ['gangmenu'] = 'https://discord.com/api/webhooks/1120791315655958619/TulGRq1ZIcCvztXTbBhzyrr4f8wt0ZkIIhQbvpRkhj7ebH_aoUOIDOJsJV-dVbQbv7BK',
    ['warehouse'] = 'https://discord.com/api/webhooks/1105159127828799659/xqF61uXeA0tPwGqDHmc6pU3Uw6lhJd77R7AcT8oTMw3UpdavkpsrKM4qYlnHQccFevkq',
    ['pdarmory'] = 'https://discord.com/api/webhooks/1174648525221543967/kPvW7buYTM93kcn2krjXWLVCUgq5zUOIOoz8JTMA-zHffJOJCJ6C61Kb-9b0wWLoW4kH',
    ['evidence'] = 'https://discord.com/api/webhooks/1174654926333411409/xHhiu0zLEkqZWmEwOwcF2GCNP3EwspSxZWBY5qUgrRHmL_8GI0AgTc34u-W0Yuu2fvqO',
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'QBCore Logs',
                ['icon_url'] = 'https://media.discordapp.net/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png?width=670&height=670',
            },
        }
    }
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function()
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')