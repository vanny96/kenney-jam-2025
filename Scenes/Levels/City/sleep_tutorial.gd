extends Node

@export var heroine: Heroine

func _process(delta: float) -> void:
	if heroine.state_machine.get_active_state().name == "Sleepy":
		show_tutorial()

func show_tutorial():
	$Tutorial.visible = true
	await GlobalSignals.sleeping_started
	queue_free()
