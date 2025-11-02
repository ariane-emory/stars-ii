extends Node

## Centralized ship configuration data
## This autoload provides ship-specific data like rotation corrections and scale multipliers

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

# Complete ship configurations - single source of truth for all ship data
# Each ship has its complete configuration defined here for easy maintenance
var ship_configs: Dictionary = {
	"Alpine Cruiser": ShipConfig.new("Alpine Cruiser", "res://glb/Alpine Cruiser.glb", Vector3(0, -90, 0), 1.953125),
	"Banshee Gunship": ShipConfig.new("Banshee Gunship", "res://glb/Banshee Gunship.glb", Vector3(0, 90, 0), 0.88),
	"Barrier Frigate": ShipConfig.new("Barrier Frigate", "res://glb/Barrier Frigate.glb", Vector3(0, 90, 0), 1.1),
	"Barricade Frigate": ShipConfig.new("Barricade Frigate", "res://glb/Barricade Frigate.glb", Vector3(0, 90, 0), 1.85625),
	"Batwing Gunship": ShipConfig.new("Batwing Gunship", "res://glb/Batwing Gunship.glb", Vector3(0, -90, 0), 1.1),
	"Belt Freighter": ShipConfig.new("Belt Freighter", "res://glb/Belt Freighter.glb", Vector3(0, 180, 0), 2.25),
	"Blood Eagle Fighter": ShipConfig.new("Blood Eagle Fighter", "res://glb/Blood Eagle Fighter.glb", Vector3(0, 90, 0), 0.45),
	"Brawler Gunship": ShipConfig.new("Brawler Gunship", "res://glb/Brawler Gunship.glb", Vector3(0, 90, 0), 1.1),
	"Brachiator Gun Platform": ShipConfig.new("Brachiator Gun Platform", "res://glb/Brachiator Gun Platform.glb", Vector3(0, 90, 0), 0.99),
	"Breacher Assault Ship": ShipConfig.new("Breacher Assault Ship", "res://glb/Breacher Assault Ship.glb", Vector3(0, 90, 0), 1.375),
	"Bulwark Battleship": ShipConfig.new("Bulwark Battleship", "res://glb/Bulwark Battleship.glb", Vector3(0, 90, 0), 1.65),
	"Carp Trader": ShipConfig.new("Carp Trader", "res://glb/Carp Trader.glb", Vector3(0, 90, 0), 1.1),
	"Cyclops Missile Boat": ShipConfig.new("Cyclops Missile Boat", "res://glb/Cyclops Missile Boat.glb", Vector3(0, 90, 0), 1.1),
	"Dagger Fighter": ShipConfig.new("Dagger Fighter", "res://glb/Dagger Fighter.glb", Vector3(0, 90, 0), 0.72),
	"Darkling Fighter": ShipConfig.new("Darkling Fighter", "res://glb/Darkling Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Dart Scout": ShipConfig.new("Dart Scout", "res://glb/Dart Scout.glb", Vector3(0, 90, 0), 0.8),
	"Dispatch Shuttle": ShipConfig.new("Dispatch Shuttle", "res://glb/Dispatch Shuttle.glb", Vector3(0, 90, 0), 0.8),
	"Dolphin Trader": ShipConfig.new("Dolphin Trader", "res://glb/Dolphin Trader.glb", Vector3(0, 90, 0), 1.0),
	"Drushi Battleship": ShipConfig.new("Drushi Battleship", "res://glb/Drushi Battleship.glb", Vector3(0, 90, 0), 1.875),
	"Dwarf Fighter": ShipConfig.new("Dwarf Fighter", "res://glb/Dwarf Fighter.glb", Vector3(0, 90, 0), 0.6),
	"Eclipse Battlleship": ShipConfig.new("Eclipse Battlleship", "res://glb/Eclipse Battlleship.glb", Vector3(0, 90, 0), 2.0),
	"Empress Liner": ShipConfig.new("Empress Liner", "res://glb/Empress Liner.glb", Vector3(0, 90, 0), 1.5),
	"Executive Liner": ShipConfig.new("Executive Liner", "res://glb/Executive Liner.glb", Vector3(0, 90, 0), 1.65),
	"Express Trader": ShipConfig.new("Express Trader", "res://glb/Express Trader.glb", Vector3(0, 90, 0), 1.0),
	"Falcon Scout": ShipConfig.new("Falcon Scout", "res://glb/Falcon Scout.glb", Vector3(0, 90, 0), 0.72),
	"Forefront Interceptor": ShipConfig.new("Forefront Interceptor", "res://glb/Forefront Interceptor.glb", Vector3(0, 90, 0), 0.81),
	"Fortress Cruiser": ShipConfig.new("Fortress Cruiser", "res://glb/Fortress Cruiser.glb", Vector3(0, 90, 0), 1.1),
	"Front Line Frigate": ShipConfig.new("Front Line Frigate", "res://glb/Front Line Frigate.glb", Vector3(0, -90, 0), 1.5625),
	"Frostbite Gunship": ShipConfig.new("Frostbite Gunship", "res://glb/Frostbite Gunship.glb", Vector3(0, 90, 0), 0.99),
	"Fury Fighter": ShipConfig.new("Fury Fighter", "res://glb/Fury Fighter.glb", Vector3(0, 90, 0), 0.7128),
	"Gattler Frigate": ShipConfig.new("Gattler Frigate", "res://glb/Gattler Frigate.glb", Vector3(0, 90, 0), 1.1),
	"Hoplite Fighter": ShipConfig.new("Hoplite Fighter", "res://glb/Hoplite Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Horseman Gunship": ShipConfig.new("Horseman Gunship", "res://glb/Horseman Gunship.glb", Vector3(0, -90, 0), 1.1),
	"Icepick Fighter": ShipConfig.new("Icepick Fighter", "res://glb/Icepick Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Lineman Hauler": ShipConfig.new("Lineman Hauler", "res://glb/Lineman Hauler.glb", Vector3(0, 90, 0), 2.0),
	"Long Shot Gun Platform": ShipConfig.new("Long Shot Gun Platform", "res://glb/Long Shot Gun Platform.glb", Vector3(0, 90, 0), 1.21),
	"Longhauler Freighter": ShipConfig.new("Longhauler Freighter", "res://glb/Longhauler Freighter.glb", Vector3(0, 90, 0), 1.21),
	"Longshoreman Hauler": ShipConfig.new("Longshoreman Hauler", "res://glb/Longshoreman Hauler.glb", Vector3(0, 90, 0), 1.25),
	"Luna Shuttle": ShipConfig.new("Luna Shuttle", "res://glb/Luna Shuttle.glb", Vector3(0, 90, 0), 0.729),
	"Mosquito Fighter": ShipConfig.new("Mosquito Fighter", "res://glb/Mosquito Fighter.glb", Vector3(0, 90, 0), 0.9),
	"Myrmidon Gunship": ShipConfig.new("Myrmidon Gunship", "res://glb/Myrmidon Gunship.glb", Vector3(0, 180, 0), 0.99),
	"Nebula Battleship": ShipConfig.new("Nebula Battleship", "res://glb/Nebula Battleship.glb", Vector3(0, 90, 0), 1.1),
	"Nordic Liner": ShipConfig.new("Nordic Liner", "res://glb/Nordic Liner.glb", Vector3(0, 90, 0), 2.5),
	"Northerner Gunship": ShipConfig.new("Northerner Gunship", "res://glb/Northerner Gunship.glb", Vector3(0, 90, 0), 0.99),
	"Nova Battleship": ShipConfig.new("Nova Battleship", "res://glb/Nova Battleship.glb", Vector3(0, -90, 0), 1.1),
	"Nubulous Scout": ShipConfig.new("Nubulous Scout", "res://glb/Nubulous Scout.glb", Vector3(0, 90, 0), 0.8),
	"Occulus Gun Platform": ShipConfig.new("Occulus Gun Platform", "res://glb/Occulus Gun Platform.glb", Vector3(0, 90, 0), 1.21),
	"Overlook Gunship": ShipConfig.new("Overlook Gunship", "res://glb/Overlook Gunship.glb", Vector3(0, 90, 0), 0.9),
	"Pacifica Liner": ShipConfig.new("Pacifica Liner", "res://glb/Pacifica Liner.glb", Vector3(0, 90, 0), 1.65),
	"Pacer Gunship": ShipConfig.new("Pacer Gunship", "res://glb/Pacer Gunship.glb", Vector3(0, 90, 0), 1.1),
	"Paladin Gunship": ShipConfig.new("Paladin Gunship", "res://glb/Paladin Gunship.glb", Vector3(0, 90, 0), 1.21),
	"Paragon Shuttle": ShipConfig.new("Paragon Shuttle", "res://glb/Paragon Shuttle.glb", Vector3(0, 90, 0), 0.8),
	"Perimiter Patrol Ship": ShipConfig.new("Perimiter Patrol Ship", "res://glb/Perimiter Patrol Ship.glb", Vector3(0, 90, 0), 1.0),
	"Pikeman Fighter": ShipConfig.new("Pikeman Fighter", "res://glb/Pikeman Fighter.glb", Vector3(0, 90, 0), 0.7128),
	"Pickax Mining Ship": ShipConfig.new("Pickax Mining Ship", "res://glb/Pickax Mining Ship.glb", Vector3(0, 90, 0), 1.0),
	"Prosperity Trader": ShipConfig.new("Prosperity Trader", "res://glb/Prosperity Trader.glb", Vector3(0, 90, 0), 1.0),
	"Quadrant Frigate": ShipConfig.new("Quadrant Frigate", "res://glb/Quadrant Frigate.glb", Vector3(0, 90, 0), 1.1),
	"Rack Fighter": ShipConfig.new("Rack Fighter", "res://glb/Rack Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Railway Hauler": ShipConfig.new("Railway Hauler", "res://glb/Railway Hauler.glb", Vector3(0, 90, 0), 1.5),
	"Raven Scout": ShipConfig.new("Raven Scout", "res://glb/Raven Scout.glb", Vector3(0, 90, 0), 0.8),
	"Resolute Frigate": ShipConfig.new("Resolute Frigate", "res://glb/Resolute Frigate.glb", Vector3(0, 90, 0), 1.375),
	"Rimward Freighter": ShipConfig.new("Rimward Freighter", "res://glb/Rimward Freighter.glb", Vector3(0, 90, 0), 1.0),
	"Robin Gunship": ShipConfig.new("Robin Gunship", "res://glb/Robin Gunship.glb", Vector3(0, 90, 0), 1.1),
	"Royal Standard Battleship": ShipConfig.new("Royal Standard Battleship", "res://glb/Royal Standard Battleship.glb", Vector3(0, 90, 0), 1.1),
	"Sentry Patrol Ship": ShipConfig.new("Sentry Patrol Ship", "res://glb/Sentry Patrol Ship.glb", Vector3(0, 90, 0), 1.0),
	"Secutor Patrol Ship": ShipConfig.new("Secutor Patrol Ship", "res://glb/Secutor Patrol Ship.glb", Vector3(0, 90, 0), 1.1),
	"Shadowblade Fighter": ShipConfig.new("Shadowblade Fighter", "res://glb/Shadowblade Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Shark Gunship": ShipConfig.new("Shark Gunship", "res://glb/Shark Gunship.glb", Vector3(0, 90, 0), 1.1),
	"Solar Empress Liner": ShipConfig.new("Solar Empress Liner", "res://glb/Solar Empress Liner.glb", Vector3(0, -90, 0), 1.2),
	"Sparrow Fighter": ShipConfig.new("Sparrow Fighter", "res://glb/Sparrow Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Spear Frigate": ShipConfig.new("Spear Frigate", "res://glb/Spear Frigate.glb", Vector3(0, 90, 0), 1.65),
	"Spike Patrol Ship": ShipConfig.new("Spike Patrol Ship", "res://glb/Spike Patrol Ship.glb", Vector3(0, -90, 0), 1.1),
	"Stalwart Battleship": ShipConfig.new("Stalwart Battleship", "res://glb/Stalwart Battleship.glb", Vector3(0, 90, 0), 1.1),
	"Star Eagle Fighter": ShipConfig.new("Star Eagle Fighter", "res://glb/Star Eagle Fighter.glb", Vector3(0, 90, 0), 0.45),
	"Star Skipper Trader": ShipConfig.new("Star Skipper Trader", "res://glb/Star Skipper Trader.glb", Vector3(0, -90, 0), 0.99),
	"Starways Hauler": ShipConfig.new("Starways Hauler", "res://glb/Starways Hauler.glb", Vector3(0, 90, 0), 1.5),
	"Steadfast Frigate": ShipConfig.new("Steadfast Frigate", "res://glb/Steadfast Frigate.glb", Vector3(0, 90, 0), 1.1),
	"Stiletto Fighter": ShipConfig.new("Stiletto Fighter", "res://glb/Stiletto Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Stingray Fighter": ShipConfig.new("Stingray Fighter", "res://glb/Stingray Fighter.glb", Vector3(0, 90, 0), 0.72),
	"Strider Scout": ShipConfig.new("Strider Scout", "res://glb/Strider Scout.glb", Vector3(0, 90, 0), 0.9),
	"Sundown Cruiser": ShipConfig.new("Sundown Cruiser", "res://glb/Sundown Cruiser.glb", Vector3(0, 90, 0), 1.1),
	"Swordsman Gunship": ShipConfig.new("Swordsman Gunship", "res://glb/Swordsman Gunship.glb", Vector3(0, 90, 0), 1.1),
	"Toad Assault Ship": ShipConfig.new("Toad Assault Ship", "res://glb/Toad Assault Ship.glb", Vector3(0, -90, 0), 1.125),
	"Tortoise Gunship": ShipConfig.new("Tortoise Gunship", "res://glb/Tortoise Gunship.glb", Vector3(0, 90, 0), 1.1),
	"Tropica Gunship": ShipConfig.new("Tropica Gunship", "res://glb/Tropica Gunship.glb", Vector3(0, 90, 0), 1.1),
	"Vampire Fighter": ShipConfig.new("Vampire Fighter", "res://glb/Vampire Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Vector Battleship": ShipConfig.new("Vector Battleship", "res://glb/Vector Battleship.glb", Vector3(0, 90, 0), 1.65),
	"Viceroy Shuttle": ShipConfig.new("Viceroy Shuttle", "res://glb/Viceroy Shuttle.glb", Vector3(0, 90, 0), 0.8),
	"Viking Frigate": ShipConfig.new("Viking Frigate", "res://glb/Viking Frigate.glb", Vector3(0, -90, 0), 1.875),
	"Void Hauler": ShipConfig.new("Void Hauler", "res://glb/Void Hauler.glb", Vector3(0, -90, 0), 1.5),
	"Vulture Gunship": ShipConfig.new("Vulture Gunship", "res://glb/Vulture Gunship.glb", Vector3(0, 90, 0), 0.5),
	"Wasp Fighter": ShipConfig.new("Wasp Fighter", "res://glb/Wasp Fighter.glb", Vector3(0, 90, 0), 0.6),
	"Zephyr Scout": ShipConfig.new("Zephyr Scout", "res://glb/Zephyr Scout.glb", Vector3(0, 90, 0), 0.8),
	"Equinox Battleship": ShipConfig.new("Equinox Battleship", "res://glb/Equinox Battleship.glb", Vector3(0, 90, 0), 1.375),
	"Fleetfoot Scout": ShipConfig.new("Fleetfoot Scout", "res://glb/Fleetfoot Scout.glb", Vector3(0, 90, 0), 0.88),
	"Hedgehog Battleship": ShipConfig.new("Hedgehog Battleship", "res://glb/Hedgehog Battleship.glb", Vector3(0, 90, 0), 1.782),
	"Infernus Gunship": ShipConfig.new("Infernus Gunship", "res://glb/Infernus Gunship.glb", Vector3(0, 90, 0), 1.1),
	"Naos Shuttle": ShipConfig.new("Naos Shuttle", "res://glb/Naos Shuttle.glb", Vector3(0, 180, 0), 0.8),
	"Sea Turtle Shuttle": ShipConfig.new("Sea Turtle Shuttle", "res://glb/Sea Turtle Shuttle.glb", Vector3(0, -90, 0), 0.8),
	"Shield Battleship": ShipConfig.new("Shield Battleship", "res://glb/Shield Battleship.glb", Vector3(0, 90, 0), 2.475),
	"Snowbird Gunship": ShipConfig.new("Snowbird Gunship", "res://glb/Snowbird Gunship.glb", Vector3(0, 90, 0), 1.1),
	"Spartan Gunship": ShipConfig.new("Spartan Gunship", "res://glb/Spartan Gunship.glb", Vector3(0, -90, 0), 1.1),
	"Stinger Fighter": ShipConfig.new("Stinger Fighter", "res://glb/Stinger Fighter.glb", Vector3(0, 90, 0), 0.72),
	"Sunbird Fighter": ShipConfig.new("Sunbird Fighter", "res://glb/Sunbird Fighter.glb", Vector3(0, 0, 0), 0.4),
	"Unyielding Battleship": ShipConfig.new("Unyielding Battleship", "res://glb/Unyielding Battleship.glb", Vector3(0, -90, 0), 1.1),
	"Valiant Gunship": ShipConfig.new("Valiant Gunship", "res://glb/Valiant Gunship.glb", Vector3(0, 90, 0), 0.99),
	"Vampie Fighter": ShipConfig.new("Vampie Fighter", "res://glb/Vampie Fighter.glb", Vector3(0, 90, 0), 0.8)
}

# List of all ship model paths (for random selection) - maintained for backward compatibility
var all_ship_paths: Array[String] = []

# Complete ship list (for validation) - maintained for backward compatibility
var ship_list: Array[String] = []

func _ready():
	_initialize_ship_data()

func _initialize_ship_data():
	## Initialize ship data by populating helper arrays for backward compatibility
	## All actual ship configurations are now in the ship_configs dictionary above
	
	# Populate ship lists from GLB files for backward compatibility
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
	var config = get_ship_config(ship_name)
	if config:
		return config.rotation_correction
	else:
		return Vector3(0, 0, 0)

func get_random_ship_path() -> String:
	## Get a random ship model path
	if all_ship_paths.size() > 0:
		return all_ship_paths[randi() % all_ship_paths.size()]
	else:
		push_error("No ship paths available")
		return ""
