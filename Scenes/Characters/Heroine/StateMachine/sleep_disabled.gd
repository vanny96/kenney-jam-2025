extends LimboState

@export var heroine: Heroine
@export var animation_player: AnimationPlayer
@export var sleeping_vfs: CPUParticles3D

var passed_time: float = 0

func _enter() -> void:
	animation_player.play("heroine/sleep")
	sleeping_vfs.emitting = true
	sleeping_vfs.color = Color.WHITE
	GlobalSignals.sleeping_started.emit()
	heroine.model.position.y = 0.5
	passed_time = 0

func _exit() -> void:
	heroine.model.position.y = 0
	sleeping_vfs.color = Color(Color.WHITE, 0)
	sleeping_vfs.emitting = false
	GlobalSignals.sleeping_ended.emit()
	
