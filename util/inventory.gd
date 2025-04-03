class_name Inventory

const INVENTORY_SIZE := 16


var item_slots : Array[ItemQuantity] = []

signal changed

func _to_string() -> String:
	return "Inventory(item_slots: {item_slots})".format({
		"item_slots": item_slots
	})

func _init():
	item_slots.resize(INVENTORY_SIZE)
	item_slots.fill(null)
	changed.emit()

func used_space() -> int:
	return item_slots.reduce(
		func (acc: int, it: ItemQuantity) -> int: return acc + (1 if it != null else 0),
		0
	)

func free_space() -> int:
	return INVENTORY_SIZE - used_space()

func can_store_item(item: Item) -> bool:
	if free_space() > 0:
		return true
	
	if item.stack_size <= 1:
		return false
	
	for slot in item_slots:
		if slot != null and slot.item.template.id == item.template.id and slot.quantity < item.stack_size:
			return true
			
	return false

func swap_slots(idx1: int, idx2: int) -> void:
	var aux := item_slots[idx1]
	item_slots[idx1] = item_slots[idx2]
	item_slots[idx2] = aux
	changed.emit()

func remove_item(idx: int) -> void:
	item_slots[idx] = null
	changed.emit()

func store_item_quantity(item: Item, quantity: int) -> void:
	for it in quantity:
		store_item(item)

func store_item(item: Item) -> bool:
	if item.stack_size > 1:
		for slot in item_slots:
			if slot != null and slot.item.template.id == item.template.id and slot.quantity < item.stack_size:
				slot.quantity += 1
				changed.emit()
				return true
	
	if free_space() > 0:
		var idx := 0
		for slot in item_slots:
			if slot != null:
				idx += 1
			else:
				break
		item_slots[idx] = ItemQuantity.new(item, 1)
		changed.emit()
		return true
		
	return false
