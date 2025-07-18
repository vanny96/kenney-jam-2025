extends Node

signal scene_changed(path: String)

func reload_current_scene():
	change_scene(get_tree().current_scene.scene_file_path)

func change_scene(scene_path: String):
	var new_scene = load(scene_path)
	change_scene_to_packed(new_scene)

func change_scene_to_packed(scene: PackedScene):
	var new_scene = scene.instantiate()
	_change_scene(new_scene)
	scene_changed.emit(scene.resource_path)

func _change_scene(scene: Node):
	var curr_scene = get_tree().current_scene
	get_tree().root.add_child(scene)
	get_tree().current_scene = scene
	get_tree().root.remove_child(curr_scene)
