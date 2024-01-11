extends Marker3D
var mouse_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_pos = get_mouse_position();
