extends Node3D

@export var time_before_sleep: float
@export var heroine_animation_player: AnimationPlayer
@export var heroine_animation_player_2: AnimationPlayer
@export var heroine_sleep_vfx: CPUParticles3D
@export var heroine_sleep_position: Node3D
@export var heroine: Node3D

@export var scrolling_screen: VBoxContainer
@export var scrolling_screen_time: float
@export var scrolling_screen_wait: float

const main_menu_path = "res://Scenes/Menus/MainMenu/MainMenu.tscn"


func _ready() -> void:
	heroine_animation()
	scroll_screen()


func heroine_animation():
	await get_tree().create_timer(time_before_sleep).timeout
	heroine_animation_player_2.stop()
	heroine_animation_player.play("heroine/sleep")
	heroine.global_position = heroine_sleep_position.global_position
	heroine.global_rotation = heroine_sleep_position.global_rotation
	heroine_sleep_vfx.emitting = true
	
func scroll_screen():
	var screen_size = get_window().content_scale_size
	scrolling_screen.position.y = screen_size.y * 1.2
	var tween = create_tween()
	tween.tween_property(scrolling_screen, "position:y", (screen_size.y/-2), scrolling_screen_time)
	tween.tween_interval(scrolling_screen_wait)
	await tween.finished
	SceneManager.change_scene(main_menu_path)
