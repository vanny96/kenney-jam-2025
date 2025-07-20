extends LimboState

@export var heroine: Heroine
@export var animation_player: AnimationPlayer
@export var audio_emitter: MultiAudioEmitter
@export var succesful_attack_audio_emitter: MultiAudioEmitter
@export var collision_area: Area3D

func _enter() -> void:
	audio_emitter.play_next()
	animation_player.play("heroine/punch")
	animation_player.speed_scale = 2
	animation_player.animation_finished.connect(_go_idle.unbind(1))
	damage_enemies()
	
func damage_enemies():
	var enemy_hit := false
	for body in collision_area.get_overlapping_bodies():
		if body is not Heroine:
			enemy_hit = true
		if body is Alien:
			body.attacked()
	if enemy_hit:
		succesful_attack_audio_emitter.play_next()

func _exit() -> void:
	animation_player.speed_scale = 1
	animation_player.animation_finished.disconnect(_go_idle.unbind(1))
	
func _go_idle():
	heroine.curr_punches -= 1
	if not heroine.curr_punches:
		dispatch(PlayerHSM.transition_sleepy)
	dispatch(PlayerHSM.transition_idle)
