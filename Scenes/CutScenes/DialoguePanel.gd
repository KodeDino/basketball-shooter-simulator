extends Panel

@export var next_scene: PackedScene

@onready var name_label: RichTextLabel = $"../NamePanel/MarginContainer/NameLabel"
@onready var dialogue_label: RichTextLabel = $MarginContainer/DialogueLabel
@onready var button: Button = $MarginContainer/Button
@onready var portrait_rect: TextureRect = $"../PortraitRect"
@onready var opponent_marker: Marker2D = $"../OpponentMarker"
@onready var main_character_marker: Marker2D = $"../MainCharacterMarker"



func _ready() -> void:
	SignalManager.on_dialogue_updated.connect(set_text)

func set_text(dialogue_data: Dictionary) -> void:
	var current_character = dialogue_data['character']
	name_label.text = current_character
	dialogue_label.text = dialogue_data['line']
	if dialogue_data.has("texture"):
		if current_character != "科迪":
			portrait_rect.position = opponent_marker.position
		else:
			portrait_rect.position = main_character_marker.position
		portrait_rect.texture = dialogue_data["texture"]

func _on_button_pressed() -> void:
	DialogueManager.proceed_dialogue(next_scene)
