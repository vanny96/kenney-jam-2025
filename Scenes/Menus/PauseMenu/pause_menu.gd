extends Control
class_name PauseMenu

@export var resume_button: Button
@export var restart_button: Button
@export var settings_button: Button
@export var controls_button: Button 
@export var exit_button: Button

@onready var settings_menu: Control = $Settings
@onready var controls_menu: Control = $Controls

func _ready() -> void:
	MenuAudio.configure_buttons([resume_button, settings_button, controls_button, exit_button])
	
	resume_button.pressed.connect(resume)
	restart_button.pressed.connect(restart)
	settings_button.pressed.connect(settings)
	controls_button.pressed.connect(controls)
	exit_button.pressed.connect(exit)
	
	if OS.has_feature("web"):
		resume_button.theme_type_variation = "Accent"
		exit_button.visible = false
		
	if not owner:
		enter_pause()
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if visible:
			resume()
		else:
			enter_pause()
		
func enter_pause():
	visible = true
	resume_button.grab_focus()
	get_tree().paused = true

func restart():
	resume()
	SceneManager.reload_current_scene()

func resume():
	visible = false
	settings_menu.visible = false
	get_tree().paused = false

func settings():
	settings_menu.visible = true

func controls():
	controls_menu.visible = true
	
func exit():
	get_tree().quit()
