extends LimboState

@export var heroine: Heroine
@export var animation_player: AnimationPlayer

func _enter() -> void:
	animation_player.play("heroine/sleep")
	heroine.model.position.y = 0.5
	await get_tree().create_timer(heroine.sleep_time).timeout
	heroine.curr_punches = heroine.max_punches
	dispatch(PlayerHSM.transition_energetic)
	
func _exit() -> void:
	heroine.model.position.y = 0
	
