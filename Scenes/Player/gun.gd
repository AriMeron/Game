extends CharacterBody3D

var speed = 7
var roll_speed = 15
var rolling = false
var roll_timer = 0.5
var roll_direction = Vector3.ZERO


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector3.ZERO
	var moving = false
	#moving w player
	if not rolling:
		if Input.is_action_pressed("ui_right"):
			velocity.x += 1
			moving = true
		if Input.is_action_pressed("ui_left"):
			velocity.x -= 1
			moving = true
		if Input.is_action_pressed("ui_down"):
			velocity.z += 1
			moving = true
		if Input.is_action_pressed("ui_up"):
			velocity.z -= 1
			moving = true
		if moving:
			velocity = velocity.normalized() * speed

	if rolling:
		$Gun.visible = not $Gun.visible

	# Apply movement using velocity
	if velocity.length() > 0:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.slide(collision.get_normal())
			move_and_collide(velocity * delta)
	
	#following cursor rotation
