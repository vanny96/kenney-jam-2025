extends LimboState

@export var animation_player: AnimationPlayer

func _enter() -> void:
	animation_player.play("alien/attack")
	animation_player.animation_finished.connect(_go_run.unbind(1))

func _exit() -> void:
	animation_player.animation_finished.disconnect(_go_run.unbind(1))
	
func _go_run():
	dispatch(AlienHSM.transition_run)
