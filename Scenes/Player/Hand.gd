extends CharacterBody3D

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		transform.origin = Vector3 (0.06, -0.02, 0);
	if Input.is_action_pressed("ui_left"):
		transform.origin = Vector3 (-0.06, -0.02, 0);
