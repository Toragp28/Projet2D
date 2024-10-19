extends Node2D

@export var speed: float = 200.0
var player_on_box = false
var target_position: Vector2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if player_on_box:
		var current_position: Vector2 = global_position
		var direction: Vector2 = (target_position - current_position).normalized()
		var movement: Vector2 = direction * speed * delta

		if current_position.distance_to(target_position) > movement.length():
			global_position += movement
		else:
			global_position = target_position
			queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	target_position = area.global_position
	if area.has_node("box"):
		player_on_box = true
