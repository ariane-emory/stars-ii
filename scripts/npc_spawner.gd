extends Node3D

## Spawns NPC ships at game start

@export var npc_count: int = 8
@export var spawn_radius: float = 1000.0

var npc_ship_scene = preload("res://scenes/npc_ship.tscn")

# List of all available ship models (60 total)
var ship_models = [
    "res://glb/Alpine Cruiser.glb",
    "res://glb/Belt Freighter.glb",
    "res://glb/Blood Eagle Fighter.glb",
    "res://glb/Breacher Assault Ship.glb",
    "res://glb/Bulwark Battleship.glb",
    "res://glb/Cyclops Missile Boat.glb",
    "res://glb/Dagger Fighter.glb",
    "res://glb/Dart Scout.glb",
    "res://glb/Drushi Battleship.glb",
    "res://glb/Eclipse Battlleship.glb",
    "res://glb/Empress Liner.glb",
    "res://glb/Equinox Battleship.glb",
    "res://glb/Express Trader.glb",
    "res://glb/Falcon Scout.glb",
    "res://glb/Fleetfoot Scout.glb",
    "res://glb/Fortress Cruiser.glb",
    "res://glb/Fury Fighter.glb",
    "res://glb/Hoplit eFighter.glb",
    "res://glb/Horseman Gunship.glb",
    "res://glb/Infernus Gunship.glb",
    "res://glb/Lineman Hauler.glb",
    "res://glb/Longhauler Freighter.glb",
    "res://glb/Luna Shuttle.glb",
    "res://glb/Nebula Battleship.glb",
    "res://glb/Nova Battleship.glb",
    "res://glb/Nubulous Scout.glb",
    "res://glb/Occulus Gun Platform.glb",
    "res://glb/Pacer Gunship.glb",
    "res://glb/Pacifica Liner.glb",
    "res://glb/Paladin Gunship.glb",
    "res://glb/Pickax Mining Ship.glb",
    "res://glb/Prosperity Trader.glb",
    "res://glb/Rack Fighter.glb",
    "res://glb/Railway Hauler.glb",
    "res://glb/Resolute Frigate.glb",
    "res://glb/Rimward Freighter.glb",
    "res://glb/Royal Standard Battleship.glb",
    "res://glb/Sentry Patrol Ship.glb",
    "res://glb/Shadoblade Fighter.glb",
    "res://glb/Shark Gunship.glb",
    "res://glb/Shield Battleship.glb",
    "res://glb/Snowbird Gunship.glb",
    "res://glb/Solar Empress Liner.glb",
    "res://glb/Spear Frigate.glb",
    "res://glb/Stalward Battleship.glb",
    "res://glb/Star Eagle Fighter.glb",
    "res://glb/Star Skipper Trader.glb",
    "res://glb/Starways Hauler.glb",
    "res://glb/Stingr.glb",
    "res://glb/Strider Scout.glb",
    "res://glb/Sunbird Fighter.glb",
    "res://glb/Swordsman Gunship.glb",
    "res://glb/Tortois Gunship.glb",
    "res://glb/Unyielding Battleship.glb",
    "res://glb/Vector Battleship.glb",
    "res://glb/Void Hauler.glb",
    "res://glb/Vulture Gunship.glb",
    "res://glb/Was Fighter.glb",
    "res://glb/Wasp Fighter.glb",
    "res://glb/Zephyr Scout.glb"
]

func _ready():
    spawn_npcs()

func spawn_npcs():
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
        
        # Randomize ship model - select random GLB from all available models
        var random_model_path = ship_models[randi() % ship_models.size()]
        var model_scene = load(random_model_path)
        
        # Extract ship name from path (e.g., "res://glb/Falcon Scout.glb" -> "Falcon Scout")
        var ship_name = random_model_path.get_file().get_basename()
        npc.ship_name = ship_name
        
        # Remove the default Model node if it exists
        var old_model = npc.get_node_or_null("Model")
        if old_model:
            old_model.free()  # Use free() instead of queue_free() for immediate removal
        
        # Instance and add the new random model
        var new_model = model_scene.instantiate()
        new_model.name = "Model"
        npc.add_child(new_model)
        
        # Add NPC to scene (this will trigger _ready() which expects Model to exist)
        add_child(npc)
        
        print("Spawned NPC #", i, " with model: ", ship_name)
