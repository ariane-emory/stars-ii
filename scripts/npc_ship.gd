extends CharacterBody3D

## NPC ship with simple wandering behavior

@export var speed: float = 100.0
@export var rotation_speed: float = 1.0

var rotation_angle: float = 0.0
var target_rotation_angle: float = 0.0
var wander_time: float = 0.0
var wander_duration: float = 5.0
var ship_name: String = ""
var ship_name_label: Label = null

func _ready():
	# Add to npc_ships group for radar detection
	add_to_group("npc_ships")
	
	# Random starting rotation
	rotation_angle = randf_range(0, TAU)
	target_rotation_angle = rotation_angle
	# Random starting position offset (including altitude)
	# Randomly place ships either above or below the player plane
	var altitude = randf_range(50, 150) * (1 if randf() > 0.5 else -1)
	position += Vector3(randf_range(-500, 500), altitude, randf_range(-500, 500))
	# Random wander duration
	wander_duration = randf_range(3.0, 8.0)
	
	# Scale up the model MUCH larger
	var model = get_node_or_null("Model")
	if model:
		model.scale = Vector3(100, 100, 100)
		
		# Convert all materials to unshaded
		convert_to_unshaded(model)
		
		# Apply standard rotation fix for all ships
		apply_standard_rotation_fix(model)
	
	# Create a 3D label to display the ship name
	if ship_name != "":
		create_name_label()
	


func _physics_process(delta):
	wander_time += delta
	
	# Pick a new target direction periodically
	if wander_time >= wander_duration:
		wander_time = 0.0
		target_rotation_angle = randf_range(0, TAU)
		wander_duration = randf_range(3.0, 8.0)
	
	# Smoothly rotate towards target angle
	var angle_diff = target_rotation_angle - rotation_angle
	# Normalize angle difference to [-PI, PI] for shortest rotation
	angle_diff = fmod(angle_diff + PI, TAU) - PI
	
	# Rotate towards target
	if abs(angle_diff) > 0.01:
		var rotation_step = sign(angle_diff) * min(abs(angle_diff), rotation_speed * delta)
		rotation_angle += rotation_step
		rotation_angle = fmod(rotation_angle, TAU)
	
	# Move in current direction
	var direction = Vector3(cos(rotation_angle), 0, sin(rotation_angle))
	velocity = direction * speed
	
	move_and_slide()
	
	# Update visual rotation
	rotation.y = -rotation_angle
	
	# Update name label position if it exists
	if ship_name_label:
		update_name_label_position()

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
	
	# Recursively process children
	for child in node.get_children():
		convert_to_unshaded(child)

func apply_standard_rotation_fix(model: Node3D):
	## Apply the standard rotation fix that works for all ships
	
	# Create a wrapper node
	var wrapper = Node3D.new()
	wrapper.name = "ModelWrapper"
	
	# Remove model from its current parent
	var parent = model.get_parent()
	parent.remove_child(model)
	
	# Add wrapper to parent, then model to wrapper
	parent.add_child(wrapper)
	wrapper.add_child(model)
	
	# Apply the standard rotation that makes ships face correctly
	wrapper.rotation_degrees = Vector3(90, 90, 0)

func create_name_label():
	## Create a 2D HUD-style text label that follows the ship
	
	# Find the HUD CanvasLayer in the main scene
	var hud = get_node("/root/Main/HUD")
	if not hud:
		return
	
# Create the actual text label as a child of HUD
	var text_label = Label.new()
	text_label.text = ship_name
	text_label.name = "ShipLabel_" + ship_name  # Unique name
	text_label.add_theme_color_override("font_color", Color.GREEN)
	text_label.add_theme_font_size_override("font_size", 28)
	text_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	text_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	text_label.modulate = Color.GREEN
	
	# Set proper monospaced font using SystemFont
	var mono_font = SystemFont.new()
	mono_font.font_names = ["Consolas", "Monaco", "Courier New", "DejaVu Sans Mono", "monospace"]
	mono_font.allow_system_fallback = true
	
	# Apply the monospace font with fallback
	text_label.add_theme_font_override("font", mono_font)
	
	# Add to HUD
	hud.add_child(text_label)
	
	# Store reference for position updates
	ship_name_label = text_label

func update_name_label_position():
	## Update the 2D label position to follow the ship in screen space
	
	if not ship_name_label:
		return
	
	# Get the camera from the main scene
	var camera = get_node("/root/Main/Camera3D")
	if not camera:
		return
	
	# Convert world position to screen coordinates
	var screen_pos = camera.unproject_position(global_position)
	
	# Set label position (centered on the ship)
	var label_size = ship_name_label.get_size()
	ship_name_label.position = Vector2(
		screen_pos.x - label_size.x / 2,
		screen_pos.y - label_size.y / 2 - 100  # Offset above ship
	)

func _exit_tree():
	## Clean up the label when ship is removed from scene
	if ship_name_label and is_instance_valid(ship_name_label):
		ship_name_label.queue_free()
		ship_name_label = null
