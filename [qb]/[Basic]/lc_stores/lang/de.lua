if not Lang then Lang = {} end
Lang['de'] = {
    ['open'] = "Drücke ~y~E~w~ zum Öffnen",
    ['open_target'] = "Eigentümer-Dashboard öffnen",
    ['open_market'] = "Drücke ~y~E~w~ zum Öffnen",
    ['open_market_target'] = "Offener Markt",
    ['download_jobs'] = "Drücke ~y~E~w~ zum Laden von Auftragsdetails",
    ['show_jobs'] = "~y~%s~w~ \nBezahlung: $ %s \nDrücke ~y~E~w~ zum starten",
    ['job_already_in_progress'] = "Dieser Auftrag wird bereits von jemand anderem bearbeitet, versuchen Sie es erneut",
    ['no_available_jobs'] = "Hier sind keine Stellen verfügbar",
    ['cannot_do_own_job'] = "Sie können nicht in Ihrem eigenen Geschäft angestellt werden",
    ['buy_message'] = "Dieser Laden hat keinen Besitzer, wollen Sie ihn für $%s?",
    ['already_has_business'] = "Du hast bereits einen Laden.",
    ['already_has_owner'] = "Dieses Geschäft hat bereits einen Besitzer",
    ['businnes_bougth'] = "Herzlichen Glückwunsch, Sie haben ein Geschäft gekauft",
	['category_max_amount'] = "Sie haben die maximale Anzahl von erlaubten Kategorien erreicht",
	['category_bought'] = "Kategorie gekauft",
	['category_bought_balance'] = "Kategorie gekauft: %s",
	['category_sold_balance'] = "Kategorie verkauft: %s",
	['category_sold'] = "Kategorie verkauft",
	['category_not_found'] = "Kategorie nicht gefunden",
    ['cannot_sell_last_category'] = "Du kannst deine letzte Kategorie nicht verkaufen",
    ['insufficient_funds'] = "Nicht genügend Geld",
    ['insufficient_funds_store'] = "INicht genügend Geld um diesen Laden zu kaufen: %s",
    ['money_withdrawn'] = "Geld abheben",
    ['money_deposited'] = "Geld einzahlen",
    ['invalid_value'] = "Ungültiger Wert",
    ['invalid_price'] = "Der Preis muss zwischen $ %s und $ %s liegen",
    ['max_level'] = "Sie haben bereits die maximale Stufe erreicht",
    ['occupied_places'] = "Besetzte Garage",
    ['already_has_job'] = "Sie haben bereits eine Lieferung in Arbeit",
    ['truck_blip'] = "Fahrzeug",
    ['already_is_in_garage'] = "Ihr Fahrzeug steht in Ihrer Garage, nutzen Sie es, um die Produkte zu holen",
    ['vehicle_locked'] = "Fahrzeug <b>abgeschlossen</b>.",
    ['vehicle_unlocked'] = "Fahrzeug <b>aufgeschlossen</b>.",
    ['blip_route'] = "Produkte",
	['vehicle_destroyed'] = "Ihr Fahrzeug ist zerstört worden, Sie haben es versäumt, Produkte zu liefern",
    ['you_died'] = "Sie sind gestorben, Sie haben keine Produkte geliefert",
    ['objective_marker'] = "Drücke ~y~E~w~ Produkte zu sammeln",
    ['objective_marker_2'] = "Drücke ~y~E~w~ zur Lagerung der Produkte",
    ['objective_marker_3'] = "Drücke ~y~[E]~w~ die Produkte zu exportieren",
    ['out_of_veh'] = "Sie müssen aus dem Fahrzeug aussteigen",
    ['bring_to_van'] = "Bringen Sie die Kiste zum Lieferwagen",
    ['bring_to_store'] = "Bringen Sie die Produkte zurück in den Laden",
    ['sucess'] = "~g~Erfolgreich",
    ['sucess_finished'] = "Lieferung abgeschlossen",
    ['sucess_2'] = "~g~Erfolgreich",
    ['sucess_in_progess_2'] = "Bringen Sie das Fahrzeug zurück in die Garage",
	['sucess_finished_2'] = "Export beendet",
    ['exported_income'] = "Exportierter Artikel: %s %s",
    ['stock_full'] = "Die Lagerbestände sind voll",
    ['stock_empty'] = "Unzureichender Lagerbestand für diesen Artikel",
    ['buy_products_expenses'] = "Gekaufter Artikel: %s %s",
    ['create_job_expenses'] = "Lieferauftrag erstellt: %s",
    ['create_job_income'] = "Auslieferungsfahrer entfernt: %s",
    ['upgrade_expenses'] = "Upgrade gekauft: %s",
    ['stock_upgrade'] = "Kapazität der Lagerbestände",
    ['truck_upgrade'] = "Kapazität des LKW",
    ['relationship_upgrade'] = "Beziehung",
    ['cant_delete_job'] = "Jemand erledigt diese Aufgabe, Sie können sie nicht löschen",
    ['cant_delete_category'] = "Bitte löschen Sie die Zusteller-Jobs, bevor Sie diese Kategorie löschen",
    ['bought_item'] = "Item verkauft: %s %s",
    ['bought_item_2'] = "Du kaufst %s %s",
    ['sell_error'] = "Sie können dieses Geschäft nicht verkaufen",
    ['store_sold'] = "Sie haben diesen Laden verkauft",
    ['max_job_amount'] = "Sie können keinen Vertrag mit dieser Menge an Produkten beginnen",
    ['cant_carry_item'] = "Kann diesen Artikel nicht tragen",
	['dont_have_weapon_license'] = "Sie haben keinen Waffenschein",
    ['inserted_on_stock'] = "%sx %s auf Vorrat eingelegt",
    ['not_enought_items'] = "Sie haben keine %sx %s",
	['no_permission'] = "Sie sind nicht berechtigt, auf dieses Menü zuzugreifen",
	['cant_buy_that_amount'] = "Sie können dieses Element nur in %s er-Sets kaufen.",

    ['max_employees'] = "Du hast die maximale Anzahl an Mitarbeiter erreicht",
    ['user_not_found'] = "Bürger nicht gefunden",
    ['user_employed'] = "Bürger bereits angestellt",
    ['hired_user'] = "Gratuliere, du hast %s eingestellt",
    ['fired_user'] = "Mitarbeiter gefeuert",
    ['insufficient_permission'] = "Du hast keine Rechte um dies zutun.",
    ['comission_received'] = "Sie haben eine Provision erhalten, überprüfen Sie Ihr Konto",
    ['comission_sent'] = "Der Mitarbeiter hat Ihre Provision erhalten",
    ['cant_find_user'] = "Diese Mitarbeiter sind jetzt nicht verfügbar",
    ['give_comission_expenses'] = 'Provisionen an Arbeitnehmer %s',
    ['role_changed'] = "Rolle gewechselt",

    ['logs_date'] = "Date",
    ['logs_hour'] = "Time",
    ['logs_bought'] = "```prolog\n[STORE PURCHASED]: %s \n[ID]: %s \r```",
    ['logs_close'] = "```prolog\n[STORE CLOSED]: %s \n[ID]: %s \r```",
    ['logs_item_bought'] = "```prolog\n[ITEM PURCHASED]: %s\n[ITEM]: %s [AMOUNT]: %s \n[ID]: %s \r```",
    ['logs_lost_low_stock'] = "```prolog\n[STORE BROKE]: %s\n[STOCK]: %s\n[EMPTY FROM]: %s\n[ID]: %s \r```",
    ['logs_start_import'] = "```prolog\n[IMPORT STARTED]\n[STORE]: %s\n[ITEM]: %s\n[AMOUNT]: %s\n[PRICE]: %s\n[ID]: %s \r```",
	['logs_start_export'] = "```prolog\n[EXPORT STARTED]\n[STORE]: %s\n[ITEM]: %s\n[AMOUNT]: %s\n[ID]: %s \r```",
	['logs_finish_import'] = "```prolog\n[IMPORT FINISHED]\n[STORE]: %s\n[ITEM]: %s\n[AMOUNT]: %s\n[STOCK]: %s\n[ID]: %s \r```",
	['logs_finish_export'] = "```prolog\n[EXPORT FINISHED]\n[STORE]: %s\n[ITEM]: %s\n[AMOUNT]: %s\n[REWARD]: %s\n[ID]: %s \r```",
    ['logs_money_withdrawn'] = "```prolog\n[STORE]: %s\n[MONEY WITHDRAWN]: %s\n[ID]: %s \r```",
    ['logs_money_deposited'] = "```prolog\n[STORE]: %s\n[MONEY DEPOSITED]: %s\n[ID]: %s \r```",
    ['logs_comission'] = "```prolog\n[STORE]: %s\n[COMISSION]: %s\n[EMPLOYEE ID]: %s \n[ID]: %s \r```",
}