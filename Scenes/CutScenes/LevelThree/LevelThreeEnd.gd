extends "res://Scenes/CutScenes/Cutscene.gd"

@onready var background: Sprite2D = $Background
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var dialogue_paused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	SignalManager.on_dialogue_updated.connect(_check_for_animation)
	animation_player.animation_finished.connect(_on_animation_finished)


func _check_for_animation(_dialogue_data: Dictionary) -> void:
	if !dialogue_paused && DialogueManager.current_line_index == 3:
		canvas_layer.hide()
		dialogue_paused = true
		animation_player.play('background_animation')


func _on_animation_finished(animation_name: String) -> void:
	if animation_name == "background_animation":
		canvas_layer.show()
		DialogueManager.proceed_dialogue()
