extends Camera3D

@export var target: Node3D
@export var follow_target: bool = true

@export var initial_offset: Vector3
@onready var initial_rotation: Vector3 = rotation_degrees

@export var sleeping_offset: Vector3
@export var sleeping_rotation: Vector3

@export var transition_speed: float

@onready var target_offset = initial_offset
@onready var target_rotation = initial_rotation

var target_tween: Tween

func _ready() -> void:
	GlobalSignals.sleeping_started.connect(update_targets.bind(sleeping_offset, sleeping_rotation))
	GlobalSignals.sleeping_ended.connect(update_targets.bind(initial_offset, initial_rotation))


func _process(delta: float) -> void:
	if target and follow_target:
		position = target.position - target_offset
		rotation_degrees = target_rotation

func update_targets(p_offset: Vector3, p_rotation: Vector3):
	target_tween = create_tween()
	target_tween.parallel().tween_property(self, "target_offset", p_offset, transition_speed)
	target_tween.parallel().tween_property(self, "target_rotation", p_rotation, transition_speed)
	
