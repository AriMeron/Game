extends CharacterBody3D

var lifetime = 5.0  # Lifetime of the bullet in seconds
var initial_direction: Vector3  # Define the initial_direction property
var active = false
var bullet

func _ready():
	set_process(true)
	active = true
	bullet = $Area3D
	bullet.connect("body_entered", Callable(self, "_on_Area_body_entered"))
	

func _process(delta):
	if active:
		global_transform.origin += initial_direction * delta  # Use initial_direction
	# Decrease the lifetime each frame
	lifetime -= delta
	if lifetime <= 0:
		queue_free()  # Remove the bullet from the scene

func _on_Area_body_entered(body:Node) -> void:
	print("Obama")
	queue_free()
	if (body.is_in_group("Player")):
		if (body.is_in_group("Democrat")):
			pass
		else:
			print("ObamaDealDamage")
			body.dealDamage()
