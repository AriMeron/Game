extends GPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready():
	one_shot = true

func set_velocity(v : Vector3):
	var pm = process_material
	pm.direction = v
	pm.initial_velocity_min = -0.3
	pm.initial_velocity_max = -0.3
	pm.linear_accel_min = -5
	pm.linear_accel_max = -5
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
