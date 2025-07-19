extends CharacterBody3D
class_name Alien

signal died

@export var speed: float
@export var player_distance_bias: float

@onready var state_machine: LimboHSM = $LimboHSM
@onready var death_sound_player: AudioStreamPlayer3D = $DeathPlayer
@onready var death_particles: CPUParticles3D = $DeathParticles
@onready var model: Node3D = $characterSmall

func attacked():
	died.emit()
	model.visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	death_particles.emitting = true
	death_sound_player.play()
	death_particles.finished.connect(queue_free)
	#queue_free()
	
func activate():
	state_machine.dispatch(AlienHSM.transition_run)
	
func disable():
	state_machine.dispatch(AlienHSM.transition_idle)
