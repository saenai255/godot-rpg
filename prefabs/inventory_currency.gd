extends Label

const MULT = 1000

func _ready() -> void:
	set_currency(PlayerState.currency)
	PlayerState.currency_changed.connect(set_currency)
	
func set_currency(value: int) -> void:
	var gold := floori(value / MULT / MULT)
	var silver := floori(value / MULT) % MULT
	var copper := value % MULT
	text = "{gold}g {silver}s {copper}c".format({
		"gold": gold,
		"silver": silver,
		"copper": copper
	})
