extends Node3D
var mouse_position
var x_coord
var y_coord


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_viewport().get_mouse_position()
	#$GunRotation.look_at(look_target.translation,Vector3.UP)
	x_coord = mouse_position.x
	y_coord = mouse_position.y
	rotate_z((mouse_position.x - mouse_position.y) * 0.01 * delta)
