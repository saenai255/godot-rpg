extends CanvasLayer

const INVENTORY_SIZE := Inventory.INVENTORY_SIZE

const ItemIconPrefab := preload("res://prefabs/item_icon.tscn")

func _ready() -> void:
	PlayerState.inventory.changed.connect(render_slots)
	render_slots()

func render_slots() -> void:
	for child in %SlotGrid.get_children():
		child.queue_free()
	
	var slot_idx := 0
	for slot in PlayerState.inventory.item_slots:
		var item_icon: ItemIcon = ItemIconPrefab.instantiate()
		
		item_icon.data = slot
		item_icon.active = false
		item_icon.canvas = self
		item_icon.gui_input.connect(func(event: InputEvent):
			handle_gui_input(slot, slot_idx, event)	
		)
		
		%SlotGrid.add_child(
			item_icon
		)

		slot_idx += 1

func is_right_click_released(event: InputEvent) -> bool:
	return event is InputEventMouseButton and event.button_index == 2 and event.is_released()

func handle_gui_input(inventory_slot: Inventory.ItemQuantity, slot_idx: int, event: InputEvent) -> void:
	if is_right_click_released(event):
		if inventory_slot == null:
			return
		var slot := inventory_slot.item.get_equip_slot()
		if slot == EquippedItems.EquippedItemSlot.None:
			return
	
		var prev_equipped_item := PlayerState.equipped_items.items[slot]
		PlayerState.equipped_items.equip(slot, inventory_slot.item)
		PlayerState.inventory.remove_item(slot_idx)
		print_debug('equipped item %s' % [inventory_slot.item.name])
		if prev_equipped_item != null:
			PlayerState.inventory.store_item(prev_equipped_item)
			print_debug('prev equipped item sent to inventory %s' % [prev_equipped_item.name])

const ItemSlot = Item.EquipmentSlot
