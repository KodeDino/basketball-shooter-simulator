extends Node2D

@export var next_level_scene: PackedScene
@export var enemy_score: int = 3
@onready var hud: Control = $CanvasLayer/Hud
@onready var enemy_score_label: Label = $CanvasLayer/MarginContainer/EnemyScore


@onready var basketball_spawn_spot: Marker2D = $BasketballSpawnSpot
const BASKETBALL = preload("res://Scenes/Basketball/Basketball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ScoreManager.reset()
	hud.update_display()
	spawn_basketball()
	SignalManager.on_basketball_removed.connect(_on_basketball_removed)
	enemy_score_label.text = "Opponent Score %02d" % enemy_score


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
			# TODO show button to next level scene
			SceneManager.load_next_scene(next_level_scene)
			
