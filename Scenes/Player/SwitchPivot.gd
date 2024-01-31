extends Node3D
var side_name = "right"

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
		
	setPoint()
	
func setPoint():
	if side_name == "right":
		transform.origin = Vector3 (0.015, -0.02, 0);
	elif side_name == "left":
		transform.origin = Vector3 (-0.01, -0.02, 0);
