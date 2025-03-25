extends Node

var inventory := Inventory.new()

var currency := 0
signal currency_changed(int)
func set_currency(value: int) -> void:
	currency = value
	currency_changed.emit(value)
