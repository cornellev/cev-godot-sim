extends CharacterBody3D


var ground_truth_publisher: GodotRosFloat64ArrayPublisher

const MAX_SPEED = 2.0
const MAX_STEERING = 3.1415 * 30.0 / 180.0
const JUMP_VELOCITY = 4.5

const WHEELBASE = 1
var yaw = 0.0

var velocity_forward: float = 0.0

var dstate: Vector3

var prev_position: Vector3 = Vector3.ZERO
var angular_velocity: float

func _ready():
	var topic_name = Config.get_config().get_value("racecar", "ground_truth_topic", "ground_truth")
	ground_truth_publisher = GodotRosFloat64ArrayPublisher.new()
	ground_truth_publisher.init(Global.ros2_node, topic_name, 10);

func upload_ground_truth():
	if not ground_truth_publisher: return
	var p = [position.x, position.z, rotation.y, velocity.x, velocity.z]
	var ground_truth = PackedFloat64Array(p);
	ground_truth_publisher.publish(ground_truth);

func _physics_process(delta: float) -> void:
	upload_ground_truth()

	# Inputs
	var speed = MAX_SPEED * InputSource.get_speed()
	var steering = MAX_STEERING * InputSource.get_steering()
#	
	angular_velocity = speed * tan(steering) / WHEELBASE
	rotation.y += angular_velocity * delta
	dstate = Vector3(speed, 0, 0).rotated(Vector3.UP, rotation.y) * delta
	velocity_forward = speed;
	
	velocity = (position - prev_position) / delta
	prev_position = position;
	
	#velocity = dstate/delta;
	move_and_collide(dstate)
	#move_and_slide();
