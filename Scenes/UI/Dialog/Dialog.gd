extends Control

@export var next_scene: PackedScene

@onready var name_label: RichTextLabel = $NamePanel/MarginContainer/NameLabel
@onready var dialogue_label: RichTextLabel = $DialoguePanel/MarginContainer/DialogueLabel
@onready var portrait_rect: TextureRect = $PortraitRect
@onready var opponent_marker: Marker2D = $OpponentMarker
@onready var main_character_marker: Marker2D = $MainCharacterMarker

var _anim_textures: Array = []
var _anim_index: int = 0
var _anim_timer: Timer


func _ready() -> void:
	SignalManager.on_dialogue_updated.connect(set_text)
	_anim_timer = Timer.new()
	_anim_timer.wait_time = 0.5
	add_child(_anim_timer)
	_anim_timer.timeout.connect(_on_anim_timer_timeout)


func set_text(dialogue_data: Dictionary) -> void:
	_anim_timer.stop()
	name_label.text = dialogue_data['character']
	dialogue_label.text = dialogue_data['line']
	if dialogue_data.has("textures"):
		_anim_textures = dialogue_data["textures"]
		_anim_index = 0
		_set_portrait_position(dialogue_data['character'])
		portrait_rect.texture = _anim_textures[0]
		_anim_timer.start()
	elif dialogue_data.has("texture"):
		_set_portrait_position(dialogue_data['character'])
		portrait_rect.texture = dialogue_data["texture"]


func _set_portrait_position(current_character: String) -> void:
	if current_character != "科迪":
		portrait_rect.position = opponent_marker.position
	else:
		portrait_rect.position = main_character_marker.position


func _on_anim_timer_timeout() -> void:
	_anim_index += 1
	if _anim_index >= _anim_textures.size():
		_anim_timer.stop()
		return
	portrait_rect.texture = _anim_textures[_anim_index]


func _on_button_pressed() -> void:
	DialogueManager.proceed_dialogue(next_scene)
