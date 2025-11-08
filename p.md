Okay, I've added a bunch of new models to the ./station-glbs folder.

Please import them, moving each into the ./glb folder as you import it, place them on a new row in the grid layout. Once we adjust the scale on these, they're going to pretty large, so give the row a pretty wide spacing.

These models are space stations, not ships, so they should have a thrust rating of 0.

---

Okay, we're probably going to want some way twitch between starting scenarios for the game...

Let's call the current scenario, where all of the ships are spawned laid out in an orderly grid and it starts in a paused state, the 'ship_gallery' scenario.

Let's call the prior starting conditions, where just a dozen-ish random ships spawned moving naturally, the 'normal' scenario and implement some easy way to quickly switch between these two starting scenarios in the code.
