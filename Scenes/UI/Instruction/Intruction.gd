extends Control

@export var instruction: String

@onready var rich_text_label: RichTextLabel = $Panel/MarginContainer2/RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rich_text_label.text = "Instruction:\n[indent]" + instruction + "[/indent]"


func _on_texture_button_pressed() -> void:
	SignalManager.emit_on_instruction_next_button_pressed()
	hide()
