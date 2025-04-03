extends CharacterBody2D

class_name Player

const InventoryPrefab := preload("res://prefabs/inventory_node.tscn")
const DebugConsolePrefab := preload("res://prefabs/debug_console.tscn")

var SPEED := 100.0
const RUN_SPEED_MULTIPLIER := 1.7

enum Direction { Left, Right, Up, Down }
var last_direction := Direction.Left

enum AnimationState { Busy, Ready }
var animation_state := AnimationState.Ready

var input_vector := Vector2.ZERO
var is_running := false
var is_inventory_open := false

var inventory: CanvasLayer = null
var debug_console : Control = null

func _ready() -> void:
	$AnimatedSprite2D.play("idle_front")
	PlayerState.player_instance = self
	PlayerState.inventory.store_item_quantity(Consts.ITEM_PLANT_FIBER.create_instance(), 15)
	PlayerState.inventory.store_item_quantity(Consts.ITEM_ROUGH_STONE.create_instance(), 15)
	PlayerState.inventory.store_item_quantity(Consts.ITEM_WOOD_LOG.create_instance(), 10)
	PlayerState.inventory.store_item(Consts.ITEM_ROPE.create_instance())
	PlayerState.inventory.store_item(Consts.ITEM_STONE_SWORD.create_instance())
	PlayerState.set_currency(Currency.ONE_SILVER * 15 + 100 * Currency.ONE_COPPER)

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_console"):
		if debug_console == null:
			debug_console = DebugConsolePrefab.instantiate()
			$CanvasLayer.add_child(debug_console)
		else:
			debug_console.toggle()
	if debug_console != null and debug_console.visible:
		return
	
	if Input.is_action_just_pressed("toggle_inventory"):
		is_inventory_open = !is_inventory_open
		
		if is_inventory_open:
			inventory = InventoryPrefab.instantiate()
			add_child(inventory)
		else:
			inventory.queue_free()
		
	
	if is_inventory_open:
		return
	
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	is_running = Input.is_action_pressed("sprint")
	
	velocity = input_vector * (SPEED * RUN_SPEED_MULTIPLIER if is_running else SPEED)
	move_and_slide()
	
	if Input.is_action_pressed("attack"):
		animation_state = AnimationState.Busy
		$AnimatedSprite2D.play("attack_right", 2)
		if last_direction == Direction.Left:
			$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.animation_finished.connect(func():
			animation_state = AnimationState.Ready
			$AnimatedSprite2D.flip_h = false
			handle_animation()
		)
	
	handle_animation()

func handle_animation():
	if animation_state != AnimationState.Ready:
		return
	
	var animation := ""
	if input_vector == Vector2.ZERO:
		if last_direction == Direction.Down:
			animation = "idle_front"
		elif last_direction == Direction.Left:
			animation = "idle_left"
		elif last_direction == Direction.Right:
			animation = "idle_right"
		elif last_direction == Direction.Up:
			animation = "idle_back"
	else:
		if input_vector.y > 0:
			animation = "run_down" if is_running else "walk_down"
			last_direction = Direction.Down
		if input_vector.y < 0:
			animation = "run_up" if is_running else "walk_up"
			last_direction = Direction.Up
		if input_vector.x > 0:
			animation = "run_right" if is_running else "walk_right"
			last_direction = Direction.Right
		if input_vector.x < 0:
			animation = "run_left" if is_running else "walk_left"
			last_direction = Direction.Left
	
	if animation != "":
		$AnimatedSprite2D.play(animation)
