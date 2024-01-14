extends RigidBody3D

var lifetime = 5.0  # Lifetime of the bullet in seconds

func _ready():
	set_process(true)

func _process(delta):
	# Decrease the lifetime each frame
	if lifetime > 0:
		lifetime -= delta
		if lifetime <= 0:
			queue_free()  # Remove the bullet from the scene
