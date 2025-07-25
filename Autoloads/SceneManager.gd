extends Node

const LEVEL_ONE = preload("res://Scenes/Levels/LevelOne/LevelOne.tscn")
const MAIN_MENU = preload("res://Scenes/MainMenu/MainMenu.tscn")
const TRANSITION = preload("res://Scenes/Transition/Transition.tscn")

var next_scene: PackedScene

func load_next_scene(newScene: PackedScene) -> void:
	next_scene = newScene
	var transition = TRANSITION.instantiate()
	add_child(transition)


func load_main_menu() -> void:
	load_next_scene(MAIN_MENU)


func load_level_one() -> void:
	load_next_scene(LEVEL_ONE)
