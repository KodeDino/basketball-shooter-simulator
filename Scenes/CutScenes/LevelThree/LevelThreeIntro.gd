extends "res://Scenes/CutScenes/Cutscene.gd"

@onready var background: Sprite2D = $Background

var switch_background: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	SignalManager.on_dialogue_updated.connect(_on_dialogue_updated)


func _on_dialogue_updated(_dialogue_data: Dictionary) -> void:
	if !switch_background && DialogueManager.current_line_index == 3:
		background.texture = preload("uid://iu10wdjktmi4")
		switch_background = true
