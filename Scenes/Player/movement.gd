extends CharacterBody3D

var speed = 7
var roll_speed = 15
var rolling = false
var roll_timer = 0.5
var roll_direction = Vector3.ZERO

@export var dirt_particle :PackedScene
@export var cloud_particle :PackedScene
@export var blood_particle :PackedScene
@export var bullet_particle :PackedScene
@export var bullet :PackedScene
@export var bullet_casing_particle :PackedScene
@export var heal_particle :PackedScene 

func _physics_process(delta):
	var velocity = Vector3.ZERO
	var moving = false
	
	if not moving:
		$DustTrail.get_child(0).emitting = false
	
	# Handle inputs
	if not rolling:
		if Input.is_action_pressed("right"):
			velocity.x += 1
			moving = true
		if Input.is_action_pressed("left"):
			velocity.x -= 1
			moving = true
		if Input.is_action_pressed("down"):
			velocity.z += 1
			moving = true
		if Input.is_action_pressed("up"):
			velocity.z -= 1
			moving = true
		if moving:
			velocity = velocity.normalized() * speed
			$DustTrail.get_child(0).emitting = true

	if Input.is_action_just_pressed("roll") and not rolling:
		
		
		rolling = true
		roll_timer = 0.6  # Reset the roll timer
		if moving:
			roll_direction = velocity.normalized()  # Set roll direction to current movement direction
		else:
			# Default roll direction if not moving
			roll_direction = Vector3(0, 0, 0.1667) 
			
		# create dirt particle
		var dirt = dirt_particle.instantiate()
		dirt.position.y = -0.05
		dirt.get_child(0).set_velocity_direction(roll_direction)
		get_tree().get_root().get_child(0).get_child(4).add_child(dirt)
		# create cloud particle
		var cloud = cloud_particle.instantiate()
		cloud.get_child(0).set_velocity_direction(roll_direction)
		get_tree().get_root().get_child(0).get_child(4).add_child(cloud)

	if rolling:
		if roll_timer > 0:
			velocity = roll_direction * roll_speed
			roll_timer -= delta
		else:
			rolling = false
			roll_direction = Vector3.ZERO

	# Apply movement using velocity
	if velocity.length() > 0:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.slide(collision.get_normal())
			move_and_collide(velocity * delta)

	# The update_animation function will need adjustments for the new setup.
	# Ensure the AnimatedSprite3D child node is properly updated.

# Adjust the update_animation function as needed for the new setup.
	
	# Particles
	
	if Input.is_action_just_pressed("fire"):
		var p = bullet_particle.instantiate()
		p.get_child(0).set_velocity_direction(Vector3(1, 0, 0))
		#p.get_child(0).set_velocity(velocity.length())
		get_child(0).get_child(0).get_child(0).get_child(0).add_child(p)
		
		var bc = bullet_casing_particle.instantiate()
		get_child(0).get_child(0).get_child(0).get_child(0).add_child(bc)
		
		var b = bullet.instantiate()
		b.get_child(0).set_velocity_direction(Vector3(0, -1, 0))
		get_child(0).get_child(0).get_child(0).get_child(0).add_child(b)
		
	if Input.is_action_just_pressed("blood_particle"):
		var p = blood_particle.instantiate()
		p.position.y = -0.05
		add_child(p)
		
	if Input.is_action_pressed("heal"):
		var p = heal_particle.instantiate()
		add_child(p)
