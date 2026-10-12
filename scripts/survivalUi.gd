extends CanvasLayer

@onready var score = $score
@onready var speed = $speed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score.text = str($"/root/Globals".points) + " kills"
	if $"/root/Globals".speed < 100:
		if $"/root/Globals".speed < 10:
			speed.text = "00" + str(int(floor($"/root/Globals".speed))) + " MPH"
		else:
			speed.text = "0" + str(int(floor($"/root/Globals".speed))) + " MPH"
	else:
		speed.text = str(int(floor($"/root/Globals".speed))) + " MPH"
