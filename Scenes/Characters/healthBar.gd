extends Control

var max_health : float = 100.0
var current_health : float = 100.0

# Function to update the health bar
func update_health_bar():
	$TextureProgress.value = current_health / max_health

# Function to decrease health
func decrease_health(amount: float):
	current_health -= amount
	current_health = max(0, current_health)  # Ensure health doesn't go below 0
	update_health_bar()

# Function to increase health
func increase_health(amount: float):
	current_health += amount
	current_health = min(max_health, current_health)  # Ensure health doesn't exceed max
	update_health_bar()
