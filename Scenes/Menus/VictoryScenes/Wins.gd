extends Node  # Change 'Node' to the type of your parent node, or 'AnimationPlayer' if the script is attached directly to it.

# Called whe n the node enters the scene tree for the first time.
func _ready():
	var biden = $Biden  # Adjust the path to your AnimationPlayer node.
	var bush = $Bush 
	var jfk = $JFK 
	var obama = $Obama 
	var reagan = $Reagan 
	var trump = $Trump
	
	#add if-then logic for dems/reps winning
	
	#Democrats
	if biden:
		biden.play("default")  # Replace 'default_animation' with the name of your default animation.
	if obama:
		obama.play("default")
	if jfk:
		jfk.play("default")

	#Republicans
	if trump:
		trump.play("default")
	if bush:
		bush.play("default")
	if reagan:
		reagan.play("default")
