extends LimboHSM

@onready var idle: LimboState = $Idle
@onready var walk: LimboState = $Walk
@onready var sleep: LimboState = $Sleep

@export var yawn_audio: AudioStreamPlayer3D

func _enter() -> void:
	yawn_audio.play()

func _ready() -> void:
	add_transition(ANYSTATE, idle, PlayerHSM.transition_idle)
	add_transition(ANYSTATE, walk, PlayerHSM.transition_run) 
	add_transition(ANYSTATE, sleep, PlayerHSM.transition_sleep)
	add_transition(sleep, idle, PlayerHSM.wake_up_event)
	
	add_event_handler(PlayerHSM.wake_up_event, yawn_if_sleeping)
	
func yawn_if_sleeping():
	if get_active_state() == sleep:
		yawn_audio.play()
	return false
