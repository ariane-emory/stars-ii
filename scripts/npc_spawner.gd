extends Node3D

## Spawns NPC ships at game start
## In verification mode, spawns all ships organized by class

@export var npc_count: int = 8
@export var spawn_radius: float = 1000.0
@export var verification_mode: bool = true  # When true, spawns all ships in organized grid

var npc_ship_scene = preload("res://scenes/npc_ship.tscn")

# Ship classification based on name suffixes
var ship_classes = {
	"Fighters": [],
	"Scouts": [],
	"Shuttles": [],
	"Gunships": [],
	"Traders": [],
	"Patrol Ships": [],
	"Assault Ships": [],
	"Frigates": [],
	"Cruisers": [],
	"Freighters": [],
	"Battleships": [],
	"Haulers": [],
	"Liners": [],
	"Gun Platforms": [],
	"Mining/Construction": [],
	"Missile Boats": [],
	"Interceptors": [],
	"Other": []
}

# Define the order of ship classes for grid layout
var ship_class_order = [
	"Fighters",
	"Scouts", 
	"Shuttles",
	"Gunships",
	"Traders",
	"Patrol Ships",
	"Assault Ships",
	"Frigates",
	"Cruisers",
	"Freighters",
	"Battleships",
	"Haulers",
	"Liners",
	"Gun Platforms",
	"Mining/Construction",
	"Missile Boats",
	"Interceptors",
	"Other"
]

func _ready():
	if verification_mode:
		spawn_verification_grid()
	else:
		spawn_npcs()

func classify_ship(ship_name: String) -> String:
	## Classify a ship based on its name
	if ship_name.ends_with("Fighter"):
		return "Fighters"
	elif ship_name.ends_with("Scout"):
		return "Scouts"
	elif ship_name.ends_with("Shuttle"):
		return "Shuttles"
	elif ship_name.ends_with("Gunship"):
		return "Gunships"
	elif ship_name.ends_with("Patrol Ship"):
		return "Patrol Ships"
	elif ship_name.ends_with("Assault Ship"):
		return "Assault Ships"
	elif ship_name.ends_with("Frigate"):
		return "Frigates"
	elif ship_name.ends_with("Cruiser"):
		return "Cruisers"
	elif ship_name.ends_with("Battleship"):
		return "Battleships"
	elif ship_name.ends_with("Trader"):
		return "Traders"
	elif ship_name.ends_with("Freighter"):
		return "Freighters"
	elif ship_name.ends_with("Hauler"):
		return "Haulers"
	elif ship_name.ends_with("Liner"):
		return "Liners"
	elif ship_name.ends_with("Gun Platform"):
		return "Gun Platforms"
	elif ship_name.ends_with("Mining Ship") or ship_name.ends_with("Construction Ship"):
		return "Mining/Construction"
	elif ship_name.ends_with("Missile Boat"):
		return "Missile Boats"
	elif ship_name.ends_with("Interceptor"):
		return "Interceptors"
	else:
		return "Other"

func spawn_verification_grid():
	## Spawn all ships organized by class in a grid layout
	print("=== VERIFICATION MODE: Spawning all ships by class ===")
	
	# Classify all ships
	for ship_name in ShipData.ship_list:
		var ship_class = classify_ship(ship_name)
		ship_classes[ship_class].append(ship_name)

	
	# Spawn ships in organized rows
	var row_z_position = 0.0
	var row_spacing = 400.0  # Space between class rows (100% increase from 200)
	var ship_spacing = 300.0  # Space between ships in same row (100% increase from 150)
	
	for ship_class in ship_class_order:
		var ships_in_class = ship_classes[ship_class]
		if ships_in_class.size() == 0:
			continue
		
		print("/\n--- " + ship_class + " (" + str(ships_in_class.size()) + " ships) ---")
		
		# Use doubled spacing for battleships to prevent text overlap
		var current_ship_spacing = ship_spacing
		if ship_class == "Battleships":
			current_ship_spacing = ship_spacing * 2.0
		
		# Calculate starting X position to center the row
		var row_width = (ships_in_class.size() - 1) * current_ship_spacing
		var start_x = -row_width / 2.0
		
		for i in range(ships_in_class.size()):
			var ship_name = ships_in_class[i]
			var x_position = start_x + (i * current_ship_spacing)
			var spawn_pos = Vector3(x_position, 0, row_z_position)
			
			spawn_ship_at_position(ship_name, spawn_pos)
			
			print("  " + ship_name)		
		row_z_position += row_spacing
	
	print("\n=== Total ships spawned: " + str(ShipData.ship_list.size()) + " ===")

