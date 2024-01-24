extends Node3D # or extends Node3D for 3D scenes

# Define common variables
var health : int = 100
var player_choice: String
var party : int #0 is republican, 1 is democrat
var ID

# Add common functionality
func take_damage(damage_amount: int) -> void:
	health -= damage_amount
	if health <= 0:
		# Implement logic for when the player's health reaches zero
		queue_free()  # Destroy the player instance, for example

# Add other common methods or signals as needed
