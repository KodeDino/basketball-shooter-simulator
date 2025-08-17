extends Node2D

@export var dialogue_data: DialogueResource

@onready var canvas_layer: CanvasLayer = $CanvasLayer

var audio_stream_player: AudioStreamPlayer

func _ready() -> void:
	audio_stream_player = get_node_or_null("AudioStreamPlayer")
	SignalManager.on_dialogue_finished.connect(hide_panel)


func show_panel() -> void:
	if audio_stream_player && audio_stream_player.playing:
		audio_stream_player.stop()
	DialogueManager.start_dialogue(dialogue_data)
	canvas_layer.show()


func hide_panel() -> void:
	canvas_layer.hide()
