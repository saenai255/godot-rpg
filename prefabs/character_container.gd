extends VBoxContainer

const Slot = EquippedItems.EquippedItemSlot

func _ready() -> void:
	update_character()
	PlayerState.equipped_items.items_changed.connect(update_character)

	var icons: Array[ItemIcon] = [
		%MainHand,
		%OffHand,
		%Head,
		%Neck,
		%Shoulders,
		%Back,
		%Chest,
		%Hands,
		%Legs,
		%Feet,
		%Finger1,
		%Finger2,
		%Ear1,
		%Ear2
	]
	for icon in icons:
		icon.gui_input.connect(func(event: InputEvent):
			if event is InputEventMouseButton and event.button_index == 2 and event.is_released():
				if icon.data != null:
					handle_item_unequip(icon.data.item)
		)

func handle_item_unequip(item: Item):
	PlayerState.equipped_items.unequip(item.get_equip_slot())
	PlayerState.inventory.store_item(item)
	print_debug("unequip item %s" % [item.name])

func update_item_texture(node: ItemIcon, slot: Slot) -> void:
	var item: Item = PlayerState.equipped_items.items.get(slot, null)
	if item == null:
		node.update_data(null)
	else:
		node.update_data(Inventory.ItemQuantity.new(item, 1))

func update_character() -> void:
	update_item_texture(%MainHand, Slot.MainHand)
	update_item_texture(%OffHand, Slot.OffHand)
	update_item_texture(%Head, Slot.Head)
	update_item_texture(%Neck, Slot.Neck)
	update_item_texture(%Shoulders, Slot.Shoulders)
	update_item_texture(%Back, Slot.Back)
	update_item_texture(%Chest, Slot.Chest)
	update_item_texture(%Hands, Slot.Hands)
	update_item_texture(%Legs, Slot.Legs)
	update_item_texture(%Feet, Slot.Feet)
	update_item_texture(%Finger1, Slot.Finger1)
	update_item_texture(%Finger2, Slot.Finger2)
	update_item_texture(%Ear1, Slot.Ear1)
	update_item_texture(%Ear2, Slot.Ear2)
	
