extends Node

@onready var endgame_screen: PackedScene = preload("uid://brxsnokf23x7t")

func _process(delta: float) -> void:
	if get_tree().get_nodes_in_group("alien").is_empty():
		SceneManager.change_scene_to_packed(endgame_screen)
