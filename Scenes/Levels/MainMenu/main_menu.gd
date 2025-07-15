extends Control

@export var first_level: PackedScene

@export var play_button: Button 
@export var settings_button: Button 
@export var exit_button: Button 

@onready var buttons: Array[Button] = [play_button, settings_button, exit_button]

@onready var settings_menu: Control = $Settings

func _ready() -> void:
	play_button.pressed.connect(play)
	settings_button.pressed.connect(settings)
	exit_button.pressed.connect(exit)
	
	play_button.grab_focus()
	
	if OS.has_feature("web"):
		exit_button.visible = false
		
	Debugger.set_debug_info("First Level", first_level.resource_path if first_level else "Unset")
	
func play():
	if first_level:
		SceneManager.change_scene_to_packed(first_level)

func settings():
	settings_menu.visible = true
	
func exit():
	get_tree().quit()
