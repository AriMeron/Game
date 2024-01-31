extends CharacterBody2D

const GRAVITY = 9.8
const JUMP_POWER = -300
var jump_timer = 0

func _ready():
	# Initialize the jump timer with a random value
	jump_timer = randf_range(1, 3)

func _physics_process(delta):
	velocity.y += GRAVITY

	# Update the jump timer
	jump_timer -= delta

	# Check if it's time to jump
	if jump_timer <= 0 and is_on_floor(): # Add a condition to check if the character can jump
		velocity.y = JUMP_POWER
		# Reset the timer
		jump_timer = randf_range(1, 3)
