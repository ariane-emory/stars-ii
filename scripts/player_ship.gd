extends CharacterBody3D

## Player-controlled spaceship with rotation-based movement (like Escape Velocity)

# Movement parameters
@export var thrust_power: float = 500.0
@export var rotation_speed: float = 1.5  # radians per second
@export var max_speed: float = 800.0
@export var drag: float = 0.995  # Velocity multiplier per frame (0.99 = very little drag, space-like)

# Current rotation angle (in radians, 0 = pointing right)
var rotation_angle: float = 0.0

# Ship model name
var ship_name: String = "Unknown"

func _ready():
	# Start with a random rotation
	rotation_angle = randf_range(0, TAU)
	print("Player ship initialized at position: ", position)
	
	# Check if model loaded
	var model = get_node_or_null("Model")
	if model:
		print("Model found: ", model)
		print("Model has ", model.get_child_count(), " children")
		
		# Get ship name from model's scene file path
		if model.scene_file_path:
			ship_name = model.scene_file_path.get_file().get_basename()
			print("Ship name: ", ship_name)
		
		# Scale up model MUCH larger
		model.scale = Vector3(100, 100, 100)
		print("Model scaled to: ", model.scale)
		
		# Convert all materials to unshaded
		convert_to_unshaded(model)
		
		# Apply standard rotation correction
		print("Model initial rotation: ", model.rotation_degrees)
		apply_standard_rotation_fix(model)
	else:
		print("ERROR: Model node not found!")

func convert_to_unshaded(node: Node):
	## Recursively convert all materials in this node and its children to unshaded
	if node is MeshInstance3D:
		var mesh_instance = node as MeshInstance3D
		
		# Process each surface
		for i in range(mesh_instance.mesh.get_surface_count()):
			# Get the current material (either override or default)
			var current_mat = mesh_instance.get_surface_override_material(i)
			if not current_mat:
				current_mat = mesh_instance.mesh.surface_get_material(i)
			
			if current_mat:
				# Create a new unshaded material
				var unshaded_mat = StandardMaterial3D.new()
				unshaded_mat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
				
				# Copy the albedo color/texture from the original material
				if current_mat is StandardMaterial3D:
					unshaded_mat.albedo_color = current_mat.albedo_color
					unshaded_mat.albedo_texture = current_mat.albedo_texture
				
				# Apply the unshaded material
				mesh_instance.set_surface_override_material(i, unshaded_mat)
				print("Converted material for surface ", i, " on ", mesh_instance.name)
	
	# Recursively process children
	for child in node.get_children():
		convert_to_unshaded(child)

func apply_standard_rotation_fix(model: Node3D):
	## Apply rotation fix using centralized ship data
	# Create a wrapper node
	var wrapper = Node3D.new()
	wrapper.name = "ModelWrapper"
	
	# Remove model from its current parent
	var parent = model.get_parent()
	parent.remove_child(model)
	
	# Add wrapper to parent, then model to wrapper
	parent.add_child(wrapper)
	wrapper.add_child(model)
	
	# Get rotation from centralized ship data
	var ship_rotation = ShipData.get_ship_rotation(ship_name)
	wrapper.rotation_degrees = ship_rotation
	print("Applied rotation fix using wrapper node: ", ship_rotation)

# Debug function to test different rotations
func test_rotation(x_deg: float, y_deg: float, z_deg: float):
	var model = get_node_or_null("Model")
	if model:
		model.rotation_degrees = Vector3(x_deg, y_deg, z_deg)
		print("=== ROTATION TEST: X=%.0f°, Y=%.0f°, Z=%.0f° ===" % [x_deg, y_deg, z_deg])

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
	# J or Left Arrow = rotate left (counter-clockwise)
	if Input.is_key_pressed(KEY_J) or Input.is_key_pressed(KEY_LEFT):
		rotation_angle -= rotation_speed * delta
	
	# L or Right Arrow = rotate right (clockwise)
	if Input.is_key_pressed(KEY_L) or Input.is_key_pressed(KEY_RIGHT):
		rotation_angle += rotation_speed * delta
	
	# Keep angle in 0-2π range
	rotation_angle = wrapf(rotation_angle, 0, TAU)

func handle_thrust(delta):
	# Calculate direction based on current rotation
	var direction = Vector3(cos(rotation_angle), 0, sin(rotation_angle))
	
	# I or Up Arrow = forward thrust
	if Input.is_key_pressed(KEY_I) or Input.is_key_pressed(KEY_UP):
		velocity += direction * thrust_power * delta
	
	# K or Down Arrow = reverse thrust (braking)
	if Input.is_key_pressed(KEY_K) or Input.is_key_pressed(KEY_DOWN):
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
