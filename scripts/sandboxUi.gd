extends CanvasLayer

@onready var score = $score
@onready var speed = $speed
@onready var maxpeople = $"people_controls/max"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score.text = str($"/root/Globals".points) + " kills"
	speed.text = str(int(floor($"/root/Globals".speed))) + " MPH"
	maxpeople.text = str($"/root/Globals".MAX_PEOPLE)


func _on_more_pressed() -> void:
	$"/root/Globals".MAX_PEOPLE += 1


func _on_less_pressed() -> void:
	$"/root/Globals".MAX_PEOPLE -= 1
