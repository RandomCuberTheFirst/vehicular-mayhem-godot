extends CharacterBody2D


const SPEED = 1.0
var MAX_SPEED = 100.0
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
	var directionY := Input.get_axis("upsie", "down")
	if directionX and directionY: MAX_SPEED = 50.0
	else: MAX_SPEED = 100.0
	if directionX:
		if velocity.x < MAX_SPEED and velocity.x > -MAX_SPEED:
			velocity.x += directionX * SPEED
			$piviot.scale.x = directionX
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	
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
	$"/root/Globals".speed = sqrt(velocity.x**2+velocity.y**2)
	
	#sound
	if velocity != Vector2(0,0):
		if $engineSound.playing == false:
			$engineSound.playing = true
		$engineSound.pitch_scale = $"/root/Globals".speed*2/100
		$engineSound.volume_db = ($"/root/Globals".speed/100)*20-10
	else:
		$engineSound.playing = false
	# *2/100
	move_and_slide()
