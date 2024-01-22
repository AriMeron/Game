extends Camera3D

# Offset from the player
var offset = Vector3(0, 11, 11)  # Adjust based on your game's requirements

func _process(delta):
	# Assuming the player node is a sibling of the camera and is named "Player"
	var player = get_parent().get_node("Player")
	
	# Check if the player node is found
	if player:
		# Update the camera's position based on the player's position and the offset
		global_transform.origin = player.global_transform.origin + offset
