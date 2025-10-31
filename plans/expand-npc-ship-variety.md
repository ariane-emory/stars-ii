# Expand NPC Ship Model Variety

## Goal
Modify the NPC spawning system to randomly select from all 60 available GLB ship models instead of the current hardcoded 8 models.

## Current State
- 60 GLB ship models available in `glb/` directory
- Only 8 models listed in `npc_spawner.gd` ship_models array
- All NPC ships currently spawn with hardcoded "Falcon Scout" model from `npc_ship.tscn`
- TODO comment indicates ship model randomization is not implemented

## Implementation Plan

### Phase 1: Preparation
- [x] Create comprehensive list of all 60 ship model paths
- [x] Update `npc_spawner.gd` ship_models array to include all GLB files
- [x] Verify model path format is correct (res://glb/[Name].glb)

### Phase 2: Dynamic Model Loading
- [x] Modify `spawn_npcs()` function to randomly select a model path
- [x] Implement dynamic model loading for each NPC instance
- [x] Remove hardcoded Model node from spawned NPC
- [x] Load and add randomly selected model as child of NPC
- [x] Ensure proper node naming (Model) for compatibility with npc_ship.gd

### Phase 3: Compatibility & Testing
- [x] Verify model scaling (100x) works with all ship types
- [x] Verify unshaded material conversion works with all ship types
- [x] Verify standard rotation fix (90, 90, 0) works with all ship types
- [x] Test spawning multiple NPCs with different models
- [x] Verify no errors or warnings in Godot console

### Phase 4: Code Cleanup
- [x] Remove TODO comment from npc_spawner.gd
- [x] Remove outdated ship_models list comment if needed
- [x] Verify code formatting (4 spaces indentation)
- [x] Final build verification

## Implementation Complete ✅

All phases have been successfully completed! The NPC spawning system now:
- Uses all 60 available ship models from the `glb/` directory
- Randomly selects a different model for each spawned NPC
- Maintains full compatibility with existing model transformations (scaling, unshaded materials, rotation fix)
- Provides significantly enhanced visual variety in the game

### Changes Made:
1. **npc_spawner.gd**: Updated ship_models array from 8 to 60 models
2. **npc_spawner.gd**: Implemented dynamic model loading in spawn_npcs() function
3. **All existing functionality preserved**: Model scaling, material conversion, and rotation fixes all work correctly

## Technical Notes
- All ship models must go through same transformations in `npc_ship.gd:_ready()`:
  - Scale to Vector3(100, 100, 100)
  - Convert materials to unshaded via `convert_to_unshaded()`
  - Apply rotation fix via `apply_standard_rotation_fix()`
- Model node must be named "Model" to be found by `get_node_or_null("Model")`
- Use `load()` to dynamically load GLB PackedScenes at runtime
- Instance the loaded scene and add as child to NPC ship
