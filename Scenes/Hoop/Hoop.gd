extends Node2D

@onready var net: Area2D = $Net
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var net_drag: float = 0.0
@onready var score_area: Area2D = $ScoreArea


var bodies_in_top_trigger: Array = []


func _physics_process(delta: float) -> void:
	for body in net.get_overlapping_bodies():
		if body is Basketball:
			body.linear_velocity *= net_drag


func _on_net_body_entered(body: Node2D) -> void:
	if body is Basketball:
		animated_sprite_2d.play("hoop")	


func _on_score_area_body_entered(body: Node2D) -> void:
	# If the ball enters the score area AND it's currently in the top trigger, it's a valid goal.
	if body is Basketball and bodies_in_top_trigger.has(body):
		ScoreManager.increment_score()
		SignalManager.emit_on_basketball_score()
		
		# Remove the ball from the list so it can't score again.
		bodies_in_top_trigger.erase(body)

			
func _on_hoop_trigger_area_body_entered(body: Node2D) -> void:
	if body is Basketball and not bodies_in_top_trigger.has(body):
		bodies_in_top_trigger.append(body)


func _on_hoop_trigger_area_body_exited(body: Node2D) -> void:
	if body is Basketball and bodies_in_top_trigger.has(body):
		bodies_in_top_trigger.erase(body)
