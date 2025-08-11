extends Node2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.on_dialogue_finished.connect(hide_panel)


func show_panel() -> void:
	var dialogue_data = load("res://Resources/LevelOneEndDialogue.tres")
	DialogueManager.start_dialogue(dialogue_data)
	canvas_layer.show()

func hide_panel() -> void:
	canvas_layer.hide()
