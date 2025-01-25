extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	# add_child(ConfigLoader.vehicle)
	# Then, pass a reference to the vehicle to each sensor when it's created
	
	for sensor in SensorLoader.sensors:
		add_child(sensor)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
