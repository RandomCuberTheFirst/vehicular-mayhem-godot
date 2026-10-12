extends CharacterBody2D

const sprite = ["blake", "bob", "karen", "kate"]
const SPEED = 40.0
const BLOOD = preload("res://scenes/blood.tscn")
var bleedout = false
var direction: Vector2
var scared = false

var player = null

@onready var character = sprite[randi_range(0,3)]
@onready var animSprite = $AnimatedSprite2D
@onready var global = $"/root/Globals"
@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@onready var wander_point = global_position + Vector2(randi_range(-20,20),(randi_range(-20,20)))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animSprite.play(character + "I")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#movement and movement styles
	if scared:
		run_away(delta)
	else:
		wander(delta)
	
	if navigation_agent_2d.is_target_reached() == false:
		velocity = velocity.lerp(direction * SPEED, delta)
	
	#animation
	if animSprite.animation != character + "D":
		if is_moving():
			if animSprite.animation != character + "W":
				animSprite.play(character + "W")
		elif animSprite.animation == character + "W":
			animSprite.play(character + "I")
	
	#blood
	if animSprite.get_self_modulate() == Color(0.925, 0.0, 0.18, 1.0):
		if not bleedout:
			if is_moving():
				add_blood()
	
	move_and_slide()

# navigation
func run_away(delta):
	navigation_agent_2d.target_position = global.hospitalPos
	direction = global_position.direction_to(navigation_agent_2d.get_next_path_position())
	if navigation_agent_2d.is_target_reached() == false:
		velocity = velocity.lerp(direction * SPEED, delta)

func wander(delta):
	navigation_agent_2d.target_position = wander_point
	direction = global_position.direction_to(navigation_agent_2d.get_next_path_position())
	if navigation_agent_2d.is_target_reached() == false:
		velocity = velocity.lerp(direction * (SPEED*0.1), delta)
	else:
		wander_point = global_position + Vector2(randi_range(-20,20),(randi_range(-20,20)))

# blood effect
func add_blood():
	bleedout = true
	var blud = BLOOD.instantiate()
	blud.position = position
	get_parent().add_child(blud)
	await get_tree().create_timer(0.1).timeout
	bleedout = false

func is_moving():
	if velocity != Vector2(0,0):
		return true
	else:
		return false

# death
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body:
		player = body
		animSprite.set_self_modulate(Color(0.925, 0.0, 0.18, 1.0))
		velocity = player.velocity
		$"/root/Globals".points += 1
		animSprite.animation = character + "D"
		get_node("scream" + str(randi_range(1, 3))).playing = true
		await get_tree().create_timer(1).timeout
		queue_free()
		global.people -= 1

func _on_area_2d_body_exited(_body: Node2D) -> void:
	player = null

# enter hospital
func _on_hospital_area_entered(_area: Area2D) -> void:
	global.people -= 1
	queue_free()

# run when person killed
	# detect person killed near by
func _on_warning_radius_body_entered(body: Node2D) -> void:
	scared = true
