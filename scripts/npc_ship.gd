extends CharacterBody3D

## NPC ship with simple wandering behavior

@export var speed: float = 100.0
@export var rotation_speed: float = 1.0

var rotation_angle: float = 0.0
var wander_time: float = 0.0
var wander_duration: float = 5.0

func _ready():
	# Random starting rotation
	rotation_angle = randf_range(0, TAU)
	# Random starting position offset
	position += Vector3(randf_range(-500, 500), 0, randf_range(-500, 500))
	# Random wander duration
	wander_duration = randf_range(3.0, 8.0)
	
	# Scale up the model
	var model = get_node_or_null("Model")
	if model:
		model.scale = Vector3(5, 5, 5)

func _physics_process(delta):
	wander_time += delta
	
	# Change direction periodically
	if wander_time >= wander_duration:
		wander_time = 0.0
		rotation_angle = randf_range(0, TAU)
		wander_duration = randf_range(3.0, 8.0)
	
	# Move in current direction
	var direction = Vector3(cos(rotation_angle), 0, sin(rotation_angle))
	velocity = direction * speed
	
	move_and_slide()
	
	# Update visual rotation
	rotation.y = -rotation_angle
