extends Control

@export var master_audio_slider: Slider
@export var music_audio_slider: Slider
@export var sfx_audio_slider: Slider
@export var sensibility_slider: Slider
@export var close_button: Button

@onready var master_bus_idx: int = AudioServer.get_bus_index("Master")
@onready var music_bus_idx: int = AudioServer.get_bus_index("Music")
@onready var sfx_bus_idx: int = AudioServer.get_bus_index("SFX")

func _ready() -> void:
	_setup_audio(master_audio_slider, master_bus_idx)
	_setup_audio(music_audio_slider, music_bus_idx)
	_setup_audio(sfx_audio_slider, sfx_bus_idx)
	_setup_sensibility()
	_setup_close_button()

func _setup_audio(slider: Slider, bus_idx: int):
	slider.value = AudioServer.get_bus_volume_linear(bus_idx) * 100
	MenuAudio.configure_slider(slider)
	slider.value_changed.connect(func(value): 
		AudioServer.set_bus_volume_linear(bus_idx, value / 100)
	)
	
	
func _setup_sensibility():
	sensibility_slider.value = Globals.sensibility
	MenuAudio.configure_slider(sensibility_slider)
	master_audio_slider.value_changed.connect(func(value): Globals.sensibility = value)
	
func _setup_close_button():
	MenuAudio.configure_button(close_button)
	close_button.pressed.connect(func():
		visible = false
	)
