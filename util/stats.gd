extends Node

class_name Stats

enum Stat {
	Health,
	Mana,
	PhysicalPower,
	MagicPower,
	PhysicalArmor,
	MagicArmor,
	DodgeRating,
	CriticalRating,
	CriticalPower,
	Strength,
	Intellect,
	Dexterity,
	Stamina,
}


var health := 0
var mana := 0
var physical_power := 0
var magic_power := 0
var physical_armor := 0
var magic_armor := 0
var dodge_rating := 0
var critical_rating := 0
var critical_power := 0
var strength := 0
var intellect := 0
var dexterity := 0
var stamina := 0

func _to_string() -> String:
	return 'Stats(health %d, mana %d, phys_power %d, magic_power %d, phys_armor %d, magic_armor %d, dodge %d, crit %d, crit_power %d, strength %d, intellect %d, dexterity %d, stamina %d)' % [
		health,
		mana,
		physical_power,
		magic_power,
		physical_armor,
		magic_armor,
		dodge_rating,
		critical_rating,
		critical_power,
		strength,
		intellect,
		dexterity,
		stamina,
	]

func add(other: Stats) -> Stats:
	var result := new()
	
	result.health = health + other.health
	result.mana = mana + other.mana
	result.physical_power = physical_power + other.physical_power
	result.magic_power = magic_power + other.physical_power
	result.physical_armor = physical_armor + other.physical_armor
	result.magic_armor = magic_armor + other.magic_armor
	result.dodge_rating = dodge_rating + other.dodge_rating
	result.critical_rating = critical_rating + other.critical_rating
	result.critical_power = critical_power + other.critical_power
	result.strength = strength + other.strength
	result.intellect = intellect + other.intellect
	result.dexterity = dexterity + other.dexterity
	result.stamina = stamina + other.stamina
	
	return result

class StatValue:
	var type: Stat
	var value: int
	
	func _init(_type: Stat, _value: int) -> void:
		self.type = _type
		self.value = _value

static func from(values: Array[StatValue]) -> Stats:
	var out := new()
	
	for val in values:
		var t := val.type
		var v := val.value
		
		if t == Stat.Health:
			out.health += v
		elif t == Stat.Mana:
			out.mana += v
		elif t == Stat.PhysicalPower:
			out.physical_power += v
		elif t == Stat.MagicPower:
			out.magic_power += v
		elif t == Stat.PhysicalArmor:
			out.physical_armor += v
		elif t == Stat.MagicArmor:
			out.magic_armor += v
		elif t == Stat.DodgeRating:
			out.dodge_rating += v
		elif t == Stat.CriticalRating:
			out.critical_rating += v
		elif t == Stat.CriticalPower:
			out.critical_power += v
		elif t == Stat.Strength:
			out.strength += v
		elif t == Stat.Intellect:
			out.intellect += v
		elif t == Stat.Dexterity:
			out.dexterity += v
		elif t == Stat.Stamina:
			out.stamina += v
		else:
			push_error('unhandled type: ' + str(t))
	
	return out

func get_phys_damage_reduction(level: int) -> float:
	return (5.0 + float(physical_armor) / 20.0 + float(level) / 3.0) / 100.0
func get_magic_damage_reduction(level: int) -> float:
	return (5.0 + float(magic_armor) / 20.0 + float(level) / 3.0) / 100.0
func get_dodge_chance(level: int) -> float:
	return (5.0 + float(dodge_rating) / 20.0 + float(level) / 3.0) / 100.0
func get_crit_chance(level: int) -> float:
	return (5.0 + float(critical_rating) / 20.0 + float(level) / 3.0) / 100.0
func get_crit_multiplier(level: int) -> float:
	return (50.0 + float(critical_power) / 10.0 + float(level) * 2.0) / 100.0 
