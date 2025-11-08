extends Node

## Centralized ship configuration data
## This autoload provides ship-specific data like rotation corrections and scale multipliers

# Configuration: Sort ships by modification time (newest first) or alphabetical
# Set to false for alphabetical order, true for modification time order
var sort_by_mod_time: bool = true

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
	"Dwarf Interceptor": ShipConfig.new("Dwarf Interceptor", "res://glb/Dwarf Interceptor.glb", Vector3(0, 90, 0), 0.66),
	"Fireball Interceptor": ShipConfig.new("Fireball Interceptor", "res://glb/Fireball Interceptor.glb", Vector3(0, 90, 0), 0.70),
	"Forefront Interceptor": ShipConfig.new("Forefront Interceptor", "res://glb/Forefront Interceptor.glb", Vector3(0, 90, 0), 0.81),
	"Fury Interceptor": ShipConfig.new("Fury Interceptor", "res://glb/Fury Interceptor.glb", Vector3(0, 90, 0), 0.748),
	"Stinger Interceptor": ShipConfig.new("Stinger Interceptor", "res://glb/Stinger Interceptor.glb", Vector3(0, 90, 0), 0.72),
	"Vampire Interceptor": ShipConfig.new("Vampire Interceptor", "res://glb/Vampire Interceptor.glb", Vector3(0, 90, 0), 0.88),
	"Alpine Cruiser": ShipConfig.new("Alpine Cruiser", "res://glb/Alpine Cruiser.glb", Vector3(0, 0, 0), 2.484),
	"Arsenal Gunship": ShipConfig.new("Arsenal Gunship", "res://glb/Arsenal Gunship.glb", Vector3(0, 90, 0), 1.2),
	"Audacious Patrol Ship": ShipConfig.new("Audacious Patrol Ship", "res://glb/Audacious Patrol Ship.glb", Vector3(0, 90, 0), 1.2),
	"Banshee Gunship": ShipConfig.new("Banshee Gunship", "res://glb/Banshee Gunship.glb", Vector3(0, 90, 0), 0.974),
	"Barrier Frigate": ShipConfig.new("Barrier Frigate", "res://glb/Barrier Frigate.glb", Vector3(0, 90, 0), 1.865),
	"Barricade Frigate": ShipConfig.new("Barricade Frigate", "res://glb/Barricade Frigate.glb", Vector3(0, 90, 0), 1.906),
	"Batwing Gunship": ShipConfig.new("Batwing Gunship", "res://glb/Batwing Gunship.glb", Vector3(0, 90, 0), 1.04),
	"Bearclaw Frigate": ShipConfig.new("Bearclaw Frigate", "res://glb/Bearclaw Frigate.glb", Vector3(0, 90, 0), 1.621),
	"Belt Freighter": ShipConfig.new("Belt Freighter", "res://glb/Belt Freighter.glb", Vector3(0, 180, 0), 2.30),
	"Blood Eagle Fighter": ShipConfig.new("Blood Eagle Fighter", "res://glb/Blood Eagle Fighter.glb", Vector3(0, 90, 0), 0.45),
	"Brawler Gunship": ShipConfig.new("Brawler Gunship", "res://glb/Brawler Gunship.glb", Vector3(0, 90, 0), 1.095),
	"Brachiator Gun Platform": ShipConfig.new("Brachiator Gun Platform", "res://glb/Brachiator Gun Platform.glb", Vector3(0, 90, 0), 1.19),
	"Breacher Assault Ship": ShipConfig.new("Breacher Assault Ship", "res://glb/Breacher Assault Ship.glb", Vector3(0, 90, 0), 1.652),
	"Bulwark Battleship": ShipConfig.new("Bulwark Battleship", "res://glb/Bulwark Battleship.glb", Vector3(0, 90, 0), 2.828),
	"Carp Trader": ShipConfig.new("Carp Trader", "res://glb/Carp Trader.glb", Vector3(0, 90, 0), 1.41),
	"Cyclops Missile Boat": ShipConfig.new("Cyclops Missile Boat", "res://glb/Cyclops Missile Boat.glb", Vector3(0, 90, 0), 1.36),
	"Dagger Fighter": ShipConfig.new("Dagger Fighter", "res://glb/Dagger Fighter.glb", Vector3(0, 90, 0), 0.77),
	"Darkling Fighter": ShipConfig.new("Darkling Fighter", "res://glb/Darkling Fighter.glb", Vector3(0, 270, 0), 0.906),
	"Dart Scout": ShipConfig.new("Dart Scout", "res://glb/Dart Scout.glb", Vector3(0, 90, 0), 0.75),
	"Dispatch Shuttle": ShipConfig.new("Dispatch Shuttle", "res://glb/Dispatch Shuttle.glb", Vector3(0, 90, 0), 0.81),
	"Dolphin Trader": ShipConfig.new("Dolphin Trader", "res://glb/Dolphin Trader.glb", Vector3(0, 90, 0), 1.2),
	"Drushi Battleship": ShipConfig.new("Drushi Battleship", "res://glb/Drushi Battleship.glb", Vector3(0, 90, 0), 2.08625),
	"Eclipse Battleship": ShipConfig.new("Eclipse Battleship", "res://glb/Eclipse Battleship.glb", Vector3(0, 90, 0), 2.65),
	"Empress Liner": ShipConfig.new("Empress Liner", "res://glb/Empress Liner.glb", Vector3(0, 90, 0), 1.85),
	"Evil Eye Gun Platform": ShipConfig.new("Evil Eye Gun Platform", "res://glb/Evil Eye Gun Platform.glb", Vector3(0, 0, 0), 1.1),
	"Executive Liner": ShipConfig.new("Executive Liner", "res://glb/Executive Liner.glb", Vector3(0, 90, 0), 1.70),
	"Express Trader": ShipConfig.new("Express Trader", "res://glb/Express Trader.glb", Vector3(0, 90, 0), 1.3),
	"Falcon Scout": ShipConfig.new("Falcon Scout", "res://glb/Falcon Scout.glb", Vector3(0, 90, 0), 0.72),
	"Fortress Cruiser": ShipConfig.new("Fortress Cruiser", "res://glb/Fortress Cruiser.glb", Vector3(0, 90, 0), 2.0415),
	"Front Line Cruiser": ShipConfig.new("Front Line Cruiser", "res://glb/Front Line Cruiser.glb", Vector3(0, -90, 0), 2.384),
	"Frostbite Gunship": ShipConfig.new("Frostbite Gunship", "res://glb/Frostbite Gunship.glb", Vector3(0, 90, 0), 1.04),
	"Gattler Frigate": ShipConfig.new("Gattler Frigate", "res://glb/Gattler Frigate.glb", Vector3(0, 90, 0), 1.668),
	"Grasshopper Cruiser": ShipConfig.new("Grasshopper Cruiser", "res://glb/Grasshopper Cruiser.glb", Vector3(0, 90, 0), 2.55),
	"Hoplite Fighter": ShipConfig.new("Hoplite Fighter", "res://glb/Hoplite Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Horseman Gunship": ShipConfig.new("Horseman Gunship", "res://glb/Horseman Gunship.glb", Vector3(0, -90, 0), 1.15),
	"Icepick Fighter": ShipConfig.new("Icepick Fighter", "res://glb/Icepick Fighter.glb", Vector3(0, 90, 0), 0.85),
	"Lineman Hauler": ShipConfig.new("Lineman Hauler", "res://glb/Lineman Hauler.glb", Vector3(0, 90, 0), 2.5),
	"Long Shot Gun Platform": ShipConfig.new("Long Shot Gun Platform", "res://glb/Long Shot Gun Platform.glb", Vector3(0, 90, 0), 1.189),
	"Longhauler Freighter": ShipConfig.new("Longhauler Freighter", "res://glb/Longhauler Freighter.glb", Vector3(0, 90, 0), 2.264),
	"Longshoreman Hauler": ShipConfig.new("Longshoreman Hauler", "res://glb/Longshoreman Hauler.glb", Vector3(0, 90, 0), 2.91),
	"Luna Shuttle": ShipConfig.new("Luna Shuttle", "res://glb/Luna Shuttle.glb", Vector3(0, 90, 0), 0.765),
	"Marathon Fighter": ShipConfig.new("Marathon Fighter", "res://glb/Marathon Fighter.glb", Vector3(0, 90, 0), 0.71),
	"Mosquito Fighter": ShipConfig.new("Mosquito Fighter", "res://glb/Mosquito Fighter.glb", Vector3(0, 90, 0), 0.91),
	"Moth Scout": ShipConfig.new("Moth Scout", "res://glb/Moth Scout.glb", Vector3(0, 90, 0), 0.70),
	"Myrmidon Gunship": ShipConfig.new("Myrmidon Gunship", "res://glb/Myrmidon Gunship.glb", Vector3(0, 180, 0), 1.04),
	"Nebula Battleship": ShipConfig.new("Nebula Battleship", "res://glb/Nebula Battleship.glb", Vector3(0, 90, 0), 2.85),
	"Nexion Cruiser": ShipConfig.new("Nexion Cruiser", "res://glb/Nexion Cruiser.glb", Vector3(0, 270, 0), 2.081),
	"Nightgaunt Gunship": ShipConfig.new("Nightgaunt Gunship", "res://glb/Nightgaunt Gunship.glb", Vector3(0, 90, 0), 1.15),
	"Nordic Liner": ShipConfig.new("Nordic Liner", "res://glb/Nordic Liner.glb", Vector3(0, 90, 0), 1.90),
	"Northerner Gunship": ShipConfig.new("Northerner Gunship", "res://glb/Northerner Gunship.glb", Vector3(0, 90, 0), 1.04),
	"Nova Battleship": ShipConfig.new("Nova Battleship", "res://glb/Nova Battleship.glb", Vector3(0, -90, 0), 1.45),
	"Nubulous Scout": ShipConfig.new("Nubulous Scout", "res://glb/Nubulous Scout.glb", Vector3(0, 90, 0), 0.72),
	"Occulus Gun Platform": ShipConfig.new("Occulus Gun Platform", "res://glb/Occulus Gun Platform.glb", Vector3(0, 90, 0), 1.31),
	"Orca Freighter": ShipConfig.new("Orca Freighter", "res://glb/Orca Freighter.glb", Vector3(0, 90, 0), 2.15),
	"Overlook Gunship": ShipConfig.new("Overlook Gunship", "res://glb/Overlook Gunship.glb", Vector3(0, 90, 0), 0.95),
	"Pacifica Liner": ShipConfig.new("Pacifica Liner", "res://glb/Pacifica Liner.glb", Vector3(0, 90, 0), 1.965),
	"Pacer Gunship": ShipConfig.new("Pacer Gunship", "res://glb/Pacer Gunship.glb", Vector3(0, 90, 0), 1.139),
	"Paladin Gunship": ShipConfig.new("Paladin Gunship", "res://glb/Paladin Gunship.glb", Vector3(0, 90, 0), 1.030),
	"Paragon Shuttle": ShipConfig.new("Paragon Shuttle", "res://glb/Paragon Shuttle.glb", Vector3(0, 90, 0), 0.684),
	"Perimiter Patrol Ship": ShipConfig.new("Perimiter Patrol Ship", "res://glb/Perimiter Patrol Ship.glb", Vector3(0, 90, 0), 1.2),
	"Pikeman Fighter": ShipConfig.new("Pikeman Fighter", "res://glb/Pikeman Fighter.glb", Vector3(0, 90, 0), 0.913),
	"Pickax Mining Ship": ShipConfig.new("Pickax Mining Ship", "res://glb/Pickax Mining Ship.glb", Vector3(0, 90, 0), 1.20),
	"Pugilist Patrol Ship": ShipConfig.new("Pugilist Patrol Ship", "res://glb/Pugilist Patrol Ship.glb", Vector3(0, 90, 0), 0.99),
	"Prosperity Trader": ShipConfig.new("Prosperity Trader", "res://glb/Prosperity Trader.glb", Vector3(0, 90, 0), 1.2),
	"Quadrant Cruiser": ShipConfig.new("Quadrant Cruiser", "res://glb/Quadrant Cruiser.glb", Vector3(0, 90, 0), 2.281),
	"Railway Hauler": ShipConfig.new("Railway Hauler", "res://glb/Railway Hauler.glb", Vector3(0, 90, 0), 3.35),
	"Raven Scout": ShipConfig.new("Raven Scout", "res://glb/Raven Scout.glb", Vector3(0, 90, 0), 0.85),
	"Resolute Frigate": ShipConfig.new("Resolute Frigate", "res://glb/Resolute Frigate.glb", Vector3(0, 90, 0), 1.563),
	"Rimward Freighter": ShipConfig.new("Rimward Freighter", "res://glb/Rimward Freighter.glb", Vector3(0, 90, 0), 1.375),
	"Robin Gunship": ShipConfig.new("Robin Gunship", "res://glb/Robin Gunship.glb", Vector3(0, 90, 0), 1.15),
	"Royal Standard Battleship": ShipConfig.new("Royal Standard Battleship", "res://glb/Royal Standard Battleship.glb", Vector3(0, 90, 0), 2.87),
	"Sai Fighter": ShipConfig.new("Sai Fighter", "res://glb/Sai Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Chrysalis Construction Ship": ShipConfig.new("Chrysalis Construction Ship", "res://glb/Chrysalis Construction Ship.glb", Vector3(0, 90, 0), 1.60),
	"Scarab Construction Ship": ShipConfig.new("Scarab Construction Ship", "res://glb/Scarab Construction Ship.glb", Vector3(0, 90, 0), 1.60),
	"Sentry Patrol Ship": ShipConfig.new("Sentry Patrol Ship", "res://glb/Sentry Patrol Ship.glb", Vector3(0, 90, 0), 1.2),
	"Secutor Patrol Ship": ShipConfig.new("Secutor Patrol Ship", "res://glb/Secutor Patrol Ship.glb", Vector3(0, 90, 0), 1.431),
	"Shadowblade Fighter": ShipConfig.new("Shadowblade Fighter", "res://glb/Shadowblade Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Shark Gunship": ShipConfig.new("Shark Gunship", "res://glb/Shark Gunship.glb", Vector3(0, 90, 0), 0.991),
	"Sokoly Fighter": ShipConfig.new("Sokoly Fighter", "res://glb/Sokoly Fighter.glb", Vector3(0, 90, 0), 0.95),
	"Solar Empress Liner": ShipConfig.new("Solar Empress Liner", "res://glb/Solar Empress Liner.glb", Vector3(0, 90, 0), 2.4),
	"Sparrow Fighter": ShipConfig.new("Sparrow Fighter", "res://glb/Sparrow Fighter.glb", Vector3(0, 90, 0), 0.8),
	"Spear Frigate": ShipConfig.new("Spear Frigate", "res://glb/Spear Frigate.glb", Vector3(0, 90, 0), 1.915),
	"Spike Patrol Ship": ShipConfig.new("Spike Patrol Ship", "res://glb/Spike Patrol Ship.glb", Vector3(0, -90, 0), 1.216),
	"Stalwart Battleship": ShipConfig.new("Stalwart Battleship", "res://glb/Stalwart Battleship.glb", Vector3(0, 90, 0), 2.9),
	"Star Eagle Fighter": ShipConfig.new("Star Eagle Fighter", "res://glb/Star Eagle Fighter.glb", Vector3(0, 90, 0), 0.45),
	"Star Skipper Trader": ShipConfig.new("Star Skipper Trader", "res://glb/Star Skipper Trader.glb", Vector3(0, -90, 0), 1.289),
	"Starways Hauler": ShipConfig.new("Starways Hauler", "res://glb/Starways Hauler.glb", Vector3(0, 90, 0), 2.575),
	"Steadfast Frigate": ShipConfig.new("Steadfast Frigate", "res://glb/Steadfast Frigate.glb", Vector3(0, 90, 0), 1.575),
	"Stiletto Fighter": ShipConfig.new("Stiletto Fighter", "res://glb/Stiletto Fighter.glb", Vector3(0, 90, 0), 0.77),
	"Stingray Fighter": ShipConfig.new("Stingray Fighter", "res://glb/Stingray Fighter.glb", Vector3(0, 90, 0), 0.77),
	"Strider Scout": ShipConfig.new("Strider Scout", "res://glb/Strider Scout.glb", Vector3(0, 90, 0), 0.812),
	"Sunfall Cruiser": ShipConfig.new("Sunfall Cruiser", "res://glb/Sunfall Cruiser.glb", Vector3(0, 90, 0), 2.40),
	"Sundiver Frigate": ShipConfig.new("Sundiver Frigate", "res://glb/Sundiver Frigate.glb", Vector3(0, 90, 0), 1.54),
	"Swordsman Gunship": ShipConfig.new("Swordsman Gunship", "res://glb/Swordsman Gunship.glb", Vector3(0, 90, 0), 1.15),
	"Toad Assault Ship": ShipConfig.new("Toad Assault Ship", "res://glb/Toad Assault Ship.glb", Vector3(0, -90, 0), 1.473),
	"Tortoise Gunship": ShipConfig.new("Tortoise Gunship", "res://glb/Tortoise Gunship.glb", Vector3(0, 90, 0), 1.15),
	"Tropica Gunship": ShipConfig.new("Tropica Gunship", "res://glb/Tropica Gunship.glb", Vector3(0, 90, 0), 1.090),
	"Twinstrike Gunship": ShipConfig.new("Twinstrike Gunship", "res://glb/Twinstrike Gunship.glb", Vector3(0, 90, 0), 1.15),
	"Termite Gunship": ShipConfig.new("Termite Gunship", "res://glb/Termite Gunship.glb", Vector3(0, 90, 0), 1.168),
	"Trident Gunship": ShipConfig.new("Trident Gunship", "res://glb/Trident Gunship.glb", Vector3(0, 90, 0), 1.168),
	"Vector Battleship": ShipConfig.new("Vector Battleship", "res://glb/Vector Battleship.glb", Vector3(0, 90, 0), 1.85),
	"Viceroy Shuttle": ShipConfig.new("Viceroy Shuttle", "res://glb/Viceroy Shuttle.glb", Vector3(0, 90, 0), 0.84),
	"Viking Frigate": ShipConfig.new("Viking Frigate", "res://glb/Viking Frigate.glb", Vector3(0, -90, 0), 1.70),
	"Voidreach Hauler": ShipConfig.new("Voidreach Hauler", "res://glb/Voidreach Hauler.glb", Vector3(0, 0, 0), 3.3),
	
	# Space Stations (thrust rating: 0) - EXTRA WIDE spacing for very large models
	"Type 1 Station": ShipConfig.new("Type 1 Station", "res://glb/Type 1 Station.glb", Vector3(0, 0, 0), 5.7),
	"Type 2 Station": ShipConfig.new("Type 2 Station", "res://glb/Type 2 Station.glb", Vector3(0, 0, 0), 5.6),
	"Type 3 Station": ShipConfig.new("Type 3 Station", "res://glb/Type 3 Station.glb", Vector3(0, 0, 0), 5.7),
	"Type 4 Station": ShipConfig.new("Type 4 Station", "res://glb/Type 4 Station.glb", Vector3(90, 0, 0), 5.5),
	"Type 5 Station": ShipConfig.new("Type 5 Station", "res://glb/Type 5 Station.glb", Vector3(0, 0, 0), 5.6),
	"Type 6 Station": ShipConfig.new("Type 6 Station", "res://glb/Type 6 Station.glb", Vector3(0, 0, 0), 5.7),
	"Type 7 Station": ShipConfig.new("Type 7 Station", "res://glb/Type 7 Station.glb", Vector3(90, 90, 0), 5.5),
	"Type 8 Station": ShipConfig.new("Type 8 Station", "res://glb/Type 8 Station.glb", Vector3(0, 0, 0), 5.5),
	"Type 9 Station": ShipConfig.new("Type 9 Station", "res://glb/Type 9 Station.glb", Vector3(0, 0, 0), 5.6),
	"Type 10 Station": ShipConfig.new("Type 10 Station", "res://glb/Type 10 Station.glb", Vector3(0, 0, 0), 5.7),
	"Type 11 Station": ShipConfig.new("Type 11 Station", "res://glb/Type 11 Station.glb", Vector3(0, 0, 0), 5.7),
	"Type 12 Station": ShipConfig.new("Type 12 Station", "res://glb/Type 12 Station.glb", Vector3(0, 0, 0), 5.5),
	"Type 14 Station": ShipConfig.new("Type 14 Station", "res://glb/Type 14 Station.glb", Vector3(0, 0, 0), 5.5),
	"Type 15 Station": ShipConfig.new("Type 15 Station", "res://glb/Type 15 Station.glb", Vector3(0, 0, 0), 5.5),
	"Type 16 Station": ShipConfig.new("Type 16 Station", "res://glb/Type 16 Station.glb", Vector3(0, 0, 0), 5.5),
	"Type 17 Station": ShipConfig.new("Type 17 Station", "res://glb/Type 17 Station.glb", Vector3(0, 0, 0), 5.5),
	"Type 18 Station": ShipConfig.new("Type 18 Station", "res://glb/Type 18 Station.glb", Vector3(0, 0, 0), 5.5),
	"Type 19 Station": ShipConfig.new("Type 19 Station", "res://glb/Type 19 Station.glb", Vector3(0, 0, 0), 5.5),
	"Type 20 Station": ShipConfig.new("Type 20 Station", "res://glb/Type 20 Station.glb", Vector3(0, 0, 0), 5.5),
	"Type 21 Station": ShipConfig.new("Type 21 Station", "res://glb/Type 21 Station.glb", Vector3(0, 0, 90), 5.5),
	"Type 22 Station": ShipConfig.new("Type 22 Station", "res://glb/Type 22 Station.glb", Vector3(0, 0, 0), 5.5),
	"Type 23 Station": ShipConfig.new("Type 23 Station", "res://glb/Type 23 Station.glb", Vector3(0, 0, 90), 5.5),
	"Type 24 Station": ShipConfig.new("Type 24 Station", "res://glb/Type 24 Station.glb", Vector3(0, 0, 0), 5.5),
	"Type 25 Station": ShipConfig.new("Type 25 Station", "res://glb/Type 25 Station.glb", Vector3(0, 0, 0), 5.5),
	
	"Vulture Gunship": ShipConfig.new("Vulture Gunship", "res://glb/Vulture Gunship.glb", Vector3(0, 90, 0), 0.6),
	"Wasp Fighter": ShipConfig.new("Wasp Fighter", "res://glb/Wasp Fighter.glb", Vector3(0, 90, 0), 0.7),
	"Watchman Gunship": ShipConfig.new("Watchman Gunship", "res://glb/Watchman Gunship.glb", Vector3(0, 90, 0), 1.103),
	"Zephyr Scout": ShipConfig.new("Zephyr Scout", "res://glb/Zephyr Scout.glb", Vector3(0, 90, 0), 0.8),
	"Equinox Battleship": ShipConfig.new("Equinox Battleship", "res://glb/Equinox Battleship.glb", Vector3(0, 90, 0), 1.725),
	"Fleetfoot Scout": ShipConfig.new("Fleetfoot Scout", "res://glb/Fleetfoot Scout.glb", Vector3(0, 90, 0), 0.792),
	"Hedgehog Battleship": ShipConfig.new("Hedgehog Battleship", "res://glb/Hedgehog Battleship.glb", Vector3(0, 90, 0), 2.852),
	"Infernus Gunship": ShipConfig.new("Infernus Gunship", "res://glb/Infernus Gunship.glb", Vector3(0, 90, 0), 1.095),
	"Naos Shuttle": ShipConfig.new("Naos Shuttle", "res://glb/Naos Shuttle.glb", Vector3(0, 180, 0), 0.8),
	"Sea Turtle Shuttle": ShipConfig.new("Sea Turtle Shuttle", "res://glb/Sea Turtle Shuttle.glb", Vector3(0, -90, 0), 0.734),
	"Shield Battleship": ShipConfig.new("Shield Battleship", "res://glb/Shield Battleship.glb", Vector3(0, 90, 0), 2.875),
	"Snowbird Gunship": ShipConfig.new("Snowbird Gunship", "res://glb/Snowbird Gunship.glb", Vector3(0, 90, 0), 1.1),
	"Spartan Gunship": ShipConfig.new("Spartan Gunship", "res://glb/Spartan Gunship.glb", Vector3(0, 90, 0), 1.15),
	"Sunbird Fighter": ShipConfig.new("Sunbird Fighter", "res://glb/Sunbird Fighter.glb", Vector3(0, 0, 0), 0.36),
	"Unyielding Battleship": ShipConfig.new("Unyielding Battleship", "res://glb/Unyielding Battleship.glb", Vector3(0, 0, 0), 2.7),
	"Valiant Gunship": ShipConfig.new("Valiant Gunship", "res://glb/Valiant Gunship.glb", Vector3(0, 90, 0), 1.194),
	# New ships added from new-glbs folder
	"Albino Gunship": ShipConfig.new("Albino Gunship", "res://glb/Albino Gunship.glb", Vector3(0, 90, 0), 1.068),
	"Beluga Freighter": ShipConfig.new("Beluga Freighter", "res://glb/Beluga Freighter.glb", Vector3(0, 90, 0), 1.847),
	"Butterfly Shuttle": ShipConfig.new("Butterfly Shuttle", "res://glb/Butterfly Shuttle.glb", Vector3(0, 90, 0), 0.628),
	"Choronzom Frigate": ShipConfig.new("Choronzom Frigate", "res://glb/Choronzom Frigate.glb", Vector3(0, 90, 0), 1.639),
	"Diabolus Gunship": ShipConfig.new("Diabolus Gunship", "res://glb/Diabolus Gunship.glb", Vector3(0, 90, 0), 1.118),
	"Drake Fighter": ShipConfig.new("Drake Fighter", "res://glb/Drake Fighter.glb", Vector3(0, 270, 0), 0.919),
	"Firefly Fighter": ShipConfig.new("Firefly Fighter", "res://glb/Firefly Fighter.glb", Vector3(0, 90, 0), 1.019),
	"Gladius Gunship": ShipConfig.new("Gladius Gunship", "res://glb/Gladius Gunship.glb", Vector3(0, 90, 0), 1.068),
	"Guardsman Patrol Ship": ShipConfig.new("Guardsman Patrol Ship", "res://glb/Guardsman Patrol Ship.glb", Vector3(0, 90, 0), 1.223),
	"Jetsam Trader": ShipConfig.new("Jetsam Trader", "res://glb/Jetsam Trader.glb", Vector3(0, 90, 0), 1.230),
	"Locust Gunship": ShipConfig.new("Locust Gunship", "res://glb/Locust Gunship.glb", Vector3(0, 270, 0), 1.168),
	"Merkara Trader": ShipConfig.new("Merkara Trader", "res://glb/Merkara Trader.glb", Vector3(0, 90, 0), 1.280),
	"Migo Frigate": ShipConfig.new("Migo Frigate", "res://glb/Migo Frigate.glb", Vector3(0, 90, 0), 1.789),
	"Noseeum Gunship": ShipConfig.new("Noseeum Gunship", "res://glb/Noseeum Gunship.glb", Vector3(0, 90, 0), 1.218),
	"Packet Trader": ShipConfig.new("Packet Trader", "res://glb/Packet Trader.glb", Vector3(0, 90, 0), 1.330),
	"Panoptic Gun Platform": ShipConfig.new("Panoptic Gun Platform", "res://glb/Panoptic Gun Platform.glb", Vector3(0, 0, 0), 1.178),
	"Princess Shuttle": ShipConfig.new("Princess Shuttle", "res://glb/Princess Shuttle.glb", Vector3(0, 90, 0), 0.778),
	"Samurai Gunship": ShipConfig.new("Samurai Gunship", "res://glb/Samurai Gunship.glb", Vector3(0, 90, 0), 1.068),
	"Silverfish Fighter": ShipConfig.new("Silverfish Fighter", "res://glb/Silverfish Fighter.glb", Vector3(0, 270, 0), 1.069),
	"Smiler Frigate": ShipConfig.new("Smiler Frigate", "res://glb/Smiler Frigate.glb", Vector3(0, 90, 0), 1.539),
	"Victorious Frigate": ShipConfig.new("Victorious Frigate", "res://glb/Victorious Frigate.glb", Vector3(0, 90, 0), 1.639),
	
	# New ships added from new-glbs folder (batch 2)
	"Arctic Trader": ShipConfig.new("Arctic Trader", "res://glb/Arctic Trader.glb", Vector3(0, 90, 0), 1.28),
	"Compass Freighter": ShipConfig.new("Compass Freighter", "res://glb/Compass Freighter.glb", Vector3(0, 135, 0), 2.15),
	"First Class Trader": ShipConfig.new("First Class Trader", "res://glb/First Class Trader.glb", Vector3(0, 90, 0), 1.23),
	"Frostfall Trader": ShipConfig.new("Frostfall Trader", "res://glb/Frostfall Trader.glb", Vector3(0, 90, 0), 1.28),
	"Priority Trader": ShipConfig.new("Priority Trader", "res://glb/Priority Trader.glb", Vector3(0, 90, 0), 1.23),
	"Silk Road Trader": ShipConfig.new("Silk Road Trader", "res://glb/Silk Road Trader.glb", Vector3(0, 270, 0), 1.28),
	"Snowdrift Freighter": ShipConfig.new("Snowdrift Freighter", "res://glb/Snowdrift Freighter.glb", Vector3(0, 90, 0), 1.65),
	"Snowman Trader": ShipConfig.new("Snowman Trader", "res://glb/Snowman Trader.glb", Vector3(0, 90, 0), 1.28),
	"Xfer Trader": ShipConfig.new("Xfer Trader", "res://glb/Xfer Trader.glb", Vector3(0, 90, 0), 1.28)
}

# List of all ship model paths (for random selection) - maintained for backward compatibility
var all_ship_paths: Array[String] = []

# Complete ship list (for validation) - maintained for backward compatibility
var ship_list: Array[String] = []

func _ready():
	_initialize_ship_data()
	_validate_ship_models()

func _initialize_ship_data():
	## Initialize ship data by populating helper arrays for backward compatibility
	## Ships are sorted by file modification time (newest first)
	## This helps identify recently added/modified ships in verification mode
	## Newest ships will appear on the left side of each class row
	
	# Collect ship files with their modification times
	var ship_files_with_time = []
	var dir = DirAccess.open("res://glb/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".glb") and not file_name.begins_with("Missile") and not file_name.begins_with("Asteroid"):
				var file_path = "res://glb/" + file_name
				var mod_time = FileAccess.get_modified_time(file_path)
				ship_files_with_time.append({
					"name": file_name.replace(".glb", ""),
					"path": file_path,
					"mod_time": mod_time
				})
			file_name = dir.get_next()
	else:
		push_error("ShipData: Failed to open res://glb/ directory")
	
	# Sort ships based on configuration
	if sort_by_mod_time:
		# Sort by modification time (newest first - use > for descending)
		# This ensures recently modified ships (like renamed ones) appear on the left side
		ship_files_with_time.sort_custom(func(a, b): return a.mod_time > b.mod_time)
	else:
		# Sort alphabetically by ship name (original behavior)
		ship_files_with_time.sort_custom(func(a, b): return a.name < b.name)
	
	# Populate ship lists in sorted order
	for ship_data in ship_files_with_time:
		ship_list.append(ship_data.name)
		all_ship_paths.append(ship_data.path)

func _validate_ship_models():
	## Validate ship models to detect duplicates or corruption
	## This helps identify data issues like duplicate GLB files
	var file_hashes = {}
	var duplicate_found = false
	
	for ship_name in ship_list:
		var config = get_ship_config(ship_name)
		if not config:
			continue
			
		var file_path = config.model_path.replace("res://", "")
		var file = FileAccess.open(config.model_path, FileAccess.READ)
		if file:
			var file_hash = FileAccess.get_md5(file_path)
			file.close()
			
			if file_hashes.has(file_hash):
				push_warning("ShipData: Duplicate model detected! '" + ship_name + "' and '" + file_hashes[file_hash] + "' use identical GLB files. This may cause visual confusion.")
				duplicate_found = true
			else:
				file_hashes[file_hash] = ship_name
	
	if duplicate_found:
		push_warning("ShipData: Model validation found duplicate GLB files. Please check your asset files.")

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
