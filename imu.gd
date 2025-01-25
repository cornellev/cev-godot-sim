extends Node

var topic_name: String
var frame_id: String

var publisher: GodotRosImuPublisher

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	publisher = GodotRosImuPublisher.new();
	publisher.init(Global.ros2_node, topic_name, 10);

var previous_velocity: Vector3 = Vector3.ZERO
var acceleration: Vector3 = Vector3.ZERO

#var previous_ang_velocity: float
#var ang_acceleration: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var racecar = $"../Racecar"
	#racecar.t
	var imu = Imu.new();
	
	var velocity = racecar.velocity
	acceleration = (velocity - previous_velocity) / delta;
	previous_velocity = velocity;
	
	var ang_velocity = racecar.angular_velocity
	#ang_acceleration = (angular_velocity - previous_ang_velocity) / delta
	#previous_ang_velocity = ang_velocity

	imu.set_frame_id(frame_id);
	imu.set_linear_acceleration(acceleration);
	imu.set_angular_velocity(Vector3(0.0, ang_velocity, 0.0));
	
	publisher.publish(imu);
