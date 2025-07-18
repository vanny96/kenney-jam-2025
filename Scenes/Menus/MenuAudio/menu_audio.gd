extends Node

@onready var hover_sound: AudioStreamPlayer = $HoverSound
@onready var click_sound: AudioStreamPlayer = $ClickSound
@onready var slider_sound: AudioStreamPlayer = $SliderSound

func configure_buttons(buttons: Array[Button]):
	for button in buttons:
		configure_button(button)

func configure_button(button: Button):
	button.mouse_entered.connect(hover_sound.play)
	button.button_down.connect(click_sound.play)

func configure_slider(slider: Slider):
	slider.value_changed.connect(slider_sound.play.unbind(1))
