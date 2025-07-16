extends Node2D

@onready var basketball_spawn_spot: Marker2D = $BasketballSpawnSpot
const BASKETBALL = preload("res://Scenes/Basketball/Basketball.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_basketball()
	SignalManager.on_basketball_removed.connect(_on_basketball_removed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_basketball_removed() -> void:
	spawn_basketball()


func spawn_basketball() -> void:
	if ScoreManager._chance > 0:
		var basketball = BASKETBALL.instantiate()
		basketball.position = basketball_spawn_spot.position
		add_child(basketball)
		ScoreManager.reduce_change()
