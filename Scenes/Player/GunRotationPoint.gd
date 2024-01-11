extends Node3D
var mouse_position


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	mouse_position = get_viewport().get_mouse_position()
	rotate_z((mouse_position.x - mouse_position.y) * delta)
