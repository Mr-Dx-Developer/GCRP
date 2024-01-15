🌟 ᴍᴄᴅᴏɴᴀʟᴅ 🔴🟡🟢

Thanks for showing your personal interest in my work!
Contact Me If You Need Help 

🔗 > https://discord.gg/uNGQk2Z

⌨️🖱🖥 𝕀𝕟𝕤𝕥𝕒𝕝𝕝𝕒𝕥𝕚𝕠𝕟

1. Copy To Resouce Folder

2. Open qb-target and init.lua, put this at boxzone

Config.BoxZones = {

	["McDonald"] =
	 {
        name = "McDonald",
        coords = vector3(95.29, 285.1, 108.99),
        length = 2.6,
        width = 2.8,
        heading = 250,
        debugPoly = false,
		minZ=107.39,
		maxZ=111.39,
        options = {
            {
				type = "client",
                event = "McDonald:open",
                icon = "fa-solid fa-burger",
                label = "Drive Thru",
            },
        },
        distance = 3.5,
    },
}


3. You Can Add Money To Society Find At server/main.lua Just Change It In line 48

   exports['qb-management']:AddMoney("mcdonald", _price)

5. Ensure at server.cfg
6. Restart You Server

🛠 𝔻𝕖𝕡𝕖𝕟𝕕𝕖𝕟𝕔𝕚𝕖𝕤

QB-Core
QB-Target
Polyzone




