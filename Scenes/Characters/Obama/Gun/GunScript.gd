extends Sprite3D

var reference_resolution = Vector2(1280, 720)
var hand_pos_relative = Vector2(0.5, 0.5) # Relative position (50% of width and height)

var angle_degrees = 0
@onready
var rotationHelp = get_node("RotationHelper")
@onready
var body = get_parent()
@onready
var hand = get_node(".")
@onready
var cam = get_parent().get_node("ObamaCam")

var flipGun = false



# Recoil variables
var original_position_right = Vector3()
var original_position_left = Vector3()
var current_recoil = 0.0
var max_recoil = 0.035 # Maximum recoil offset
var recoil_step = 0.03 # Recoil increase per click
var recoil_recovery_speed = 0.4 # Speed of recoil recovery
var current_recoil_rotation = 0
var max_recoil_rotation = 25
var recoil_rotation_step = 25
var recoil_recovery_rotation_speed = 160

var ogHandPos = Vector3()
#fireRate is timeUntil can shoot again
var fireRate = .2
var shotTimer = 0
var canShoot = true
@onready
var bullet_spawn = get_node("RotationHelper/Gun/BulletSpawn")
func _ready():
	original_position_right = rotationHelp.position
	original_position_left = original_position_right
	#original_position_left.y -= .025
	ogHandPos = hand.position

func _process(delta):
	var window_size = get_viewport().get_size()
	var hand_pos = Vector2( hand_pos_relative.x * window_size.x, hand_pos_relative.y * window_size.y )
	# Calculate the hand positions based on the current window size

	var mouse_pos = get_viewport().get_mouse_position()
	var angle_to_mouse = 0
	angle_to_mouse = atan2(mouse_pos.y - hand_pos.y, mouse_pos.x - hand_pos.x)


	# Convert the angle to degrees and clamp it
	angle_degrees = rad_to_deg(-1 * angle_to_mouse)

	rotationHelp.rotation.z = deg_to_rad(angle_degrees)

	if Input.is_action_pressed("click"):
		if canShoot:
			current_recoil += recoil_step
			current_recoil = min(current_recoil, max_recoil)
			current_recoil_rotation += recoil_rotation_step
			current_recoil_rotation = min(current_recoil_rotation, max_recoil_rotation)
			canShoot = false
			if body.rolling == false: 
				shoot_bullet(mouse_pos, angle_degrees)
				#create_bullet_explosion_particle()
	if current_recoil > 0.0 or current_recoil_rotation > 0.0:
		current_recoil -= recoil_recovery_speed * delta
		current_recoil = max(current_recoil, 0.0)
		current_recoil_rotation -= recoil_recovery_rotation_speed * delta
		current_recoil_rotation = max(current_recoil_rotation, 0.0)
	
	if not canShoot:
		shotTimer += delta
	if shotTimer > fireRate:
		canShoot = true
		shotTimer = 0
		
		
	if not flipGun:
		hand.position.y = ogHandPos.y + current_recoil
		hand.position.x = ogHandPos.x - current_recoil
		rotationHelp.rotation.z = deg_to_rad(angle_degrees) + deg_to_rad(current_recoil_rotation)
		#gunModel.rotation.z = deg_to_rad(current_recoil_rotation)
	else:
		hand.position.y =  ogHandPos.y + current_recoil
		hand.position.x = - 1 * ogHandPos.x + current_recoil
		rotationHelp.rotation.z = deg_to_rad(angle_degrees) - deg_to_rad(current_recoil_rotation)
		#gunModel.rotation.z = - deg_to_rad(current_recoil_rotation)

var BULLET_SCENE = preload("res://Scenes/Characters/Joe Biden/Gun/bullet.tscn")
const BULLET_SPEED = 20
const RAY_LENGTH = 1000

func shoot_bullet(mouse_pos, angle):
	#YOU HAVE TO USE THE CAMERA :(((((
	var y_height = 2
	var bullet_instance = BULLET_SCENE.instantiate()
	get_tree().get_root().add_child(bullet_instance)
	# Extract only the global X and Z position
	var spawn_pos = bullet_spawn.global_transform.origin
	spawn_pos.y = y_height  # Set Y to a constant value
	# Apply the position to the bullet instance
	var window_size = get_viewport().get_size()
	bullet_instance.global_transform.origin = Vector3(spawn_pos.x, y_height, spawn_pos.z)
	var from = cam.project_ray_origin(mouse_pos)
	var to = from + cam.project_ray_normal(mouse_pos) * RAY_LENGTH
	# Use the camera's projection to find the z-coordinate in 3D space
	var projected_z = (from.z + (to.z - from.z) * ((y_height - from.y) / (to.y - from.y)))

	# Create a target position using the mouse's x, a constant y, and the calculated z
	var target_pos_3d = Vector3(from.x, y_height, projected_z)

	var direction = (target_pos_3d - spawn_pos).normalized()

	# Add a random bloom to the direction
	var bloom_amount = 0.09  # Adjust this value for more/less bloom
	direction.x += randf_range(-bloom_amount, bloom_amount)
	direction.z += randf_range(-bloom_amount, bloom_amount)
	direction = direction.normalized()  # Re-normalize the direction vector
	if angle < 90 and angle > -90 and direction.x < 0:
		direction.x *= -1
	elif (angle > 90 or angle < -90) and direction.x > 0:
		direction.x *= -1
	
		
	
	# Store the direction for use in the bullet's script
	if typeof(body.velo) == 2:
		bullet_instance.initial_direction = direction * BULLET_SPEED
	elif body.velo.x != 0 or body.velo.y != 0:
		bullet_instance.initial_direction = direction * BULLET_SPEED * (abs(sqrt(body.velo.x * body.velo.x + body.velo.z * body.velo.z)) * .1)
	else:
		bullet_instance.initial_direction = direction * BULLET_SPEED
	


	
	




var BulletCasingParticle = preload("res://Scenes/Characters/Joe Biden/Particles/BulletCasingParticle.tscn")

var BulletExplosionParticle = preload("res://Scenes/Characters/Joe Biden/Particles/BulletParticle.tscn")
func create_bullet_casing_particle():
	var particle = BulletCasingParticle.instantiate()
	particle.position.z = 0.1
	if flipGun:
		particle.get_child(0).set_velocity_direction(Vector3(2, -1, 0))
	else:
		particle.get_child(0).set_velocity_direction(Vector3(-2, -1, 0))
	get_child(0).get_child(0).add_child(particle)
	
func create_bullet_explosion_particle():
	var particle = BulletExplosionParticle.instantiate()
	particle.position.x = 0.07
	if flipGun:
		particle.position.y = 0.02
	else :
		particle.position.y = -0.02
	get_child(0).get_child(0).add_child(particle)
	
