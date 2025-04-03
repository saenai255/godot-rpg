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


var ITEM_PLANT_FIBER := ItemTemplate.from(
	func(item: ItemTemplate) -> void:
		item.name = "Plant Fiber"
		item.quality = ItemEnums.Quality.Common
		item.description = "Thin, flexible fibers harvested from plants, ideal for crafting basic clothing or ropes."
		item.stack_size = LARGE_STACK
		item.texture = 	_atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 1, 24 * 9, 24, 24))
		item.sell_price = 10
)

var ITEM_WOOD_LOG := ItemTemplate.from(
	func(item: ItemTemplate) -> void:
		item.name = "Wood Log"
		item.quality = ItemEnums.Quality.Common
		item.description = "A simple log gathered from trees, useful for crafting basic tools and weapons."
		item.stack_size = LARGE_STACK
		item.texture = _atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 0, 0, 24, 24))
)

var ITEM_ROUGH_STONE := ItemTemplate.from(
	func(item: ItemTemplate) -> void:
		item.name = "Rough Stone"
		item.quality = ItemEnums.Quality.Common
		item.description = "A rough piece of stone, commonly used to create simple weapons and build fires."
		item.stack_size = LARGE_STACK
		item.texture = _atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 4, 0, 24, 24))
)

var ITEM_ROPE := ItemTemplate.from(
	func(item: ItemTemplate) -> void:
		item.name = "Rope"
		item.quality = ItemEnums.Quality.Uncommon
		item.description = "A piece of rope made out of fiber."
		item.stack_size = LARGE_STACK
		item.texture = _atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 3, 24 * 6, 24, 24))
)

var ITEM_STONE_SWORD := ItemTemplate.from(
	func(item: ItemTemplate) -> void:
		item.name = "Stone Sword"
		item.quality = ItemEnums.Quality.Uncommon
		item.description = "Heavy and not very sharp. Probably not the best type of sword."
		item.texture = preload("res://sprites/stone_sword_transparent_32x32.png")
		item.stats = Stats.from([
			Stats.StatValue.new(Stats.Stat.Strength, 3),
			Stats.StatValue.new(Stats.Stat.PhysicalPower, 5),
			Stats.StatValue.new(Stats.Stat.CriticalPower, 10),
		])
		item.slot = Item.EquipmentSlot.Weapon
		item.weapon_slot = ItemEnums.WeaponSlot.TwoHand
		item.damage = DamageRange.new(3, 5, ItemEnums.DamageType.Physical)
)

var ITEM_SABIUTA_LU_MARIUCA := ItemTemplate.from(
	func(item: ItemTemplate) -> void:
		item.name = "Sabiuta lu Mariuca"
		item.quality = ItemEnums.Quality.Epic
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
		item.weapon_slot = ItemEnums.WeaponSlot.OneHand
		item.damage = DamageRange.new(4500, 5000, ItemEnums.DamageType.Magical)
)

var ITEM_THUNDERFURY := ItemTemplate.from(
	func(item: ItemTemplate) -> void:
		item.name = "Thunderfury, Blessed Blade of the Windseeker"
		item.quality = ItemEnums.Quality.Legendary
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
		item.weapon_slot = ItemEnums.WeaponSlot.OneHand
		item.damage = DamageRange.new(230, 270, ItemEnums.DamageType.Physical)
)

var ITEM_CLOTH_HELMET := ItemTemplate.from(
	func(item: ItemTemplate):
		item.name = "Ragged Cloth Helmet"
		item.description = "Doesn't help much"
		item.stats = Stats.from([
			Stats.StatValue.new(Stats.Stat.PhysicalArmor, 5)
		])
		item.slot = Item.EquipmentSlot.Head
		item.sell_price = 1
		item.quality = ItemEnums.Quality.Common
		item.texture = preload("res://sprites/ragged_cloth_helmet_32x32.png")
)

var items : Array[ItemTemplate] = [
	ITEM_ROPE,
	ITEM_WOOD_LOG,
	ITEM_PLANT_FIBER,
	ITEM_ROUGH_STONE,
	ITEM_STONE_SWORD,
	ITEM_THUNDERFURY,
	ITEM_SABIUTA_LU_MARIUCA,
	ITEM_CLOTH_HELMET,
]

var RECIPE_RAGGED_CLOTH_HELMET := Recipe.from(
	func(r: Recipe):
		r.name = "Pattern: Ragged Cloth Helmet"
		r.required_skill = 0
		r.required_items = [ItemTemplateQuantity.new(ITEM_PLANT_FIBER, 3)]
		r.generates_items = [ItemTemplateQuantity.new(ITEM_CLOTH_HELMET, 1)]
)


var PROFESSION_TAILORING := Profession.from(
	func(p: Profession):
		p.name = "Tailoring"
		p.known_recipes = [
			RECIPE_RAGGED_CLOTH_HELMET,
		]
		p.all_recipes = [
			RECIPE_RAGGED_CLOTH_HELMET,
		]
		p.skill = 0
)

var professions : Array[Profession] = [
	PROFESSION_TAILORING
]
