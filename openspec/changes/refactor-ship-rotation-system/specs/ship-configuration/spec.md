## MODIFIED Requirements
### Requirement: Individual Ship Rotation Configuration
The ship configuration system SHALL store rotation settings for each individual ship rather than using grouped rotation categories.

#### Scenario: Ship rotation lookup
- **WHEN** the system needs rotation data for a specific ship
- **THEN** it SHALL retrieve the exact Vector3 rotation value from a ship-specific dictionary
- **AND** SHALL NOT apply category-based rotation assumptions

#### Scenario: Ship rotation validation
- **WHEN** initializing ship data
- **THEN** the system SHALL validate that every ship in the ship list has a defined rotation
- **AND** SHALL report warnings for any ships missing rotation configuration

#### Scenario: Backward compatibility
- **WHEN** existing code calls get_ship_rotation()
- **THEN** the function SHALL return the same Vector3 result as before
- **AND** SHALL maintain the same function signature and behavior

#### Scenario: Configuration maintenance
- **WHEN** adding a new ship to the system
- **THEN** the configuration SHALL require explicit rotation definition for that ship
- **AND** SHALL NOT allow ships to inherit rotation from categories

## REMOVED Requirements
### Requirement: Grouped Rotation Lists
**Reason**: Grouped rotation categories (alt_rotation_ships, reverse_rotation_ships, flip_rotation_ships) lead to incorrect assumptions and error-prone configuration.
**Migration**: All existing ship rotations will be migrated to individual dictionary entries with their current correct values.

### Requirement: Rotation Category Logic
**Reason**: The logic that determines rotation based on ship category membership is being removed to prevent incorrect categorization assumptions.
**Migration**: Replace category-based lookup with direct dictionary lookup using ship name as key.