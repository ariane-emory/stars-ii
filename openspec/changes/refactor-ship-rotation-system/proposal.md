## Why
The current ship rotation system uses grouped lists (alt_rotation_ships, reverse_rotation_ships, flip_rotation_ships) which is error-prone and leads to incorrect assumptions about ship orientations. LLMs frequently move ships between lists without understanding that neither list may provide the correct rotation for a specific ship.

## What Changes
- Replace grouped rotation lists with individual ship rotation configuration
- Each ship will have its own explicit rotation setting stored in a dictionary
- Remove the three rotation list categories (alt_rotation, reverse_rotation, flip_rotation)
- Maintain backward compatibility during transition
- Add validation to ensure every ship has a defined rotation

## Impact
- Affected specs: ship-configuration
- Affected code: scripts/ship_data.gd (rotation system)
- **BREAKING**: Changes internal rotation management API but preserves external interface