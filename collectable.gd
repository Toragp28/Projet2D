extends Node2D

@export var speed: float = 200.0
var player_on_box = false
var target_position: Vector2
var pickable = true


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
			if pickable == true:
				global_position = target_position
				var player_scene = get_tree().get_root().get_node("Level")
				var player_scene2 = player_scene.get_node("Player") 
				player_scene2.ressource += 1  # Accès à la propriété 'ressource'
				queue_free()



func _on_area_2d_area_entered(area: Area2D) -> void:
	target_position = area.global_position
	if area.has_node("box"):
		player_on_box = true


func _on_cooldown_pickup_timeout() -> void:
	pickable = true
