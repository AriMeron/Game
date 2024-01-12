extends AnimatedSprite3D

var prev_mouse_position
var next_mouse_position
var speed = 7
var roll_speed = 15
var rolling = false
var roll_timer = 0.5
var roll_direction = Vector3.ZERO
var side_name = ""
var flip_h_value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector3.ZERO
	var moving = false
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
		flip_h_value = 1
		side_name = "right"
	elif Input.is_action_pressed("ui_up"):
		flip_h_value = 2
		side_name = "left"
	switch_hand()
	
func switch_hand():
	set_animation ("right")
	if side_name == "left":
		flip_h = true
		transform.origin = Vector3 (-0.2, -0.06, 0);
	elif side_name == "right":
		flip_h = false
		transform.origin = Vector3 (-0.08, -0.06, 0);
