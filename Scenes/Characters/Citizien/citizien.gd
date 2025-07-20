extends StaticBody3D
class_name Citizien

signal attacked_signal

@export var max_health: int = 20
@export var help_scream_frequency: float = 12
@export var help_scream_max_initial_wait: float = 6

@onready var curr_health: int = max_health
@onready var help_sound_emitter: MultiAudioEmitter = $MultiSoundEmitter

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var death_sound_emitter: AudioStreamPlayer3D = $DeathSound

var help_scream_tween: Tween

func _ready() -> void:
	animation_player.play("citizien/terrified")

func attacked():
	curr_health -= 1
	attacked_signal.emit()
	if not curr_health:
		help_scream_tween.kill()
		death_sound_emitter.play()
		animation_player.play("citizien/death")
		await animation_player.animation_finished 
		queue_free()
		
func activate():
	start_screaming()
	
func disable():
	if help_scream_tween:
		help_scream_tween.kill()

func start_screaming():
	var sub_tween = create_tween().set_loops(-1)
	sub_tween.tween_callback(help_sound_emitter.play_next)
	sub_tween.tween_interval(help_scream_frequency)
	
	var initial_wait = randf() * help_scream_max_initial_wait
	help_scream_tween = create_tween()
	help_scream_tween.tween_interval(initial_wait)
	help_scream_tween.tween_subtween(sub_tween)
