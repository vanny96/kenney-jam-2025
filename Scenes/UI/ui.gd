extends CanvasLayer

@export var player: Heroine

@export var punches: RichTextLabel
@export var enemies: RichTextLabel
@export var citiziens: RichTextLabel

@export var pause_button: TextureButton
@export var pause_menu: PauseMenu

func _process(delta: float) -> void:
	update_labels()
	pause_button.pressed.connect(pause_menu.enter_pause)
	
func update_labels():
	if player:
		punches.text = "%s" % player.curr_punches
		enemies.text = "%s" % get_tree().get_nodes_in_group("alien").size()
		citiziens.text = "%s" % (get_tree().get_nodes_in_group("citizien").size() - 1)
