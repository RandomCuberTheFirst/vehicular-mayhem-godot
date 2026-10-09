extends TextureButton

@onready var main = get_tree().current_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_pressed() -> void:
	main.close_menu()
