extends GPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready():
	one_shot = true
	#pass

func set_velocity_direction(v : Vector3):
	var pm = process_material
	pm.direction = v

func set_velocity(v : float):
	var pm = process_material
	pm.initial_velocity_min = pm.initial_velocity_min + v
	pm.initial_velocity_max = pm.initial_velocity_max + v

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
