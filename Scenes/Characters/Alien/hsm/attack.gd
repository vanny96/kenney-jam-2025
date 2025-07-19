extends LimboState

@export var animation_player: AnimationPlayer
@export var attack_area: Area3D

func _enter() -> void:
	animation_player.play("alien/attack")
	animation_player.animation_finished.connect(_go_run.unbind(1))
	attack()

func attack():
	for body in attack_area.get_overlapping_bodies():
		if body.is_in_group("citizien"):
			body.attacked()

func _exit() -> void:
	animation_player.animation_finished.disconnect(_go_run.unbind(1))
	
func _go_run():
	dispatch(AlienHSM.transition_run)
