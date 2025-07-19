extends Node3D

@export var target: Node3D
@export var distance: float
@export var enabled: bool = true

@onready var aliens: Array[Alien] = _get_aliens()
@onready var coffee: Coffee = _get_coffee()
@onready var collision_shape: CollisionShape3D = $DebugView

@onready var aliens_count: int = aliens.size()
var aliens_killed: int = 0

func _ready() -> void:
	if not Engine.is_editor_hint():
		collision_shape.disabled = true


func _process(delta: float) -> void:
	if not enabled:
		return
		
	if Engine.is_editor_hint():
		var shape: CylinderShape3D = collision_shape.shape as CylinderShape3D
		shape.radius = distance
	else:
		var curr_distance = (target.position - position).length()
		if curr_distance < distance:
			activate_aliens()
		
func _get_aliens():
	var loc_aliens: Array[Alien] = []
	for child in get_children():
		if child is Alien:
			child.died.connect(aliend_died)
			loc_aliens.append(child)
	return loc_aliens
	
func _get_coffee() -> Coffee:
	for child in get_children():
		if child is Coffee:
			return child
	return null
	
func aliend_died():
	aliens_killed += 1
	if aliens_killed >= aliens_count and coffee:
		coffee.activate()
	
func activate_aliens():
	for alien in aliens:
		alien.activate()
	enabled = false
