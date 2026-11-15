extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var bouncePerBounce
var numCollision = 0





var speedMult = 1

@onready var nooting = $NootNoot
@onready var game = $".."
@onready var sprite = $"Penguie Sprite"

signal collision()




func _physics_process(delta: float) -> void:
	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		##velocity.y = JUMP_VELOCITY
#
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
	if velocity.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	
	
	if round(velocity) == Vector2(0,0):
		sprite.play("default")
	else:
		sprite.play("Slide")
	
	
	
	speedMult = game.penguinSpeedMult
	
	bouncePerBounce = game.bounceBounce
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())
		game.bounces += bouncePerBounce
		print(game.bounces)
		
		nooting.pitch_scale = randf() + randi_range(0,1)
		nooting.play()
		emit_signal("collision")
	



func launch(force : Vector2) -> void:
	velocity = (force + Vector2(randi_range(-20,20), randi_range(-20,20))) * speedMult





func speedIncrease():
	
	pass
