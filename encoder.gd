extends Node

var topic_name: String
var publisher: GodotRosFloat32Publisher

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	publisher = GodotRosFloat32Publisher.new()
	publisher.init(Global.ros2_node, topic_name, 10)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	var encoder_reading = $"../Racecar".velocity_forward
	publisher.publish(encoder_reading)
	
