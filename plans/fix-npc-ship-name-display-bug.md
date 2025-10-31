# Critical Bug Fix: Rotating Green Rectangles Issue

## Problem Analysis
The NPC ship name display is partially working - green rectangles are appearing above ships, but they're rotating with the ships instead of staying horizontal and always facing the camera. This indicates the labels are being parented to the rotating ModelWrapper node instead of the NPC ship root node.

## Root Cause Diagnosis
1. **Parenting Issue**: Labels are added to NPC ship root, but ModelWrapper rotation affects them
2. **Node Hierarchy**: `apply_standard_rotation_fix()` creates ModelWrapper and moves Model inside it
3. **Label Position**: Labels positioned relative to ship root, but inherit rotation from ModelWrapper
4. **Expected Behavior**: Labels should stay horizontal and always face camera (billboard)
5. **Actual Behavior**: Labels rotate with ship model, indicating wrong parent node

## Implementation Plan

### Phase 1: Diagnose Node Hierarchy Issue
- [x] Add debug output to show current node hierarchy after model setup
- [x] Verify ModelWrapper creation and Model reparenting
- [x] Check if labels are being added to correct parent node
- [x] Confirm label positioning relative to ship root vs ModelWrapper

### Phase 2: Fix Label Parenting
- [x] Ensure labels are parented to NPC ship root, not Model or ModelWrapper
- [x] Test if label positioning needs adjustment for ModelWrapper hierarchy
- [x] Verify labels maintain horizontal orientation regardless of ship rotation
- [x] Confirm billboard behavior works correctly from ship root

### Phase 3: Alternative Label Approaches
- [ ] Try creating labels as sibling of ModelWrapper, not child of ship
- [ ] Test adding labels to scene tree at same level as NPC ship
- [ ] Verify different parenting strategies for label visibility
- [ ] Test if labels need different coordinate system

### Phase 4: Coordinate System Fix
- [ ] Ensure label positioning accounts for ModelWrapper transformation
- [ ] Test if labels need world space vs local space positioning
- [ ] Verify label rotation independence from ship model rotation
- [ ] Test different height offsets for better visibility

### Phase 5: Final Verification
- [ ] Test complete label system with all 60 ship models
- [ ] Verify labels stay horizontal and face camera correctly
- [ ] Confirm labels don't rotate with ship movement
- [ ] Add final cleanup and optimization

## Technical Notes
- ModelWrapper is created in `apply_standard_rotation_fix()` at line 105-117
- Model is moved from ship root to ModelWrapper at line 113-114
- Labels are added to ship root at line 129 in current implementation
- Labels should maintain independent orientation from ModelWrapper rotation
- Billboard mode should ensure labels always face camera regardless of parent rotation

## Success Criteria
- All NPC ships display their model names in horizontal green text
- Labels stay fixed orientation and always face camera
- Labels don't rotate with ship model rotation
- Labels are positioned clearly above ships without overlap
- System works for all 60 ship models
- No errors or warnings in Godot console