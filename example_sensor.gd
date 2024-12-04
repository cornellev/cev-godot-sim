extends Node

@export var property: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("example sensor created with property=" + property)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print('example sensor working')
	pass  
