extends GPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready():
	one_shot = true;
	var pm = process_material
	pm.direction.x = 1
	pm.direction.y = 0
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
