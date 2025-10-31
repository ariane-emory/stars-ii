# Add Circular Radar Minimap

## Why
Players need situational awareness of nearby ships without cluttering the main view. A radar display provides real-time relative positions of nearby friendly and enemy ships in an intuitive visual format.

## What Changes
- Add a circular radar/minimap display in the top-right corner of the HUD
- Display friendly ships (NPCs) as small green triangles indicating their position relative to the player
- Display enemy ships (when implemented) as small red triangles indicating their position relative to the player
- Show ship positions relative to the player's current location and orientation
- Clamp distant ship indicators to the edge of the radar circle when they exceed the detection range

## Impact
- **Affected specs**: `radar-display` (new capability)
- **Affected code**: 
  - `scenes/hud.tscn` - Add radar UI element
  - New script `scripts/radar_display.gd` - Implement radar logic
  - `scripts/npc_ship.gd` - May need to support faction/team tracking (future)
- **User-facing changes**: New UI element in top-right corner showing nearby ships
