extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_view_assets_button_down():
	pass # Replace with function body.


func _on_load_map_button_down():
	pass # Replace with function body.


func _on_host_button_down():
	pass # Replace with function body.


func _on_client_button_down():
	pass # Replace with function body.


func _on_test_movement_button_down():
	pass # Replace with function body.


func _on_load_menus_button_down():
	pass # Replace with function body.


func _on_node_load_example_button_down():
	var scene = load("res://Scenes/Menus/ExampleScene.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()
