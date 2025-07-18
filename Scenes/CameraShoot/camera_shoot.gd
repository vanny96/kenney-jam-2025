extends Node3D

@export var image_path: String

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		take_screenshot()

func take_screenshot():
	var img = get_viewport().get_texture().get_image()
	img.save_png("%s/%s.png" % [image_path, Time.get_unix_time_from_system()])
