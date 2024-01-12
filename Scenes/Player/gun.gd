extends CharacterBody3D
#
var sensitivity = 0.1

func _process(delta):
	var screen_size = get_viewport().get_visible_rect().size
	var mouse_position = get_viewport().get_mouse_position()

	# Calculate the direction vector from character to mouse
	var character_position = global_transform.origin
	var target_direction = (mouse_position - screen_size / 2).normalized()

	# Calculate the angle between the current direction and the target direction
	var angle = atan2(target_direction.y, target_direction.x)

	# Set the character's rotation to point towards the mouse
	set_rotation(Vector3(0, 0, -angle))
