extends CharacterBody3D

const ROTATION_SPEED = 10
var side_name = "right"
var rolling = false
var roll_timer = 0.5

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		# Right, Up-Right, or Up
		if Input.is_action_pressed("ui_down"): 
			side_name = "right"
		elif Input.is_action_pressed("ui_up"):
			side_name= "right"
		else:
			side_name = "right"
	elif Input.is_action_pressed("ui_left"):
		# Left, Up-Left, or Up coming from the left side
		if Input.is_action_pressed("ui_down"): 
			side_name = "left"
		elif Input.is_action_pressed("ui_up"):
			side_name = "left"
		else:
			side_name = "left"
	elif Input.is_action_pressed("ui_down"):
		side_name = "right"
	elif Input.is_action_pressed("ui_up"):
		side_name = "left"
	switch()

func switch():
	if side_name == "right":
		transform.origin = Vector3 (0.06, -0.02, 0);
	else:
		transform.origin = Vector3 (-0.06, -0.02, 0);
