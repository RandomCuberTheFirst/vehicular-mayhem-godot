extends Control

@onready var main = get_tree().current_scene

func _on_start_pressed() -> void:
	main.open_menu("res://scenes/game_mode_select.tscn")
