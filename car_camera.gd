extends Camera3D

@export var target: Node3D
@export var follow_speed: float = 5.0

var publisher: GodotRosImagePublisher

func _ready() -> void:
	publisher = GodotRosImagePublisher.new()
	publisher.init(Global.ros2_node, "/camera", 10);

#get_tree().root.get_texture().get_data() 

#func get_camera_image(camera: Camera3D) -> Image:
	## Create a viewport
	#if camera:
		#var image = camera.get_viewport().get_texture().get_image()
		#return image
	#
	#return null
	
func get_camera_image(camera: Camera3D, resolution: Vector2) -> Image:
	# Create a new viewport for offscreen rendering
	var viewport := Viewport.new()
	viewport.size = resolution
	viewport.usage = Viewport.USAGE_3D  # Ensure it's for 3D rendering
	viewport.disable_3d_audio = true   # Avoid unnecessary audio processing

	# Add the viewport temporarily to the scene tree
	add_child(viewport)

	# Set the Camera3D's world and assign it to the viewport
	viewport.world_3d = camera.get_world_3d()
	viewport.camera_3d = camera

	# Wait for one frame to ensure rendering completes
	await get_tree().process_frame()

	# Get the rendered image from the viewport
	var texture := viewport.get_texture()
	var image := texture.get_image()

	# Clean up by removing the viewport
	viewport.queue_free()

	return image



func _process(delta):
	if target:
		global_transform.origin = lerp(global_transform.origin, target.global_transform.origin, follow_speed * delta)
		var desired_rotation = target.rotation
		rotation = rotation.lerp(desired_rotation, follow_speed * delta)
		
		var image = get_camera_image(self)
		if image:
			publisher.publish(image, "camera_frame");
