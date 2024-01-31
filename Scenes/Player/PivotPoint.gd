extends Node3D

var side_name = "right"
var sensitivity = 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	var screen_size = get_viewport().get_visible_rect().size
	var mouse_position = get_viewport().get_mouse_position()
	
	# Calculate the direction vector from pivot to mouse
	var pivot_position = global_transform.origin
	var target_direction = (mouse_position - screen_size / 2).normalized()
	
	# Calculate the angle between the current direction and the target direction
	var angle = atan2(target_direction.y, target_direction.x)
	
	# Set the pivot node's rotation to pivot both sibling nodes
	rotation_degrees.z = -angle

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
	switchPivot()
	
func switchPivot():
	if side_name == "right":
		position = Vector3(-0.081, -0.026, -0.006)
	elif side_name == "left":
		position = Vector3(-0.22, -0.026, -0.006)
