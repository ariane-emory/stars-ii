extends Node3D

## Spawns NPC ships at game start

@export var npc_count: int = 8
@export var spawn_radius: float = 1000.0

var npc_ship_scene = preload("res://scenes/npc_ship.tscn")

# List of available ship models
var ship_models = [
    "res://glb/Falcon Scout.glb",
    "res://glb/Dart Scout.glb",
    "res://glb/Strider Scout.glb",
    "res://glb/Fleetfoot Scout.glb",
    "res://glb/Dagger Fighter.glb",
    "res://glb/Fury Fighter.glb",
    "res://glb/Wasp Fighter.glb",
    "res://glb/Express Trader.glb"
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
        
        # TODO: Randomize ship model (requires loading different GLBs)
        # For now, all NPCs use the same model defined in npc_ship.tscn
        
        add_child(npc)
