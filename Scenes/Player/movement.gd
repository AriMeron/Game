extends CharacterBody3D

var speed = 7
var roll_speed = 15
var rolling = false
var roll_timer = 0.5
var roll_direction = Vector3.ZERO

func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

func _physics_process(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		var velocity = Vector3.ZERO
		var moving = false
		
		# Handle inputs
		if not rolling:
			if Input.is_action_pressed("ui_right"):
				velocity.x += 1
				moving = true
			if Input.is_action_pressed("ui_left"):
				velocity.x -= 1
				moving = true
			if Input.is_action_pressed("ui_down"):
				velocity.z += 1
				moving = true
			if Input.is_action_pressed("ui_up"):
				velocity.z -= 1
				moving = true
			if moving:
				velocity = velocity.normalized() * speed

		if Input.is_action_just_pressed("roll") and not rolling:
			rolling = true
			roll_timer = 0.6  # Reset the roll timer
			if moving:
				roll_direction = velocity.normalized()  # Set roll direction to current movement direction
			else:
				# Default roll direction if not moving
				roll_direction = Vector3(0, 0, 0.1667) 

		if rolling:
			if roll_timer > 0:
				velocity = roll_direction * roll_speed
				roll_timer -= delta
			else:
				rolling = false
				roll_direction = Vector3.ZERO

		# Apply movement using velocity
		if velocity.length() > 0:
			var collision = move_and_collide(velocity * delta)
			if collision:
				velocity = velocity.slide(collision.get_normal())
				move_and_collide(velocity * delta)

		# The update_animation function will need adjustments for the new setup.
		# Ensure the AnimatedSprite3D child node is properly updated.

# Adjust the update_animation function as needed for the new setup.
