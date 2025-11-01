extends Node3D

## Generates a starfield background with glowing white dots

@export var star_count: int = 4000
@export var field_size: float = 40000.0
@export var star_height: float = -100.0  # Below the action

func _ready():
	generate_starfield()

func generate_starfield():
	# Create a MultiMesh for performance
	var multimesh = MultiMesh.new()
	var mesh = SphereMesh.new()
	mesh.radius = 1.0
	mesh.height = 2.0
	
	multimesh.mesh = mesh
	multimesh.transform_format = MultiMesh.TRANSFORM_3D
	multimesh.instance_count = star_count
	
	# Create material with emission for glow
	var material = StandardMaterial3D.new()
	material.albedo_color = Color.WHITE
	material.emission_enabled = true
	material.emission = Color.WHITE
	material.emission_energy_multiplier = 2.0
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	
	mesh.material = material
	
	# Position stars randomly
	for i in range(star_count):
		var star_transform = Transform3D()
		
		# Random position in field
		var x = randf_range(-field_size / 2, field_size / 2)
		var z = randf_range(-field_size / 2, field_size / 2)
		star_transform.origin = Vector3(x, star_height, z)
		
		# Random size (0.5 to 4 units)
		var star_scale = randf_range(0.5, 4.0)
		star_transform = star_transform.scaled(Vector3(star_scale, star_scale, star_scale))
		
		multimesh.set_instance_transform(i, star_transform)
	
	# Add to scene
	var multimesh_instance = MultiMeshInstance3D.new()
	multimesh_instance.multimesh = multimesh
	add_child(multimesh_instance)
