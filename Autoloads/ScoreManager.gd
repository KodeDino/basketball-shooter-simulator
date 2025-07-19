extends Node


var _score: int = 0
var _chance: int = 10


func increment_score() -> void:
	_score += 1

func reduce_change() -> void:
	_chance -= 1

func reset() -> void:
	_score = 0
	_chance = 10
