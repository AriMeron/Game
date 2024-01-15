extends GPUParticles3D

#@export var GunRotation :PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	var pm = process_material
	one_shot = true
	
	pm.direction.y = -1;

func set_velocity(v : Vector3):
	var pm = process_material
	
	pm.direction.x = 0;#v.x
	#pm.direction.y = 0; #v.y
	pm.direction.z = 0; #v.z

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