func spawn_ship_at_position(ship_name: String, spawn_position: Vector3):
	## Spawn a specific ship at a specific position
	var npc = npc_ship_scene.instantiate()
	
	# Set flag to skip random positioning in verification mode
	npc.skip_random_positioning = true
	
	var config = ShipData.get_ship_config(ship_name)
	if not config:
		push_error("Could not find config for ship: " + ship_name)
		return
	
	var model_scene = load(config.model_path)
	if not model_scene:
		push_error("Failed to load model for ship: " + ship_name + " at path: " + config.model_path)
		npc.queue_free()
		return
	
	npc.ship_name = ship_name
	
	# Remove default Model node if it exists
	var old_model = npc.get_node_or_null("Model")
	if old_model:
		old_model.free()
	
	# Instance and add to new model
	var new_model = model_scene.instantiate()
	if not new_model:
		push_error("Failed to instantiate model for ship: " + ship_name)
		npc.queue_free()
		return
	
	new_model.name = "Model"
	npc.add_child(new_model)
	
	# Add NPC to scene
	add_child(npc)
	
	# In verification mode, set all ships to point downward (towards +Z / bottom of screen)
	# rotation_angle: 0 = right (+X), PI/2 = down (+Z), PI = left (-X), 3*PI/2 = up (-Z)
	npc.rotation_angle = PI / 2  # Point downward
	npc.target_rotation_angle = PI / 2  # Keep pointing downward
	
	# Update rotation fix now that ship name is set
	npc.update_rotation_fix()
	
	# Immediately apply visual rotation in verification mode (since ships start paused)
	npc.update_visual_rotation()
	
	# Set position after adding to scene to ensure proper placement
	npc.position = spawn_position


func spawn_npcs():
	## Original random spawn behavior
	for i in range(npc_count):
		var npc = npc_ship_scene.instantiate()
		
		# Random position around origin
		var angle = randf_range(0, TAU)
		var distance = randf_range(200, spawn_radius)
		npc.position = Vector3(
			cos(angle) * distance,
			0,
			sin(angle) * distance
		)
		
		# Randomize ship model - select random GLB from ShipData
		var ship_paths = ShipData.get_all_ship_paths()
		var random_model_path = ship_paths[randi() % ship_paths.size()]
		var model_scene = load(random_model_path)
		if not model_scene:
			push_error("Failed to load random model at path: " + random_model_path)
			npc.queue_free()
			continue
		
		# Extract ship name from path using ShipData helper
		var ship_name = ShipData.get_ship_name_from_path(random_model_path)
		
		npc.ship_name = ship_name
		
		# Remove the default Model node if it exists
		var old_model = npc.get_node_or_null("Model")
		if old_model:
			old_model.free()  # Use free() instead of queue_free() for immediate removal
		
		# Instance and add the new random model
		var new_model = model_scene.instantiate()
		if not new_model:
			push_error("Failed to instantiate random model for ship: " + ship_name)
			npc.queue_free()
			continue
		new_model.name = "Model"
		npc.add_child(new_model)
		
		# Add NPC to scene (this will trigger _ready() which expects Model to exist)
		add_child(npc)
		
		# Update rotation fix now that ship name is set
		npc.update_rotation_fix()
		
		
