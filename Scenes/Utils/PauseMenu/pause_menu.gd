extends Control
class_name PauseMenu

@onready var resume_button: Button = $PanelContainer/Buttons/Resume
@onready var settings_button: Button = $PanelContainer/Buttons/Settings
@onready var exit_button: Button = $PanelContainer/Buttons/Exit

@onready var settings_menu: Control = $Settings

func _ready() -> void:
	resume_button.pressed.connect(resume)
	settings_button.pressed.connect(settings)
	exit_button.pressed.connect(exit)
	
	if OS.has_feature("web"):
		exit_button.visible = false
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if visible:
			resume()
		else:
			enter_pause()
		
func enter_pause():
	visible = true
	get_tree().paused = true

func resume():
	visible = false
	settings_menu.visible = false
	get_tree().paused = false

func settings():
	settings_menu.visible = true
	
func exit():
	get_tree().quit()
