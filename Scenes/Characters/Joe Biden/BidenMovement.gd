extends CharacterBody3D

var speed = 4
var roll_speed = 7
var rolling = false
var roll_timer = 0.5
var roll_direction = Vector3.ZERO
var brandonTimer = 0
var brandonScale = 1
var isDark = false
var health
var velo = 0
var DirtParticle = preload("res://Scenes/Characters/Joe Biden/Particles/DirtParticle.tscn")
var BloodParticle = preload("res://Scenes/Characters/Joe Biden/Particles/BloodParticle.tscn")
var HealParticle = preload("res://Scenes/Characters/Joe Biden/Particles/HealParticle.tscn")
var Biden
var healthBar

@onready var camera = $BidenCam
 
func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

func _ready():
	if not is_multiplayer_authority() : return
	camera.current = true
	
	Biden = $CollisionShape3D.get_parent_node_3d()
	healthBar = $SubViewport/Node3D
	health = 100

func _physics_process(delta):
	if not is_multiplayer_authority() : return
	var velocity = Vector3.ZERO
	var moving = false
	if Input.is_action_just_pressed("ability"):
		isDark = true
	if isDark:
		brandonTimer += delta
	if brandonTimer >= 6:
		brandonTimer = 0
		isDark = 0
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

	if Input.is_action_just_pressed("roll") and not rolling:
		rolling = true
		roll_timer = 0.6  # Reset the roll timer
		if moving:
			roll_direction = velocity.normalized()  # Set roll direction to current movement direction
		else:
			# Default roll direction if not moving
			roll_direction = Vector3(0, 0, 0.1667) 
			
		create_dirt_particle(roll_direction)
		

	if rolling:
		if roll_timer > 0:
			velocity = roll_direction * roll_speed
			roll_timer -= delta
		else:
			rolling = false
			roll_direction = Vector3.ZERO

	# Apply movement using velocity
	if velocity.length() > 0:
		if isDark:
			velocity = velocity * brandonScale + velocity
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.slide(collision.get_normal())
			move_and_collide(velocity * delta)
		velo = velocity

	# The update_animation function will need adjustments for the new setup.
	# Ensure the AnimatedSprite3D child node is properly updated.
	set_dust_trail_particle(moving, velocity)
	if Input.is_action_just_pressed("blood_particle"):
		create_blood_particle()
	if Input.is_action_just_pressed("heal"):
		create_heal_particle()
	
# Adjust the update_animation function as needed for the new setup.
func get_player_type():
	return "democrat"

func set_dust_trail_particle(b : bool, velocity_direction : Vector3):
	$DustTrail.get_child(0).emitting = b
	$DustTrail.get_child(0).set_velocity_direction(velocity_direction)
	
func create_dirt_particle(velocity_direction : Vector3):
	var particle = DirtParticle.instantiate()
	particle.get_child(0).set_velocity_direction(velocity_direction)
	add_child(particle)
	
func create_blood_particle():
	var particle = BloodParticle.instantiate()
	add_child(particle)
	
func create_heal_particle():
	var particle = HealParticle.instantiate()
	add_child(particle)

func dead():
	updateHealthBar()
	Biden.position = Vector3(-51, 0, 0)
	health = 100
	
func dealDamage():
	health -= 20
	updateHealthBar()
	if (health <= 0):
		dead()

func updateHealthBar():
	healthBar.value = health

