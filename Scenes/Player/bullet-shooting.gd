extends Node3D

# Constants
const RAY_LENGTH = 1000
const BULLET_SPEED = 50 # Speed of the bullet
const BULLET_SCENE = preload("res://Scenes/Player/Bullet.tscn") # Path to the Bullet scene
var hand: CharacterBody3D
var origin
var cam
var intersects_with_floor = false
var side_name = "right"

func _ready():
	hand = get_node_or_null("Node3D/Player/Hand")
	cam = $Camera3D

func _process(delta):
	var screen_size = get_viewport().get_visible_rect().size
	var mouse_position = get_viewport().get_mouse_position()

#	var character_position = transform.origin + gun_offset
	var target_direction = (mouse_position - screen_size / 2).normalized()

	# Calculate the angle between the current direction and the target direction
	var angle = atan2(target_direction.y, target_direction.x)
	if angle > -1.5708 and angle < 1.5708:
		side_name = "right"
	else:
		side_name = "left"
	if Input.is_action_pressed("shoot"):
		shoot_bullet()

func shoot_bullet(y_height: float = 2.0):
	var bullet_spawn = get_node("Player/Hand/Gun/BulletSpawn")  # Get BulletSpawn node
	if not bullet_spawn:
		print("BulletSpawn node not found")
		return

	var bullet_instance = BULLET_SCENE.instantiate()
	bullet_instance.global_transform = bullet_spawn.global_transform
	add_child(bullet_instance)

	# Convert mouse position to 3D world space
	var mouse_pos = get_viewport().get_mouse_position()
	var from = cam.project_ray_origin(mouse_pos)
	var to = from + cam.project_ray_normal(mouse_pos) * RAY_LENGTH

	# Use the camera's projection to find the z-coordinate in 3D space
	# that corresponds to the mouse's y-coordinate
	var projected_z = (from.z + (to.z - from.z) * ((y_height - from.y) / (to.y - from.y)))

	# Create a target position using the mouse's x, a constant y, and the calculated z
	var target_pos_3d = Vector3(from.x, y_height, projected_z)

	# Calculate direction vector
	var direction = (target_pos_3d - bullet_spawn.global_transform.origin).normalized()
	bullet_instance.linear_velocity = direction * BULLET_SPEED
