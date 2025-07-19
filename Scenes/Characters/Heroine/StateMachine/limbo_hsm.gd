extends LimboHSM
class_name PlayerHSM

@onready var energetic: LimboState = $Energetic
@onready var sleepy: LimboState = $Sleepy

static var transition_idle = &"transition_idle" 
static var transition_run = &"transition_run"
static var transition_attack = &"transition_attack"  
static var transition_sleep = &"transition_sleep"  

static var transition_energetic = &"transition_energetic"
static var transition_sleepy = &"transition_sleepy"

func _ready() -> void:
	add_transition(ANYSTATE, energetic, transition_energetic)
	add_transition(ANYSTATE, sleepy, transition_sleepy) 
	
	initialize(self)
	set_active(true)
