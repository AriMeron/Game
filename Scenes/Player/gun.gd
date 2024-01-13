extends CharacterBody3D

var sensitivity = 0.1
var gun_offset = Vector3()  # Initialize gun_offset as a Vector3
const ROTATION_SPEED = 10
var side_name = "right"
var rolling = false
var roll_timer = 0.5
var min_angle # 45 degrees to the left
var max_angle # 45 degrees to the right



func set_gun_offset(offset: Vector3):
	gun_offset = offset

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		if Input.is_action_pressed("ui_down"):
			side_name = "left"  # Left and Down pressed
		elif Input.is_action_pressed("ui_up"):
			side_name = "left"  # Left and Up pressed
		else:
			side_name = "left"  # Only Left pressed
	elif Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("ui_down"):
			side_name = "right"  # Right and Down pressed
		elif Input.is_action_pressed("ui_up"):
			side_name = "right"  # Right and Up pressed
		else:
			side_name = "right"  # Only Right pressed

	var screen_size = get_viewport().get_visible_rect().size
	var mouse_position = get_viewport().get_mouse_position()

	# Calculate the direction vector from character to mouse
	var character_position = global_transform.origin + gun_offset
	var target_direction = (mouse_position - screen_size / 2).normalized()

	# Calculate the angle between the current direction and the target direction
	var angle = atan2(target_direction.y, target_direction.x)
	
		# Flip the object horizontally based on side_name
	if side_name == "left":
		scale.x = abs(scale.x)
		angle = -angle + 3.1415
#		min_angle = 5
#		max_angle = 8
#		print(angle)
#		angle = clamp(angle, min_angle, max_angle)  # Ensure the scale is positive
		set_rotation(Vector3(0, 0, angle))
	elif side_name == "right":
		scale.x = -abs(scale.x)  # Flip the scale to negative
		max_angle = 1.7
		min_angle = -0.9
		angle = clamp(angle, min_angle, max_angle)
		print(angle)
		set_rotation(Vector3(0, 0, -angle))
