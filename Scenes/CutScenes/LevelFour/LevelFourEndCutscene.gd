extends "res://Scenes/CutScenes/Cutscene.gd"

const FADE_DURATION = 0.3

const TRANSITIONS: Dictionary = {
	6: preload("res://Assets/Background/Level_04/Background_04_Paris.png"),
	11: preload("res://Assets/Background/Level_04/Background_04_Inside Aircraft.png"),
}

@onready var background: Sprite2D = $Background
@onready var fade_rect: ColorRect = $FadeLayer/FadeRect


func _ready() -> void:
	super._ready()
	SignalManager.on_dialogue_updated.connect(_check_transition)
	show_panel()


func _check_transition(_dialogue_data: Dictionary) -> void:
	var idx = DialogueManager.current_line_index
	if TRANSITIONS.has(idx):
		_do_background_transition(TRANSITIONS[idx])


func _do_background_transition(new_bg: Texture2D) -> void:
	canvas_layer.hide()
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, FADE_DURATION)
	tween.tween_callback(func(): background.texture = new_bg)
	tween.tween_property(fade_rect, "modulate:a", 0.0, FADE_DURATION)
	tween.tween_callback(func(): canvas_layer.show())
