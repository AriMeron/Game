extends GPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready():
	one_shot = true
	var pm = process_material
	pm.angle_min = -90
	pm.angle_max = 90
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
