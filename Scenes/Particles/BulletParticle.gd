extends GPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready():
	one_shot = true

func set_velocity(v : Vector3):
	var pm = process_material
	pm.direction = v

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
