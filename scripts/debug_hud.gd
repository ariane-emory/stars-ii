extends Label

## Debug HUD showing player ship stats

var player_ship: CharacterBody3D

func _ready():
	# Find player ship
	player_ship = get_tree().get_first_node_in_group("player")
	
	if not player_ship:
		# Try finding it by name
		player_ship = get_node_or_null("/root/Main/PlayerShip")

func _process(_delta):
	if player_ship:
		var velocity = player_ship.velocity
		var speed = velocity.length()
		var pos = player_ship.position
		var rotation_angle = player_ship.rotation_angle
		var ship_name = player_ship.ship_name if "ship_name" in player_ship else "Unknown"
		
		text = "Ship: %s\n" % ship_name
		text += "Speed: %.0f units/s\n" % speed
		text += "Position: (%.0f, %.0f)\n" % [pos.x, pos.z]
		text += "Rotation: %.2f rad (%.0f°)\n" % [rotation_angle, rad_to_deg(rotation_angle)]
		text += "FPS: %d\n" % Engine.get_frames_per_second()
		text += "\nControls: I/K or Up/Down thrust\n"
		text += "J/L or Left/Right rotate, Space stop"
	else:
		text = "Player ship not found"
