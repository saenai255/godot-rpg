extends Node


const TEX_CRAFTING_MATS := preload("res://sprites/craft_mats/resources_neutral_bg.png")

const LARGE_STACK := 50
const SMALL_STACK := 10
const UNSTACKABLE := 1

func _atlas_tex(src: Texture2D, region: Rect2) -> Texture2D:
	var atlas := AtlasTexture.new()
	atlas.atlas = src
	atlas.region = region
	return atlas


var ITEM_PLANT_FIBER := Item.from(
	func(item: Item) -> void:
		item.name = "Plant Fiber"
		item.quality = Item.ItemQuality.Common
		item.description = "Thin, flexible fibers harvested from plants, ideal for crafting basic clothing or ropes."
		item.stack_size = LARGE_STACK
		item.texture = 	_atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 1, 24 * 9, 24, 24))
		item.sell_price = 10
)

var ITEM_WOOD_LOG := Item.from(
	func(item: Item) -> void:
		item.name = "Wood Log"
		item.quality = Item.ItemQuality.Common
		item.description = "A simple log gathered from trees, useful for crafting basic tools and weapons."
		item.stack_size = LARGE_STACK
		item.texture = _atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 0, 0, 24, 24))
)

var ITEM_ROUGH_STONE := Item.from(
	func(item: Item) -> void:
		item.name = "Rough Stone"
		item.quality = Item.ItemQuality.Common
		item.description = "A rough piece of stone, commonly used to create simple weapons and build fires."
		item.stack_size = LARGE_STACK
		item.texture = _atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 4, 0, 24, 24))
)

var ITEM_ROPE := Item.from(
	func(item: Item) -> void:
		item.name = "Rope"
		item.quality = Item.ItemQuality.Uncommon
		item.description = "A piece of rope made out of fiber."
		item.stack_size = LARGE_STACK
		item.texture = _atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 3, 24 * 6, 24, 24))
)

var ITEM_STONE_SWORD := Item.from(
	func(item: Item) -> void:
		item.name = "Stone Sword"
		item.quality = Item.ItemQuality.Uncommon
		item.description = "Heavy and not very sharp. Probably not the best type of sword."
		item.texture = preload("res://sprites/stone_sword_transparent_32x32.png")
		item.stats = Stats.from([
			Stats.StatValue.new(Stats.Stat.Strength, 3),
			Stats.StatValue.new(Stats.Stat.PhysicalPower, 5),
			Stats.StatValue.new(Stats.Stat.CriticalPower, 10),
		])
		item.slot = Item.EquipmentSlot.Weapon
		item.weapon_slot = Item.WeaponSlot.TwoHand
		item.damage = Item.DamageRange.new(3, 5, Item.DamageType.Physical)
)

var ITEM_SABIUTA_LU_MARIUCA := Item.from(
	func(item: Item) -> void:
		item.name = "Sabiuta lu Mariuca"
		item.quality = Item.ItemQuality.Epic
		item.description = "Da' ce-oi face?"
		item.texture = preload("res://sprites/stone_sword_transparent_32x32.png")
		item.stats = Stats.from([
			Stats.StatValue.new(Stats.Stat.DodgeRating, 300),
			Stats.StatValue.new(Stats.Stat.Intellect, 200),
			Stats.StatValue.new(Stats.Stat.CriticalRating, 250),
			Stats.StatValue.new(Stats.Stat.CriticalPower, 350),
			Stats.StatValue.new(Stats.Stat.Stamina, 350),
		])
		item.slot = Item.EquipmentSlot.Weapon
		item.weapon_slot = Item.WeaponSlot.OneHand
		item.damage = Item.DamageRange.new(4500, 5000, Item.DamageType.Magical)
)

var ITEM_THUNDERFURY := Item.from(
	func(item: Item) -> void:
		item.name = "Thunderfury, Blessed Blade of the Windseeker"
		item.quality = Item.ItemQuality.Legendary
		item.description = "Probably a copyright infringement."
		item.texture = preload("res://sprites/stone_sword_transparent_32x32.png")
		item.stats = Stats.from([
			Stats.StatValue.new(Stats.Stat.Strength, 33),
			Stats.StatValue.new(Stats.Stat.Stamina, 27),
			Stats.StatValue.new(Stats.Stat.Intellect, 15),
			Stats.StatValue.new(Stats.Stat.Dexterity, 17),
			Stats.StatValue.new(Stats.Stat.CriticalRating, 43),
			Stats.StatValue.new(Stats.Stat.CriticalPower, 152),
			Stats.StatValue.new(Stats.Stat.DodgeRating, 72),
			Stats.StatValue.new(Stats.Stat.MagicArmor, 52),
		])
		item.slot = Item.EquipmentSlot.Weapon
		item.weapon_slot = Item.WeaponSlot.OneHand
		item.damage = Item.DamageRange.new(230, 270, Item.DamageType.Physical)
)


var items : Array[Item] = [
	ITEM_ROPE,
	ITEM_WOOD_LOG,
	ITEM_PLANT_FIBER,
	ITEM_ROUGH_STONE,
	ITEM_STONE_SWORD,
	ITEM_THUNDERFURY,
	ITEM_SABIUTA_LU_MARIUCA,
]
