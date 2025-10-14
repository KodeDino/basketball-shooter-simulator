extends Node2D

@export var next_level_scene: PackedScene
@export var enemy_score: int = 3
@export var current_level_number: int
@export var is_special_level: bool = false

@onready var hud: Control = $CanvasLayer/Hud
@onready var enemy_score_label: Label = $CanvasLayer/MarginContainer/EnemyScore
@onready var game_over: Control = $CanvasLayer/GameOver
@onready var basketball_spawn_spot: Marker2D = $BasketballSpawnSpot
@onready var margin_container: MarginContainer = $CanvasLayer/MarginContainer

const BASKETBALL = preload("res://Scenes/Basketball/Basketball.tscn")

var gadget: Gadget

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.reset()
	gadget = get_node("CanvasLayer/Gadget")
	hud.update_display()
	spawn_basketball()
	connect_signals()
	enemy_score_label.text = "Opponent Score %02d" % enemy_score


func connect_signals() -> void:
	SignalManager.on_basketball_removed.connect(_on_basketball_removed)
	SignalManager.on_main_menu_button_clicked.connect(load_main_menu)
	SignalManager.on_instruction_next_button_pressed.connect(_on_instruction_pressed)


func _on_instruction_pressed() -> void:
	hud.show()
	margin_container.show()
	

func _on_basketball_removed() -> void:
	spawn_basketball()


func spawn_basketball() -> void:
	if ScoreManager._chance > 0:
		var basketball = BASKETBALL.instantiate()
		basketball.position = basketball_spawn_spot.position
		add_child(basketball)
		ScoreManager.reduce_change()
		gadget.update_display()
	else:
		if ScoreManager._score > enemy_score:
			if is_special_level:
				ScoreManager.mark_special_level_won(current_level_number)
			save_level_and_proceed_scene()
		else:
			if !is_special_level:
				SignalManager.emit_on_game_over_show()
				game_over.show()
			else:
				save_level_and_proceed_scene()

			
func save_level_and_proceed_scene() -> void:
	if current_level_number:
		ScoreManager.complete_level(current_level_number)
	SceneManager.load_next_scene(next_level_scene)		


func load_main_menu() -> void:
	SceneManager.load_main_menu()
