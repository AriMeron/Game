extends Node3D

var area
var health
var timer
var label
var forLoop = false
var found = false

# Called when the node enters the scene tree for the first time.
func _ready():
	area = $Area
	area.connect("body_entered", Callable(self, "_on_Area_body_entered"))
	area.connect("body_exited", Callable(self, "_on_Area_body_exited"))
	label = $Label3D
	health = 0
	timer = Timer.new()
	timer.set_wait_time(1.0)  # Set the interval to 1 second
	timer.set_one_shot(false)  # Only call the function once per timer
	timer.connect("timeout", Callable(self, "_addHealth"))  # Connect the timeout signal to the other_function
	add_child(timer)  # Add the timer to the scene tree to start it

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_Area_body_entered(body:Node) -> void:
	if (body.is_in_group("Player")):
		body.health += 100
		timer.start()
		print("in")
	
	
func _on_Area_body_exited(body:Node) -> void:
	if (body.is_in_group("Player")):
		timer.stop()
		print("out")

func _addHealth(body:Node):
	body.health += 5
	print("adding health")
	health += 5
	label.text = "Health: " + str(health)
	
