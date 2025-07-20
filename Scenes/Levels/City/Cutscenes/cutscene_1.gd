extends Node

@export var heroine: Heroine
@export var camera: Camera3D
@export var ui: CanvasLayer

@onready var camera_position_1: Vector3 = camera.target.position - camera.target_offset
@export var camera_position_2: Vector3
@export var camera_pan_time: float

@export var soundtrack_audio_level: float = -25
@onready var soundtrack_initial_level: float = Soundtrack.volume_db

@onready var line_1: RichTextLabel = $Subtitles/Subtitles/Line
@onready var line_2: RichTextLabel = $Subtitles/Subtitles/Line2
@onready var line_3: RichTextLabel = $Subtitles/Subtitles/Line3
@onready var line_4: RichTextLabel = $Subtitles/Subtitles/Line4

func _ready() -> void:
	var tween = create_tween()
	tween.tween_callback(disable_entities)
	tween.tween_property(Soundtrack, "volume_db", soundtrack_audio_level, 0.5)
	tween.tween_subtween(play_heroine_initial())
	tween.tween_subtween(move_camera_to(camera_position_2))
	tween.tween_subtween(play_alien_scene())
	tween.tween_subtween(move_camera_to(camera_position_1))
	tween.tween_subtween(play_heroine_end())
	tween.tween_property(Soundtrack, "volume_db", soundtrack_initial_level, 1)
	tween.tween_callback(enable_entities)
	tween.tween_callback(queue_free)
	
func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_ENTER):
		enable_entities()
		queue_free()
	
func disable_entities():
	heroine.state_machine.dispatch(PlayerHSM.transition_disabled)
	camera.follow_target = false
	ui.visible = false
	
func enable_entities():
	heroine.state_machine.dispatch(PlayerHSM.transition_energetic)
	camera.follow_target = true
	ui.visible = true
	
func move_camera_to(position: Vector3):
	var tween = create_tween()
	(tween.tween_property(camera, "global_position", position, camera_pan_time)
	.set_ease(Tween.EASE_IN_OUT)
	.set_trans(Tween.TRANS_CUBIC))
	return tween
	
func play_alien_scene():
	var tween = create_tween()
	tween.tween_property(line_3, "visible", true, 0)
	tween.tween_callback($HelpScream2.play)
	tween.tween_callback($AlienNoises.play).set_delay(1)
	tween.tween_callback($AlienNoises2.play).set_delay(0.2)
	tween.tween_property(line_3, "visible", false, 0)
	return tween
	
func play_heroine_initial():
	var tween = create_tween()
	tween.tween_callback(heroine.state_machine.dispatch.bind(PlayerHSM.transition_sleep))
	tween.tween_callback(heroine.state_machine.dispatch.bind(PlayerHSM.transition_idle)).set_delay(2)
	tween.tween_property(line_1, "visible", true, 0)
	tween.tween_callback($HeroinLine1.play)
	tween.tween_property(line_1, "visible", false, 0).set_delay(1.5)
	tween.tween_property(line_2, "visible", true, 0)
	tween.tween_callback($HelpScream1.play)
	tween.tween_property(line_2, "visible", false, 0).set_delay(1)
	return tween 
	
func play_heroine_end():
	var tween = create_tween()
	tween.tween_property(line_4, "visible", true, 0)
	tween.tween_callback($HeroinLine2.play)
	tween.tween_property(line_4, "visible", false, 0).set_delay(1.5)
	return tween 
