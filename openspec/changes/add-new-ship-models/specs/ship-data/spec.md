# Ship Data Specification

## ADDED Requirements

### Requirement: Ship Configuration Registry
The system SHALL maintain a centralized registry of all ship configurations including model paths, rotation corrections, and scale multipliers.

#### Scenario: Ship configuration lookup
- **WHEN** a ship name is queried
- **THEN** the system returns the complete ship configuration including model path, rotation, and scale

#### Scenario: Random ship selection
- **WHEN** a random ship is requested
- **THEN** the system returns a valid ship model path from all configured ships

### Requirement: New Ship Models Integration
The system SHALL include 22 new ship models available for spawning and gameplay.

#### Scenario: Arsenal Gunship available
- **WHEN** requesting ship configurations
- **THEN** Arsenal Gunship is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Audacious Patrol Ship available
- **WHEN** requesting ship configurations
- **THEN** Audacious Patrol Ship is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Bearpaw Frigate available
- **WHEN** requesting ship configurations
- **THEN** Bearpaw Frigate is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Evil Eye Gun Platform available
- **WHEN** requesting ship configurations
- **THEN** Evil Eye Gun Platform is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Fireball Fighter available
- **WHEN** requesting ship configurations
- **THEN** Fireball Fighter is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Grasshopper Frigate available
- **WHEN** requesting ship configurations
- **THEN** Grasshopper Frigate is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Marathon Fighter available
- **WHEN** requesting ship configurations
- **THEN** Marathon Fighter is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Moth Scout available
- **WHEN** requesting ship configurations
- **THEN** Moth Scout is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Motorcade Shuttle available
- **WHEN** requesting ship configurations
- **THEN** Motorcade Shuttle is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Nexion Frigate available
- **WHEN** requesting ship configurations
- **THEN** Nexion Frigate is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Nightgaunt Gunship available
- **WHEN** requesting ship configurations
- **THEN** Nightgaunt Gunship is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Orca Hauler available
- **WHEN** requesting ship configurations
- **THEN** Orca Hauler is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Pinnacle Fighter available
- **WHEN** requesting ship configurations
- **THEN** Pinnacle Fighter is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Pugilist Patrol Ship available
- **WHEN** requesting ship configurations
- **THEN** Pugilist Patrol Ship is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Racer Fighter available
- **WHEN** requesting ship configurations
- **THEN** Racer Fighter is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Redeye Gun Platform available
- **WHEN** requesting ship configurations
- **THEN** Redeye Gun Platform is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Sai Fighter available
- **WHEN** requesting ship configurations
- **THEN** Sai Fighter is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Scarab Construction Ship available
- **WHEN** requesting ship configurations
- **THEN** Scarab Construction Ship is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Sokoly Fighter available
- **WHEN** requesting ship configurations
- **THEN** Sokoly Fighter is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Sundiver Frigate available
- **WHEN** requesting ship configurations
- **THEN** Sundiver Frigate is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Twinstrike Gunship available
- **WHEN** requesting ship configurations
- **THEN** Twinstrike Gunship is included with default rotation Vector3(0, 90, 0) and scale 1.0

#### Scenario: Watchman Gunship available
- **WHEN** requesting ship configurations
- **THEN** Watchman Gunship is included with default rotation Vector3(0, 90, 0) and scale 1.0

### Requirement: Asteroid Models Exclusion
The system SHALL NOT include asteroid models in the spawnable ship registry.

#### Scenario: Asteroids excluded from ship spawning
- **WHEN** requesting random ship models for spawning
- **THEN** Asteroid 1, Asteroid 2, Asteroid 3, and Asteroid 4 are not included in available ships
- **AND** asteroids remain available in the project for other purposes

### Requirement: Ship Model File Organization
The system SHALL load ship models from the `res://glb/` directory.

#### Scenario: Ship models in correct location
- **WHEN** the game initializes
- **THEN** all ship GLB files are loaded from `res://glb/` directory
- **AND** associated texture files are loaded from the same directory
