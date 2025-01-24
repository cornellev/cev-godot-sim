extends Node


#var camera1 = null
var camera2 = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#camera1 = $CarCameraPivot/SubViewport/CarCamera 
	camera2 = $GodCameraPivot/GodCamera
	
	#camera1.current = true
	camera2.current = true
	
func swap_cameras():
	# Activate the other camera
	#if camera1.current:
		#camera1.current = false
		#camera2.current = true
	#else:
		#camera2.current = false
		#camera1.current = true
	pass
	#print(camera1.current, camera2.current)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("swap_cameras"):
		swap_cameras()
