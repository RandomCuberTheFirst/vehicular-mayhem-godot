extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var num = randi_range(0, 35)
	var numStr = str(num)
	if num < 10:
		numStr = "0" + numStr
	$Splat.texture = load("res://resources/blood/splat"+numStr+".png")
	await get_tree().create_timer(0.5).timeout
	queue_free()
