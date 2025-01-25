extends Node

var sensors = []

# TODO: could enforce the name of the sensor to be the name of the scene file
var SENSOR_MAP: Dictionary = {
		"example_sensor": "res://example_sensor.tscn",
		"lidar": "res://lidar.tscn",
		"encoder": "res://encoder.tscn",
		"imu": "res://imu.tscn",
		"camera": "res://camera.tscn"
	};

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var config = Config.get_config()
	for section in config.get_sections():
		#sensors.append
		if section in SENSOR_MAP:
			var sensor_scene = load(SENSOR_MAP[section]).instantiate()
			for property in config.get_section_keys(section):
				if property in sensor_scene:
					sensor_scene.set(property, config.get_value(section, property)) 

			sensors.append(sensor_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
