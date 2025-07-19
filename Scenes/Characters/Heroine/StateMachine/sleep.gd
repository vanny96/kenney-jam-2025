extends LimboState

@export var heroine: Heroine
@export var animation_player: AnimationPlayer

var passed_time: float = 0

func _enter() -> void:
	animation_player.play("heroine/sleep")
	heroine.model.position.y = 0.5
	passed_time = 0
	
func _update(delta: float) -> void:
	passed_time += delta
	if passed_time > heroine.sleep_time:
		heroine.curr_punches = heroine.max_punches
		dispatch(PlayerHSM.transition_energetic)

func _exit() -> void:
	heroine.model.position.y = 0
	
