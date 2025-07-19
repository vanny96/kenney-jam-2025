extends StaticBody3D

@export var max_health: int = 20
@onready var curr_health: int = max_health

func attacked():
	curr_health -= 1
	print("Citizien health %s" % curr_health)
	if not curr_health:
		queue_free()
