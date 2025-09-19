extends Node2D

@export var next_level_scene: PackedScene
@export var enemy_score: int = 3
@export var current_level_number: int

@onready var hud: Control = $CanvasLayer/Hud
@onready var enemy_score_label: Label = $CanvasLayer/MarginContainer/EnemyScore
@onready var game_over: Control = $CanvasLayer/GameOver
@onready var basketball_spawn_spot: Marker2D = $BasketballSpawnSpot

const BASKETBALL = preload("res://Scenes/Basketball/Basketball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.reset()
	hud.update_display()
	spawn_basketball()
	connect_signals()
	enemy_score_label.text = "Opponent Score %02d" % enemy_score


func connect_signals() -> void:
	SignalManager.on_basketball_removed.connect(_on_basketball_removed)
	SignalManager.on_main_menu_button_clicked.connect(load_main_menu)


func _on_basketball_removed() -> void:
	spawn_basketball()


func spawn_basketball() -> void:
	if ScoreManager._chance > 0:
		var basketball = BASKETBALL.instantiate()
		basketball.position = basketball_spawn_spot.position
		add_child(basketball)
		ScoreManager.reduce_change()
	else:
		if ScoreManager._score > enemy_score:
			if current_level_number:
				print("DEBUG: level complete with current_level_number: ", current_level_number)
				ScoreManager.complete_level(current_level_number)
			else:
				#TODO remove later, temporary debug log
				print('DEBUG: no current_level_number exported value')
			SceneManager.load_next_scene(next_level_scene)
		else:
			game_over.show()
	

func load_main_menu() -> void:
	SceneManager.load_main_menu()
