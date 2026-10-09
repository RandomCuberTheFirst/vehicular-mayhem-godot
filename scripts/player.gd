extends CharacterBody2D


const SPEED = 1.0
const MAX_SPEED = 100.0
const JUMP_VELOCITY = -400.0

var color = "red"

@onready var anim = $piviot/AnimationPlayer
@onready var sprite = $piviot/Sprite2D
@onready var collisonBox = $CollisionShape2D

func _ready() -> void:
	anim.play(color + "H")
	

func _physics_process(_delta: float) -> void:
	#movement
	var directionX := Input.get_axis("leftyloosey", "rightytighty")
	if directionX:
		if velocity.x < MAX_SPEED and velocity.x > -MAX_SPEED:
			velocity.x += directionX * SPEED
			$piviot.scale.x = directionX
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	var directionY := Input.get_axis("upsie", "down")
	if directionY:
		if velocity.y < MAX_SPEED and velocity.y > -MAX_SPEED:
			velocity.y += directionY * (SPEED*2/3)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	
	#animation
	if Input.is_action_pressed("upsie"):
		anim.play(color + "U")
		if Input.is_action_pressed("rightytighty"):
			sprite.rotation = 45
			collisonBox.rotation = 45
		elif Input.is_action_pressed("leftyloosey"):
			sprite.rotation = 45
			collisonBox.rotation = -45
		else:
			sprite.rotation = 0
			collisonBox.rotation = 0
	elif Input.is_action_pressed("down"):
		anim.play(color + "D")
		if Input.is_action_pressed("rightytighty"):
			sprite.rotation = -45
			collisonBox.rotation = -45
		elif Input.is_action_pressed("leftyloosey"):
			sprite.rotation = -45
			collisonBox.rotation = 45
		else:
			sprite.rotation = 0
			collisonBox.rotation = 0
	elif Input.is_action_pressed("leftyloosey") or Input.is_action_pressed("rightytighty"):
		anim.play(color + "H")
	
	#UI
	$"/root/Globals".speed = velocity.x
	
	move_and_slide()
