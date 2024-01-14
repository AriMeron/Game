extends Node3D

# Constants
const RAY_LENGTH = 1000
const BULLET_SPEED = 10 # Speed of the bullet
const BULLET_SCENE = preload("res://Scenes/Player/Bullet.tscn") # Path to the Bullet scene
var hand: CharacterBody3D
var origin

func _ready():
	hand = get_node_or_null("Node3D/Player/Hand")

func _physics_process(delta):
	hand = get_node("Player/Hand")
	if hand:
		origin = hand.global_transform.origin
	else:
		print("CharacterBody3D node is null")
		origin = Vector3.ZERO  # Or handle the null case as needed
	var space_state = get_world_3d().direct_space_state
	var cam = $Camera3D
	var mousepos = get_viewport().get_mouse_position()
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)

	# Shooting a bullet
	if Input.is_action_just_pressed("shoot"):
		print("shoot")
		shoot_bullet(origin, end)
		print (origin)
		print (end)

func shoot_bullet(origin, end):
	var bullet_instance = BULLET_SCENE.instantiate()
	add_child(bullet_instance)
	bullet_instance.global_transform.origin = origin

	# Calculate the direction to shoot the bullet
	var direction = (end - origin).normalized()
	bullet_instance.look_at(end, Vector3.UP) # Ensure bullet faces towards the target
	bullet_instance.linear_velocity = direction * BULLET_SPEED # Set the bullet's velocity

	# Optionally, handle bullet's life time or collision signals here
