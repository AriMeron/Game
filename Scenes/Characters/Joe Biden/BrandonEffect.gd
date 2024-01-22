extends ColorRect

var time_elapsed = 0
var duration = 0.4
var expanding = false
var enabled = false
var contracting = false
# Called when the node enters the scene tree for the first time.
func _ready():
	anchor_left = 0.5
	anchor_right = 0.5
	anchor_bottom = 0.5
	anchor_top = 0.5
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ability") and time_elapsed == 0:
		expanding = true
		time_elapsed = 0
		enabled = true
	
	if enabled:
		time_elapsed += delta
	
	if expanding:
		anchor_left = 0.5 - (time_elapsed / duration) * .5
		anchor_right = 0.5 + (time_elapsed / duration) * .5
		anchor_bottom = 0.5 + (time_elapsed / duration) * .5
		anchor_top = 0.5 - (time_elapsed / duration) * .5
		if time_elapsed >= duration:
			expanding = false
	
	if time_elapsed > 5.5:
		contracting = true
	
	if contracting:
		var editTimeElapsed = time_elapsed - 5.5
		anchor_left = 0 + (editTimeElapsed / duration) * .5
		anchor_right = 1 - (editTimeElapsed / duration) * .5
		anchor_bottom = 1 - (editTimeElapsed / duration) * .5
		anchor_top = 0 + (editTimeElapsed / duration) * .5
		if editTimeElapsed >= duration:
			contracting = false
			enabled = false
			time_elapsed = 0
		
		
