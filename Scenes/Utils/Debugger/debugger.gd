extends Node

@onready var debug_info: Dictionary[String, Label] = {}
@onready var debug_info_panel: Container = $CanvasLayer/DebugInfo
@onready var debug_info_font: FontFile = preload("res://Scenes/Utils/Debugger/debugger-font.ttf")

func _ready() -> void:
	_setup_debug_info()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reload_scene"):
		SceneManager.reload_current_scene()

func _setup_debug_info() -> void:
	if OS.is_debug_build():
		_load_debug_base_info()
		SceneManager.scene_changed.connect(reset_debug_info.unbind(1))
		debug_info_panel.visible = true

func reset_debug_info() -> void:
	for label in debug_info.values():
		label.queue_free()
	debug_info.clear()
	_load_debug_base_info()

func _load_debug_base_info() -> void:
	set_debug_info("Scene Name", get_tree().current_scene.scene_file_path)

func set_debug_info(name: String, value: String) -> void:
	await Engine.get_main_loop().process_frame
	var label: Label = debug_info.get(name, Label.new())
	label.text = "%-15s %s" % [name + ":", value]
	
	if not label.get_parent():
		label.add_theme_font_override("font", debug_info_font)
		debug_info_panel.add_child(label)
		debug_info[name] = label
