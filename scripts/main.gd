extends Node2D

var current_menu = null
var current_scene = null

@onready var level_manager = $levelManager
@onready var menu_manager = $menuManager/menuManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	open_menu("res://scenes/color_select.tscn")
	set_level("res://scenes/levels/level_1.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("LET_ME_LEAVE_BITCH"):
		get_tree().quit()
		#open_menu("res://scene/menus/pausemenu.tscn")

func open_menu(menu_path: String):
	if current_menu:
		current_menu.queue_free()
		current_menu = null
	var new_menu_scene = load(menu_path)
	current_menu = new_menu_scene.instantiate()
	menu_manager.add_child(current_menu)
	get_tree().paused = true

func is_menu_open():
	if current_menu:
		return true
	else:
		return false

func close_menu():
	if current_menu:
		get_tree().paused = false
		current_menu.queue_free()
		current_menu = null

func set_level(scene_path):
	if $levelManager/player:
		var player = $levelManager/player
		player.position = Vector2(0,0)
	if current_scene:
		current_scene.queue_free()
		current_scene = null
	var new_scene = load(scene_path)
	current_scene = new_scene.instantiate()
	level_manager.add_child(current_scene)

func add_player():
	if get_node_or_null("levelManager/player"):
		$levelManager/player.queue_free()
	else:
		var new_player = load("res://assets/player/player.tscn")
		var current_player = new_player.instantiate()
		level_manager.add_child(current_player)
