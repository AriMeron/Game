extends AnimatedSprite3D

var speed = 7
var roll_speed = 15
var rolling = false
var roll_timer = 0.5
var roll_direction = Vector3.ZERO
var prevMove = "idle_side"
var startedRollingAnim = false
var flip_h_value = 0




func _physics_process(delta):
	var hand_node = get_parent().get_node("Gun")
	var gunModel = hand_node.get_node("RotationHelper/Gun")
	var angle_degrees = hand_node.angle_degrees
	var movement = Vector3.ZERO
	var moving = false

	# Handle inputs
	if not rolling:
		if Input.is_action_pressed("right"):
			movement.x += 1
			moving = true
		if Input.is_action_pressed("left"):
			movement.x -= 1
			moving = true
		if Input.is_action_pressed("down"):
			movement.z += 1
			moving = true
		if Input.is_action_pressed("up"):
			movement.z -= 1
			moving = true
		if moving:
			movement = movement.normalized() * speed * delta
	if Input.is_action_just_pressed("roll") and not rolling:
		rolling = true
		hand_node.visible = false
		roll_timer = 0.6  # Reset the roll timer
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
			startedRollingAnim = false
			hand_node.visible = true
			roll_direction = Vector3.ZERO
	# Normalize the movement if there is any
	if rolling and not startedRollingAnim:
		startedRollingAnim = true
		if Input.is_action_pressed("right"):
			# Right, Up-Right, or Up
			flip_h = false
			if Input.is_action_pressed("down"): 
				play("roll_side")
			elif Input.is_action_pressed("up"):
				play("roll_diag")
			else:
				play("roll_side")
		elif Input.is_action_pressed("left"):
			# Left, Up-Left, or Up coming from the left side
			flip_h = true
			if Input.is_action_pressed("down"): 
				play("roll_side")
			elif Input.is_action_pressed("up"):
				play("roll_diag")
			else:
				play("roll_side")
		elif Input.is_action_pressed("down"):
			play("roll_forward")
		elif Input.is_action_pressed("up"):
			play("roll_up")
		else:
			play("roll_forward")
	elif not startedRollingAnim:
		if angle_degrees <= 90 and angle_degrees >= -90:
			flip_h = false
			gunModel.flip_h = true
			gunModel.flip_v = false
			hand_node.flipGun = false
			if hand_node.position.x < 0:
				hand_node.position.x *= -1
				gunModel.position.y += .025
			if angle_degrees > 75:
				if movement.length() >0:
					play("walk_up")
				else:
					play("idle_up")
			elif angle_degrees <= 75 and angle_degrees >= 50:
				if movement.length() >0:
					play("walk_diag")
				else:
					play("idle_diag")
			elif angle_degrees < 50 and angle_degrees > -60:
				if movement.length() >0:
					play("walk_side")
				else:
					play("idle_side")
			else:
				if movement.length() >0:
					play("walk_forward")
				else:
					play("idle_forward")
		else:
			flip_h = true
			gunModel.flip_h = true
			gunModel.flip_v = true
			hand_node.flipGun = true
			if hand_node.position.x > 0:
				hand_node.position.x *= -1
				gunModel.position.y -= .025
			if angle_degrees < 105 and angle_degrees > 0:
				if movement.length() >0:
					play("walk_up")
				else:
					play("idle_up")
			elif angle_degrees >= 105 and angle_degrees <= 140:
				if movement.length() >0:
					play("walk_diag")
				else:
					play("idle_diag")
			elif angle_degrees > 140 or angle_degrees < -120:
				if movement.length() >0:
					play("walk_side")
				else:
					play("idle_side")
			else:
				if movement.length() >0:
					play("walk_forward")
				else:
					play("idle_forward")
			

		

