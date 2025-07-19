extends LimboHSM

@onready var idle: LimboState = $Idle
@onready var walk: LimboState = $Walk
@onready var sleep: LimboState = $Sleep

@export var heroine: Heroine

func _ready() -> void:
	add_transition(ANYSTATE, idle, PlayerHSM.transition_idle)
	add_transition(ANYSTATE, walk, PlayerHSM.transition_run) 
	add_transition(ANYSTATE, sleep, PlayerHSM.transition_sleep)
	add_transition(sleep, idle, PlayerHSM.wake_up_event)
