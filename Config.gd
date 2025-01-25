extends Node

var config: ConfigFile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func load_config():
	config = ConfigFile.new()
	var err = config.load("user://config.ini")
	
	# If the file didn't load, ignore it.
	if err != OK:
		print("Didn't fing config.ini")
		return

func get_config():
	if config == null:
		self.load_config()
	
	return config
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
