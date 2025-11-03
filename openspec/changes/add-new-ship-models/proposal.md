# Add New Ship Models

## Why
New 3D ship models and asteroids have been added to the `new-glbs/` directory and need to be integrated into the game. These models expand the variety of ships available for NPC spawning and add asteroid models for future use.

## What Changes
- Move 26 GLB files from `new-glbs/` to `glb/` directory (22 ships + 4 asteroids)
- Add 22 new ship configurations to `ShipData` (excluding asteroids)
- Ships will automatically be available for random NPC spawning via existing spawn system
- Asteroids will be available in the project but not added to spawnable ships

## Impact
- Affected specs: `ship-data` (new capability)
- Affected code: 
  - `scripts/ship_data.gd` - Add 22 new ship configurations
  - File system - Move GLB files from `new-glbs/` to `glb/`
- No breaking changes to existing systems
