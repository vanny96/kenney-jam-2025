extends CharacterBody3D
class_name Heroine

@export var speed: float = 0
@export var walk_speed: float = 0
@export var sleep_time: float = 5
@export var max_punches: int = 5
var curr_punches: int = 5

@onready var model: Node3D = $characterSmall

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y = -9.8
	
