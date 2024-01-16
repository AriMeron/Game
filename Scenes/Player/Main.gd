extends Node3D

# Constants
const RAY_LENGTH = 1000
const BULLET_SPEED = 50 # Speed of the bullet
const BULLET_SCENE = preload("res://Scenes/Player/Bullet.tscn") # Path to the Bullet scene
var hand: CharacterBody3D
var origin
var cam

func _ready():
	hand = get_node_or_null("Node3D/Player/Hand")
	cam = $Camera3D

func _physics_process(delta):
	hand = get_node("Player/Hand")
	if hand:
		origin = hand.global_transform.origin
	else:
		print("CharacterBody3D node is null")
		origin = Vector3.ZERO  # Or handle the null case as needed
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()
	var end = origin + cam.project_ray_normal(mousepos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)

	# Shooting a bullet
	if Input.is_action_just_pressed("shoot"):
		print("shoot")
		shoot_bullet()
		print (origin)
		print (end)
func shoot_bullet():
	var camera = get_node_or_null("Camera3D")
	if camera == null:
		print("Camera node not found")
		return

	var bullet_instance = BULLET_SCENE.instantiate()
	add_child(bullet_instance)
	var initial_z = 2
	bullet_instance.global_transform.origin = camera.global_transform.origin

	var mouse_pos = get_viewport().get_mouse_position()
	var from = camera.project_ray_origin(mouse_pos)
	var to = from + camera.project_ray_normal(mouse_pos) * RAY_LENGTH
	var query_parameters = PhysicsRayQueryParameters3D.new()
	query_parameters.from = from
	query_parameters.to = to
	var space_state = get_world_3d().direct_space_state
	var result = space_state.intersect_ray(query_parameters)

	var target_pos
	if result:
		target_pos = result.position
	else:
		# If the raycast doesn't hit anything, use the 'to' position as the target
		target_pos = to
	# Maintain constant Z-axis level
	target_pos.z = initial_z
	var direction = (target_pos - camera.global_transform.origin).normalized()
	bullet_instance.linear_velocity = direction * BULLET_SPEED

#	var camera = get_node_or_null("Camera3D")
#	if camera == null:
#		print("Camera node not found")
#		return
#
#	var bullet_instance = BULLET_SCENE.instantiate()
#	add_child(bullet_instance)
#	bullet_instance.global_transform.origin = camera.global_transform.origin
#
#	var mouse_pos = get_viewport().get_mouse_position()
#	var from = camera.project_ray_origin(mouse_pos)
#	var to = from + camera.project_ray_normal(mouse_pos) * 1000
#	var query_parameters = PhysicsRayQueryParameters3D.new()
#	query_parameters.from = from
#	query_parameters.to = to
#	var space_state = get_world_3d().direct_space_state
#	var result = space_state.intersect_ray(query_parameters)
#
#	if result:
#		var target_pos = result.position
#		var direction = (target_pos - camera.global_transform.origin).normalized()
#		bullet_instance.linear_velocity = direction * BULLET_SPEED
#	else:
#		bullet_instance.queue_free()  # Remove the bullet if it doesn't hit anything
