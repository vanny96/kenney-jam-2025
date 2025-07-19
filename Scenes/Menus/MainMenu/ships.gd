extends Node2D

@export var move_speed := 100

var moving_nodes: Array[Sprite2D] = []

func _ready():
	for child in get_children():
		if child is Sprite2D:
			moving_nodes.append(child)

func _process(delta):
	var screen_size = get_window().content_scale_size
	for node in moving_nodes:
		node.position.x -= move_speed * delta
		var node_width = node.texture.get_width() / 2
		if node.position.x + node_width < 0:
			node.position.x = screen_size.x + node_width
