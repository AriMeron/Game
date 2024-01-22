extends MeshInstance3D  # Assuming this script is attached to the node you want to scale

var is_scaling = false
var scale_speed = 240.0
var scale_duration = 6
var elapsed_time = 0.0
var initial_scale = Vector3(0.05, 0.05, 0.05)
var pause

func _ready():
	scale = initial_scale  # Set initial scale
	visible = false  # Start with the node invisible
	pause = false

func _process(delta):
	if Input.is_action_just_pressed("ability") and !is_scaling:
		is_scaling = true
		elapsed_time = 0.0
		visible = true  # Make the node visible when scaling starts
	
	if elapsed_time > 1 and elapsed_time < 5:
		pause = true
		elapsed_time += delta
		visible = false
	elif elapsed_time != 0:
		pause = false
		visible = true
	if is_scaling and not pause:
		elapsed_time += delta
		var progress = elapsed_time / scale_duration
		scale.x = initial_scale.x * (1.0 + (6 - elapsed_time) * scale_speed * progress)
		scale.z = initial_scale.z * (1.0 + (6 - elapsed_time) * scale_speed * progress)

		if elapsed_time >= scale_duration:
			is_scaling = false
			elapsed_time = 0
			scale = initial_scale  # Reset scale after scaling
			visible = false  # Hide the node after scaling completes

