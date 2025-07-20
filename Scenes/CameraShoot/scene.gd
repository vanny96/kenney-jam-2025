extends Node3D

func _ready() -> void:
	$Heroine/AnimationPlayer.play("heroine/sleep")
	var alien_player: AnimationPlayer = $Alien/AnimationPlayer
	alien_player.play("alien/attack")
	alien_player.animation_finished.connect(alien_player.play.bind("alien/attack"))
