extends Control


@onready var score_label: Label = $MarginContainer/ScoreLabel


func _ready() -> void:
	update_score_label()
	SignalManager.on_basketball_score.connect(_on_basketball_score)


func _on_basketball_score() -> void:
	update_score_label()


func update_score_label() -> void:
	#score_label.text = str(ScoreManager._score)
	score_label.text = "%02d" % ScoreManager._score
