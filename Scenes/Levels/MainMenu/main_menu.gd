extends Control

@export var first_level: PackedScene

@onready var play_button: Button = $Buttons/Play
@onready var settings_button: Button = $Buttons/Settings
@onready var exit_button: Button = $Buttons/Exit

@onready var settings_menu: Control = $Settings

func _ready() -> void:
	play_button.pressed.connect(play)
	settings_button.pressed.connect(settings)
	exit_button.pressed.connect(exit)
	
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
