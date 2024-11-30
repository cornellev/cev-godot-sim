extends Node3D

var publisher: GodotRosPublisher
var subscriber: GodotRosSubscriber

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Global.ros2_node
	publisher = GodotRosPublisher.new()
	publisher.init(Global.ros2_node, "data", 10);
	
	subscriber = GodotRosSubscriber.new()
	subscriber.init(Global.ros2_node, "data");
	subscriber.message_received.connect(show_data)
	pass # Replace with function body.


func show_data(message):
	print(message);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	publisher.publish("HELLO WORLD");
	pass 
