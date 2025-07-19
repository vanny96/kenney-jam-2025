extends Camera3D

@export var target: Node3D
@export var offset: Vector3

func _process(delta: float) -> void:
	if target:
		position = target.position - offset
