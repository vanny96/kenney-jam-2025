extends Node3D

@export var target: Node 
@export var signal_name: String
@export var health_field: String
@export var max_health_field: String

@export var health_bar: TextureProgressBar
@export var healthy_color: Color
@export var bad_color: Color
@export var show_duration: float

var disappear_tween: Tween

func _ready() -> void:
	visible = false
	if target:
		var max_health := target.get(max_health_field) as int
		var curr_health := target.get(health_field) as int
		health_bar.max_value = max_health
		health_bar.value = curr_health
		target.connect(signal_name, show_health) 

func show_health():
	var health_value = target.get(health_field) as int
	health_bar.value = health_value
	health_bar.tint_progress = healthy_color if health_value > 3 else bad_color
	visible = true
	
	if disappear_tween:
		disappear_tween.kill()
	disappear_tween = create_tween()
	disappear_tween.tween_property(self, "visible", false, 0).set_delay(show_duration)
	

	
