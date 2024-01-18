extends CharacterBody3D

const ROTATION_SPEED = 10
var side_name = "right"
var rolling = false
var roll_timer = 0.5

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
	var target_direction = (mouse_position - screen_size / 2).normalized()

	# Calculate the angle between the current direction and the target direction
	var angle = atan2(target_direction.y, target_direction.x)
	if angle > -1.5708 and angle < 1.5708:
		side_name = "right"
	else:
		side_name = "left"
	switch()

func switch():
	if side_name == "right":
		transform.origin = Vector3(0.06, -0.04, 0)
	else:
		transform.origin = Vector3(-0.06, -0.04, 0)
