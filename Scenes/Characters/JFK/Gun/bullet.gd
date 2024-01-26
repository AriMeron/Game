extends CharacterBody3D

var lifetime = 5.0  # Lifetime of the bullet in seconds
var initial_direction: Vector3  # Define the initial_direction property
var active = false

func _ready():
	set_process(true)
	active = true

func _process(delta):
	if active:
		global_transform.origin += initial_direction * delta  # Use initial_direction
	# Decrease the lifetime each frame
	lifetime -= delta
	if lifetime <= 0:
		queue_free()  # Remove the bullet from the scene
