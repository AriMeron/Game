extends ProgressBar

var max_health = 100
var current_health

# Called when the node enters the scene tree for the first time.
func _ready():
	value = 100
	current_health = 100

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
