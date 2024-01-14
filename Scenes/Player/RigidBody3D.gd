extends RigidBody3D

# Signal for when the bullet hits something
signal bullet_hit(target)

var speed = 10 # Speed of the bullet, adjust as needed
var direction = Vector3.ZERO # Direction in which the bullet will move

func _ready():
	linear_velocity = direction * speed # Set initial velocity

	# Set the bullet to deactivate (or queue_free) after a certain amount of time to prevent it from traveling indefinitely
	await(get_tree().create_timer(5)) # 5 seconds as an example
	queue_free()

func _on_Bullet_body_entered(body: Node):
	# Emit signal when the bullet collides with something
	emit_signal("bullet_hit", body)
	queue_free() # Remove the bullet after it hits something

func set_direction(new_direction: Vector3):
	direction = new_direction.normalized()
	linear_velocity = direction * speed # Update velocity when direction changes
