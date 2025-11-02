extends Node

## Centralized ship configuration data
## This autoload provides ship-specific data like rotation corrections

# Ship configuration structure
class ShipConfig:
	var name: String
	var model_path: String
	var rotation_correction: Vector3
	var scale_multiplier: float
	
	func _init(p_name: String, p_model_path: String, p_rotation: Vector3, p_scale: float = 1.0):
		name = p_name
		model_path = p_model_path
		rotation_correction = p_rotation
		scale_multiplier = p_scale

# Dictionary of ship configurations indexed by ship name
var ship_configs: Dictionary = {}

# List of all ship model paths (for random selection)
var all_ship_paths: Array[String] = []

# Complete ship list (for validation)
var ship_list: Array[String] = []

# Individual ship rotation configuration
var ship_rotation_dict: Dictionary = {}

# Default rotation for most ships
var default_rotation: Vector3 = Vector3(0, 0, 0)

func _ready():
	_initialize_ship_data()

func _initialize_ship_data():
	## Initialize all ship configurations with their rotation corrections
	
	# Default rotation for most ships (the majority need this)
	
	# Individual ship rotation configuration - each ship has explicit rotation setting
	ship_rotation_dict = {
		# Alternative rotation (0, 90, 0) - right wingtip thrust
		"Pickax Mining Ship": Vector3(0, 90, 0),
		"Luna Shuttle": Vector3(0, 90, 0),
		"Cyclops Missile Boat": Vector3(0, 90, 0),
		"Blood Eagle Fighter": Vector3(0, 90, 0),
		"Vulture Gunship": Vector3(0, 90, 0),
		"Fury Fighter": Vector3(0, 90, 0),
		"Lineman Hauler": Vector3(0, 90, 0),
		"Rack Fighter": Vector3(0, 90, 0),
		"Shark Gunship": Vector3(0, 90, 0),
		"Fortress Cruiser": Vector3(0, 90, 0),
		"Brachiator Gun Platform": Vector3(0, 90, 0),
		"Brawler Gunship": Vector3(0, 90, 0),
		"Starways Hauler": Vector3(0, 90, 0),
		"Strider Scout": Vector3(0, 90, 0),
		"Fleetfoot Scout": Vector3(0, 90, 0),
		"Vector Battleship": Vector3(0, 90, 0),
		"Equinox Battleship": Vector3(0, 90, 0),
		"Tortoise Gunship": Vector3(0, 90, 0),
		"Drushi Battleship": Vector3(0, 90, 0),
		"Star Eagle Fighter": Vector3(0, 90, 0),
		"Occulus Gun Platform": Vector3(0, 90, 0),
		"Spear Frigate": Vector3(0, 90, 0),
		"Shield Battleship": Vector3(0, 90, 0),
		"Breacher Assault Ship": Vector3(0, 90, 0),
		"Pacifica Liner": Vector3(0, 90, 0),
		"Falcon Scout": Vector3(0, 90, 0),
		"Pacer Gunship": Vector3(0, 90, 0),
		"Resolute Frigate": Vector3(0, 90, 0),
		"Dagger Fighter": Vector3(0, 90, 0),
		"Wasp Fighter": Vector3(0, 90, 0),
		"Longhauler Freighter": Vector3(0, 90, 0),
		"Zephyr Scout": Vector3(0, 90, 0),
		"Nebula Battleship": Vector3(0, 90, 0),
		"Dart Scout": Vector3(0, 90, 0),
		"Perimiter Patrol Ship": Vector3(0, 90, 0),
		"Sentry Patrol Ship": Vector3(0, 90, 0),
		"Secutor Patrol Ship": Vector3(0, 90, 0),
		"Viceroy Shuttle": Vector3(0, 90, 0),
		"Long Shot Gun Platform": Vector3(0, 90, 0),
		"Express Trader": Vector3(0, 90, 0),
		"Swordsman Gunship": Vector3(0, 90, 0),
		"Stingray Fighter": Vector3(0, 90, 0),
		"Paladin Gunship": Vector3(0, 90, 0),
		"Nordic LIner": Vector3(0, 90, 0),
		"Empress Liner": Vector3(0, 90, 0),
		"Overlook Gunship": Vector3(0, 90, 0),
		"Paragon Shuttle": Vector3(0, 90, 0),
		"Northerner Gunship": Vector3(0, 90, 0),
		"Dwarf Fighter": Vector3(0, 90, 0),
		"Gattler Frigate": Vector3(0, 90, 0),
		"Snowbird Gunship": Vector3(0, 90, 0),
		"Dolphin Trader": Vector3(0, 90, 0),
		"Sundown Cruiser": Vector3(0, 90, 0),
		"Quadrant Frigate": Vector3(0, 90, 0),
		"Rimward Freighter": Vector3(0, 90, 0),
		"Nubulous Scout": Vector3(0, 90, 0),
		"Hoplite Fighter": Vector3(0, 90, 0),
		"Tropica Gunship": Vector3(0, 90, 0),
		"Mosquito Fighter": Vector3(0, 90, 0),
		"Railway Hauler": Vector3(0, 90, 0),
		"Barrier Frigate": Vector3(0, 90, 0),
		"Stiletto Fighter": Vector3(0, 90, 0),
		"Star Skipper Trader": Vector3(0, -90, 0),
		"Eclipse Battlleship": Vector3(0, 90, 0),
		"Stinger Fighter": Vector3(0, 90, 0),
		"Stalwart Battleship": Vector3(0, 90, 0),
		"Bulwark Battleship": Vector3(0, 90, 0),
		"Spike Patrol Ship": Vector3(0, -90, 0),
		"Barricade Frigate": Vector3(0, 90, 0),
		
		# Reverse rotation (0, -90, 0) - left wingtip thrust
		"Horseman Gunship": Vector3(0, -90, 0),
		"Nova Battleship": Vector3(0, -90, 0),
		"Batwing Gunship": Vector3(0, -90, 0),
		"Front Line Frigate": Vector3(0, -90, 0),
		"Viking Frigate": Vector3(0, -90, 0),
		"Sea Turtle Shuttle": Vector3(0, -90, 0),
		"Darkling Fighter": Vector3(0, -90, 0),
		"Spartan Gunship": Vector3(0, -90, 0),
		"Robin Gunship": Vector3(0, 90, 0),
		"Carp Trader": Vector3(0, 90, 0),
		"Solar Empress Liner": Vector3(0, -90, 0),
		"Shadowblade Fighter": Vector3(0, 90, 0),
		"Prosperity Trader": Vector3(0, 90, 0),
		"Sparrow Fighter": Vector3(0, -90, 0),
		"Frostbite Gunship": Vector3(0, 90, 0),
		"Icepick Fighter": Vector3(0, -90, 0),
		"Forefront Interceptor": Vector3(0, 90, 0),
		"Dispatch Shuttle": Vector3(0, 90, 0),
		"Toad Assault Ship": Vector3(0, -90, 0),
		"Raven Scout": Vector3(0, 90, 0),
		"Banshee Gunship": Vector3(0, 90, 0),
		"Vampire Fighter": Vector3(0, 90, 0),
		
		# 180 degree rotation (0, 180, 0) - backward thrust
		"Belt Freighter": Vector3(0, 180, 0),
		"Myrmidon Gunship": Vector3(0, 180, 0),
		"Executive Liner": Vector3(0, 90, 0),
		"Pikeman Fighter": Vector3(0, 90, 0),
		"Royal Standard Battleship": Vector3(0, 180, 0),
		"Steadfast Frigate": Vector3(0, 180, 0)
	}
	
	# Validate that all ships have defined rotations
	_validate_ship_rotations()
	
	# Ship class categorization for scaling (reserved for future use)
	# var fighters: Array[String] = []
	# var gunships: Array[String] = []
	# var freighters: Array[String] = []
	# var cruisers: Array[String] = []
	# var battleships: Array[String] = []
	# var scouts: Array[String] = []
	# var traders: Array[String] = []
	# var patrol_ships: Array[String] = []
	# var shuttles: Array[String] = []
	# var gun_platforms: Array[String] = []
	# var assault_ships: Array[String] = []
	# var liners: Array[String] = []
	# var haulers: Array[String] = []
	# var frigates: Array[String] = []
	# var interceptors: Array[String] = []
	
	# Populate ship lists from GLB files
	var dir = DirAccess.open("res://glb/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".glb") and not file_name.begins_with("Missile"):
				var ship_name = file_name.replace(".glb", "")
				ship_list.append(ship_name)
				all_ship_paths.append("res://glb/" + file_name)
			file_name = dir.get_next()
	
	# Create ship configurations
	for ship_name in ship_list:
		var rotation = default_rotation
		if ship_rotation_dict.has(ship_name):
			rotation = ship_rotation_dict[ship_name]
		
		# Set scale multiplier for specific ships
		var scale_multiplier = 1.0
		
		# Special cases for haulers and freighters
		if ship_name == "Railway Hauler":
			scale_multiplier = 1.5
		elif ship_name == "Belt Freighter":
			scale_multiplier = 1.5
		elif ship_name == "Blood Eagle Fighter":
			scale_multiplier = 0.5
		elif ship_name == "Forefront Interceptor":
			scale_multiplier = 0.9
		elif ship_name == "Alpine Cruiser":
			scale_multiplier = 1.1
		elif ship_name == "Longhauler Freighter":
			scale_multiplier = 1.21
		elif ship_name == "Long Shot Gun Platform":
			scale_multiplier = 1.1
		elif ship_name == "Eclipse Battlleship":
			scale_multiplier = 2.0
		elif ship_name == "Drushi Battleship":
			scale_multiplier = 1.25
		elif ship_name == "Luna Shuttle":
			scale_multiplier = 0.81
		elif ship_name == "Executive Liner":
			scale_multiplier = 1.1
		elif ship_name == "Star Eagle Fighter":
			scale_multiplier = 0.9
		elif ship_name == "Longshoreman Hauler":
			scale_multiplier = 1.25
		elif ship_name == "Breacher Assault Ship":
			scale_multiplier = 1.25
		elif ship_name == "Front Line Frigate":
			scale_multiplier = 1.25
		elif ship_name == "Nordic LIner":
			scale_multiplier = 1.25
		elif ship_name == "Void Hauler":
			scale_multiplier = 1.5
		elif ship_name == "Strider Scout":
			scale_multiplier = 0.9
		# Reduce fighters, scouts, and shuttles by 0.1
		elif ship_name.ends_with("Fighter") or ship_name.ends_with("Scout") or ship_name.ends_with("Shuttle"):
			scale_multiplier = 0.8
		# Increase battleships and cruisers by 0.1
		elif ship_name.ends_with("Battleship") or ship_name.ends_with("Cruiser"):
			scale_multiplier = 1.1
		# Increase liners by 0.2
		elif ship_name.ends_with("Liner"):
			scale_multiplier = 1.2
		
		var config = ShipConfig.new(
			ship_name,
			"res://glb/" + ship_name + ".glb",
			rotation,
			scale_multiplier
		)
		ship_configs[ship_name] = config

func _validate_ship_rotations():
	## Ensure all ships have defined rotations
	for ship_name in ship_list:
		if not ship_rotation_dict.has(ship_name):
			push_warning("Ship '%s' missing from rotation dictionary, using default rotation" % ship_name)
			ship_rotation_dict[ship_name] = default_rotation

func get_ship_config(ship_name: String) -> ShipConfig:
	## Get configuration for a specific ship
	if ship_configs.has(ship_name):
		return ship_configs[ship_name]
	else:
		push_error("Ship config not found: " + ship_name)
		return null

func get_ship_scale(ship_name: String) -> float:
	## Get scale multiplier for a specific ship
	var config = get_ship_config(ship_name)
	if config:
		return config.scale_multiplier
	else:
		return 1.0

func get_all_ship_paths() -> Array[String]:
	## Get all available ship model paths
	return all_ship_paths

func get_ship_name_from_path(path: String) -> String:
	## Extract ship name from file path
	return path.get_file().get_basename()

func get_ship_rotation(ship_name: String) -> Vector3:
	## Get rotation correction for a specific ship
	if ship_rotation_dict.has(ship_name):
		return ship_rotation_dict[ship_name]
	else:
		return default_rotation

func get_random_ship_path() -> String:
	## Get a random ship model path
	if all_ship_paths.size() > 0:
		return all_ship_paths[randi() % all_ship_paths.size()]
	else:
		push_error("No ship paths available")
		return ""
