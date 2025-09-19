extends Node

const SAVE_PATH = "user://basketball_simulator.dat"

var _highest_unlocked_level: int = 1
var _score: int = 0
var _chance: int = 10


func _ready() -> void:
	load_progress()

func complete_level(level_number: int) -> void:
	if level_number >= _highest_unlocked_level:
		unlock_next_level()

func unlock_next_level() -> void:
	_highest_unlocked_level += 1
	save_progress()

func increment_score() -> void:
	_score += 1

func reduce_change() -> void:
	_chance -= 1

func reset() -> void:
	_score = 0
	_chance = 10


func save_progress() -> void:
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_32(_highest_unlocked_level)
		file.close()


func load_progress() -> void:
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		if file.get_length() > 0:
			_highest_unlocked_level = file.get_32()
		file.close()
	else:
		print("FAILED to load file.")
	
