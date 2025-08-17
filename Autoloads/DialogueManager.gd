extends Node


var current_dialogue: DialogueResource
var current_line_index: int = 0
const LEVEL_ONE = preload("res://Scenes/Levels/LevelOne/LevelOne.tscn")

func get_current_dialogue_data() -> Dictionary:
	return current_dialogue.dialogue_sequence[current_line_index]


func start_dialogue(dialogue_resource: DialogueResource) -> void:	
	print(dialogue_resource)
	current_dialogue = dialogue_resource
	current_line_index = 0
	SignalManager.emit_on_dialogue_updated(get_current_dialogue_data())

func proceed_dialogue(next_scene: PackedScene = null) -> void:
	current_line_index += 1
	if current_line_index < current_dialogue.dialogue_sequence.size():
		SignalManager.emit_on_dialogue_updated(get_current_dialogue_data())
	else:
		SignalManager.emit_on_dialogue_finished()
		SceneManager.load_next_scene(next_scene)
