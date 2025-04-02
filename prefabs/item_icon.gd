extends MarginContainer
class_name ItemIcon

const TooltipPrefab = preload("res://prefabs/item_tooltip.tscn")

@export var active := false
var data : Inventory.ItemQuantity = null
@export var canvas: CanvasLayer = null

var tooltip: MarginContainer = null

func _ready() -> void:
	$Active.visible = active
	update_data(data)
	mouse_entered.connect(handle_mouse_entered)
	mouse_exited.connect(handle_mouse_exited)

func update_data(item: Inventory.ItemQuantity) -> void:
	data = item
	if data == null:
		$MarginContainer/ColorRect.visible = true
		$MarginContainer/TextureRect.visible = false
	else:
		$MarginContainer/ColorRect.visible = false
		$MarginContainer/TextureRect.visible = true
		
		%Quantity.text = str(data.quantity) if data.quantity > 1 else ""
		$MarginContainer/TextureRect.texture = data.item.texture
		

func set_active(is_active: bool) -> void:
	active = is_active
	$Active.visible = active

func handle_mouse_entered() -> void:
	set_active(data != null)
	if data == null:
		if tooltip != null:
			tooltip.queue_free()
			tooltip = null
	else:
		if tooltip == null:
			tooltip = TooltipPrefab.instantiate()
			tooltip.set_item(data)
			#tooltip.scale = Vector2(0.5, 0.5)
			canvas.add_child(tooltip)
			tooltip.global_position = get_global_mouse_position() + Vector2(32, 32)
		tooltip.set_item(data)

func handle_mouse_exited() -> void:
	set_active(false)
	if tooltip != null:
		tooltip.queue_free()
		tooltip = null
