extends CharacterBody3D


const MAX_SPEED = 2.0
const MAX_STEERING = 3.1415 * 30.0 / 180.0
const JUMP_VELOCITY = 4.5

const WHEELBASE = 1
var yaw = 0.0

var velocity_forward: float = 0.0

func _physics_process(delta: float) -> void:
	# Inputs
	var speed = MAX_SPEED * InputSource.get_speed()
	var steering = MAX_STEERING * InputSource.get_steering()
#
	rotation.y += speed * tan(steering) / WHEELBASE * delta
	var dstate = Vector3(speed, 0, 0).rotated(Vector3.UP, rotation.y) * delta
	velocity_forward = speed;

	move_and_collide(dstate)
