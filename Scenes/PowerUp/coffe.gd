extends Node3D
class_name Coffee

@onready var model: Node3D = $Model
@onready var area: Area3D = $Area3D
@onready var pick_up_sound: AudioStreamPlayer3D = $PickUpSound
@onready var active_sound: AudioStreamPlayer3D = $ActivaeSound

@export var rotation_speed: float = 5

func _ready() -> void:
	visible = false
	area.body_entered.connect(_body_entered)

func _process(delta: float) -> void:
	model.rotate(Vector3.UP, rotation_speed * delta)
	
func activate():
	visible = true
	active_sound.play()
	await active_sound.finished
	active_sound.play()

func _body_entered(node: Node3D):
	if visible and node is Heroine:
		var heroine := node as Heroine
		heroine.drink_coffee()
		pick_up_sound.play()
		pick_up_sound.finished.connect(queue_free)
		visible = false
		var disable_process_mode = func():
			process_mode = Node.PROCESS_MODE_DISABLED
		disable_process_mode.call_deferred()
