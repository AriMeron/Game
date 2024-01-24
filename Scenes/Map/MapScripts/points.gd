extends Node3D

var area
var rep_points = 0
var dem_points = 0
var timer
var label
var forLoop = false
var found = false

func _ready():
	var scoreboard_scene = preload("res://Scenes/Map/score_board.tscn")
	ui = scoreboard_scene.instantiate()
	add_child(ui)
	area = $Area
	area.connect("body_entered", Callable(self, "_on_Area_body_entered"))
	area.connect("body_exited", Callable(self, "_on_Area_body_exited"))
	timer = Timer.new()
	timer.stop()
	timer.set_wait_time(1.0)
	timer.set_one_shot(false)
	timer.connect("timeout", Callable(self, "_addPoints"))
	add_child(timer)
	ui.update_score_Dem(0)
	ui.update_score_Rep(0)

func _on_Area_body_entered(body: Node) -> void:
	if body.has_method("get_player_type"):
		var player_type = body.get_player_type()
		if player_type == "democrat":
			in_zone_democrat = true
		elif player_type == "republican":
			in_zone_republican = true
		timer.start()
		print("Player entered: ", player_type)

func _on_Area_body_exited(body: Node) -> void:
	if body.has_method("get_player_type"):
		var player_type = body.get_player_type()
		if player_type == "democrat":
			in_zone_democrat = false
		elif player_type == "republican":
			in_zone_republican = false
		if not in_zone_democrat and not in_zone_republican:
			timer.stop()
		print("Player exited: ", player_type)

func _addPoints():
	if in_zone_democrat:
		dem_points += 5
		ui.update_score_Dem(dem_points)
		print("Democrat scored")
	if in_zone_republican:
		rep_points += 5
		ui.update_score_Rep(rep_points)
		print("Republican scored")
