extends Node2D

@export var return_to_menu_button: Button 

@onready var main_menu: PackedScene = preload("res://Scenes/Menus/MainMenu/MainMenu.tscn")

func _ready() -> void:
	MenuAudio.configure_button(return_to_menu_button)
	return_to_menu_button.pressed.connect(return_to_menu)
	
func return_to_menu():
	SceneManager.change_scene_to_packed(main_menu)
