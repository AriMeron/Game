extends Label
var ammo = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(ammo)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(ammo)
	

var leftHeld = false
func _input(event):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			if ammo > 0 and leftHeld == false:
				ammo -=1
				leftHeld = true
	elif Input.is_action_just_released:
		leftHeld = false
	if Input.is_key_pressed(KEY_R):
		ammo = 50
