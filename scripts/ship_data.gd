extends Node

## Centralized ship configuration data
## This autoload provides ship-specific data like rotation corrections

# Ship configuration structure
class ShipConfig:
	var name: String
	var model_path: String
	var rotation_correction: Vector3
	
	func _init(p_name: String, p_model_path: String, p_rotation: Vector3):
		name = p_name
		model_path = p_model_path
		rotation_correction = p_rotation

# Dictionary of ship configurations indexed by ship name
var ship_configs: Dictionary = {}

# List of all ship model paths (for random selection)
var all_ship_paths: Array[String] = []

func _ready():
	_initialize_ship_data()

func _initialize_ship_data():
	## Initialize all ship configurations with their rotation corrections
	
	# Default rotation for most ships (the majority need this)
	var default_rotation = Vector3(0, 0, 0)
	
	# Old default rotation - some ships still need this
	var old_default_rotation = Vector3(90, 90, 0)
	
	# Alternative rotation for ships with different GLB orientation
	var alt_rotation = Vector3(0, 90, 0)
	
	# Ships that need the old default rotation (90, 90, 0)
	var old_default_ships = [
		"Dart Scout",
		"Falcon Scout"
	]
	
	# Ships that need the alternative rotation (0, 90, 0)
	var alt_rotation_ships = [
		"Pickax Mining Ship",
		"Luna Shuttle",
		"Cyclops Missile Boat",
		"Blood Eagle Fighter",
		"Vulture Gunship",
		"Fury Fighter",
		"Lineman Hauler",
		"Rack Fighter",
		"Shark Gunship",
		"Star Skipper Trader",
		"Nebulous Scout",
		"Fortress Cruiser"
	]
	
	# All ship models with their paths
	var ship_list = [
		"Alpine Cruiser",
		"Belt Freighter",
		"Blood Eagle Fighter",
		"Breacher Assault Ship",
		"Bulwark Battleship",
		"Cyclops Missile Boat",
		"Dagger Fighter",
		"Dart Scout",
		"Drushi Battleship",
		"Eclipse Battlleship",
		"Empress Liner",
		"Equinox Battleship",
		"Express Trader",
		"Falcon Scout",
		"Fleetfoot Scout",
		"Fortress Cruiser",
		"Fury Fighter",
		"Hoplit eFighter",
		"Horseman Gunship",
		"Infernus Gunship",
		"Lineman Hauler",
		"Longhauler Freighter",
		"Luna Shuttle",
		"Nebula Battleship",
		"Nova Battleship",
		"Nubulous Scout",
		"Occulus Gun Platform",
		"Pacer Gunship",
		"Pacifica Liner",
		"Paladin Gunship",
		"Pickax Mining Ship",
		"Prosperity Trader",
		"Rack Fighter",
		"Railway Hauler",
		"Resolute Frigate",
		"Rimward Freighter",
		"Royal Standard Battleship",
		"Sentry Patrol Ship",
		"Shadoblade Fighter",
		"Shark Gunship",
		"Shield Battleship",
		"Snowbird Gunship",
		"Solar Empress Liner",
		"Spear Frigate",
		"Stalward Battleship",
		"Star Eagle Fighter",
		"Star Skipper Trader",
		"Starways Hauler",
		"Stingr",
		"Strider Scout",
		"Sunbird Fighter",
		"Swordsman Gunship",
		"Tortois Gunship",
		"Unyielding Battleship",
		"Vector Battleship",
		"Void Hauler",
		"Vulture Gunship",
		"Was Fighter",
		"Wasp Fighter",
		"Zephyr Scout"
	]
	
	# Build ship configurations
	for ship_name in ship_list:
		var model_path = "res://glb/" + ship_name + ".glb"
		var rotation: Vector3
		
		# Determine which rotation to use
		if ship_name in alt_rotation_ships:
			rotation = alt_rotation
		elif ship_name in old_default_ships:
			rotation = old_default_rotation
		else:
			rotation = default_rotation
		
		var config = ShipConfig.new(ship_name, model_path, rotation)
		ship_configs[ship_name] = config
		all_ship_paths.append(model_path)

func get_ship_rotation(ship_name: String) -> Vector3:
	## Get the rotation correction for a specific ship by name
	if ship_configs.has(ship_name):
		return ship_configs[ship_name].rotation_correction
	else:
		# Return default rotation if ship not found
		push_warning("Ship '%s' not found in ship_data, using default rotation" % ship_name)
		return Vector3(0, 0, 0)

func get_ship_config(ship_name: String) -> ShipConfig:
	## Get the full configuration for a specific ship
	if ship_configs.has(ship_name):
		return ship_configs[ship_name]
	else:
		push_warning("Ship '%s' not found in ship_data" % ship_name)
		return null

func get_all_ship_paths() -> Array[String]:
	## Get list of all ship model paths for random selection
	return all_ship_paths.duplicate()

func get_ship_name_from_path(path: String) -> String:
	## Extract ship name from GLB path
	return path.get_file().get_basename()
