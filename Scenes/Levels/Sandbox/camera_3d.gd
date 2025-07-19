extends Camera3D

@export var target: Node3D

@onready var offset := target.position - position

func _process(delta: float) -> void:
	if target:
		position = target.position - offset
