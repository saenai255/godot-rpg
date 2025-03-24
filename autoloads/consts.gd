extends Node


const TEX_CRAFTING_MATS := preload("res://sprites/craft_mats/resources_neutral_bg.png")

const LARGE_STACK := 50
const SMALL_STACK := 10
const UNSTACKABLE := 1

func _register_item(item: Item) -> Item:
	items.append(item)
	return item

func _atlas_tex(src: Texture2D, region: Rect2) -> Texture2D:
	var atlas := AtlasTexture.new()
	atlas.atlas = src
	atlas.region = region
	return atlas


var ITEM_PLANT_FIBER := _register_item(
	Item.new(
		1,
		"Plant Fiber",
		Item.ItemQuality.Common,
		"Thin, flexible fibers harvested from plants, "
		+ "ideal for crafting basic clothing or ropes.",
		LARGE_STACK,
		_atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 1, 24 * 9, 24, 24))
	)
)


var ITEM_WOOD_LOG := _register_item(
	Item.new(
		2,
		"Wood Log",
		Item.ItemQuality.Common,
		"A simple log gathered from trees, "
		+ "useful for crafting basic tools and weapons.",
		LARGE_STACK,
		_atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 0, 0, 24, 24))
	)
)

var ITEM_ROUGH_STONE := _register_item(
	Item.new(
		3,
		"Rough Stone",
		Item.ItemQuality.Common,
		"A rough piece of stone, commonly used to create "
		+ "simple weapons and build fires.",
		LARGE_STACK,
		_atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 4, 0, 24, 24))
	)
)

var ITEM_ROPE := _register_item(
	Item.new(
		4,
		"Rope",
		Item.ItemQuality.Uncommon,
		"A piece of rope made out of fiber.",
		LARGE_STACK,
		_atlas_tex(TEX_CRAFTING_MATS, Rect2(24 * 3, 24 * 6, 24, 24))
	)
)

var ITEM_STONE_SWORD := _register_item(
	Item.new(
		5,
		"Stone Sword",
		Item.ItemQuality.Uncommon,
		"Heavy and not very sharp. Probably not the best type of sword.",
		UNSTACKABLE,
		preload("res://sprites/stone_sword_transparent_32x32.png"),
	)
)

var items : Array[Item] = []
