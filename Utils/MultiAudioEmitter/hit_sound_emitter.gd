extends AudioStreamPlayer3D
class_name MultiAudioEmitter

@export var audios: Array[AudioStream]
@export var randomize: bool

var curr_track: int = 0

func _ready() -> void:
	if randomize:
		audios.shuffle()

func play_next():
	var next_track = audios[curr_track]
	curr_track = (curr_track + 1) % audios.size()
	stream = next_track
	play()
