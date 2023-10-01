extends CharacterBody3D

const SPEED = 10
const JUMP_VELOCITY = 4.5
const MAX_JUMPS = 3

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camerabase = $CameraBase
@onready var anim = $SonicMMM/AnimationPlayer

enum CharacterState {
	RUNNING,
	JUMPING,
}

var current_state = CharacterState.RUNNING
var jumps_remaining = MAX_JUMPS

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if Input.is_action_just_pressed("jump") and jumps_remaining > 0:
		velocity.y = JUMP_VELOCITY
		jumps_remaining -= 1
		current_state = CharacterState.JUMPING
		anim.play("sn_ball")
	elif is_on_floor():
		current_state = CharacterState.RUNNING
		anim.play("sn_run")
		jumps_remaining = MAX_JUMPS

	var direction = -transform.basis.z

	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED

	move_and_slide()
