extends Control

@onready var master_audio_slider: Slider = $PanelContainer/VBoxContainer/GridContainer/MasterAudio/MasterAudio
@onready var sensibility_slider: Slider = $PanelContainer/VBoxContainer/GridContainer/Sensibility/Sensibility
@onready var close_button: Button = $PanelContainer/VBoxContainer/CloseButton

@onready var master_bus_idx: int = AudioServer.get_bus_index("Master")

func _ready() -> void:
	_setup_master_audio()
	_setup_sensibility()
	_setup_close_button()

func _setup_master_audio():
	master_audio_slider.value = AudioServer.get_bus_volume_linear(master_bus_idx) * 100
	master_audio_slider.value_changed.connect(func(value): 
		AudioServer.set_bus_volume_linear(master_bus_idx, value / 100)
	)
	
func _setup_sensibility():
	sensibility_slider.value = Globals.sensibility
	master_audio_slider.value_changed.connect(func(value): Globals.sensibility = value)
	
func _setup_close_button():
	close_button.pressed.connect(func():
		visible = false
	)
