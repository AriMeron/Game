extends Node3D # or extends Node3D for 3D scenes

# Define common variables
var health
var player_choice: String
var party #0 is republican, 1 is democrat
var ID

func _ready():
	health = 100

# Add common functionality
func take_damage(damage_amount: int) -> void:
	health -= damage_amount
	if health <= 0:
		# Implement logic for when the player's health reaches zero
		queue_free()  # Destroy the player instance, for example

func setParty(p: int) -> void:
	party = p

func setPlayerChoice(player: String) -> void:
	player_choice = player
# Add other common methods or signals as needed
