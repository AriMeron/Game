extends CharacterBody3D

var prev_mouse_position
var next_mouse_position
var speed = 7
var roll_speed = 15
var rolling = false
var roll_timer = 0.5
var roll_direction = Vector3.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	prev_mouse_position = get_viewport().get_mouse_position()
	rotate_z((prev_mouse_position.x - prev_mouse_position.x)	* .1 * delta)
	
	var velocity = Vector3.ZERO
	var moving = false
	if not rolling:
		if Input.is_action_pressed("ui_right"):
			transform.origin = Vector3 (0.05, -0.097, 0);
		if Input.is_action_pressed("ui_left"):
			transform.origin = Vector3 (-0.05, -0.097, 0);
		if Input.is_action_pressed("ui_down"):
			transform.origin = Vector3 (-0.223, -0.097, 0);
		if Input.is_action_pressed("ui_up"):
			transform.origin = Vector3 (-0.223, -0.097, 0);

	# Apply movement using velocity
	if velocity.length() > 0:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.slide(collision.get_normal())
			move_and_collide(velocity * delta)
