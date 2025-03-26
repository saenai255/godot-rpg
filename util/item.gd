class_name Item

enum ItemQuality {
	Junk,
	Common,
	Uncommon,
	Rare,
	Epic,
	Legendary
}

var id: int
var name: String
var description: String
var stack_size: int
var texture: Texture2D
var quality: ItemQuality
var stats: Stats

func _init(_id: int, _name: String, _quality: ItemQuality, _description: String, _stack_size: int, _texture: Texture2D, _stats: Stats = Stats.new()):
	id = _id
	quality = _quality
	name = _name
	description = _description
	stack_size = _stack_size
	texture = _texture if _texture != null else load("res://icon.svg")
	stats = _stats
	
func _to_string() -> String:
	return "Item(id: %d, name: '%s', quality: %s, description: '%s', stack_size: %d)" % [id, name, quality, description, stack_size]
