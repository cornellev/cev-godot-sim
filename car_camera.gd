extends Camera3D

@export var target: Node3D
@export var follow_speed: float = 5.0

var publisher: GodotRosImagePublisher

func _ready() -> void:
	publisher = GodotRosImagePublisher.new()
	publisher.init(Global.ros2_node, "/camera", 10);

#get_tree().root.get_texture().get_data() 

func get_camera_image(camera: Camera3D) -> Image:
	# Create a viewport
	if camera:
		var image = camera.get_viewport().get_texture().get_image()
		return image
	
	return null

func _process(delta):
	if target:
		global_transform.origin = lerp(global_transform.origin, target.global_transform.origin, follow_speed * delta)
		var desired_rotation = target.rotation
		rotation = rotation.lerp(desired_rotation, follow_speed * delta)
		
		var image = get_camera_image(self)
		if image:
			publisher.publish(image, "camera_frame");
