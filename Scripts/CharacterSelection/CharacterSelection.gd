extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func loadObama():
	var scene = load("res://Scenes/Menus/CharacterSelection/Obama.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()


func loadJFK():
	var scene = load("res://Scenes/Menus/CharacterSelection/JFK.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()


func loadBiden():
	var scene = load("res://Scenes/Menus/CharacterSelection/Biden.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()


func loadTrump():
	var scene = load("res://Scenes/Menus/CharacterSelection/Trump.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()


func loadBush():
	var scene = load("res://Scenes/Menus/CharacterSelection/Bush.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()


func loadReagan():
	var scene = load("res://Scenes/Menus/CharacterSelection/Reagan.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()
