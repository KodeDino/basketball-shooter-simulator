extends Node

signal on_basketball_score
signal on_basketball_removed

func emit_on_basketball_score() -> void:
	on_basketball_score.emit()

func emit_on_basketball_removed() -> void:
	on_basketball_removed.emit()
