QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	unemployed = { label = 'Civilian', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Freelancer', payment = 50 } } },
	bus = { label = 'Bus', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Driver', payment = 180 } } },
	judge = { label = 'Honorary', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Judge', payment = 800 } } },
	lawyer = { label = 'Law Firm', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Associate', payment = 175 } } },
	reporter = { label = 'Reporter', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Journalist', payment = 175 } } },
	trucker = { label = 'Trucker', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Driver', payment = 50 } } },
	tow = { label = 'Towing', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Driver', payment = 200 } } },
	garbage = { label = 'Garbage', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Collector', payment = 200 } } },
	vineyard = { label = 'Vineyard', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Picker', payment = 200 } } },
	hotdog = { label = 'Hotdog', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Sales', payment = 200 } } },

	police = {
		label = 'Law Enforcement',
		type = 'leo',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 800 },
			['1'] = { name = 'Solo Cadet', payment = 800 },
			['2'] = { name = 'Officer', payment = 900 },
			['3'] = { name = 'Senior Officer', payment = 950 },
			['4'] = { name = 'Corporal', payment = 1000 },
			['5'] = { name = 'Sergeant', payment = 1100 },
			['6'] = { name = 'Lieutenant', payment = 1200 },
			['7'] = { name = 'Captain', payment = 1300 },
			['8'] = { name = 'Assistant Chief', isboss = true, payment = 1400 },
			['9'] = { name = 'Chief of Police', isboss = true, payment = 1500 },
		},
	},
	ambulance = {
		label = 'EMS',
		type = 'ems',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Trainee', payment = 50 },
			['1'] = { name = 'EMT', payment = 75 },
			['2'] = { name = 'Therapist', payment = 100 },
			['3'] = { name = 'Nurse', payment = 125 },
			['4'] = { name = 'Surgeon', payment = 75 },
			['5'] = { name = 'Paramedic', payment = 100 },
			['6'] = { name = 'Lieutenant', payment = 125 },
			['7'] = { name = 'Captain', payment = 125 },
			['8'] = { name = 'Assistant Chief', isboss = true, payment = 150 },
			['9'] = { name = 'Chief of EMS', isboss = true, payment = 150 },
		},
	},
	
	senator = {
		label = 'Government',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Executive', payment = 250 },
			['1'] = { name = 'Senior Executive', payment = 450 },
			['2'] = { name = 'Public Administrator', payment = 600 },
			['3'] = { name = 'Deputy Senator', payment = 700 },
			['4'] = { name = 'Senator', isboss = true, payment = 1000 },
		},
	},
	cookies = {
		label = 'Cookies',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Farmer', payment = 250 },
			['1'] = { name = 'Shopkeeper', payment = 450 },
			['2'] = { name = 'Shopkeeper', payment = 600 },
			['3'] = { name = 'Manager', payment = 700 },
			['4'] = { name = 'Owner', isboss = true, payment = 1000 },
		},
	},
	realestate = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 250 },
			['1'] = { name = 'House Sales', payment = 450 },
			['2'] = { name = 'Business Sales', payment = 600 },
			['3'] = { name = 'Broker', payment = 700 },
			['4'] = { name = 'Manager', isboss = true, payment = 1000 },
		},
	},
	burgershot = {
		label = 'Burgershot',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Trainee', payment = 900 },
			['1'] = { name = 'Employee', payment = 1000 },
			['2'] = { name = 'Burger Flipper', payment = 1200 },
			['3'] = { name = 'Manager', payment = 1300 },
			['4'] = { name = 'Owner', isboss = true, payment = 1400 },
		},
	},
	taco = {
		label = 'Taco',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Trainee', payment = 900 },
			['1'] = { name = 'Employee', payment = 1000 },
			['2'] = { name = 'Burger Flipper', payment = 1200 },
			['3'] = { name = 'Manager', payment = 1300 },
			['4'] = { name = 'Owner', isboss = true, payment = 1400 },
		},
	},
	uwu = {
		label = 'UwU Cat Cafe',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Trainee', payment = 900 },
			['1'] = { name = 'Employee', payment = 1000 },
			['2'] = { name = 'Experienced', payment = 1200 },
			['3'] = { name = 'Manager', payment = 1300 },
			['4'] = { name = 'Owner', isboss = true, payment = 1400 },
		},
	},
	taxi = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Driver', payment = 0 },
			--[[ ['1'] = { name = 'Driver', payment = 250 },
			['2'] = { name = 'Event Driver', payment = 350 },
			['3'] = { name = 'Sales', payment = 450 },
			['4'] = { name = 'Manager', isboss = true, payment = 550 }, ]]
		},
	},
	cardealer = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 250 },
			['1'] = { name = 'Showroom Sales', payment = 350 },
			['2'] = { name = 'Business Sales', payment = 450 },
			['3'] = { name = 'Finance', payment = 550 },
			['4'] = { name = 'Manager', isboss = true, payment = 650 },
		},
	},
	mechanic = {
		label = 'LS Customs',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 600 },
			['1'] = { name = 'Novice', payment = 700 },
			['2'] = { name = 'Experienced', payment = 800 },
			['3'] = { name = 'Advanced', payment = 900 },
			['4'] = { name = 'Manager', isboss = true, payment = 1200 },
		},
	},
	--[[ mechanic2 = {
		label = 'LS Customs',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	mechanic3 = {
		label = 'LS Customs',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	}, ]]
	beeker = {
		label = 'Beeker\'s Garage',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	bennys = {
		label = 'Benny\'s Original Motor Works',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
}
