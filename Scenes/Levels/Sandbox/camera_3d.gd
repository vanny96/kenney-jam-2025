extends Camera3D

@export var target: Node3D

var offset: Vector3

func _ready():
	if target:
		offset = target.position - position

func _process(delta: float) -> void:
	if target:
		position = target.position - offset
