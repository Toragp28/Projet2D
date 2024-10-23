extends Node2D

# Inventory reference for the item
@export var itemRes: InventoryItem
@export var speed: float = 200.0

# Flags and variables
var player_on_box = false
var target_position: Vector2
var pickable = true

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
				# Désactiver le ramassage plutôt que de détruire l'objet
				make_non_pickable()

func add_to_inventory() -> void:
	var player_scene = get_tree().get_root().get_node("Level")
	var player_scene2 = player_scene.get_node("Player") 
	
	# Ajouter l'élément à l'inventaire du joueur
	if player_scene2.has_method("add_to_inventory"):
		player_scene2.add_to_inventory(itemRes)
	
	# Optionnel : mettre à jour les ressources du joueur
	player_scene2.ressource += 1
	
	# Assurez-vous que la mise à jour de l'inventaire se fait depuis le script de l'inventaire
	player_scene2.inventory.updated.emit()  # Émettre le signal depuis l'inventaire du joueur

	# Rendre l'objet non ramassable
	make_non_pickable()


func make_non_pickable() -> void:
	# Désactiver la collision pour cet objet
	$CollisionShape2D.disabled = true  # Assurez-vous que ce nœud existe dans la hiérarchie
	
	# Optionnel : cacher l'apparence visuelle
	$Sprite2D.visible = false  # Assurez-vous que le nœud Sprite2D existe aussi

	# L'objet n'est plus ramassable
	pickable = false


# Handling area collision with the box
func _on_area_2d_area_entered(area: Area2D) -> void:
	target_position = area.global_position
	if area.has_node("box"):
		player_on_box = true
