extends CharacterBody3D
class_name Heroine

signal attacked_signal

@export var speed: float = 0
@export var sprint_speed: float = 0
@export var walk_speed: float = 0
@export var sleep_time: float = 5
@export var spawn_point: Node3D

@export var max_punches: int = 5
@onready var curr_punches: int = max_punches

@export var max_health: int
@onready var curr_health: int = max_health

@onready var model: Node3D = $characterSmall
@onready var state_machine: LimboHSM = $LimboHSM
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = -9.8
	
func attacked():
	curr_health -= 1
	state_machine.dispatch(PlayerHSM.wake_up_event)
	attacked_signal.emit()
	if not curr_health:
		global_position = spawn_point.global_position
		curr_health = max_health
		GlobalSignals.player_died.emit()

func drink_coffee():
	max_punches += 1
	curr_punches += 1
	speed *= 1.2
	sprint_speed *= 1.2
	state_machine.dispatch(PlayerHSM.transition_energetic)
