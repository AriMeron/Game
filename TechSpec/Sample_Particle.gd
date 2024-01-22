extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 10
	if Input.is_action_pressed("move_left"):
		velocity.x -= 10
	if Input.is_action_pressed("move_down"):
		velocity.y += 10
	if Input.is_action_pressed("move_up"):
		velocity.y -= 10

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$Obama.play()
	else:
		$Obama.stop()
	
	position += velocity * delta
	$Obama.position = position
	
	if Input.is_action_pressed("create_particle"):
		var particle_system = GPUParticles2D.new()

		# Particle system settings
		particle_system.texture = preload("res://biden.jpeg")
		particle_system.amount = 1
		particle_system.lifetime = 1
		particle_system.explosiveness = 1
		particle_system.one_shot = true
		
		var process_material = ParticleProcessMaterial.new()
		
		# Process material settings
		particle_system.process_material = process_material
		process_material.scale_min = 0.05
		process_material.scale_max = 0.1
		process_material.emission_shape = ParticleProcessMaterial.EMISSION_SHAPE_SPHERE
		process_material.emission_sphere_radius = 20
		process_material.spread = 180
		process_material.gravity.y = 98
		process_material.initial_velocity_min = 625
		process_material.initial_velocity_max = 625
		process_material.linear_accel_min = 500
		process_material.linear_accel_max = 500
		process_material.radial_accel_min = 0
		process_material.radial_accel_max = 0
		process_material.tangential_accel_min = 0
		process_material.tangential_accel_max = 0
		process_material.angle_min = -75
		process_material.angle_max = 75

		# Add the particle system as a child of your desired node
		get_node("Obama").add_child(particle_system)

