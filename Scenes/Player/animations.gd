extends AnimatedSprite3D

var speed = 7
var roll_speed = 15
var rolling = false
var roll_timer = 0.5
var roll_direction = Vector3.ZERO


func _physics_process(delta):
	var movement = Vector3.ZERO
	var moving = false
	
	# Handle inputs
	if not rolling:
		if Input.is_action_pressed("ui_right"):
			movement.x += 1
			moving = true
		if Input.is_action_pressed("ui_left"):
			movement.x -= 1
			moving = true
		if Input.is_action_pressed("ui_down"):
			movement.z += 1
			moving = true
		if Input.is_action_pressed("ui_up"):
			movement.z -= 1
			moving = true
		if moving:
			movement = movement.normalized() * speed * delta
	if Input.is_action_just_pressed("roll") and not rolling:
		rolling = true
		roll_timer = 0.6  # Reset the roll timer
		print(movement)
		if moving:
			roll_direction = movement  # Set roll direction to current movement direction
		else:
			#TODO dont hardcode this lol
			roll_direction = Vector3(0, 0, 0.1667) 
	if rolling:
		if roll_timer > 0:
			movement = roll_direction * roll_speed * delta * speed
			roll_timer -= delta
		else:
			rolling = false
			roll_direction = Vector3.ZERO
	# Normalize the movement if there is any
	if movement.length() > 0:
		#global_transform.origin += movement
		update_animation(movement)
	else:
		# Stop the animation if not moving
		play("idle")



func update_animation(movement: Vector3):
	var anim_name = ""
	var flip_h_value = 0
	
	if rolling:
		anim_name = "roll_diag"
	else:
		# Determine the animation based on movement
		if Input.is_action_pressed("ui_right"):
			# Right, Up-Right, or Up
			flip_h_value = 1
			if Input.is_action_pressed("ui_down"): 
				anim_name = "walk_forward"
			elif Input.is_action_pressed("ui_up"):
				anim_name = "walk_diag"
			else:
				anim_name = "walk_side"
		elif Input.is_action_pressed("ui_left"):
			# Left, Up-Left, or Up coming from the left side
			flip_h_value = 2
			if Input.is_action_pressed("ui_down"): 
				anim_name = "walk_forward"
			elif Input.is_action_pressed("ui_up"):
				anim_name = "walk_diag"
			else:
				anim_name = "walk_side"
		elif Input.is_action_pressed("ui_down"):
			anim_name = "walk_forward"
		elif Input.is_action_pressed("ui_up"):
			anim_name = "walk_up"
	# Set the animation and flip_h property
	if anim_name != "":
		play(anim_name)
		if flip_h_value == 1:
			flip_h = false  # Correctly use the flip_h_value variable
		elif flip_h_value == 2:
			flip_h = true
	else:
		play("idle")
