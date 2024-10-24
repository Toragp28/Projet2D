extends Node2D

enum STATE {
	Idle,
	OPEN,
	OPENNED
}

var state = STATE.Idle
var player_is_area = false

var rarities_drop = {
	"common": 1000,
	"rare" : 300,
	"epic" : 100,
	"legendary" : 50
}

var color_for_rarity = {
	"common": Color(1, 1, 1, 0.2), # Blanc/gris avec transparence
	"rare": Color(0, 0, 1, 0.3), # Bleu avec transparence
	"epic": Color(0.5, 0, 0.5, 0.35), # Violet avec transparence
	"legendary": Color(1, 0.5, 0, 0.4) # Orange avec transparence
}



var all_item_lootable = {			#Plus le poids est haut moins l'item a de chance de drop
	"wood" : 10,
	"stone" : 40,
	"gold" : 100
}

var rng = RandomNumberGenerator.new()

func get_loot_by_weight():
	var total_weight = 0.0
	var cumulative_weight = {}
	

	for item in all_item_lootable:
		total_weight += 1.0 / float(all_item_lootable[item])
		cumulative_weight[item] = total_weight
	
	var loot_roll = rng.randf_range(0, total_weight) 
	
	for item in cumulative_weight:
		if loot_roll <= cumulative_weight[item]:
			return item


func get_rarity():
	rng.randomize()
	
	var weighted_sum = 0
	
	for n in rarities_drop:
		weighted_sum += rarities_drop[n]
		
	var item = rng.randi_range(0, weighted_sum)
	
	for n in rarities_drop:
		if item <= rarities_drop[n]:
			return n
		item -= rarities_drop[n]

func _ready() -> void:
	var rarity = get_rarity()
	$Aura.color = color_for_rarity[rarity]
	$Aura.energy = 4.14
	
	var rarity_loot = randf_range(10, 100)
	var rarity_multiplier = 1.0
	
	if rarity == "common":
		rarity_multiplier = 1.0
	elif rarity == "rare":
		rarity_multiplier = 1.5
	elif rarity == "epic":
		rarity_multiplier = 2.0
	elif rarity == "legendary":
		rarity_multiplier = 4.0
	
	var true_rarity_loot = rarity_loot * rarity_multiplier
	print(true_rarity_loot)
	
	var all_loot = []
	
	# On limite le nombre de tentatives de loot pour éviter trop de doublons rares
	for i in range(3): # Modifier cette valeur selon combien d'items max tu veux looter
		var item_loot = get_loot_by_weight()
		if item_loot and float(all_item_lootable[item_loot]) <= true_rarity_loot:
			# Vérifie si l'item n'est pas déjà présent trop de fois
			var max_occurrences = 1 if item_loot == "gold" else 2
			if all_loot.count(item_loot) < max_occurrences:
				all_loot.append(item_loot)
	if rarity == "legendary":
		all_loot.append("gold")
	
	print(all_loot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("sword_attack") and player_is_area == true and state == STATE.Idle:
		state = STATE.OPEN
		
		
		


	
	##################################"
	
	if state == STATE.Idle:
		$AnimatedSprite2D.play("idle")
	if state == STATE.OPEN:
		$AnimatedSprite2D.play("open")
	if state == STATE.OPENNED:
		$AnimatedSprite2D.play("opened")
		


func _on_zone_open_area_entered(area: Area2D) -> void:
	if area.has_node("box2"):
		player_is_area = true


func _on_zone_open_area_exited(area: Area2D) -> void:
	if area.has_node("box2"):
		player_is_area = false


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "open":
		state = STATE.OPENNED
		
