# Mouse Wheel Zoom Control

## Why
Players need the ability to adjust their view distance to better observe both close-up ship details and wider battlefield context. Currently, the camera is fixed at a single zoom level (855.7 units above the player), limiting situational awareness.

## What Changes
- Add mouse wheel input handling to the camera controller
- Implement smooth zoom transitions between 50% (427.85 units) and 200% (1711.4 units) of current zoom
- Maintain player ship centered on screen during zoom changes
- Preserve existing camera follow behavior

## Impact
- Affected specs: `camera-zoom` (new capability)
- Affected code: `scripts/camera_controller.gd`
- No breaking changes - purely additive feature
