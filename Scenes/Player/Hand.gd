extends CharacterBody3D

const ROTATION_SPEED = 10

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		transform.origin = Vector3 (0.06, -0.02, 0);
	if Input.is_action_pressed("ui_left"):
		transform.origin = Vector3 (-0.06, -0.02, 0);
	if Input.is_action_pressed("ui_down"):
		transform.origin = Vector3 (-0.06, -0.02, 0);
	if Input.is_action_pressed("ui_up"):
		transform.origin = Vector3 (-0.06, -0.02, 0);
	
	var rotation_amount = Input.get_action_strength("turn") * ROTATION_SPEED * delta
	rotate_z(rotation_amount)
