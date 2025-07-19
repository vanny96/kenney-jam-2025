extends LimboState

@export var animation_player: AnimationPlayer

func _enter() -> void:
	animation_player.play("alien/idle")
	
