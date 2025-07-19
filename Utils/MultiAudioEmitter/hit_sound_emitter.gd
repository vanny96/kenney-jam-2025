extends AudioStreamPlayer3D
class_name MultiAudioEmitter

@export var audios: Array[AudioStream]

var curr_track: int = 0

func play_next():
	var next_track = audios[curr_track]
	curr_track = (curr_track + 1) % audios.size()
	stream = next_track
	play()
