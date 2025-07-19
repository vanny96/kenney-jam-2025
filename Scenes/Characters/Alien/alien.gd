extends CharacterBody3D
class_name Alien

signal died

@export var speed: float
@export var player_distance_bias: float

@onready var state_machine: LimboHSM = $LimboHSM
@onready var death_sound_player: AudioStreamPlayer3D = $DeathPlayer

func _ready() -> void:
	GlobalSignals.player_died.connect(disable)

func attacked():
	died.emit()
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	death_sound_player.play()
	death_sound_player.finished.connect(queue_free)
	#queue_free()
	
func activate():
	state_machine.dispatch(AlienHSM.transition_run)
	
func disable():
	state_machine.dispatch(AlienHSM.transition_idle)
