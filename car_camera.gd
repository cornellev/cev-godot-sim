extends Camera3D

var topic_name: String
var frame_id: String
var follow_speed: float = 5.0
var publisher: GodotRosImagePublisher

func _ready() -> void:
	topic_name = get_parent().get_parent().topic_name
	frame_id = get_parent().get_parent().frame_id
	publisher = GodotRosImagePublisher.new()
	publisher.init(Global.ros2_node, topic_name, 10);

#get_tree().root.get_texture().get_data() 

func get_camera_image(camera: Camera3D) -> Image:
	# Create a viewport
	if camera:
		var image = camera.get_viewport().get_texture().get_image()
		return image
	
	return null

func _process(delta):
	var target = $"../../../Racecar"
	if target:
		global_transform = target.global_transform
		
		var image = get_camera_image(self)
		if image:
			publisher.publish(image, frame_id);
