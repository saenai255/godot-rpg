class_name Item

enum ItemQuality {
	Junk,
	Common,
	Uncommon,
	Rare,
	Epic,
	Legendary
}

enum EquipmentSlot {
	None,
	Head,
	Chest,
	Shoulders,
	Legs,
	Feet,
	Hands,
	Neck,
	Finger,
	Ear,
	Weapon,
}

enum WeaponSlot {
	None,
	OneHand,
	OffHand,
	MainHand,
	TwoHand
}

enum DamageType {
	Physical,
	Magical
}

class DamageRange:
	var min: int
	var max: int
	var type: DamageType
	
	func _init(from: int, to: int, typ: DamageType):
		self.min = from
		self.max = to
		self.type = typ

var id: int
var name: String
var description: String
var stack_size: int
var texture: Texture2D
var quality: ItemQuality
var stats: Stats
var slot: EquipmentSlot
var weapon_slot: WeaponSlot
var damage: DamageRange

static var last_id := 0

func _init():
	last_id += 1
	id = last_id
	texture = load("res://icon.svg")
	stats = Stats.new()
	quality = ItemQuality.Junk
	slot = EquipmentSlot.None
	stack_size = Consts.UNSTACKABLE
	weapon_slot = WeaponSlot.None
	damage = null

static func from(cb: Callable) -> Item:
	var item: Item = new()
	cb.call(item)
	return item
	
func _to_string() -> String:
	return "Item(id: %d, name: '%s', quality: %s, description: '%s', stack_size: %d)" % [id, name, quality, description, stack_size]
