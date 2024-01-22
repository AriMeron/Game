extends Node3D  

var inZone = true
var collision_node
var area

func _ready():
	collision_node = $MeshInstance3D/StaticBody3D/doorCollision
	area = $Area
	area.connect("body_entered", Callable(self, "_on_Area_body_entered"))
	area.connect("body_exited", Callable(self, "_on_Area_body_exited"))
	
func _input(_event):
	if Input.is_action_just_pressed("interact"):
		if inZone == true:
			print("EVENT")
			print(collision_node.disabled)
			if collision_node.disabled:
				collision_node.disabled = false
			else:
				collision_node.disabled = true
	
func _on_Area_body_entered(_body:Node) -> void:
	$Label3D.visible = true
	inZone = true
	
	
func _on_Area_body_exited(_body:Node) -> void:
	$Label3D.visible = false
	inZone = false
