extends LimboState

@export var animation_player: AnimationPlayer

func _enter() -> void:
	animation_player.play("heroine/idle")

func _update(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		dispatch(PlayerHSM.transition_attack)
	elif Input.is_action_just_pressed("sleep"):
		dispatch(PlayerHSM.transition_sleep)
	elif Input.get_vector("move_left", "move_right", "move_down", "move_up") != Vector2.ZERO:
		dispatch(PlayerHSM.transition_run)
	
