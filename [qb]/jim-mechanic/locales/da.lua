Loc = Loc or {}

Loc["da"] = {
	common = { -- almindeligt anvendte strenge
		owned = "Køretøjet er ikke ejet, kan ikke ændres",
		close = "Luk",
		ret = "Returner",
		stock = "Standard", -- Standard, Originalt, hvad end ord du bruger for dette
		current = "Aktuelt Installeret",
		noOptions = "Ingen tilgængelige indstillinger for denne genstand",
		notinstall = "Ikke installeret",
		installing = "Installerer ",
		installed = "Installeret!",
		instfail = " installation mislykkedes!",
		removed = "Fjernet!",
		removing = "Fjerner ",
		remfail = " fjernelse mislykkedes!",
		cant = "Kan ikke installeres på dette køretøj",
		amountoption = "Antal indstillinger: ",
		already = " allerede installeret", -- fx "Standard kofanger allerede installeret"
		menuinstalled = " Indstillinger] Installeret: ", -- fx "[4 Indstillinger] Installeret: Kofanger 1"
		nearwheel = "Du skal bevæge dig tættere på et hjul",
		nearengine = "Du skal bevæge dig tættere på motoren",
		closer = "Bevæg dig tættere på forlygterne",
		harness = "Fæster racingsele..",
	},
    progressbar = {
        progress_washing = "Washing hands",
        progress_mix = "Mixing a ",
        progress_pour = "Pouring a ",
        progress_drink = "Drinking a ",
        progress_eat = "Eating a ",
        progress_make = "Making a ",
    },
	error = {
		not_clockedin = "Not On Duty",
		cancelled = "Cancelled",
	},
	tires = {
		swap = "Skudsikker-dæk fjernet!",
		swap2 = "Drift-dæk fjernet!",
	},
	xenons = {
		notinstall = "Xenon-forlygter ikke installeret",
		-- Menus
		neonheader1 = "Lyskontrol",
		neonheader2 = "Underglow Lyskontrol",
		neonheader3 = "Underglow Farvekontrol",
		neonheader4 = "Xenon Forlygter Kontrol",
		customheader = "Brugerdefineret RGB",
		customconfirm = "ANVEND",
		neontxt1 = "Fin kontrol af neonbelysning",
		toggle = "Aktiver/deaktiver ALLE",
		front = "Foran",
		right = "Højre",
		left = "Venstre",
		back = "Bag",
		neontxt2 = "Ændr Underglow Farve",
		xenonheader = "Xenon Kontrol",
		xenontxt = "Justér farven på køretøjets forlygter",
	},

	-- Kosmetiske genstande
	bumpers = {
		menugrille = "Kølergrill",
		menuFBumper = "Forreste kofanger",
		menuBBumper = "Bageste kofanger",
	},
	exhaust = {
		menuheader = "Udstødningsmodifikation",
	},
	exterior = {
		stockMod = "Standard eksteriørmodifikation..",

		label1 = "Trim A",
		label2 = "Trim B",
		label3 = "Bagagerum",
		label4 = "Motorblok",
		label5 = "Filter",
		label6 = "Støddæmpere",
		label7 = "Hydraulik",
		label8 = "Skærmovertræk",
		label9 = "Brændstoftanke",
		label10 = "Antenner",
	},
	hood = {
		menuheader = "Motorhjelmsmodifikation",
	},
	horns = {
		menuheader = "Dysermodifikation",
	},
	interior = {
		label1 = "Rullebøjler",
		label2 = "Ornamenter",
		label3 = "Instrumentbræt",
		label4 = "Målere",
		label5 = "Dørhøjttalere",
		label6 = "Rat",
		label7 = "Gearstang",
		label8 = "Plader",
		label9 = "Højttalere",
	},
	livery = {
		oldMod = "gammel",
		menuheader = "Livery-modifikation",
		menuoldheader = "Taglivery-modifikation",
	},
	nos = {
		notinstalled = "Turbo er ikke installeret",

		nosColour = "NOS-purgefarve",
		boostmode = "Boost-tilstand",
		purgemode = "Purge-tilstand",
		boost = "Boost-kraft: ",
		spray = "Spray-styrke: ",
	},

	paint = {
		primary = "Primær",
		secondary = "Sekundær",
		pearl = "Perlemor",
		wheel = "Hjul",
		dashboard = "Instrumentbræt",
		interior = "Interiør",

		classic = "Klassisk",
		metallic = "Metallic",
		matte = "Mat",
		metals = "Metaller",
		chameleon = "Kameleon",

		menuheader = " Omlakering",
	},
	paintrgb = {
		select = "Valg:",
		finish = "Afslut valg:",
		error = "Hex-kode skal være 6 tegn",
		customheader = "Brugerdefineret HEX og RGB",
		chrome = "Krom",
		hexP = "HEX-vælger",
		rgbP = "RGB-vælger",
	},
	plates = { --paints.lua
		label1 = "Nummerpladeholder",
		label2 = "Vanity-nummerplader",
		label3 = "Brugerdefinerede nummerplader",
	},
	rims = {
		menuheader = "Fælge menu",

		label1 = "Sport",
		label2 = "Muskel",
		label3 = "Lowrider",
		label4 = "SUV",
		label5 = "Offroad",
		label6 = "Tuner",
		label7 = "Highend",
		label8 = "Benny's Originals",
		label9 = "Benny's Bespoke",
		label10 = "Open Wheel",
		label11 = "Gade",
		label12 = "Bane",
		label13 = "Forhjul",
		label14 = "Baghjul",
		label15 = "Motorcykel",

		labelcustom = "Special fælge",
	},
	rollcage = {
		menuheader = " Rullebur Modifikation",
	},
	roof = {
		menuheader = " Tag Modifikation",
	},
	seat = {
		menuheader = " Sæde Modifikation",
	},
	skirts = {
		menuskirt = "Skørter",
		menuRF = "Højre skærm",
		menuLF = "Venstre skærm",
	},
	spoilers = {
		menuheader = " Spoiler Modifikation",
	},
	smoke = {
		already = "Denne farver vises nu!",
		menuheader = " Dæk røg Modifikation",

		remove = "Fjern røg",
		custom = "CUSTOM RBG",
		black = "Sort",
		white = "Hvid",
		blue = "Blå",
		eblue = "Elektrisk blå",
		mgreen = "Mynte grøn",
		lgreen = "Lime grøn",
		yellow = "gul",
		gshower = "Gyldent bad",
		orange = "Orange",
		red = "Rød",
		ppink = "Pony Pink",
		hpink = "Varm Pink",
		purple = "Lilla",
		blacklight = "Sortlys",
	},
	windows = {
		menuheader = " Rudefilm",
	},
	stores = {
		browse = "Gennemse Butik",
		tools = "Mekaniker Værktøj",
		perform = "Performance Genstande",
		cosmetic = "Kosmetiske Genstande",
		repLufts = "Reparationsgenstande",
		nos = "NOS Genstande",
	},
	crafting = {
		menuheader = "Mekaniker Crafting",
		toolheader = "Mekaniker Værktøj",
		repLuftheader = "Reparationsgenstande",
		performheader = "Performance Genstande",
		cosmetheader = "Kosmetiske Genstande",
		nosheader = "NOS Genstande",
		numitems = " genstande", --for menu. fx "11 genstande"
	},
	payments = {
		charge = "Opkræv Kunde",
	},

	check = {
		plate = "Nummerplade:",
		value = "Værdi: $",
		unavail = "❌ Ikke tilgængelig",

		label1 = "Motorer:",
		label2 = "Bremser:",
		label3 = "Affjedring:",
		label4 = "Transmission:",
		label5 = "Panser:",
		label6 = "Turbo:",
		label7 = "Xenon:",
		label8 = "Drift Dæk:",
		label9 = "Kuglesikre Dæk:",
		label10 = "Liste over Mulige Kosmetiske Genstande",
		label11 = "Køretøj: ",

		label12 = "muligheder",
		label13 = "Eksterne Kosmetiske Genstande -",
		label14 = "Interne Kosmetiske Genstande - ",
		label15 = "Spoilers - [ ",
		label16 = "Front Bumpers - [ ",
		label17 = "Bag Bumpers - [ ",
		label18 = "Nederdele - [ ",
		label19 = "Udstødninger - [ ",
		label20 = "Griller - [ ",
		label21 = "Motorhjelme - [ ",
		label22 = "Venstre Skærm - [ ",
		label23 = "Højre Skærm - [ ",
		label24 = "Tag - [ ",
		label25 = "Nummerplade Holdere - [ ",
		label26 = "Skæmtplader - [ ",
		label27 = "Trim A - [ ",
		label28 = "Trim B - [ ",
		label29 = "Bagskabe - [ ",
		label30 = "Motorblokke - [ ",
		label31 = "Luftfiltre - [ ",
		label32 = "Motorstiver - [ ",
		label33 = "Hjulkapsler - [ ",

		label34 = "Rullebure - [ ",
		label35 = "Ornamenter - [ ",
		label36 = "Instrumentbrætter - [ ",
		label37 = "Målere - [ ",
		label38 = "Dørhøjttalere - [ ",
		label39 = "Sæder - [ ",
		label40 = "Rat - [ ",
		label41 = "Gearstænger - [ ",
		label42 = "Plaketter - [ ",
		label43 = "Højttalere - [ ",
		label44 = "Hydraulik - [ ",
		label45 = "Antenner - [ ",
		label46 = "Brændstoftanke - [ ",
		label47 = "Ja",
		label48 = "Nej",
		label49 = "Vil du fjerne ",
		label50 = "Anti-lag:",
		label51 = "Seler:",
		label53 = "Livery - [ ",
		label58 = "Nitrous:",
	},
	repair = {
		browse = "Gennemse lager",
		materials = "Du har ikke nok materialer",
		checkeng = "Kontroller motorskader..",
		checkbody = "Kontroller karosseriskader..",

		engine = "Motor",
		body = "Karrosseri",
		oil = "Olie Niveau",
		driveshaft = "Drevaksel",
		spark = "Tændrør",
		battery = "Bilbatteri",
		tank = "Brændstoftank",
		replacetire = "Udskift Dæk",
		tire = "Hjul",

		repairing = "Reparerer ",
		changing = "Skifter ",
		repaired = " fuldt repareret",
		cancel = " Reperation annulleret!",
		nomaterials = "Der er ikke nok materialer på lager",

		cost = "Pris: ",
		status = "Status: ",
		doyou = "Vil du reparere ",

		applyduct = "Anvender Gaffatape..",
		ductfull = "Du kan ikke bruge mere gaffatape på denne bil",
		nocar = "Der er ingen køretøjer i nærheden",
	},
	police = {
		header = "Værkstedbord",
		userepair = "Brug værkstedsbord",
		repair = "Reperation",
		extras = "Ekstraudstyr",
		plates = "Nummerplader",
		livery = "Livery",
		spoiler = "Spoilers",
		cleaning = "Renser køretøjet...",
		engine = "Reparerer motor...",
		body = "Reparerer karrosseri...",
		complete = "Reparation fuldført",
		restrict = "Kun for nødkøretøjer",
	},
	manual = {
		tyres = "Udskifter beskadigede dæk",
		window = "Fjerner beskadigede ruder",
		doors = "Reparerer døre",
	},

	carwax = {
		head1 = "Rengør Køretøj",
		head2 = "Rengør og Voks",
		head3 = "Rengør og Premium Voks",
		head4 = "Rengør og Ultimate Voks",
	},
	extras = {
		clean = "Køretøj Renset",
		doorerr = "Dørfejl",
		locked = "Køretøjsdøre Låst",
		flipping = "Vender Køretøj",
		flipped = "Succes! Køretøj vendt",
		failed = "Fejl ved køretøjsvending!",
		noseat = "Intet sædenummer indtastet",
		moveseat = "Du flytter til sæde ",
		fastseat = "Dette køretøj bevæger sig for hurtigt..",
		notseat = "Dette sæde er ikke tilgængeligt..",
		harness = "Du har en racerseler på, du kan ikke skifte..",
	},
	functions = {
		distance = "Afstand: ",
		inCar = "Kan ikke gøre dette inde fra køretøjet",
		outCar = "Kan ikke gøre dette uden for køretøjet",
		locked = "Køretøjet er låst",
		nearby = "Der er ingen køretøjer i nærheden",
		shop = "Kan ikke arbejde uden for en butik",
		mechanic = "Kun en mekaniker ved, hvordan man gør dette",
		checking = "Tjekker Gemme.."
	},
	servfunction = {
		checkdamage = "Tjek køretøjet for skader",
		checkmods = "Tjek mods tilgængelige på et køretøj",
		flipvehicle = "Vend nærmeste køretøj",
		togglesound = "Aktivér opgraderede motorsound",
		togglesoundesc = "Indstil opgraderede motorsound TIL eller FRA",
		cleancar = "Rengør bilen",
		hood = "Åbn/Luk Motorhjelm",
		trunk = "Åbn/Luk bagagerum",
		door = "Åbn/Luk Dør [0-3]",
		seat = "Flyt til en anden sæde [-1 til 10]",
	},
	previews = {
		changes = "Antal ændringer: ",
		previewing = "Kan ikke gøre dette under forhåndsvisning",
	},
	stancer = {
		wheel_lf = "Venstre forhjul",
		wheel_rf = "Højre forhjul",
		wheel_lr = "Venstre baghjul",
		wheel_rr = "Højre baghjul",
		wheel_lm1 = "Venstre midterste (1) hjul",
		wheel_rm1 = "Højre midterste (1) hjul",
		wheel_lm2 = "Venstre midterste (2) hjul",
		wheel_rm2 = "Højre midterste (2) hjul",
		wheel_lm3 = "Venstre midterste (3) hjul",
		wheel_rm3 = "Højre midterste (3) hjul",
		spacer = "Spacer",
		camber = "Camber",
		width = "Bredde",
		size = "Størrelse",
		suspens = "Juster affjedring",
		stance = "Stance",
		reset = "Nulstil Hjul",
	},
	--Below are names of items/mods that can't be reteived natively
	vehicleWindowOptions = {
		{ name = "Taxi", id = 4 },
		{ name = "Grønlig", id = 5 },
		{ name = "Lidt røget", id = 3 },
		{ name = "Mørk røget", id = 2 },
		{ name = "Helt sort", id = 1 }
	},
	vehiclePlateOptions = {
		{ name = "Blå på hvid #1", id = 0 },
		{ name = "Blå på hvid #2", id = 3 },
		{ name = "Blå på hvid #3", id = 4 },
		{ name = "Gul på blå", id = 2 },
		{ name = "Gul på sort", id = 1 },
		{ name = "North jylland", id = 5 },
	},
	vehicleNeonOptions = {
		{ name = "Hvid", R = 255, G = 255, B = 255 },
        { name = "Blå", R = 2, G = 21, B = 255 },
        { name = "Elektrisk blå", R = 3, G = 83, B = 255 },
        { name = "Mynte grøn", R = 0, G = 255, B = 140 },
        { name = "Lime grøn", R = 94, G = 255, B = 1 },
        { name = "Gul", R = 255, G = 255, B = 0 },
        { name = "Gyldent bad", R = 255, G = 150, B = 0 },
        { name = "Orange", R = 255, G = 62, B = 0 },
        { name = "Rød", R = 255, G = 1, B = 1 },
        { name = "Pony Pink", R = 255, G = 50, B = 100 },
        { name = "Varm Pink", R = 255, G = 5, B = 190 },
        { name = "Lilla", R = 35, G = 1, B = 255 },
        { name = "Sortlys", R = 15, G = 3, B = 255 }
	},
	vehicleHorns = {
		{ name = "Lastbil Horn", id = 0 },
		{ name = "Politi Horn", id = 1 },
		{ name = "Klovne Horn", id = 2 },
		{ name = "musik Horn 1", id = 3 },
		{ name = "musik Horn 2", id = 4 },
		{ name = "musik Horn 3", id = 5 },
		{ name = "musik Horn 4", id = 6 },
		{ name = "musik Horn 5", id = 7 },
		{ name = "træk basun", id = 8 },
		{ name = "klassisk Horn 1", id = 9 },
		{ name = "klassisk Horn 2", id = 10 },
		{ name = "klassisk Horn 3", id = 11 },
		{ name = "klassisk Horn 4", id = 12 },
		{ name = "klassisk Horn 5", id = 13 },
		{ name = "klassisk Horn 6", id = 14 },
		{ name = "klassisk Horn 7", id = 15 },
		{ name = "Skala - Do", id = 16 },
		{ name = "Skala - Re", id = 17 },
		{ name = "Skala - Mi", id = 18 },
		{ name = "Skala - Fa", id = 19 },
		{ name = "Skala - Sol", id = 20 },
		{ name = "Skala - La", id = 21 },
		{ name = "Skala - Ti", id = 22 },
		{ name = "Skala - Do", id = 23 },
		{ name = "Jazz Horn 1", id = 24 },
		{ name = "Jazz Horn 2", id = 25 },
		{ name = "Jazz Horn 3", id = 26 },
		{ name = "Jazz Horn Loop", id = 27 },
		{ name = "Star Spangled Banner 1", id = 28 },
		{ name = "Star Spangled Banner 2", id = 29 },
		{ name = "Star Spangled Banner 3", id = 30 },
		{ name = "Star Spangled Banner 4", id = 31 },
		{ name = "klassisk Horn 8 Loop", id = 32 },
		{ name = "klassisk Horn 9 Loop", id = 33 },
		{ name = "klassisk Horn 10 Loop", id = 34 },
		{ name = "klassisk Horn 8", id = 35 },
		{ name = "klassisk Horn 9", id = 36 },
		{ name = "klassisk Horn 10", id = 37 },
		{ name = "Begravelse Loop", id = 38 },
		{ name = "Begravelse", id = 39 },
		{ name = "Spooky Loop", id = 40 },
		{ name = "Spooky", id = 41 },
		{ name = "San Andreas Loop", id = 42 },
		{ name = "San Andreas", id = 43 },
		{ name = "Liberty City Loop", id = 44 },
		{ name = "Liberty City", id = 45 },
		{ name = "Festligt 1 Loop", id = 46 },
		{ name = "Festligt 1", id = 47 },
		{ name = "Festligt 2 Loop", id = 48 },
		{ name = "Festligt 2", id = 49 },
		{ name = "Festligt 3 Loop", id = 50 },
		{ name = "Festligt 3", id = 51 },
		{ name = "Luft Horn 1 Loop", id = 52},
		{ name = "Luft Horn 1", id = 53},
		{ name = "Luft Horn 2 Loop", id = 54},
		{ name = "Luft Horn 2", id = 55},
		{ name = "Luft Horn 3 Loop", id = 56},
		{ name = "Luft Horn 3", id = 57},
	},
	vehicleResprayOptionsClassic = {
		{ name = "Sort", id = 0 },
		{ name = "Karbon sort", id = 147 },
		{ name = "Grafit", id = 1 },
		{ name = "Anhracite Sort", id = 11 },
		{ name = "Sort stål", id = 2 },
		{ name = "Mørkt stål", id = 3 },
		{ name = "Sølv", id = 4 },
		{ name = "Børstet sølv", id = 5 },
		{ name = "Rullet stål", id = 6 },
		{ name = "Skygge sølv", id = 7 },
		{ name = "Sten sølv", id = 8 },
		{ name = "Midnats sølv", id = 9 },
		{ name = "Jern sølv", id = 10 },
		{ name = "Rød", id = 27 },
		{ name = "Torino Rød", id = 28 },
		{ name = "Formula Rød", id = 29 },
		{ name = "Lava Rød", id = 150 },
		{ name = "Blaze Rød", id = 30 },
		{ name = "Grace Rød", id = 31 },
		{ name = "Garnet Rød", id = 32 },
		{ name = "Solnedgangs Rød", id = 33 },
		{ name = "Cabernet Rød", id = 34 },
		{ name = "Vin rød", id = 143 },
		{ name = "Slik rød", id = 35 },
		{ name = "Varm Pink", id = 135 },
		{ name = "Pfsiter Pink", id = 137 },
		{ name = "Lakse Pink", id = 136 },
		{ name = "Solopgangs Orange", id = 36 },
		{ name = "Orange", id = 38 },
		{ name = "Lys Orange", id = 138 },
		{ name = "Guld", id = 99 },
		{ name = "Bronze", id = 90 },
		{ name = "Gul", id = 88 },
		{ name = "Racer gul", id = 89 },
		{ name = "Gullig", id = 91 },
		{ name = "Mørkegrøn", id = 49 },
		{ name = "Racing grøn", id = 50 },
		{ name = "Sø grøn", id = 51 },
		{ name = "Olivengrøn", id = 52 },
		{ name = "Lys grøn", id = 53 },
		{ name = "Benzin grøn", id = 54 },
		{ name = "Lime grøn", id = 92 },
		{ name = "Midnats blå", id = 141 },
		{ name = "Galaxy blå", id = 61 },
		{ name = "Mørke blå", id = 62 },
		{ name = "Saxon blå", id = 63 },
		{ name = "Blå", id = 64 },
		{ name = "Marine Blå", id = 65 },
		{ name = "Havne Blå", id = 66 },
		{ name = "Diamant Blå", id = 67 },
		{ name = "Surfer blå", id = 68 },
		{ name = "Marine blå", id = 69 },
		{ name = "Racing blå", id = 73 },
		{ name = "Ultra blå", id = 70 },
		{ name = "Lyse blå", id = 74 },
		{ name = "Chocolade Brun", id = 96 },
		{ name = "Bison brun", id = 101 },
		{ name = "Creeen brun", id = 95 },
		{ name = "Feltzer brun", id = 94 },
		{ name = "Maple Brun", id = 97 },
		{ name = "Beechwood Brun", id = 103 },
		{ name = "Sienna Brun", id = 104 },
		{ name = "Saddle Brun", id = 98 },
		{ name = "Moss Brun", id = 100 },
		{ name = "Woodbeech Brun", id = 102 },
		{ name = "Straw Brun", id = 99 },
		{ name = "Sandy Brun", id = 105 },
		{ name = "Bleached Brun", id = 106 },
		{ name = "Schafter Lilla", id = 71 },
		{ name = "Spinnaker Lilla", id = 72 },
		{ name = "Midnight Lilla", id = 142 },
		{ name = "Bright Lilla", id = 145 },
		{ name = "Cream", id = 107 },
		{ name = "Is Hvid", id = 111 },
		{ name = "Frost Hvid", id = 112 },
	},
	vehicleResprayOptionsMatte = {
		{ name = "Sort", id = 12 },
		{ name = "Grå", id = 13 },
		{ name = "Lyse grå", id = 14 },
		{ name = "Ice Hvid", id = 131 },
		{ name = "blå", id = 83 },
		{ name = "Mørk blå", id = 82 },
		{ name = "Midnats blå", id = 84 },
		{ name = "Midnats Lilla", id = 149 },
		{ name = "Schafter Lilla", id = 148 },
		{ name = "Rød", id = 39 },
		{ name = "Mørke rød", id = 40 },
		{ name = "Orange", id = 41 },
		{ name = "Gul", id = 42 },
		{ name = "Lime Grøn", id = 55 },
		{ name = "Grøn", id = 128 },
		{ name = "Skov grøn", id = 151 },
		{ name = "Naturlig grøn", id = 155 },
		{ name = "Oliven farve", id = 152 },
		{ name = "Mørk jord", id = 153 },
		{ name = "Ørken sand", id = 154 },
	},
	vehicleResprayOptionsMetals = {
		{ name = "Børstet stål", id = 117 },
		{ name = "Børstet sort stål", id = 118 },
		{ name = "Børstet aluminium", id = 119 },
		{ name = "Ren guld", id = 158 },
		{ name = "Børstet guld", id = 159 },
		{ name = "krom", id = 120 },
	},
	vehicleResprayOptionsChameleon = {
		{ name = "Anodized Rød", id = 161 },
		{ name = "Anodized Vin", id = 162 },
		{ name = "Anodized Lilla", id = 163 },
		{ name = "Anodized blå", id = 164 },
		{ name = "Anodized Grøn", id = 165 },
		{ name = "Anodized Lime", id = 166 },
		{ name = "Anodized kobber", id = 167 },
		{ name = "Anodized Bronze", id = 168 },
		{ name = "Anodized Champagne", id = 169 },
		{ name = "Anodized Guld", id = 170 },
		{ name = "Grøn/Blå Flip", id = 171 },
		{ name = "Grøn/Rød Flip", id = 172 },
		{ name = "Green/Brown Flip", id = 173 },
		{ name = "Green/Turqoise Flip", id = 174 },
		{ name = "Green/Purple Flip", id = 175 },
		{ name = "Teal/Purple Flip", id = 176 },
		{ name = "Turqoise/Red Flip", id = 177 },
		{ name = "Turqoise/Purple Flip", id = 178 },
		{ name = "Cyan/Purple Flip", id = 179 },
		{ name = "Blue/Pink Flip", id = 180 },
		{ name = "Blue/Green Flip", id = 181 },
		{ name = "Purple/Red Flip", id = 182 },
		{ name = "Pruple/Green Flip", id = 183 },
		{ name = "Magenta/Green Flip", id = 184 },
		{ name = "Magenta/Yellow Flip", id = 185 },
		{ name = "Burgundy/Green Flip", id = 186 },
		{ name = "Magenta/Cyan Flip", id = 187 },
		{ name = "Copper/Purple Flip", id = 188 },
		{ name = "Magenta/Orange Flip", id = 189 },
		{ name = "Red/Orange Flip", id = 190 },
		{ name = "Orange/Purple Flip", id = 191 },
		{ name = "Orange/Blue Flip", id = 192 },
		{ name = "White/Purple Flip", id = 193 },
		{ name = "Red/Rainbow Flip", id = 194 },
		{ name = "Blue/Rainbow Flip", id = 195 },
		{ name = "Dark Green Pearl", id = 196 },
		{ name = "Dark Teal Pearl", id = 197 },
		{ name = "Dark Blue Pearl", id = 198 },
		{ name = "Dark Purple Pearl", id = 199 },
		{ name = "Oil Slick Pearl", id = 200 },
		{ name = "Light Green Pearl", id = 201 },
		{ name = "Light Blue Pearl", id = 202 },
		{ name = "Light Purple Pearl", id = 203 },
		{ name = "Light Pink Pearl", id = 204 },
		{ name = "Off White Pearl", id = 205 },
		{ name = "Pink Pearl", id = 206 },
		{ name = "Yellow Pearl", id = 207 },
		{ name = "Green Pearl", id = 208 },
		{ name = "Blue Pearl", id = 209 },
		{ name = "Cream Pearl", id = 210 },
		{ name = "White Prismatic", id = 211 },
		{ name = "Graphite Prismatic", id = 212 },
		{ name = "Dark Blue Prismatic", id = 213 },
		{ name = "Dark Purple Prismatic", id = 214 },
		{ name = "Hot Pink Prismatic", id = 215 },
		{ name = "Dark Red Prismatic", id = 216 },
		{ name = "Dark Green Prismatic", id = 217 },
		{ name = "Black Prismatic", id = 218 },
		{ name = "Black Oil Spill", id = 219 },
		{ name = "Black Rainbow", id = 220 },
		{ name = "Black Holographic", id = 221 },
		{ name = "White Holographic", id = 222 },
		{ name = "Monochrome", id = 223 },
		{ name = "Night / Day", id = 224 },
		{ name = "Verlierer 2", id = 225 },
		{ name = "Sprunk Extreme", id = 226 },
		{ name = "Vice City", id = 227 },
		{ name = "Synthwave", id = 228 },
		{ name = "Four Seasons", id = 229 },
		{ name = "Maisonette 9 Throwback", id = 230 },
		{ name = "Bubblegum", id = 231 },
		{ name = "Full Rainbow", id = 232 },
		{ name = "Sunsets", id = 233 },
		{ name = "The Seven", id = 234 },
		{ name = "Kamen Rider", id = 235 },
		{ name = "Chrome Abberation", id = 236 },
		{ name = "Its Christmas", id = 237 },
		{ name = "Temperature", id = 238 },
		{ name = "Haos Special Works", id = 239 },
		{ name = "Electro", id = 240 },
		{ name = "Monika", id = 241 },
		{ name = "Fubuki", id = 242 }
	},
}