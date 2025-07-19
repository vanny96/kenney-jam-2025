extends LimboHSM
class_name AlienHSM

@onready var disabled: LimboState = $Disabled
@onready var idle: LimboState = $Idle
@onready var run: LimboState = $Run
@onready var attack: LimboState = $Attack

var active_state: LimboState

static var transition_idle = &"alien_transition_idle" 
static var transition_run = &"alien_transition_run"
static var transition_attack = &"alien_transition_attack"  

func _ready() -> void:
	add_transition(ANYSTATE, idle, transition_idle)
	add_transition(ANYSTATE, run, transition_run) 
	add_transition(ANYSTATE, attack, transition_attack)
	
	initialize(self)
	set_active(true)
	
	active_state = get_active_state()
	active_state_changed.connect(func(curr, prev):
		active_state = curr
	)
