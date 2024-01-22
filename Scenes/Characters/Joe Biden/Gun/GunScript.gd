extends Sprite3D

var reference_resolution = Vector2(1280, 720)
var hand_pos_relative = Vector2(0.5, 0.5) # Relative position (50% of width and height)

var angle_degrees = 0
@onready
var rotationHelp = get_node("RotationHelper")
@onready
var body = get_parent()
@onready
var hand = get_node(".")

var flipGun = false

# Recoil variables
var original_position_right = Vector3()
var original_position_left = Vector3()
var current_recoil = 0.0
var max_recoil = 0.035 # Maximum recoil offset
var recoil_step = 0.03 # Recoil increase per click
var recoil_recovery_speed = 0.4 # Speed of recoil recovery
var current_recoil_rotation = 0
var max_recoil_rotation = 25
var recoil_rotation_step = 14
var recoil_recovery_rotation_speed = 25

var ogHandPos = Vector3()
#fireRate is timeUntil can shoot again
var fireRate = .2
var shotTimer = 0
var canShoot = true

func _ready():
	original_position_right = rotationHelp.position
	original_position_left = original_position_right
	#original_position_left.y -= .025
	ogHandPos = hand.position

func _process(delta):
	if body.isDark:
		fireRate = 0.1
	else:
		fireRate = 0.2
	var window_size = get_viewport().get_size()
	var hand_pos = Vector2( hand_pos_relative.x * window_size.x, hand_pos_relative.y * window_size.y )
	# Calculate the hand positions based on the current window size

	var mouse_pos = get_viewport().get_mouse_position()
	var angle_to_mouse = 0
	angle_to_mouse = atan2(mouse_pos.y - hand_pos.y, mouse_pos.x - hand_pos.x)

	# Convert the angle to degrees and clamp it
	angle_degrees = rad_to_deg(-1 * angle_to_mouse)

	rotationHelp.rotation.z = deg_to_rad(angle_degrees)

	if Input.is_action_pressed("click"):
		if canShoot:
			current_recoil += recoil_step
			current_recoil = min(current_recoil, max_recoil)
			current_recoil_rotation += recoil_rotation_step
			current_recoil_rotation = min(current_recoil_rotation, max_recoil_rotation)
			canShoot = false
	if current_recoil > 0.0 or current_recoil_rotation > 0.0:
		current_recoil -= recoil_recovery_speed * delta
		current_recoil = max(current_recoil, 0.0)
		current_recoil_rotation -= recoil_recovery_rotation_speed * delta
		current_recoil_rotation = max(current_recoil_rotation, 0.0)
	
	if not canShoot:
		shotTimer += delta
	if shotTimer > fireRate:
		canShoot = true
		shotTimer = 0
		
		
	if not flipGun:
		hand.position.y = ogHandPos.y + current_recoil
		hand.position.x = ogHandPos.x - current_recoil
		#gunModel.rotation.z = deg_to_rad(current_recoil_rotation)
	else:
		hand.position.y =  ogHandPos.y + current_recoil
		hand.position.x = - 1 * ogHandPos.x + current_recoil
		#gunModel.rotation.z = - deg_to_rad(current_recoil_rotation)
