extends Node

var ros2_node: GodotRosNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GodotRosNode.Startup()
	ros2_node = GodotRosNode.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ros2_node.spin_some()
	
func _on_tree_exited() -> void:
	GodotRosNode.Shutdown()
