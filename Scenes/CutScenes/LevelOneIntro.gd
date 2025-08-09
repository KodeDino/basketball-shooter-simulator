extends Node2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	SignalManager.on_dialogue_finished.connect(hide_panel)


func show_panel() -> void:
	audio_stream_player.stop()
	var dialogue_data = load("res://Resources/LevelOneIntroDialogue.tres")
	DialogueManager.start_dialogue(dialogue_data)
	canvas_layer.show()


func hide_panel() -> void:
	canvas_layer.hide()
