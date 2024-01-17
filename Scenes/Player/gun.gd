extends CharacterBody3D

var sensitivity = 0.1
var gun_offset = Vector3()  # Initialize gun_offset as a Vector3
const ROTATION_SPEED = 10
var side_name = "right"
var rolling = false
var roll_timer = 0.5
var min_angle # 45 degrees to the left
var max_angle # 45 degrees to the right
var is_inverted = false

func set_gun_offset(offset: Vector3):
	gun_offset = offset

func _process(delta):

	var screen_size = get_viewport().get_visible_rect().size
	var mouse_position = get_viewport().get_mouse_position()

	# Calculate the direction vector from character to mouse
	var character_position = global_transform.origin + gun_offset
#	var character_position = transform.origin + gun_offset
	var target_direction = (mouse_position - screen_size / 2).normalized()

	# Calculate the angle between the current direction and the target direction
	var angle = atan2(target_direction.y, target_direction.x)
	if angle > -1.5708 and angle < 1.5708:
		side_name = "right"
	else:
		side_name = "left"
	switch(angle)
		# Flip the object horizontally based on side_name

func switch(angle):
	invert_character()
	if side_name == "left":
		scale.x = abs(scale.x)
		angle = -angle + 3.1415
		set_rotation(Vector3(0, 0, angle))
		transform.origin = Vector3(-0.12, 0.025, 0)
	elif side_name == "right":
		scale.x = -abs(scale.x)  # Flip the scale to negative
		scale.z = -scale.z
		set_rotation(Vector3(0, 0, -angle))
		transform.origin = Vector3(0.0, 0.025, 0)
	
func invert_character():
	is_inverted = !is_inverted  # Toggle the inversion state
	scale.y = -scale.y  # Flip the scale on the y-axis to invert the character

