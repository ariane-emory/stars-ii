extends Node

## Global game state manager
## Handles game-wide state like NPC pause

var npc_paused: bool = true

func _input(event):
	# Toggle NPC pause with P key
	if event is InputEventKey and event.keycode == KEY_P and event.pressed and not event.echo:
		toggle_npc_pause()

func toggle_npc_pause():
	npc_paused = !npc_paused
	print("NPC ships ", "PAUSED" if npc_paused else "UNPAUSED")
