extends Camera3D

## Camera that follows the player ship

@export var follow_speed: float = 5.0
@export var camera_offset: Vector3 = Vector3(0, 300, 300)

var player: Node3D

func _ready():
	player = get_tree().get_first_node_in_group("player")
	if not player:
		player = get_node_or_null("/root/Main/PlayerShip")
	
	if player:
		print("Camera found player at: ", player.position)
	else:
		print("WARNING: Camera could not find player!")
	
	current = true

func _process(delta):
	if player:
		var target_pos = player.position + camera_offset
		position = position.lerp(target_pos, follow_speed * delta)
