extends Node3D  

var inZone = true
var animation_node
var area
var doorState = false

func _ready():
	animation_node = $AnimationPlayer
	area = $Area
	area.connect("body_entered", Callable(self, "_on_Area_body_entered"))
	area.connect("body_exited", Callable(self, "_on_Area_body_exited"))
	
func _input(_event):
	if Input.is_action_just_pressed("interact"):
		if inZone == true && animation_node.is_playing() == false:
			print("EVENT")
			doorState = !doorState
			if (doorState):
				animation_node.play("door_opening")
			else:
				animation_node.play("door_closing")
			
	
func _on_Area_body_entered(body:Node) -> void:
	if body.is_in_group("Player"):
		$Label3D.visible = true
		inZone = true
	
	
func _on_Area_body_exited(body:Node) -> void:
	if body.is_in_group("Player"):
		$Label3D.visible = false
		inZone = false
