extends StaticBody3D

signal attacked_signal

@export var max_health: int = 20
@onready var curr_health: int = max_health

func attacked():
	curr_health -= 1
	attacked_signal.emit()
	if not curr_health:
		queue_free()
