extends Control

## Circular radar/minimap display showing nearby ships

# Radar parameters
@export var radar_radius: float = 150.0  # Pixel radius of the radar circle
@export var detection_range: float = 4000.0  # World units for radar detection range (2x zoom from original 8000)
@export var background_color: Color = Color(0, 0, 0, 0.6)  # Semi-transparent black
@export var border_color: Color = Color(0, 1, 0, 0.9)  # Green border
@export var border_width: float = 3.0
@export var grid_color: Color = Color(0, 1, 0, 0.2)  # Faint green grid
@export var show_range_rings: bool = true  # Show distance rings

# Ship indicator parameters
@export var indicator_size: float = 9.0  # Size of triangle indicators
@export var friendly_color: Color = Color(0, 1, 0, 1)  # Green for friendlies
@export var enemy_color: Color = Color(1, 0, 0, 1)  # Red for enemies

var player_ship: CharacterBody3D = null

func _ready():
	# Find player ship
	player_ship = get_tree().get_first_node_in_group("player")
	
	if not player_ship:
		# Try finding it by name
		player_ship = get_node_or_null("/root/Main/PlayerShip")
	
	# Set size to contain the radar circle with some padding
	custom_minimum_size = Vector2(radar_radius * 2 + 20, radar_radius * 2 + 20)
	size = custom_minimum_size

func _process(_delta):
	queue_redraw()  # Request redraw every frame to update radar

func _draw():
	if not player_ship:
		return
	
	# Calculate center of the radar (center of this control)
	var center = size / 2
	
	# Draw radar background (filled circle)
	draw_circle(center, radar_radius, background_color)
	
	# Draw range rings if enabled
	if show_range_rings:
		for i in range(1, 4):
			var ring_radius = radar_radius * (i / 4.0)
			draw_arc(center, ring_radius, 0, TAU, 32, grid_color, 1.0)
	
	# Draw crosshair lines
	draw_line(center + Vector2(-10, 0), center + Vector2(10, 0), grid_color, 1.0)
	draw_line(center + Vector2(0, -10), center + Vector2(0, 10), grid_color, 1.0)
	
	# Draw radar border (circle outline)
	draw_arc(center, radar_radius, 0, TAU, 64, border_color, border_width)
	
	# Draw center dot for player
	draw_circle(center, 4.0, Color.WHITE)
	
	# Get all ships in the scene
	var all_ships = get_tree().get_nodes_in_group("npc_ships")
	
	# Draw indicators for each ship
	for ship in all_ships:
		if ship is CharacterBody3D:
			draw_ship_indicator(ship, center)

func draw_ship_indicator(ship: CharacterBody3D, radar_center: Vector2):
	## Draw a triangle indicator for a ship on the radar
	
	if not player_ship:
		return
	
	# Calculate relative position (world space difference)
	var relative_pos = ship.global_position - player_ship.global_position
	
	# Convert 3D position to 2D (ignore Y axis, use X and Z)
	# Screen-space mapping: X stays X (left-right), Z becomes Y (up-down)
	var relative_2d = Vector2(relative_pos.x, relative_pos.z)
	
	# Scale to radar space
	var scale_factor = radar_radius / detection_range
	var radar_pos = relative_2d * scale_factor
	
	# Check if ship is beyond detection range (for enhanced visibility)
	var is_at_edge = false
	if radar_pos.length() > radar_radius:
		radar_pos = radar_pos.normalized() * radar_radius
		is_at_edge = true
	
	# Calculate final screen position
	var screen_pos = radar_center + radar_pos
	
	# Determine color based on ship type (for now, all NPCs are friendly)
	var color = friendly_color
	
	# Check if ship has a faction/team property (future-proofing for enemies)
	if "is_enemy" in ship and ship.is_enemy:
		color = enemy_color
	
	# Draw triangle indicator with enhanced visibility for edge indicators
	draw_triangle_indicator(screen_pos, color, is_at_edge)

func draw_triangle_indicator(pos: Vector2, color: Color, is_at_edge: bool = false):
	## Draw a small triangle pointing upward at the given position
	
	var size_multiplier = 1.0
	var outline_width = 0.0
	
	# Make edge indicators larger and add outline for visibility
	if is_at_edge:
		size_multiplier = 1.5  # 50% larger
		outline_width = 2.0  # Add white outline
	
	var half_size = (indicator_size * size_multiplier) / 2
	var height = (indicator_size * size_multiplier) * 0.866  # sqrt(3)/2 for equilateral triangle
	
	# Define triangle points (pointing up)
	var points = PackedVector2Array([
		pos + Vector2(0, -height * 0.67),  # Top point
		pos + Vector2(-half_size, height * 0.33),  # Bottom left
		pos + Vector2(half_size, height * 0.33)  # Bottom right
	])
	
	# Draw white outline for edge indicators
	if is_at_edge and outline_width > 0:
		# Draw slightly larger triangle as outline
		var outline_half_size = half_size + outline_width
		var outline_height = height + outline_width * 1.5
		var outline_points = PackedVector2Array([
			pos + Vector2(0, -outline_height * 0.67),
			pos + Vector2(-outline_half_size, outline_height * 0.33),
			pos + Vector2(outline_half_size, outline_height * 0.33)
		])
		draw_colored_polygon(outline_points, Color.WHITE)
	
	# Draw filled triangle
	draw_colored_polygon(points, color)
