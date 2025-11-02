extends Node3D

## Spawns NPC ships at game start

@export var npc_count: int = 8
@export var spawn_radius: float = 1000.0

var npc_ship_scene = preload("res://scenes/npc_ship.tscn")

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
        
        # Force spawn Robin Gunship for testing
        var ship_name: String
        var model_scene
        if i == 0:
            ship_name = "Robin Gunship"
            model_scene = load("res://glb/Robin Gunship.glb")
        else:
            # Randomize ship model - select random GLB from ShipData
            var ship_paths = ShipData.get_all_ship_paths()
            var random_model_path = ship_paths[randi() % ship_paths.size()]
            model_scene = load(random_model_path)
            # Extract ship name from path using ShipData helper
            ship_name = ShipData.get_ship_name_from_path(random_model_path)
        
        npc.ship_name = ship_name
        print("Testing ship: ", ship_name)
        
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
        
        # Update rotation fix now that ship name is set
        npc.update_rotation_fix()
        
        
