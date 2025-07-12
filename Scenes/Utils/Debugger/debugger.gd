extends Node
class_name Debugger

static var instance: Debugger

@onready var debug_info: Dictionary[String, Label]
@onready var deubg_info_panel: Container = $CanvasLayer/DebugInfo
@onready var debug_info_font: FontFile = preload("res://Scenes/Utils/Debugger/debugger-font.ttf")

func _ready() -> void:
	instance = self
	set_debug_info("Scene Name", get_tree().current_scene.name)
	if OS.is_debug_build():
		deubg_info_panel.visible = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reload_scene"):
		get_tree().reload_current_scene()

func set_debug_info(name: String, value: String):
	var label := debug_info.get(name, Label.new()) as Label
	label.text = "%-15s %s" % [name + ":", value]
	if not label.get_parent():
		label.add_theme_font_override("font", debug_info_font)
		deubg_info_panel.add_child(label)
