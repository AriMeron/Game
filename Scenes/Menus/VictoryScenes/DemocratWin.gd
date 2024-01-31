extends Node  # Change 'Node' to the type of your parent node, or 'AnimationPlayer' if the script is attached directly to it.

# Called when the node enters the scene tree for the first time.
func _ready():
	var animation_player = $Biden  # Adjust the path to your AnimationPlayer node.
	
	if animation_player:
		animation_player.play("default")  # Replace 'default_animation' with the name of your default animation.
