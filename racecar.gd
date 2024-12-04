extends CharacterBody3D


const MAX_SPEED = 2.0
const MAX_STEERING = 3.1415 * 30.0 / 180.0
const JUMP_VELOCITY = 4.5

const WHEELBASE = 1
var yaw = 0.0

var velocity_forward: float = 0.0

func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	# Inputs
	var speed = MAX_SPEED * ((1 if Input.is_action_pressed("forward") else 0) - (1 if Input.is_action_pressed("back") else 0))
	var steering = MAX_STEERING * ((1 if Input.is_action_pressed("left") else 0) - (1 if Input.is_action_pressed("right") else 0))
#
	#velocity.x += speed * cos(yaw) * delta
	#velocity.z += speed * sin(yaw) * delta
	#yaw += speed * tan(steering) / WHEELBASE * delta
	#
	#rotation.y = yaw
	rotation.y += speed * tan(steering) / WHEELBASE * delta
	var dstate = Vector3(speed, 0, 0).rotated(Vector3.UP, rotation.y) * delta
	velocity_forward = speed;
	#move_and_slide()
	move_and_collide(dstate)
