class_name Item

var template: ItemTemplate
var entry_id: int
var name: String
var description: String
var stack_size: int
var texture: Texture2D
var quality: ItemEnums.Quality
var stats: Stats
var slot: ItemEnums.Slot
var weapon_slot: ItemEnums.WeaponSlot
var damage: DamageRange
var sell_price: int

static var last_id := 0

func _init():
	last_id += 1
	entry_id = last_id
	texture = load("res://iconplaceholder64x64.png")
	stats = Stats.new()
	quality = ItemEnums.Quality.Junk
	slot = ItemEnums.Slot.None
	stack_size = Consts.UNSTACKABLE
	weapon_slot = ItemEnums.WeaponSlot.None
	damage = null
	sell_price = 0

static func from(cb: Callable) -> Item:
	var item: Item = new()
	cb.call(item)
	return item
	
func _to_string() -> String:
	return "Item(id: %d, name: '%s', quality: %s, description: '%s', stack_size: %d)" % [template.id, name, quality, description, stack_size]

const EquipSlot = ItemEnums.EquipmentSlot
const EquipmentSlot = ItemEnums.Slot

func get_equip_slot() -> EquipSlot:
	var item := self
	if item.slot == EquipmentSlot.Weapon:
		if item.weapon_slot == ItemEnums.WeaponSlot.MainHand or item.weapon_slot == ItemEnums.WeaponSlot.OneHand or item.weapon_slot == ItemEnums.WeaponSlot.TwoHand:
			return EquipSlot.MainHand
		if item.weapon_slot == ItemEnums.WeaponSlot.OffHand:
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
