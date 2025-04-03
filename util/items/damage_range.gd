class_name DamageRange

var dmg_min: int
var dmg_max: int
var type: ItemEnums.DamageType

func _init(from: int, to: int, typ: ItemEnums.DamageType):
	self.dmg_min = from
	self.dmg_max = to
	self.type = typ
