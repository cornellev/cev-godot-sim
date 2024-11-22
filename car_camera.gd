extends Camera3D

@export var target: Node3D
@export var follow_speed: float = 5.0

#get_tree().root.get_texture().get_data() 

func _process(delta):
	if target:
		global_transform.origin = lerp(global_transform.origin, target.global_transform.origin, follow_speed * delta)
		var desired_rotation = target.rotation
		rotation = rotation.lerp(desired_rotation, follow_speed * delta)
