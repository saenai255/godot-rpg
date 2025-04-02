extends Node

const MULT = 1000

func format_currency(value: int) -> String:
	var gold := floori(value / MULT / MULT)
	var silver := floori(value / MULT) % MULT
	var copper := value % MULT
	return "{gold}g {silver}s {copper}c".format({
		"gold": gold,
		"silver": silver,
		"copper": copper
	})