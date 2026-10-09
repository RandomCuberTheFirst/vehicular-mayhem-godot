extends CharacterBody2D
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var global = $"/root/Globals"
const SPEED = 80
var direction: Vector2

func _physics_process(delta: float) -> void:
	navigation_agent_2d.target_position = global.hospitalPos
	direction = global_position.direction_to(navigation_agent_2d.get_next_path_position())
	
	if navigation_agent_2d.is_target_reached() == false:
		velocity = velocity.lerp(direction * SPEED, delta)
	
	move_and_slide()
