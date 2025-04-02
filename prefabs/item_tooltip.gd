extends MarginContainer

func set_item(data: Inventory.ItemQuantity) -> void:
	if data == null:
		%Tooltip.visible = false
		return
	
	var prefix := ("%dx " % [data.quantity]) if data.quantity > 1 else ""
	%ItemName.text = prefix + data.item.name
	%ItemName.label_settings.font_color = get_quality_color(data.item.quality)
	%Quality.label_settings.font_color = get_quality_color(data.item.quality)
	%Quality.text = Item.ItemQuality.keys()[data.item.quality]
	%Description.text = data.item.description
	set_major_stats(data.item)
	set_minor_stats(data.item)
	set_equipment_type(data.item)
	set_weapon_type(data.item)
	set_weapon_damage(data.item)
	set_item_sell_price(data.item)
	%Tooltip.visible = true

func set_item_sell_price(item: Item) -> void:
	var text := "Cannot Sell"
	if item.sell_price > 0:
		text = Common.format_currency(item.sell_price)
	
	%SellPrice.text = text

func set_weapon_damage(item: Item) -> void:
	%WeaponDamageContainer.visible = item.damage != null
	if !%WeaponDamageContainer.visible:
		return
	%Damage.text = "    %d to %d damage" % [item.damage.min, item.damage.max]
	%DamageType.text = "Physical" if item.damage.type == Item.DamageType.Physical else "Magical"

func set_weapon_type(item: Item) -> void:
	%WeaponType.visible = item.weapon_slot != Item.WeaponSlot.None
	if !%WeaponType.visible:
		return
	
	var text := ""
	if item.weapon_slot == Item.WeaponSlot.OneHand:
		text = "One Handed"
	elif item.weapon_slot == Item.WeaponSlot.OffHand:
		text = "Off Handed"
	elif item.weapon_slot == Item.WeaponSlot.MainHand:
		text = "Main Handed"
	elif item.weapon_slot == Item.WeaponSlot.TwoHand:
		text = "Two Handed"
	else:
		push_error("unhandled weapon slot: " + str(item.weapon_slot))
	%WeaponType.text = text
	
func set_equipment_type(item: Item) -> void:
	%EquipmentContainer.visible = true
	
	if item.slot == Item.EquipmentSlot.None:
		%EquipmentContainer.visible = false
		return
	
	var text := ""
	if item.slot == Item.EquipmentSlot.Head:
		text = "Head"
	elif item.slot == Item.EquipmentSlot.Chest:
		text = "Chest"
	elif item.slot == Item.EquipmentSlot.Shoulders:
		text = "Shoulders"
	elif item.slot == Item.EquipmentSlot.Legs:
		text = "Legs"
	elif item.slot == Item.EquipmentSlot.Feet:
		text = "Feet"
	elif item.slot == Item.EquipmentSlot.Hands:
		text = "Hands"
	elif item.slot == Item.EquipmentSlot.Neck:
		text = "Neck"
	elif item.slot == Item.EquipmentSlot.Finger:
		text = "Finger"
	elif item.slot == Item.EquipmentSlot.Ear:
		text = "Ear"
	elif item.slot == Item.EquipmentSlot.Weapon:
		text = "Weapon"
	else:
		push_error("unhandled equipment slot: " + str(item.slot))
	
	%EquipmentType.text = text

func set_major_stats(item: Item) -> void:
	var text := ""
	
	if item.stats.stamina > 0:
		text += '+%d Stamina\n' % [item.stats.stamina]
	if item.stats.strength > 0:
		text += '+%d Strength\n' % [item.stats.strength]
	if item.stats.dexterity > 0:
		text += '+%d Dexterity\n' % [item.stats.dexterity]
	if item.stats.intellect > 0:
		text += '+%d Intellect\n' % [item.stats.intellect]
	
	if text.ends_with("\n"):
		text = text.trim_suffix("\n")
	
	%MajorStats.text = text
	%MajorStatsContainer.visible = text != ""
	
func make_minor_stat_str(value: int, stat: String) -> String:
	if value <= 0:
		return ""
	
	return "Increases %s by %d.\n" % [stat, value]

func set_minor_stats(item: Item) -> void:
	var text := ""
	
	text += make_minor_stat_str(item.stats.critical_power, "critical power")
	text += make_minor_stat_str(item.stats.critical_rating, "critical rating")
	text += make_minor_stat_str(item.stats.dodge_rating, "dodge rating")
	text += make_minor_stat_str(item.stats.health, "health")
	text += make_minor_stat_str(item.stats.magic_armor, "magic armor")
	text += make_minor_stat_str(item.stats.physical_armor, "physical armor")
	text += make_minor_stat_str(item.stats.magic_power, "magic power")
	text += make_minor_stat_str(item.stats.physical_power, "physical power")
	text += make_minor_stat_str(item.stats.mana, "mana")
	
	if text.ends_with("\n"):
		text = text.trim_suffix("\n")
	
	%MinorStats.text = text
	%MinorStatsContainer.visible = text != ""

func get_quality_color(quality: Item.ItemQuality) -> Color:
		if quality == Item.ItemQuality.Junk:
			return Color.DIM_GRAY
		elif quality == Item.ItemQuality.Common:
			return Color.WHITE_SMOKE			
		elif quality == Item.ItemQuality.Uncommon:
			return Color.LIME_GREEN
		elif quality == Item.ItemQuality.Rare:
			return Color.ROYAL_BLUE
		elif quality == Item.ItemQuality.Epic:
			return Color.DARK_ORCHID
		elif quality == Item.ItemQuality.Legendary:
			return Color.DARK_ORANGE
		return Color.BLACK
		
