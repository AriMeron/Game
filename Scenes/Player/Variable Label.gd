extends Label
var ammo = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(ammo)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(ammo)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if ammo > 0:
			ammo -=1
