extends CharacterBody2D

const speed = 100
const JUMP_VELOCITY = -240
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jump_count = 0
	
	if Input.is_action_pressed("jump") and (is_on_floor() or jump_count < 10):
		velocity.y = JUMP_VELOCITY
		if !is_on_floor():
			jump_count += 1
	
	move_and_slide()
	
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.flip_h = velocity.x < 0
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.flip_h = 0
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
