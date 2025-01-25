extends Node

var steering_subscriber: GodotRosFloat64Subscriber
var speed_subscriber: GodotRosFloat64Subscriber
var steering: float
var speed: float
var has_any_ros: bool

var use_manual_control: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print("before config")
	var config = Config.get_config()
	#print("gets config")
	
	use_manual_control = true # false
	has_any_ros = false
	
	if config.has_section("input_sources"):
		steering_subscriber = GodotRosFloat64Subscriber.new()
		steering_subscriber.init(Global.ros2_node, config.get_value("input_sources", "steering_topic", "steering"))
		steering_subscriber.connect("message_received", save_steering)
		
		speed_subscriber = GodotRosFloat64Subscriber.new()
		speed_subscriber.init(Global.ros2_node, config.get_value("input_sources", "speed_topic", "speed"))
		speed_subscriber.connect("message_received", save_speed)
		
		has_any_ros = true
	else:
		print("Has no ROS input sources")

func save_steering(data):
	steering = data

func save_speed(data):
	speed = data

func get_steering():
	if not has_any_ros or use_manual_control:
		return ((1 if Input.is_action_pressed("left") else 0) - (1 if Input.is_action_pressed("right") else 0))
	
	return steering

func get_speed():
	if not has_any_ros or use_manual_control:
		return ((1 if Input.is_action_pressed("forward") else 0) - (1 if Input.is_action_pressed("back") else 0))
	
	return speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
