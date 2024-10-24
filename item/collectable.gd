extends Node2D

# Inventory reference for the item
@export var speed: float = 200.0

# Flags and variables
var player_on_box = false
var target_position: Vector2
var pickable = true
var cooldown_time: float = 1.0  # Time before the player can pick up another item

# Called when the node is added to the scene
func _ready() -> void:
	pass

# Processing movement towards the box
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
				add_to_inventory()
				queue_free()

# Adding the item to the player's inventory
func add_to_inventory() -> void:
	var player_scene = get_tree().get_root().get_node("Level")
	var player_scene2 = player_scene.get_node("Player") 
	
	# Optionally update the player's resources
	player_scene2.ressource += 1
	pickable = false


# Reset pickable status after cooldown
func _on_cooldown_pickup_timeout() -> void:
	pickable = true

# Handling area collision with the box
func _on_area_2d_area_entered(area: Area2D) -> void:
	target_position = area.global_position
	if area.has_node("box"):
		player_on_box = true
