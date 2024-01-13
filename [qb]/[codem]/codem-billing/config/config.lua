Config = {}

Config.Framework = 'qb' -- esx, oldesx, qb, oldqb
Config.SQL = "oxmysql"  -- oxmysql, ghmattimysql, mysql-async
Config.newManagementSystem = false -- true is qb-banking false qb-managment
Config.CreateJobAccount = true -- is only for qb-banking, if there is no data for profession in sql, it creates automatically
Config.ExampleProfilePicture = "https://cdn.discordapp.com/attachments/983471660684423240/1147567519712940044/example-pp.png"

Config.Bills = {
    ["police"] = {
        {
            label = "Traffic Violation Ticket",
            amount = 100,
        },
        {
            label = "Parking Violation Ticket",
            amount = 50,
        },
        {
            label = "Reckless Driving Ticket",
            amount = 200,
        },
    },
    ["ambulance"] = {
        {
            label = "Traffic Violation Ticket",
            amount = 100,
        },
        {
            label = "Parking Violation Ticket",
            amount = 50,
        },
        {
            label = "Reckless Driving Ticket",
            amount = 200,
        },

    },
    ["mechanic"] = {
        {
            label = "Traffic Violation Ticket",
            amount = 100,
        },
        {
            label = "Parking Violation Ticket",
            amount = 50,
        },
        {
            label = "Reckless Driving Ticket",
            amount = 200,
        },
        {
            label = "Traffic Violation Ticket",
            amount = 100,
        },
        {
            label = "Parking Violation Ticket",
            amount = 50,
        },
        {
            label = "Reckless Driving Ticket",
            amount = 200,
        },
    },
}

Config.UsableItem = "" -- leave blank or set to false to disable item name | item control for open menu
Config.EnableRegisterKeyMapping = true
Config.EnableRegisterKeyMappingKey = "Y"

--[[
    if set to true adjust the keys down below by referencing this url
    -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

    if set to false adjust the keys down below by referencing this url
    -- https://docs.fivem.net/docs/game-references/controls/

]]
--

Config.OpenBillMenu = 246                --- job menu open key  Y

Config.HowManyDays = 7                   -- after how many days will it double
Config.Tax = 0.18                        -- 18% tax

Config.SendInvoiceAsStaffAccount = false --  true can send invoices as a staff account.  -- false  cannot send invoices as a staff account

Config.AllowBillingJobs = {
    ['police'] = 'Police',
    ['ambulance'] = 'EMS',
    ['mechanic'] = 'Mechanic'
}

Config.SearchPlayerBills = {
    ['police'] = 'Police',
    ['ambulance'] = 'EMS',
    ['mechanic'] = 'Mechanic'
}

Config.Admin = {
    -- ['CNQ25429'] = true, -- citizen id or steam or license

}

Config.NotificationText = {
    ['paybill'] = {
        text = "%s paid their bill of %s $",
        type = "success"
    },
    ['notacces'] = {
        text = "You do not have access to this property",
        type = "error"
    },
    ['cancelledbill'] = {
        text = "Cancelled bill.",
        type = "error"
    },
    ['wrongbillid'] = {
        text = "Wrong bill id.",
        type = "error"
    },
    ['paidbill'] = {
        text = "This bill has already been paid.",
        type = "error"
    },
    ['notowner'] = {
        text = "You are not the owner of this property",
        type = "success"
    },
    ['notmoney'] = {
        text = "You do not have enough money",
        type = "error"
    },
    ['undefinedjob'] = {
        text = "The billing address cannot be found so you cannot make a lump sum payment",
        type = "error"
    },
    ['errormoney'] = {
        text = "An error occurred while paying the bill",
        type = "error"
    },
    ['notfoundjobvault'] = {
        text = "The billing address cannot be found so you cannot make a lump sum payment",
        type = "error"
    },
    ['notfindplayer'] = {
        text = " Player not found",
        type = "error"
    },
    ['notbillyour'] = {
        text = "This bill does not belong to you",
        type = "error"
    },
    ['writeid'] = {
        text = "You need to write the person to be invoiced.",
        type = "error"
    },
    ['amountinvoice'] = {
        text = "Write the amount of the invoice..",
        type = "error"
    },
    ['reasonsection'] = {
        text = "Fill in the Reason section.",
        type = "error"
    },
    ['createbill'] = {
        text = "%s sent you a bill for %s $.",
        type = "success"
    },
    ['createdbill'] = {
        text = "You sent %s a bill for %s $.",
        type = "success"
    },
    ['offlinenotplayer'] = {
        text = "We not found player data",
        type = "error"
    },
    ['beforewait'] = {
        text = "Please wait before sending another request.",
        type = "error"
    },
    ['notallowpersonelaccount'] = {
        text = "You cannot send an invoice from your personal account.",
        type = "error"
    },
    ['noypaybill'] = {
        text = "does not have any invoice",
        type = "error"
    },
}



Config.Notification = function(message, type, isServer, src) -- You can change here events for notifications
    if isServer then
        if Config.Framework == "esx" then
            TriggerClientEvent("esx:showNotification", src, message)
        else
            TriggerClientEvent('QBCore:Notify', src, message, type, 1500)
        end
    else
        if Config.Framework == "esx" then
            TriggerEvent("esx:showNotification", message)
        else
            TriggerEvent('QBCore:Notify', message, type, 1500)
        end
    end
end
