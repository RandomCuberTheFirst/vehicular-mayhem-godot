extends CanvasLayer

@onready var score = $score
@onready var speed = $Label
@onready var maxpeople = $max

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	score.text = str($"/root/Globals".points)
	speed.text = str($"/root/Globals".speed)
	maxpeople.text = str($"/root/Globals".MAX_PEOPLE)


func _on_more_pressed() -> void:
	$"/root/Globals".MAX_PEOPLE += 1


func _on_less_pressed() -> void:
	$"/root/Globals".MAX_PEOPLE -= 1
