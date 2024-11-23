extends Node

var ros2_node: GodotRosNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Welcome to the world!")
	GodotRosNode.Startup()
	ros2_node = GodotRosNode.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("hello world")
	pass   
	
func _on_tree_exited() -> void:
	GodotRosNode.Shutdown()
	print("Bye game :(")
