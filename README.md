# Stars II - Space Combat/Trading Game

A 3D top-down space game inspired by Escape Velocity, Endless Sky, and Star Control.

## Controls

- **I** - Forward thrust
- **K** - Reverse thrust (brake)
- **J** - Rotate left (counter-clockwise)
- **L** - Rotate right (clockwise)
- **Space** - Quick stop (halves velocity)

## Current Features

- Player ship with rotation-based Newtonian movement
- 8 NPC ships wandering around the space
- Procedural starfield background (500 stars)
- Debug HUD showing speed, position, and FPS
- Orthographic top-down camera view

## Project Structure

```
scenes/
  main.tscn           - Main game scene
  player_ship.tscn    - Player ship with camera
  npc_ship.tscn       - NPC ship template
  hud.tscn           - Debug HUD overlay

scripts/
  player_ship.gd     - Player ship controls (IJKL)
  npc_ship.gd        - Simple wandering AI
  npc_spawner.gd     - Spawns NPC ships at start
  starfield.gd       - Generates star background
  debug_hud.gd       - Debug information display

glb/
  [62 spaceship models]
```

## Next Steps

- [ ] Add weapon systems
- [ ] Implement collision damage
- [ ] Add space stations for docking
- [ ] Create trading system
- [ ] Add ship statistics (speed, armor, cargo)
- [ ] Randomize NPC ship models
- [ ] Add mission system
- [ ] Create UI for ship status
