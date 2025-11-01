extends Camera3D

## Camera that keeps the player ship centered on screen at all times

@export var camera_offset: Vector3 = Vector3(0, 424.3, 0)

var player: Node3D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if not player:
		player = get_node_or_null("/root/Main/PlayerShip")
	
	if player:
		print("Camera found player at: ", player.position)
		# Position camera immediately at player position
		position = player.position + camera_offset
	else:
		print("WARNING: Camera could not find player!")
	
	current = true

func _physics_process(_delta):
	if player:
		# Keep player perfectly centered - no interpolation
		position = player.position + camera_offset
