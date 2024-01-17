Config = {}

-- $$$$$$\   $$$$$$\  $$\   $$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$\   $$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\ 
--$$  __$$\ $$  __$$\ $$$\  $$ |$$  _____|\_$$  _|$$  __$$\ $$ |  $$ |$$  __$$\ $$  __$$\\__$$  __|\_$$  _|$$  __$$\ $$$\  $$ |
--$$ /  \__|$$ /  $$ |$$$$\ $$ |$$ |        $$ |  $$ /  \__|$$ |  $$ |$$ |  $$ |$$ /  $$ |  $$ |     $$ |  $$ /  $$ |$$$$\ $$ |
--$$ |      $$ |  $$ |$$ $$\$$ |$$$$$\      $$ |  $$ |$$$$\ $$ |  $$ |$$$$$$$  |$$$$$$$$ |  $$ |     $$ |  $$ |  $$ |$$ $$\$$ |
--$$ |      $$ |  $$ |$$ \$$$$ |$$  __|     $$ |  $$ |\_$$ |$$ |  $$ |$$  __$$< $$  __$$ |  $$ |     $$ |  $$ |  $$ |$$ \$$$$ |
--$$ |  $$\ $$ |  $$ |$$ |\$$$ |$$ |        $$ |  $$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |  $$ |     $$ |  $$ |  $$ |$$ |\$$$ |
--\$$$$$$  | $$$$$$  |$$ | \$$ |$$ |      $$$$$$\ \$$$$$$  |\$$$$$$  |$$ |  $$ |$$ |  $$ |  $$ |   $$$$$$\  $$$$$$  |$$ | \$$ |
 --\______/  \______/ \__|  \__|\__|      \______| \______/  \______/ \__|  \__|\__|  \__|  \__|   \______| \______/ \__|  \__|

--Use "esx" or "qb"
Config.Framework = "qb"
--If you are using one of the most recent versions of ESX, set the script name. Default = "es_extended"
Config.ESXExport = ""
--Default ESX: "esx:getSharedObject" | Default QB: "qb-core"
Config.Core = "qb-core"
-- Money delivered after 6 hours
Config.sixhours = 100000 
-- Money delivered after 5 hours
Config.fivehours = 75000 
-- Money delivered after 4 hours
Config.fourhours = 55000 
-- Money delivered after 3 hours
Config.threehours = 40000 
-- Money delivered after 2 hours
Config.twohours = 25000 
-- Money delivered after 1 hours
Config.onehour = 10000
-- Type of currency used 
Config.currency = "$" 
-- Command to open investments menu
Config.investmentsCommand = "invest" 
-- 1 for 1 hour, 2 for 2 hours, 3 for 3 hours,... Max. 6. For testing you can use 7, it is for 20 seconds
Config.defaultTime = 2 
-- url of the discord webhook where the logs will be received
Config.webhook = "" 
