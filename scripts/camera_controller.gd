extends Camera3D

## Camera that keeps the player ship centered on screen at all times

@export var base_camera_offset: Vector3 = Vector3(0, 855.7, 0)  # Base zoom level (100%)
@export var min_zoom: float = 0.5  # 50% zoom
@export var max_zoom: float = 2.0  # 200% zoom
@export var zoom_speed: float = 0.1  # How much each scroll changes zoom
@export var zoom_smoothing: float = 10.0  # Higher = faster interpolation

var player: Node3D
var current_zoom: float = 1.0  # Current zoom level (1.0 = 100%)
var target_zoom: float = 1.0  # Target zoom level for smooth transitions

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if not player:
		player = get_node_or_null("/root/Main/PlayerShip")
	
	if player:
		print("Camera found player at: ", player.position)
		# Position camera immediately at player position
		position = player.position + get_camera_offset()
	else:
		print("WARNING: Camera could not find player!")
	
	current = true

func _unhandled_input(event):
	# Handle mouse wheel zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			# Zoom in (decrease camera distance)
			target_zoom = clamp(target_zoom - zoom_speed, min_zoom, max_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			# Zoom out (increase camera distance)
			target_zoom = clamp(target_zoom + zoom_speed, min_zoom, max_zoom)

func _physics_process(delta):
	# Smoothly interpolate current zoom toward target zoom
	current_zoom = lerp(current_zoom, target_zoom, zoom_smoothing * delta)
	
	if player:
		# Keep player perfectly centered with current zoom level
		position = player.position + get_camera_offset()

func get_camera_offset() -> Vector3:
	## Calculate camera offset based on current zoom level
	return base_camera_offset * current_zoom
