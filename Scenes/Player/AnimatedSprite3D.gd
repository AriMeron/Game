extends AnimatedSprite3D

var prev_mouse_position
var next_mouse_position
var speed = 7
var roll_speed = 15
var rolling = false
var roll_timer = 0.5
var roll_direction = Vector3.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not rolling:
		if Input.is_action_pressed("ui_right"):
			set_animation ("right");
		if Input.is_action_pressed("ui_left"):
			set_animation("left")
		if Input.is_action_pressed("ui_down"):
			set_animation("down")
		if Input.is_action_pressed("ui_up"):
			set_animation("up")
