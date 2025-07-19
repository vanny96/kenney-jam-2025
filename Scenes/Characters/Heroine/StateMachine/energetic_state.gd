extends LimboHSM

@onready var idle: LimboState = $Idle
@onready var run: LimboState = $Run
@onready var attack: LimboState = $Attack
@onready var sleep: LimboState = $Sleep

@export var heroine: Heroine

func _ready() -> void:
	add_transition(ANYSTATE, idle, PlayerHSM.transition_idle)
	add_transition(ANYSTATE, run, PlayerHSM.transition_run) 
	add_transition(ANYSTATE, attack, PlayerHSM.transition_attack) 
	add_transition(ANYSTATE, sleep, PlayerHSM.transition_sleep)
	add_transition(sleep, idle, PlayerHSM.wake_up_event)
