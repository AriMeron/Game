extends Node3D

var area
var points
var timer
var label
var forLoop = false
var scoreboard_scene
var ui

# Called when the node enters the scene tree for the first time.
func _ready():
	var scoreboard_scene = preload("res://Scenes/Map/score_board.tscn")  # Adjust the path as needed
	if scoreboard_scene:
		ui = scoreboard_scene.instantiate()
		add_child(ui)
	else:
		print("Failed to load score_board scene.")
	area = $Area
	area.connect("body_entered", Callable(self, "_on_Area_body_entered"))
	area.connect("body_exited", Callable(self, "_on_Area_body_exited"))
	label = $Label3D
	points = 0
	timer = Timer.new()
	timer.set_wait_time(1.0)  # Set the interval to 1 second
	timer.set_one_shot(false)  # Only call the function once per timer
	timer.connect("timeout", Callable(self, "_addPoints"))  # Connect the timeout signal to the other_function
	add_child(timer)  # Add the timer to the scene tree to start it

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_Area_body_entered(_body:Node) -> void:
	timer.start()
	print("in")
	
	
func _on_Area_body_exited(_body:Node) -> void:
	timer.stop()
	print("out")

func _addPoints():
	ui.update_score_Rep(5)
	ui.update_score_Dem(5)
	print("adding points")
	points += 5
	label.text = "Points: " + str(points)
	
