extends LimboHSM

@onready var idle: LimboState = $Idle
@onready var sleep: LimboState = $Sleep

func _ready() -> void:
	add_transition(ANYSTATE, idle, PlayerHSM.transition_idle)
	add_transition(ANYSTATE, sleep, PlayerHSM.transition_sleep)
