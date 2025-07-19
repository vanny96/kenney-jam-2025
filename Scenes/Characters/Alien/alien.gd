extends CharacterBody3D
class_name Alien

@export var speed: float
@export var player_distance_bias: float

@onready var state_machine: LimboHSM = $LimboHSM

func _ready() -> void:
	GlobalSignals.player_died.connect(disable)

func attacked():
	queue_free()
	
func activate():
	state_machine.dispatch(AlienHSM.transition_run)
	
func disable():
	state_machine.dispatch(AlienHSM.transition_idle)
