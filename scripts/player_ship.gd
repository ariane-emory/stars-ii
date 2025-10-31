extends CharacterBody3D

## Player-controlled spaceship with rotation-based movement (like Escape Velocity)

# Movement parameters
@export var thrust_power: float = 500.0
@export var rotation_speed: float = 3.0  # radians per second
@export var max_speed: float = 800.0
@export var drag: float = 0.95  # Velocity multiplier per frame (0.95 = slight drag)

# Current rotation angle (in radians, 0 = pointing right)
var rotation_angle: float = 0.0

func _ready():
	# Start with a random rotation
	rotation_angle = randf_range(0, TAU)
	print("Player ship initialized at position: ", position)
	
	# Check if model loaded
	var model = get_node_or_null("Model")
	if model:
		print("Model found: ", model)
		print("Model has ", model.get_child_count(), " children")
		# Scale up the model MUCH larger
		model.scale = Vector3(50, 50, 50)
		print("Model scaled to: ", model.scale)
	else:
		print("ERROR: Model node not found!")

func _physics_process(delta):
	handle_rotation(delta)
	handle_thrust(delta)
	apply_drag()
	limit_speed()
	
	# Move the ship
	move_and_slide()
	
	# Update visual rotation (rotate around Y axis for top-down view)
	rotation.y = -rotation_angle

func handle_rotation(delta):
	var turning = false
	
	# J = rotate left (counter-clockwise)
	if Input.is_key_pressed(KEY_J):
		rotation_angle += rotation_speed * delta
		turning = true
	
	# L = rotate right (clockwise)
	if Input.is_key_pressed(KEY_L):
		rotation_angle -= rotation_speed * delta
		turning = true
	
	if turning:
		print("Turning! Angle: %.2f" % rotation_angle)
	
	# Keep angle in 0-2π range
	rotation_angle = wrapf(rotation_angle, 0, TAU)

func handle_thrust(delta):
	# Calculate direction based on current rotation
	var direction = Vector3(cos(rotation_angle), 0, sin(rotation_angle))
	
	# I = forward thrust
	if Input.is_key_pressed(KEY_I):
		velocity += direction * thrust_power * delta
	
	# K = reverse thrust (braking)
	if Input.is_key_pressed(KEY_K):
		velocity -= direction * thrust_power * 0.5 * delta  # Reverse is weaker

func apply_drag():
	# Slight drag to prevent infinite acceleration
	velocity *= drag

func limit_speed():
	# Cap maximum speed
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed

func _input(event):
	# Quick stop with Space (optional convenience)
	if event.is_action_pressed("ui_select"):  # Space bar
		velocity *= 0.5
