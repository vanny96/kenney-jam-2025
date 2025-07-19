extends Node3D
class_name Coffee

@onready var model: Node3D = $Model
@onready var area: Area3D = $Area3D

@export var rotation_speed: float = 5

func _ready() -> void:
	visible = false
	area.body_entered.connect(_body_entered)

func _process(delta: float) -> void:
	model.rotate(Vector3.UP, rotation_speed * delta)
	
func activate():
	visible = true

func _body_entered(node: Node3D):
	if visible and node is Heroine:
		var heroine := node as Heroine
		heroine.drink_coffee()
		queue_free()
