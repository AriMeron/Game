extends AnimatedSprite3D

var prev_mouse_position
var next_mouse_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		next_mouse_position = get_viewport().get_mouse_position()
		rotate_z(-(next_mouse_position.y - prev_mouse_position.y) * .1 * delta)
		prev_mouse_position = next_mouse_position
