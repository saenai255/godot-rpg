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
	Back,
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
var sell_price: int

static var last_id := 0

func _init():
	last_id += 1
	id = last_id
	texture = load("res://iconplaceholder64x64.png")
	stats = Stats.new()
	quality = ItemQuality.Junk
	slot = EquipmentSlot.None
	stack_size = Consts.UNSTACKABLE
	weapon_slot = WeaponSlot.None
	damage = null
	sell_price = 0

static func from(cb: Callable) -> Item:
	var item: Item = new()
	cb.call(item)
	return item
	
func _to_string() -> String:
	return "Item(id: %d, name: '%s', quality: %s, description: '%s', stack_size: %d)" % [id, name, quality, description, stack_size]

const EquipSlot = EquippedItems.EquippedItemSlot

func get_equip_slot() -> EquipSlot:
	var item := self
	if item.slot == EquipmentSlot.Weapon:
		if item.weapon_slot == Item.WeaponSlot.MainHand or item.weapon_slot == Item.WeaponSlot.OneHand or item.weapon_slot == Item.WeaponSlot.TwoHand:
			return EquipSlot.MainHand
		if item.weapon_slot == Item.WeaponSlot.OffHand:
			return EquipSlot.OffHand
	if item.slot == EquipmentSlot.Head:
		return EquipSlot.Head
	if item.slot == EquipmentSlot.Neck:
		return EquipSlot.Neck
	if item.slot == EquipmentSlot.Shoulders:
		return EquipSlot.Shoulders
	if item.slot == EquipmentSlot.Back:
		return EquipSlot.Back
	if item.slot == EquipmentSlot.Chest:
		return EquipSlot.Chest
	if item.slot == EquipmentSlot.Hands:
		return EquipSlot.Hands
	if item.slot == EquipmentSlot.Legs:
		return EquipSlot.Legs
	if item.slot == EquipmentSlot.Feet:
		return EquipSlot.Feet
	if item.slot == EquipmentSlot.Finger:
		return EquipSlot.Finger1
	if item.slot == EquipmentSlot.Ear:
		return EquipSlot.Ear1

	return EquipSlot.None