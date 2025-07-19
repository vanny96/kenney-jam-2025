extends CharacterBody3D
class_name Alien

@export var speed: float
@export var player_distance_bias: float

func attacked():
	queue_free()
