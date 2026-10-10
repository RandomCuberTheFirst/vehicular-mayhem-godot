extends Control

@onready var main = get_tree().current_scene

func _on_button_pressed() -> void:
	main.close_menu()


func _on_button_2_pressed() -> void:
	main.le
