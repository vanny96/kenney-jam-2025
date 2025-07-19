extends CanvasLayer

@export var player: Heroine

@export var punches: Label
@export var enemies: Label
@export var citiziens: Label

func _process(delta: float) -> void:
	update_labels()
	
func update_labels():
	if player:
		punches.text = "%s" % player.curr_punches
		enemies.text = "%s" % get_tree().get_nodes_in_group("alien").size()
		citiziens.text = "%s" % (get_tree().get_nodes_in_group("citizien").size() - 1)
