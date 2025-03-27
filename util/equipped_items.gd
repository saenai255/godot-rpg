extends Node
class_name EquippedItems

enum EquippedItemSlot {
	Head = 0,
	Neck = 1,
	Ear1 = 2,
	Ear2 = 3,
	Shoulders = 4,
	Chest = 5,
	Hands = 6,
	Finger1 = 7,
	Finger2 = 8,
	MainHand = 9,
	OffHand = 10,
}

signal items_changed()
signal stats_changed(stats: Stats)

var items : Dictionary[EquippedItemSlot, Item] = {}
var computed_stats := Stats.new()

func _init() -> void:
	deferred_init.call_deferred()

func deferred_init() -> void:
	for key in EquippedItemSlot.keys():
		items.set(EquippedItemSlot[key], null)
	
	update_stats()
	items_changed.connect(update_stats)
	PlayerState.level_changed.connect(update_stats)
	

func equip(slot: EquippedItemSlot, item: Item) -> Item:
	var last_item: Item = items.get(slot, null)
	items.set(slot, item)
	items_changed.emit()
	return last_item

func unequip(slot: EquippedItemSlot) -> Item:
	var last_item: Item = items.get(slot, null)
	items.set(slot, null)
	items_changed.emit()
	return last_item

func computed_stats_to_string() -> String:
	var level := PlayerState.level
	return 'ComputedStats(\nstats %s, \ncrit %f, \ncrit_mult %f, \ndodge %f, \nmagic_dmg_reduction %f, \nphys_dmg_reduction %f)' % [
		computed_stats.to_string(),
		computed_stats.get_crit_chance(level),
		computed_stats.get_crit_multiplier(level),
		computed_stats.get_dodge_chance(level),
		computed_stats.get_magic_damage_reduction(level),
		computed_stats.get_phys_damage_reduction(level)
	]

func update_stats() -> void:
	var out := Stats.new()
	
	for slot in items:
		var item: Item = items.get(slot, null)
		if item == null:
			continue
		out = out.add(item.stats)
	
	var level := PlayerState.level
	
	out.strength += level
	out.stamina += level
	out.intellect += level
	out.dexterity += level
	out.health += 90 + level * 10 + out.stamina * 10
	out.mana += 90 + level * 10 + out.intellect * 10
	out.physical_power += level + out.strength * 2 + out.dexterity
	out.magic_power += level + out.intellect * 2
	out.physical_armor += out.strength * 2
	out.critical_rating += out.dexterity
	out.critical_power += out.dexterity
	out.dodge_rating += out.dexterity
	
	computed_stats = out
	stats_changed.emit(computed_stats)
