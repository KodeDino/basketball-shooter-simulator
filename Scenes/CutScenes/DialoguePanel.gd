extends Panel

@export var next_scene: PackedScene

@onready var name_label: RichTextLabel = $"../NamePanel/MarginContainer/NameLabel"
@onready var dialogue_label: RichTextLabel = $MarginContainer/DialogueLabel
@onready var button: Button = $MarginContainer/Button



func _ready() -> void:
	SignalManager.on_dialogue_updated.connect(set_text)

func set_text(dialogue_data: Dictionary) -> void:
	name_label.text = dialogue_data['character']
	dialogue_label.text = dialogue_data['line']

func _on_button_pressed() -> void:
	DialogueManager.proceed_dialogue(next_scene)
