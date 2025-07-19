extends LimboState

@export var animation_player: AnimationPlayer
@export var heroine: Heroine

@onready var camera: Camera3D = get_viewport().get_camera_3d()

func _enter() -> void:
	animation_player.play("heroine/walk")

func _update(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	move_horizontally(direction)
	heroine.move_and_slide()
	
	if Input.is_action_just_pressed("attack"):
		dispatch(PlayerHSM.transition_attack)
	elif direction == Vector2.ZERO:
		dispatch(PlayerHSM.transition_idle)

func move_horizontally(direction: Vector2):
	var camera_aligned_direction := direction.rotated(-camera.rotation.y)
	var movement = camera_aligned_direction.normalized() * heroine.walk_speed
	heroine.velocity.x = movement.x
	heroine.velocity.z = movement.y
	if movement != Vector2.ZERO:
		heroine.model.look_at(heroine.position - Vector3(movement.x, 0, movement.y))
