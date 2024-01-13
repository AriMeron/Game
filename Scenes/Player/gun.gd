extends CharacterBody3D

var sensitivity = 0.1
var gun_offset = Vector3()  # Initialize gun_offset as a Vector3

func set_gun_offset(offset: Vector3):
	gun_offset = offset

func _process(delta):
	var screen_size = get_viewport().get_visible_rect().size
	var mouse_position = get_viewport().get_mouse_position()

	# Calculate the direction vector from character to mouse
	# Ensure that gun_offset is a Vector3
	var character_position = transform.origin + gun_offset
	var target_direction = (mouse_position - screen_size / 2).normalized()

	# Calculate the angle between the current direction and the target direction
	var angle = atan2(target_direction.y, target_direction.x)
	set_gun_offset(Vector3(1, 0, 0))  # This sets the offset 1 unit to the right of the character

	# Set the character's rotation to point towards the mouse
	set_rotation(Vector3(0, 0, -angle - 3.1415))
