extends LimboState

@export var animation_player: AnimationPlayer
@export var audio_emitter: MultiAudioEmitter
@export var attack_area: Area3D

func _enter() -> void:
	animation_player.play("alien/attack")
	audio_emitter.play_next()
	animation_player.animation_finished.connect(_go_run.unbind(1))
	get_tree().create_timer(0.5).timeout.connect(attack)

func attack():
	for body in attack_area.get_overlapping_bodies():
		if body.is_in_group("citizien"):
			body.attacked()

func _exit() -> void:
	animation_player.animation_finished.disconnect(_go_run.unbind(1))
	
func _go_run():
	dispatch(AlienHSM.transition_run)
