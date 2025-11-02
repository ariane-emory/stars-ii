## Context
The current ship rotation system categorizes ships into three rotation groups based on observed thrust patterns. However, this approach has proven problematic as:
1. Ships may not fit neatly into the three predefined categories
2. LLMs make incorrect assumptions about which category a ship belongs in
3. Moving ships between lists doesn't solve the root problem of incorrect rotation
4. The system assumes all ships in a category need the same rotation

## Goals / Non-Goals
- Goals: 
  - Individual ship rotation configuration for precise control
  - Eliminate rotation category assumptions
  - Maintain existing external API for compatibility
  - Add validation to ensure all ships have defined rotations
- Non-Goals:
  - Change ship scaling system
  - Modify external ship configuration interface
  - Remove existing rotation correction functionality

## Decisions
- Decision: Use dictionary-based individual ship rotation configuration
  - Each ship name maps to explicit Vector3 rotation
  - Removes need for categorization assumptions
  - Allows precise per-ship tuning
- Alternatives considered:
  - Add more rotation categories (would still be categorization-based)
  - Use auto-detection (unreliable for GLB orientation variations)
  - Keep current system with better documentation (doesn't solve root issue)

## Risks / Trade-offs
- Risk: Larger configuration file size
  - Mitigation: Use efficient dictionary lookup, minimal memory impact
- Risk: Manual configuration required for each ship
  - Mitigation: Provide clear migration script and validation tools
- Trade-off: More explicit configuration vs. automatic categorization
  - Acceptable: Precision is more important than automation for this domain

## Migration Plan
1. Create individual ship rotation dictionary with current correct values
2. Update _initialize_ship_data() to use dictionary lookup
3. Remove rotation list variables and logic
4. Add validation to ensure all ships have defined rotations
5. Test with existing ship configurations

## Open Questions
- Should we keep the rotation constants (alt_rotation, etc.) as reference values?
- How should we handle ships not explicitly defined in the dictionary?