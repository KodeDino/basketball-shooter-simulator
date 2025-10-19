extends Node

const SAVE_PATH = "user://basketball_simulator.dat"

var _highest_unlocked_level: int = 1
var _score: int = 0
var _chance: int = 10
var _available_gadgets: int = 0
var _completed_special_levels: Array[int] = []
var _gadget_active_this_shot: bool = false

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
	reset_gadget_shot()

func save_progress() -> void:
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_32(_highest_unlocked_level)
		file.store_32(_available_gadgets)
		file.store_32(_completed_special_levels.size())
		for level in _completed_special_levels:
			file.store_32(level)
		file.close()

func load_progress() -> void:
	print(OS.get_data_dir())
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file:
		if file.get_length() > 0:
			_highest_unlocked_level = file.get_32()
			_available_gadgets = file.get_32()
			var special_levels_count = file.get_32()
			_completed_special_levels.clear()
			for item in range(special_levels_count):
				_completed_special_levels.append(file.get_32())
		file.close()
	else:
		print("FAILED to load file.")
	
func mark_special_level_won(level_number: int) -> void:
	if level_number in _completed_special_levels:
		return
		
	_completed_special_levels.append(level_number)
	
	match level_number:
		4:
			_available_gadgets += 1
		8:
			_available_gadgets += 2
		12:
			_available_gadgets += 3

	save_progress()
	
func use_gadget() -> void:
	if _available_gadgets > 0:
		_available_gadgets -= 1
		_gadget_active_this_shot = true
		save_progress()

func reset_gadget_shot() -> void:
	_gadget_active_this_shot = false
