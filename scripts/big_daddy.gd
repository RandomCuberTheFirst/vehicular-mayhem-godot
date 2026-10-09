extends Node2D

@onready var level = get_parent()
@onready var global = $"/root/Globals"

const PERSON = preload("res://scenes/person.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if global.people < global.MAX_PEOPLE:
		var person = PERSON.instantiate()
		person.global_position = get_node("Marker2D" + str(randi_range(1,27))).global_position
		level.add_child(person)
		global.people+= 1
