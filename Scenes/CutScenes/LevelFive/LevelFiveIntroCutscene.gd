extends "res://Scenes/CutScenes/Cutscene.gd"

const STATUE_BG = preload("res://Assets/Background/Level_05/Background_05-3_Statue.png")
const FADE_DURATION = 0.3

@onready var background: Sprite2D = $Background
@onready var fade_rect: ColorRect = $FadeLayer/FadeRect
@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	super._ready()
	SignalManager.on_dialogue_updated.connect(_check_transition)


func _check_transition(_dialogue_data: Dictionary) -> void:
	if DialogueManager.current_line_index == 1:
		_do_background_transition()


func _do_background_transition() -> void:
	canvas_layer.hide()
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, FADE_DURATION)
	tween.tween_callback(func(): background.texture = STATUE_BG)
	tween.tween_property(fade_rect, "modulate:a", 0.0, FADE_DURATION)
	tween.tween_callback(_play_character_animation)


func _play_character_animation() -> void:
	anim_player.play("character_animation")
	await anim_player.animation_finished
	canvas_layer.show()
