extends Label

class_name Currency
const ONE_COPPER = 1
const ONE_SILVER = ONE_COPPER * Common.MULT
const ONE_Gold = ONE_SILVER * Common.MULT

func _ready() -> void:
	set_currency(PlayerState.currency)
	PlayerState.currency_changed.connect(set_currency)
	
func set_currency(value: int) -> void:
	text = Common.format_currency(value)
