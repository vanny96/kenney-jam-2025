extends Control

@export var close_button: Button

func _ready() -> void:
	_setup_close_button()
	
func _setup_close_button():
	MenuAudio.configure_button(close_button)
	close_button.pressed.connect(func():
		visible = false
	)
