extends MarginContainer

var commands = {
	"currency": cmd_currency,
	"position": cmd_position,
	"speed": cmd_speed,
	"item": cmd_item,
	"collision": cmd_collision,
	"exp": cmd_experience,
	"level": cmd_level,
	"stats": cmd_stats,
	"help": cmd_help,
}

func _ready() -> void:
	%Command.text_submitted.connect(handle_command)
	%Command.grab_focus()

func toggle() -> void:
	visible = !visible
	if visible:
		%Command.clear()
		%Command.grab_focus()
	
func handle_command(command: String) -> void:
	print_cmd(command)
	%Command.clear()
	%Command.call_deferred("grab_focus")
	%Command.focus_mode = FOCUS_ALL
	
	var parts := command.split(" ")
	if len(parts) == 0:
		print_info('err: invalid command')
		return
	
	var ok := false
	for it in commands:
		if it == parts[0]:
			ok = commands[it].call(parts.slice(1))
			break
	if !ok:
		print_info('err: invalid command. see commands using "help" command')

func print_cmd(cmd: String) -> void:
	var now := Time.get_datetime_string_from_system()
	%History.text += "\n" + now + " > "
	%History.text += cmd
	%History.scroll_vertical = %History.get_v_scroll_bar().max_value
func print_info(text: String) -> void:
	%History.text += "\n    " + text
	%History.scroll_vertical = %History.get_v_scroll_bar().max_value

func get_or(parts: Array[String], idx: int, default: String) -> String:
	if len(parts) > idx:
		return parts[idx]
	else:
		return default

func cmd_currency(parts: Array[String]) -> bool:
	var subcmd := get_or(parts, 0, "help")
	var str_value := get_or(parts, 1, "")
	
	if subcmd == "add":
		if str_value == "" or !str_value.is_valid_int():
			print_info("err: invalid syntax. use: currency add [copper_amount]")
			return false
			
		var value := str_value.to_int()
		PlayerState.set_currency(PlayerState.currency + value)
		print_info('currency updated')
	elif subcmd == "help":
		print_info("available subcommand:")
		print_info("- add [copper_amount]")
		print_info("- help")
	else:
		return false
	return true 
	

func cmd_item(parts: Array[String]) -> bool:
	var subcmd := get_or(parts, 0, "help")
	var str_value1 := get_or(parts, 1, "")
	var str_value2 := get_or(parts, 2, "")
	
	if subcmd == "add":
		if !str_value1.is_valid_int():
			print_info("err: invalid syntax. use: item add [item_id] [quantity=1]")
			return false
		var item_id := str_value1.to_int()
		var quantity := str_value2.to_int() if str_value2.is_valid_int() else 1
		
		
		var item_idx := Consts.items.find_custom(func(it: Item) -> bool:
			return it.id == item_id
		)
		if item_idx != -1:
			var item := Consts.items[item_idx]
			PlayerState.inventory.store_item_quantity(item.create_instance(), quantity)
			print_info('added item [%s] x%d' % [item.name, quantity])
		else:
			print_info('err: item not found')
	elif subcmd == "search":
		var search_filter := parts.slice(1)
		print_info("search results:")
		print_info("ID %s ITEM NAME" % ["".lpad(6)])
		for item in Consts.items:
			var found := true
			for term in search_filter:
				if !item.name.contains(term):
					found = false
			if found:
				print_info("%s [%s]" % [str(item.id).rpad(10), item.name])
	elif subcmd == "equipped":
		print_info("equipped items:")
		print_info("SLOT %s ITEM_ID %s ITEM_NAME" % ["".lpad(8), "".lpad(6)])
		for slot in ItemEnums.EquipmentSlot.keys():
			var item: Item = PlayerState.equipped_items.items.get(ItemEnums.EquipmentSlot[slot], null)
			var name := "<empty slot>"
			var id := "-"
			if item != null:
				name = item.name
				id = str(item.template.id)
			print_info("%s %s [%s]" % [slot.rpad(15), id.rpad(10), name])
	elif subcmd == "help":
		print_info("available subcommands:")
		print_info("- add [item_id] [quantity=1]")
		print_info("- search [terms...]")
		print_info("- equipped")
		print_info("- help")
	else:
		return false
	return true

