extends CharacterBody3D

var lifetime = 5.0  # Lifetime of the bullet in seconds
var initial_direction: Vector3  # Define the initial_direction property
var active = false

var bullet = preload("res://Scenes/Characters/Obama/Gun/missile.tscn")

func _ready():
	set_process(true)
	active = true

func _process(delta):
	if active:
		global_transform.origin += initial_direction * delta  # Use initial_direction
		#var sprite = get_node("Sprite3D")
		if initial_direction.x > 0:
			rotation.z = -atan(initial_direction.z / initial_direction.x)
		else :
			rotation.z = atan(initial_direction.z/initial_direction.x)
			rotation.y = deg_to_rad(180)
		
		if shot_timer > 40:
			var bullet_instance = bullet.instantiate()
			bullet_instance.initial_direction = Vector3(-initial_direction.x, -10, -initial_direction.z)
			add_child(bullet_instance)
			shot_timer = 0
			
		shot_timer = shot_timer + 1
	# Decrease the lifetime each frame
	lifetime -= delta
	if lifetime <= 0:
		queue_free()  # Remove the bullet from the scene
