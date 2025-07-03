extends Control

@onready var score_label: Label = $MarginContainer/VBoxContainer/ScoreLabel
@onready var chance_label: Label = $MarginContainer/VBoxContainer/ChanceLabel



func _ready() -> void:
	update_score_label()
	update_change_label()
	SignalManager.on_basketball_score.connect(_on_basketball_score)
	SignalManager.on_basketball_removed.connect(_on_basketball_removed)


func _on_basketball_score() -> void:
	update_score_label()


func _on_basketball_removed() -> void:
	update_change_label()


func update_score_label() -> void:
	score_label.text = "Current Score %02d" % ScoreManager._score


func update_change_label() -> void:
	chance_label.text = "Remaining %02d" % ScoreManager._chance
	
