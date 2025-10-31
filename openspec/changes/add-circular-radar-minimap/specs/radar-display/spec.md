# Radar Display Specification

## ADDED Requirements

### Requirement: Circular Radar Display
The system SHALL provide a circular radar/minimap display in the top-right corner of the screen that shows nearby ships relative to the player's position.

#### Scenario: Radar is visible on screen
- **WHEN** the game is running
- **THEN** a circular radar display appears in the top-right corner of the screen
- **AND** the radar has a visible circular border or background

#### Scenario: Radar shows player center
- **WHEN** the radar is displayed
- **THEN** the player's ship is represented as the center point of the radar circle

### Requirement: Friendly Ship Indicators
The system SHALL display friendly ships as small green triangles on the radar, positioned relative to the player's current location and orientation.

#### Scenario: Nearby friendly ship appears on radar
- **WHEN** a friendly NPC ship is within radar detection range
- **THEN** a small green triangle indicator appears on the radar
- **AND** the triangle's position on the radar corresponds to the ship's position relative to the player

#### Scenario: Friendly ship position updates in real-time
- **WHEN** a friendly NPC ship moves
- **THEN** the green triangle indicator updates its position on the radar in real-time

#### Scenario: Multiple friendly ships display correctly
- **WHEN** multiple friendly NPC ships are within radar range
- **THEN** each ship is represented by its own green triangle indicator
- **AND** indicators do not overlap or obscure each other inappropriately

### Requirement: Enemy Ship Indicators
The system SHALL display enemy ships as small red triangles on the radar, positioned relative to the player's current location and orientation.

#### Scenario: Enemy ship appears on radar (future)
- **WHEN** an enemy ship is within radar detection range
- **THEN** a small red triangle indicator appears on the radar
- **AND** the triangle's position on the radar corresponds to the ship's position relative to the player

#### Scenario: Enemy ship position updates in real-time (future)
- **WHEN** an enemy ship moves
- **THEN** the red triangle indicator updates its position on the radar in real-time

### Requirement: Relative Position Calculation
The system SHALL display ship positions on the radar relative to the player's current position and orientation.

#### Scenario: Ship directly ahead shows at top of radar
- **WHEN** a ship is directly in front of the player (in the direction the player is facing)
- **THEN** the ship's indicator appears at the top of the radar circle

#### Scenario: Ship behind shows at bottom of radar
- **WHEN** a ship is directly behind the player
- **THEN** the ship's indicator appears at the bottom of the radar circle

#### Scenario: Radar rotates with player orientation
- **WHEN** the player rotates their ship
- **THEN** all ship indicators rotate correspondingly to maintain correct relative positions

### Requirement: Distance-Based Edge Clamping
The system SHALL clamp indicators for ships beyond radar range to the edge of the radar circle.

#### Scenario: Distant ship indicator clamped to edge
- **WHEN** a ship is farther from the player than the radar's maximum detection range
- **THEN** the ship's indicator appears at the edge of the radar circle
- **AND** the indicator's angular position indicates the direction to the ship

#### Scenario: Ship moving out of range smoothly transitions to edge
- **WHEN** a ship moves from within radar range to beyond radar range
- **THEN** the indicator smoothly moves from its interior position to the edge of the radar circle

#### Scenario: Ship moving into range smoothly transitions from edge
- **WHEN** a ship moves from beyond radar range to within radar range
- **THEN** the indicator smoothly moves from the edge of the radar circle to its accurate interior position
