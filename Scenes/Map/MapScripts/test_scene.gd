extends Node3D

var locations
var count = 0
var points
# Called when the node enters the scene tree for the first time.
func _ready():
	points = $ScoringZone
	locations = [get_node("possibleScoringZone1"), get_node("possibleScoringZone2"), get_node("possibleScoringZone3"), get_node("possibleScoringZone4")]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (points.points % 50 == 0 && points.points != 0):
		print("happened")
		_setLocation(count)
		points._addPoints()

func _setLocation(location):
	locations[count].visible = true
	count += 1
	if (count > 3):
		count = 0
	locations[count].visible = false
	points.global_position = locations[count].global_position
