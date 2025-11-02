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

func _ready():
	_initialize_ship_data()

func _initialize_ship_data():
	## Initialize all ship configurations with their rotation corrections
	
	# Default rotation for most ships (the majority need this)
	var default_rotation = Vector3(0, 0, 0)
	
	# Old default rotation - some ships still need this
	var old_default_rotation = Vector3(90, 90, 0)
	
	# Alternative rotation for ships with different GLB orientation (left wingtip thrust)
	var alt_rotation = Vector3(0, 90, 0)
	
	# Reverse rotation for ships with right wingtip thrust (opposite of alt_rotation)
	var reverse_rotation = Vector3(0, -90, 0)
	
	# 180 degree rotation for ships pointing backwards
	var flip_rotation = Vector3(0, 180, 0)
	
	# Ships that need the old default rotation (90, 90, 0)
	# NOTE: This rotation causes pitch which is visible in top-down view
	# Keeping this list for reference but it should be empty for top-down gameplay
	var old_default_ships = [
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
		"Fortress Cruiser",
		"Brachiator Gun Platform",
		"Brawler Gunship",
		"Starways Hauler",
		"Strider Scout",
		"Fleetfoot Scout",
		"Vector Battleship",
		"Equinox Battleship",
		"Tortoise Gunship",
		"Drushi Battleship",
		"Star Eagle Fighter",
		"Occulus Gun Platform",
		"Spear Frigate",
		"Shield Battleship",
		"Breacher Assault Ship",
		"Pacifica Liner",
		"Falcon Scout",
		"Pacer Gunship",
		"Resolute Frigate",
		"Dagger Fighter",
		"Wasp Fighter",
		"Longhauler Freighter",
		"Zephyr Scout",
		"Nebula Battleship",
		"Dart Scout",
		"Perimiter Patrol Ship",
		"Sentry Patrol Ship",
		"Secutor Patrol Ship",
		"Viceroy Shuttle",
		"Long Shot Gun Platform",
		"Express Trader",
		"Swordsman Gunship",
		"Stingray Fighter",
		"Paladin Gunship",
		"Nordic LIner",
		"Empress Liner",
		"Overlook Gunship",
		"Paragon Shuttle",
		"Northerner Gunship",
		"Dwarf Fighter",
		"Gattler Frigate",
		"Snowbird Gunship",
		"Dolphin Trader",
		"Sundown Cruiser",
		"Quadrant Frigate",
		"Rimward Freighter",
		"Nubulous Scout",
		"Hoplite Fighter",
		"Tropica Gunship",
		"Mosquito Fighter",
		"Railway Hauler"
	]
	
	# Ships that need the reverse rotation (0, -90, 0) for right wingtip thrust
	var reverse_rotation_ships = [
		"Stalwart Battleship",
		"Horseman Gunship",
		"Nova Battleship",
		"Prosperity Trader",
		"Batwing Gunship",
		"Front Line Frigate",
		"Viking Frigate",
		"Sea Turtle Shuttle"
	]
	
	# Ships that need 180 degree rotation (pointing backwards)
	var flip_rotation_ships = [
		"Belt Freighter",
		"Eclipse Battlleship",
		"Bulwark Battleship",
		"Myrmidon Gunship",
		"Star Skipper Trader",
		"Stalwart Battleship"
	]
	
	# Ship class categorization for scaling
	# Fighters: 0.9 (10% smaller)
	var fighters = [
		"Blood Eagle Fighter",
		"Dagger Fighter",
		"Darkling Fighter",
		"Dwarf Fighter",
		"Fury Fighter",
		"Hoplite Fighter",
		"Icepick Fighter",
		"Mosquito Fighter",
		"Pikeman Fighter",
		"Rack Fighter",
		"Shadoblade Fighter",
		"Sparrow Fighter",
		"Star Eagle Fighter",
		"Stiletto Fighter",
		"Stingr",
		"Stingray Fighter",
		"Sunbird Fighter",
		"Vampie Fighter",
		"Wasp Fighter"
	]
	
	# Scouts: 0.9 (10% smaller)
	var scouts = [
		"Dart Scout",
		"Falcon Scout",
		"Fleetfoot Scout",
		"Nubulous Scout",
		"Raven Scout",
		"Strider Scout",
		"Zephyr Scout"
	]
	
	# Shuttles: 0.9 (10% smaller)
	var shuttles = [
		"Dispatch Shuttle",
		"Luna Shuttle",
		"Naos Shuttle",
		"Paragon Shuttle",
		"Sea Turtle Shuttle",
		"Viceroy Shuttle"
	]
	
	# Battleships: 1.2 (20% larger)
	var battleships = [
		"Bulwark Battleship",
		"Drushi Battleship",
		"Eclipse Battlleship",
		"Equinox Battleship",
		"Guardian Battleship",
		"Nebula Battleship",
		"Nova Battleship",
		"Royal Standard Battleship",
		"Shield Battleship",
		"Stalwart Battleship",
		"Unyielding Battleship",
		"Vector Battleship"
	]
	
	# Frigates: 1.1 (10% larger)
	var frigates = [
		"Barricade Frigate",
		"Barrier Frigate",
		"Front Line Frigate",
		"Gattler Frigate",
		"Quadrant Frigate",
		"Resolute Frigate",
		"Spear Frigate",
		"Steadfast Frigate",
		"Viking Frigate"
	]
	
	# Cruisers: 1.1 (10% larger)
	var cruisers = [
		"Alpine Cruiser",
		"Fortress Cruiser",
		"Sundown Cruiser"
	]
	
	# Haulers, Freighters, Traders, Liners: 1.1 (10% larger)
	var cargo_ships = [
		"Belt Freighter",
		"Carp Trader",
		"Dolphin Trader",
		"Empress Liner",
		"Executive Liner",
		"Express Trader",
		"Lineman Hauler",
		"Longhauler Freighter",
		"Longshoreman Hauler",
		"Nordic LIner",
		"Pacifica Liner",
		"Prosperity Trader",
		"Railway Hauler",
		"Rimward Freighter",
		"Solar Empress Liner",
		"Star Skipper Trader",
		"Starways Hauler",
		"Void Hauler"
	]
	
	# Gunships: 1.05 (5% larger than default)
	var gunships = [
		"Banshee Gunship",
		"Batwing Gunship",
		"Brawler Gunship",
		"Frostbite Gunship",
		"Horseman Gunship",
		"Infernus Gunship",
		"Myrmidon Gunship",
		"Northerner Gunship",
		"Overlook Gunship",
		"Pacer Gunship",
		"Paladin Gunship",
		"Robin Gunship",
		"Shark Gunship",
		"Snowbird Gunship",
		"Spartan Gunship",
		"Swordsman Gunship",
		"Tortoise Gunship",
		"Tropica Gunship",
		"Valiant Gunship",
		"Vulture Gunship"
	]
	
	# Ships that need individual custom scale overrides (applied after class-based scaling)
	var custom_scale_ships = {
		"Unyielding Battleship": 1.43  # 10% larger than standard battleship scale (1.3 * 1.1)
	}
	
	# All ship models with their paths
	var ship_list = [
		"Alpine Cruiser",
		"Banshee Gunship",
		"Barricade Frigate",
		"Barrier Frigate",
		"Batwing Gunship",
		"Belt Freighter",
		"Blood Eagle Fighter",
		"Brachiator Gun Platform",
		"Brawler Gunship",
		"Breacher Assault Ship",
		"Bulwark Battleship",
		"Carp Trader",
		"Cyclops Missile Boat",
		"Dagger Fighter",
		"Darkling Fighter",
		"Dart Scout",
		"Dispatch Shuttle",
		"Dolphin Trader",
		"Drushi Battleship",
		"Dwarf Fighter",
		"Eclipse Battlleship",
		"Empress Liner",
		"Equinox Battleship",
		"Executive Liner",
		"Express Trader",
		"Falcon Scout",
		"Fleetfoot Scout",
		"Forefront Interceptor",
		"Fortress Cruiser",
		"Front Line Frigate",
		"Frostbite Gunship",
		"Fury Fighter",
		"Gattler Frigate",
		"Guardian Battleship",
		"Hoplite Fighter",
		"Horseman Gunship",
		"Icepick Fighter",
		"Infernus Gunship",
		"Lineman Hauler",
		"Long Shot Gun Platform",
		"Longhauler Freighter",
		"Longshoreman Hauler",
		"Luna Shuttle",
		"Mosquito Fighter",
		"Myrmidon Gunship",
		"Naos Shuttle",
		"Nebula Battleship",
		"Nordic LIner",
		"Northerner Gunship",
		"Nova Battleship",
		"Nubulous Scout",
		"Occulus Gun Platform",
		"Overlook Gunship",
		"Pacer Gunship",
		"Pacifica Liner",
		"Paladin Gunship",
		"Paragon Shuttle",
		"Perimiter Patrol Ship",
		"Pickax Mining Ship",
		"Pikeman Fighter",
		"Prosperity Trader",
		"Quadrant Frigate",
		"Rack Fighter",
		"Railway Hauler",
		"Raven Scout",
		"Resolute Frigate",
		"Rimward Freighter",
		"Robin Gunship",
		"Royal Standard Battleship",
		"Sea Turtle Shuttle",
		"Secutor Patrol Ship",
		"Sentry Patrol Ship",
		"Shadoblade Fighter",
		"Shark Gunship",
		"Shield Battleship",
		"Snowbird Gunship",
		"Solar Empress Liner",
		"Sparrow Fighter",
		"Spartan Gunship",
		"Spear Frigate",
		"Spike Patrol Ship",
		"Stalwart Battleship",
		"Star Eagle Fighter",
		"Star Skipper Trader",
		"Starways Hauler",
		"Steadfast Frigate",
		"Stiletto Fighter",
		"Stingr",
		"Stingray Fighter",
		"Strider Scout",
		"Sunbird Fighter",
		"Sundown Cruiser",
		"Swordsman Gunship",
		"Toad Assault Ship",
		"Tortoise Gunship",
		"Tropica Gunship",
		"Unyielding Battleship",
		"Valiant Gunship",
		"Vampie Fighter",
		"Vector Battleship",
		"Viceroy Shuttle",
		"Viking Frigate",
		"Void Hauler",
		"Vulture Gunship",
		"Wasp Fighter",
		"Zephyr Scout"
	]
	
	# Build ship configurations
	for ship_name in ship_list:
		var model_path = "res://glb/" + ship_name + ".glb"
		var rotation: Vector3
		var scale_mult: float = 1.0
		
		# Determine which rotation to use
		if ship_name in alt_rotation_ships:
			rotation = alt_rotation
		elif ship_name in old_default_ships:
			rotation = old_default_rotation
		elif ship_name in reverse_rotation_ships:
			rotation = reverse_rotation
		elif ship_name in flip_rotation_ships:
			rotation = flip_rotation
		else:
			rotation = default_rotation
		
		# Determine scale based on ship class
		if ship_name in fighters or ship_name in scouts or ship_name in shuttles:
			scale_mult = 0.8  # 20% smaller total
		elif ship_name in battleships:
			scale_mult = 1.3  # 30% larger
		elif ship_name in frigates or ship_name in cruisers or ship_name in cargo_ships:
			scale_mult = 1.15  # 15% larger
		elif ship_name in gunships:
			scale_mult = 1.05  # 5% larger than default
		else:
			scale_mult = 1.0  # Default size
		
		# Apply individual custom scale overrides if specified
		if custom_scale_ships.has(ship_name):
			scale_mult = custom_scale_ships[ship_name]
		
		var config = ShipConfig.new(ship_name, model_path, rotation, scale_mult)
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

func get_ship_scale(ship_name: String) -> float:
	## Get the scale multiplier for a specific ship by name
	if ship_configs.has(ship_name):
		return ship_configs[ship_name].scale_multiplier
	else:
		# Return default scale if ship not found
		return 1.0

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
