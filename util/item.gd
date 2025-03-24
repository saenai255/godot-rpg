extends RefCounted
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

func _init(id: int, name: String, quality: ItemQuality, description: String, stack_size: int, texture: Texture2D):
	self.id = id
	self.quality = quality
	self.name = name
	self.description = description
	self.stack_size = stack_size
	self.texture = texture if texture != null else load("res://icon.svg")
	
func _to_string() -> String:
	return "Item(id: %d, name: '%s', quality: %s, description: '%s', stack_size: %d)" % [id, name, quality, description, stack_size]
