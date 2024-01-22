extends CharacterBody3D

var speed = 10
var roll_speed = 23
var rolling = false
var roll_timer = 0.5
var roll_direction = Vector3.ZERO
var brandonTimer = 0
var brandonScale = 1
var isDark = false
var health = 100

func _physics_process(delta):
	var velocity = Vector3.ZERO
	var moving = false
	if Input.is_action_just_pressed("ability"):
		isDark = true
	if isDark:
		brandonTimer += delta
	if brandonTimer >= 6:
		brandonTimer = 0
		isDark = 0
	# Handle inputs
	if not rolling:
		if Input.is_action_pressed("right"):
			velocity.x += 1
			moving = true
		if Input.is_action_pressed("left"):
			velocity.x -= 1
			moving = true
		if Input.is_action_pressed("down"):
			velocity.z += 1
			moving = true
		if Input.is_action_pressed("up"):
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
		if isDark:
			velocity = velocity * brandonScale + velocity
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.slide(collision.get_normal())
			move_and_collide(velocity * delta)

	# The update_animation function will need adjustments for the new setup.
	# Ensure the AnimatedSprite3D child node is properly updated.

# Adjust the update_animation function as needed for the new setup.
func get_player_type():
	return "democrat"