func cmd_position(parts: Array[String]) -> bool:
	var subcmd := get_or(parts, 0, "help")
	var str_value1 := get_or(parts, 1, "")
	var str_value2 := get_or(parts, 2, "")
	
	if subcmd == "get":
		print_info("X: %f" % [PlayerState.player_instance.global_position.x])
		print_info("Y: %f" % [PlayerState.player_instance.global_position.y])
	elif subcmd == "set":
		if !str_value1.is_valid_float() || !str_value2.is_valid_float():
			print_info("err: invalid syntax. use: position set [x] [y]")
			return false
		
		var x := str_value1.to_float()
		var y := str_value2.to_float()

		PlayerState.player_instance.global_position.x = x
		PlayerState.player_instance.global_position.y = y
		
		print_info("position set to [%f, %f]" % [x, y])
	elif subcmd == "help":
		print_info("available subcommands:")
		print_info("- get")
		print_info("- set [x] [y]")
		print_info("- help")
	else:
		return false
	return true

func cmd_speed(parts: Array[String]) -> bool:
	var subcmd := get_or(parts, 0, "help")
	var str_value := get_or(parts, 1, "")
	
	if subcmd == "get":
		print_info("speed: " + str(PlayerState.player_instance.SPEED))
	elif subcmd == "set":
		var last_speed = PlayerState.player_instance.SPEED
		var speed := str_value.to_int() if str_value.is_valid_int() else 100
		PlayerState.player_instance.SPEED = speed
		print_info('player speed set from %d to %d' % [last_speed, speed])
	elif subcmd == "help":
		print_info("available subcommands:")
		print_info("- get")
		print_info("- set [amount=100]")
		print_info("- help")
	else:
		return false
	
	return true

func cmd_collision(parts: Array[String]) -> bool:
	var subcmd := get_or(parts, 0, "help")
	
	if subcmd == "get":
		var col_shape: CollisionShape2D = PlayerState.player_instance.get_child(0)
		print_info("player collision is " + ("disabled" if col_shape.disabled else "enabled"))
	elif subcmd == "toggle":
		var col_shape: CollisionShape2D = PlayerState.player_instance.get_child(0)
		col_shape.disabled = !col_shape.disabled
		print_info('collisions set to ' + str(!col_shape.disabled))
	elif subcmd == "help":
		print_info("available subcommands:")
		print_info("- get")
		print_info("- toggle")
		print_info("- help")
	else:
		return false
	
	return true
	
func cmd_help(_parts: Array[String]) -> bool:
	print_info("available commands:")
	for cmd in commands:
		print_info("- " + cmd)
	return true
	

func cmd_experience(parts: Array[String]) -> bool:
	var subcmd := get_or(parts, 0, "help")
	var str_value := get_or(parts, 1, "")
	
	if subcmd == "get":
		print_info("experience: %d / %d" % [PlayerState.experience, PlayerState.experience_to_level[PlayerState.level]])
	elif subcmd == "set":
		if !str_value.is_valid_int():
			return false
		var value := str_value.to_int()
		PlayerState.set_experience(value)
		cmd_experience(["get"])
	elif subcmd == "add":
		if !str_value.is_valid_int():
			return false
		var value := str_value.to_int()
		PlayerState.add_exp(value)
		cmd_experience(["get"])
	elif subcmd == "help":
		print_info("available subcommands:")
		print_info("- get")
		print_info("- set [amount]")
		print_info("- add [amount]")
		print_info("- help")
	else:
		return false
	return true
	
func cmd_stats(parts: Array[String]) -> bool:
	var subcmd := get_or(parts, 0, "help")
	
	if subcmd == "get":
		print_info("computed stats: %s" % [PlayerState.equipped_items.computed_stats_to_string()])
	elif subcmd == "help":
		print_info("available subcommands:")
		print_info("- get")
		print_info("- help")
	else:
		return false
	return true

func cmd_level(parts: Array[String]) -> bool:
	var subcmd := get_or(parts, 0, "help")
	var str_value := get_or(parts, 1, "")
	
	if subcmd == "get":
		print_info("level: %d / %d" % [PlayerState.level, PlayerState.MAX_LEVEL])
	elif subcmd == "set":
		if !str_value.is_valid_int():
			return false
		var value := str_value.to_int()
		PlayerState.set_level(value)
		cmd_level(["get"])
	elif subcmd == "add":
		if !str_value.is_valid_int():
			return false
		var value := str_value.to_int()
		PlayerState.set_level(PlayerState.level + value)
		cmd_level(["get"])
	elif subcmd == "help":
		print_info("available subcommands:")
		print_info("- get")
		print_info("- set [amount]")
		print_info("- add [amount]")
		print_info("- help")
	else:
		return false
	return true
