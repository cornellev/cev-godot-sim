extends CheckButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# if MUST use manual override
	if not InputSource.has_any_ros:
		button_pressed = true
		disabled = true
	else:
		button_pressed = false
		disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_toggled(toggled_on: bool) -> void:
	InputSource.use_manual_control = toggled_on # Replace with function body.
