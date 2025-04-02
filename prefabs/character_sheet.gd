extends VBoxContainer

const StatRowPrefab := preload("res://prefabs/stat_row.tscn")

func _ready() -> void:
	update_data(PlayerState.equipped_items.computed_stats)
	PlayerState.equipped_items.stats_changed.connect(update_data)

func _make_line(header: String, value: Variant):
	var it = StatRowPrefab.instantiate()
	%StatsContainer.add_child(it)
	it.setup(header, value)

func percent(value: float) -> String:
	return str(floor(value * 10000) / 100.0) + "%"
	
func update_data(stats: Stats) -> void:
	var level := PlayerState.level
	for child in %StatsContainer.get_children():
		child.visible = false
		child.queue_free()
	
	
	_make_line("Stamina", stats.stamina)
	_make_line("Strength", stats.strength)
	_make_line("Intellect", stats.intellect)
	_make_line("Dexterity", stats.dexterity)
	_make_line("", "")
	_make_line("Health", stats.health)
	_make_line("Mana", stats.mana)
	_make_line("Phys. Power", stats.physical_power)
	_make_line("Magic Power", stats.magic_power)
	_make_line("Phys. Armor", stats.physical_armor)
	_make_line("Magic Armor", stats.magic_armor)
	_make_line("Critical Rating", stats.critical_rating)
	_make_line("Critical Power", stats.critical_power)
	_make_line("Dodge Rating", stats.dodge_rating)
	_make_line("", "")
	_make_line("Dodge Chance", percent(stats.get_dodge_chance(level)))
	_make_line("Critical Chance", percent(stats.get_crit_chance(level)))
	_make_line("Critical Multiplier", str(floor((stats.get_crit_multiplier(level) + 1) * 100) / 100) + "x")
	_make_line("Magic Dmg. Reduction", percent(stats.get_magic_damage_reduction(level)))
	_make_line("Phys. Dmg. Reduction", percent(stats.get_phys_damage_reduction(level)))
