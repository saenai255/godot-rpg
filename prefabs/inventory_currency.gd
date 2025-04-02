extends Label

class_name Currency

func _ready() -> void:
	set_currency(PlayerState.currency)
	PlayerState.currency_changed.connect(set_currency)
	
func set_currency(value: int) -> void:
	text = Common.format_currency(value)
