# Camera Zoom Specification

## ADDED Requirements

### Requirement: Mouse Wheel Zoom Control
The camera SHALL allow players to zoom in and out using the mouse wheel, adjusting the view distance while keeping the player ship centered on screen.

#### Scenario: Zoom out with mouse wheel
- **WHEN** the player scrolls the mouse wheel away from themselves
- **THEN** the camera distance increases (zoom out)
- **AND** the zoom level remains within the 50%-200% range

#### Scenario: Zoom in with mouse wheel
- **WHEN** the player scrolls the mouse wheel toward themselves
- **THEN** the camera distance decreases (zoom in)
- **AND** the zoom level remains within the 50%-200% range

#### Scenario: Zoom at minimum boundary
- **WHEN** the player is at 50% zoom (minimum)
- **AND** attempts to zoom in further
- **THEN** the zoom level remains at 50%
- **AND** no error or unexpected behavior occurs

#### Scenario: Zoom at maximum boundary
- **WHEN** the player is at 200% zoom (maximum)
- **AND** attempts to zoom out further
- **THEN** the zoom level remains at 200%
- **AND** no error or unexpected behavior occurs

### Requirement: Zoom Range Limits
The camera zoom SHALL support a range from 50% to 200% of the base camera offset distance (855.7 units).

#### Scenario: Minimum zoom distance
- **WHEN** zoom is set to 50%
- **THEN** the camera Y offset is 427.85 units above the player

#### Scenario: Maximum zoom distance
- **WHEN** zoom is set to 200%
- **THEN** the camera Y offset is 1711.4 units above the player

#### Scenario: Default zoom level
- **WHEN** the game starts
- **THEN** the camera is at 100% zoom (855.7 units)

### Requirement: Smooth Zoom Transitions
The camera zoom SHALL transition smoothly to prevent jarring visual changes.

#### Scenario: Gradual zoom change
- **WHEN** the player changes zoom level
- **THEN** the camera distance interpolates smoothly to the new value
- **AND** the player ship remains centered throughout the transition

### Requirement: Player Centering During Zoom
The camera SHALL maintain the player ship's centered position on screen during all zoom operations.

#### Scenario: Zoom while moving
- **WHEN** the player ship is moving
- **AND** the player changes zoom level
- **THEN** the ship remains centered on screen
- **AND** the camera follows the ship's movement while zooming
