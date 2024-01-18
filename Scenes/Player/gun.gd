extends CharacterBody3D

var sensitivity = 0.1
const ROTATION_SPEED = 10
var side_name = "right"
var roll_timer = 0.5
var rolling = false
var is_inverted = false

# Constants
const RAY_LENGTH = 1000
const BULLET_SPEED = 50 # Speed of the bullet
const BULLET_SCENE = preload("res://Scenes/Player/Bullet.tscn") # Path to the Bullet scene
var hand: CharacterBody3D
var origin
var cam
var intersects_with_floor = false

func _ready():
	hand = get_node_or_null("Node3D/Player/Hand")
	cam = $Camera3D


func _process(delta):
	var screen_size = get_viewport().get_visible_rect().size
	var mouse_position = get_viewport().get_mouse_position()

	# Calculate the direction vector from character to mouse
	var character_position = global_transform.origin
	var target_direction = (mouse_position - screen_size / 2).normalized()
	# Calculate the angle between the current direction and the target direction
	var angle = atan2(target_direction.y, target_direction.x)
	if angle > -1.5708 and angle < 1.5708:
		side_name = "right"
	else:
		side_name = "left"
	switch(angle)
	if Input.is_action_pressed("shoot"):
		recoil(angle)
		await(get_tree().create_timer(0.25))

func switch(angle):
	if side_name == "left":
		scale.x = abs(scale.x)
		angle = -angle + 3.1415
		set_rotation(Vector3(0, 0, angle))
	elif side_name == "right":
		scale.x = -abs(scale.x)  # Flip the scale to negative
		scale.z = -scale.z
		set_rotation(Vector3(0, 0, -angle))

func recoil(angle):
	var new_angle
	if side_name == "left":
		new_angle = -angle + 2.9
		set_rotation(Vector3(0, 0, new_angle))
	elif side_name == "right":
		new_angle = angle - 0.2
		set_rotation(Vector3(0, 0, -new_angle))

func hide_gun_rolling():
	visible = false
