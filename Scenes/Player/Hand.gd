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
	
	switch()

func switch():
	if side_name == "right":
		transform.origin = Vector3(0.06, -0.02, 0)
	else:
		transform.origin = Vector3(-0.06, -0.02, 0)
