extends Control

class_name Gadget

@onready var label: Label = $HBoxContainer/MarginContainer2/Label
@onready var texture_button: TextureButton = $HBoxContainer/MarginContainer/TextureButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_display()

func _on_texture_button_pressed() -> void:
	ScoreManager.use_gadget()
	update_display()

func update_display() -> void:
	label.text = "x%d" % ScoreManager._available_gadgets
	texture_button.disabled = ScoreManager._available_gadgets <= 0 || ScoreManager._gadget_active_this_shot
	visible = ScoreManager._available_gadgets > 0
