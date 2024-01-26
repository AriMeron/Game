extends Node3D

var drone = preload("res://Scenes/Characters/Obama/Gun/Drone.tscn")
@onready
var cam = get_parent().get_node("ObamaCam")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	
	if Input.is_action_just_pressed("ability"):
		var drone_instance = drone.instantiate()
		
		var y_height = 10
		var spawn_pos = global_transform.origin
		var mouse_pos = get_viewport().get_mouse_position()
		var window_size = get_viewport().get_size()
		drone_instance.global_transform.origin = Vector3(spawn_pos.x, y_height, spawn_pos.z)
		var from = cam.project_ray_origin(mouse_pos)
		
		var to = from + cam.project_ray_normal(mouse_pos) * 2000
	# Use the camera's projection to find the z-coordinate in 3D space
		var projected_z = (from.z + (to.z - from.z) * ((y_height - from.y) / (to.y - from.y))) - 10

	# Create a target position using the mouse's x, a constant y, and the calculated z
		var target_pos_3d = Vector3(from.x, y_height, projected_z)

		var direction = (target_pos_3d - spawn_pos).normalized()
		
		direction.y = 0
		drone_instance.initial_direction = direction * 10
		
		get_tree().get_root().add_child(drone_instance)
		
