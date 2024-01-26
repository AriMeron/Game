extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var straight_wall = preload("res://Scenes/Characters/Trump/StraightWall.tscn")
var sideways_wall = preload("res://Scenes/Characters/Trump/SidewaysWall.tscn")
@onready
var wall_spawn = get_node("WallSpawn")
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _process(delta):
	if Input.is_action_just_pressed("ability"):
		var mouse_position = get_viewport().get_mouse_position()
		var size = get_viewport().get_size()
		var slope = size.x / size.y
		var actual_mouse_position = Vector2(mouse_position.x - size.x/2, mouse_position.y - size.y/2)
		

		
		if actual_mouse_position.x * slope < actual_mouse_position.y and actual_mouse_position.x * -slope < actual_mouse_position.y:
			#print("down")
			rotation.y = deg_to_rad(0)
			var wall_instance = straight_wall.instantiate()
			wall_instance.global_position = Vector3(global_position.x, global_position.y, global_position.z + 2)
			get_tree().get_root().add_child(wall_instance)
			
			
			
		if actual_mouse_position.x * slope > actual_mouse_position.y and actual_mouse_position.x * -slope > actual_mouse_position.y:
			#print("up")
			rotation.y = deg_to_rad(180)
			var wall_instance = straight_wall.instantiate()
			wall_instance.global_position = Vector3(global_position.x, global_position.y, global_position.z - 2)
			get_tree().get_root().add_child(wall_instance)
			
			
			
		if actual_mouse_position.x * slope < actual_mouse_position.y and actual_mouse_position.x * -slope > actual_mouse_position.y:
			#print("left")
			rotation.y = deg_to_rad(-90)
			var wall_instance = sideways_wall.instantiate()
			wall_instance.global_position = Vector3(global_position.x-2, global_position.y, global_position.z)
			get_tree().get_root().add_child(wall_instance)

			
			
		if actual_mouse_position.x * slope > actual_mouse_position.y and actual_mouse_position.x * -slope < actual_mouse_position.y:
			#print("right")
			rotation.y = deg_to_rad(90)
			var wall_instance = sideways_wall.instantiate()
			wall_instance.global_position = Vector3(global_position.x+2, global_position.y, global_position.z)
			get_tree().get_root().add_child(wall_instance)

			
		
