extends Node2D
@onready var canvas_layer: CanvasLayer = $CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_panel() -> void:
	var dialogue_data = load("res://Resources/LevelOneEndDialogue.tres")
	DialogueManager.start_dialogue(dialogue_data)
	canvas_layer.show()
