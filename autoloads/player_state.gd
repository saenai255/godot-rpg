extends Node

var inventory := Inventory.new()
var equipped_items := EquippedItems.new()

var currency := 0
signal currency_changed(value: int)
func set_currency(value: int) -> void:
	currency = value
	currency_changed.emit(value)

var player_instance : CharacterBody2D = null

var level := 1
signal level_changed(old: int, new: int)
func set_level(value: int):
	if value > MAX_LEVEL:
		value = MAX_LEVEL

	if value == level:
		return
	
	var old_level := level
	level = value
	
	level_changed.emit(old_level, level)
func level_up():
	set_level(level + 1)

var experience_to_level := {
	1: 100,
	2: 200,
	3: 300,
	4: 500,
	5: 600,
	6: 1000,
	7: 1500,
	8: 2000,
	9: 2500,
	10: 4000,
}

const MAX_LEVEL := 10

var experience := 0
signal experience_changed(old: int, new: int)
func set_experience(value: int):
	if value == experience:
		return
		
	var old_xp := experience
	
	while true:
		var exp_to_level : int = experience_to_level[level]
		if value >= exp_to_level and level < MAX_LEVEL:
			level_up()
			value -= exp_to_level
		else:
			break
		
	# leveling up done
	var exp_to_level :int = experience_to_level[level]
	if value > exp_to_level:
		value = exp_to_level
	
	experience = value
	experience_changed.emit(old_xp, experience)
func add_exp(amount: int):
	set_experience(experience + amount)
