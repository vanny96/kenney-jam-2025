extends LimboState

@export var heroine: Heroine
@export var animation_player: AnimationPlayer
@export var collision_area: Area3D

func _enter() -> void:
	animation_player.play("heroine/punch")
	animation_player.speed_scale = 2
	animation_player.animation_finished.connect(_go_idle.unbind(1))
	damage_enemies()
	
func damage_enemies():
	for body in collision_area.get_overlapping_bodies():
		if body is Alien:
			body.attacked()

func _exit() -> void:
	animation_player.speed_scale = 1
	animation_player.animation_finished.disconnect(_go_idle.unbind(1))
	
func _go_idle():
	heroine.curr_punches -= 1
	if not heroine.curr_punches:
		dispatch(PlayerHSM.transition_sleepy)
	dispatch(PlayerHSM.transition_idle)
