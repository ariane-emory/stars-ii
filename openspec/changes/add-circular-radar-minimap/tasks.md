# Implementation Tasks

## 1. Create Radar Display UI
- [ ] 1.1 Add Control node to HUD for radar container (positioned top-right)
- [ ] 1.2 Create circular background/border for radar display
- [ ] 1.3 Set up proper anchoring and sizing for top-right positioning

## 2. Implement Radar Logic Script
- [ ] 2.1 Create `scripts/radar_display.gd` script extending Control
- [ ] 2.2 Implement player ship reference tracking
- [ ] 2.3 Implement NPC ship detection via group or scene tree traversal
- [ ] 2.4 Calculate relative positions (world space to radar space conversion)
- [ ] 2.5 Handle rotation transformation based on player orientation

## 3. Ship Indicator Rendering
- [ ] 3.1 Implement triangle drawing for friendly ships (green)
- [ ] 3.2 Implement triangle drawing for enemy ships (red) - prepared for future use
- [ ] 3.3 Add edge clamping logic for ships beyond radar range
- [ ] 3.4 Add proper scaling for radar range and screen size

## 4. Integration and Testing
- [ ] 4.1 Integrate radar display into main HUD scene
- [ ] 4.2 Test radar display with multiple NPC ships
- [ ] 4.3 Verify indicators update in real-time as ships move
- [ ] 4.4 Test edge clamping behavior for distant ships
- [ ] 4.5 Verify radar rotates/updates correctly with player rotation

## 5. Polish
- [ ] 5.1 Add visual styling (circle outline, background color, etc.)
- [ ] 5.2 Tune radar detection range for optimal gameplay
- [ ] 5.3 Ensure performance is acceptable with many ships
