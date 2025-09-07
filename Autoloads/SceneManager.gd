extends Node

const TRANSITION = preload("res://Scenes/UI/Transition/Transition.tscn")


var next_scene: PackedScene

func load_next_scene(newScene: PackedScene) -> void:
	next_scene = newScene
	var transition = TRANSITION.instantiate()
	add_child(transition)


func load_main_menu() -> void:
	load_next_scene(load("res://Scenes/UI/MainMenu/MainMenu.tscn"))

func load_level_one_intro() -> void:
	load_next_scene(load("res://Scenes/CutScenes/LevelOne/LevelOneIntro.tscn"))
