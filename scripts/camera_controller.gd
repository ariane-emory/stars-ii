extends Camera3D

## Orthographic camera that follows the player ship with zoom control

@export var camera_height: float = 707.2  # Fixed height above the world
@export var base_ortho_size: float = 1200.0  # Base orthographic viewport size (100% zoom)
@export var min_zoom: float = 0.5  # 50% zoom (zoomed out for wide view)
@export var max_zoom: float = 3.0  # 300% zoom (zoomed in for close view)
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
		# Position camera above player
		position = Vector3(player.position.x, camera_height, player.position.z)
	else:
		print("WARNING: Camera could not find player!")
	
	# Set up orthographic projection
	projection = PROJECTION_ORTHOGONAL
	size = base_ortho_size
	
	current = true

func _unhandled_input(event):
	# Handle mouse wheel zoom
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP and event.pressed:
			# Zoom in (smaller ortho size = more zoomed in)
			target_zoom = clamp(target_zoom + zoom_speed, min_zoom, max_zoom)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN and event.pressed:
			# Zoom out (larger ortho size = more zoomed out)
			target_zoom = clamp(target_zoom - zoom_speed, min_zoom, max_zoom)

func _physics_process(delta):
	# Smoothly interpolate current zoom toward target zoom
	current_zoom = lerp(current_zoom, target_zoom, zoom_smoothing * delta)
	
	# Update orthographic size based on zoom (smaller size = more zoomed in)
	size = base_ortho_size / current_zoom
	
	if player:
		# Keep player perfectly centered - follow player's XZ position, maintain height
		position = Vector3(player.position.x, camera_height, player.position.z)
