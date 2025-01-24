extends Node

var topic_name: String
var frame_id: String

var publisher: GodotRosImuPublisher

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	publisher = GodotRosImuPublisher.new();
	publisher.init(Global.ros2_node, topic_name, 10);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var imu = Imu.new();
	
	# TODO: get Imu data.
	imu.set_frame_id(frame_id);
	imu.set_linear_acceleration(Vector3(1.0, 2.0, 3.0));
	
	publisher.publish(imu);
