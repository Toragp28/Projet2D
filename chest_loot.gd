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

var all_item_lootable = {
	"wood" : 1,
	"stone" : 0.5,
	"gold" : 0.1
}

var rng = RandomNumberGenerator.new()

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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rarity = get_rarity()
	# Configurez la couleur de la lumière 2D
	$Aura.color = color_for_rarity[rarity]
	$Aura.energy = 4.14 # Ajustez l'énergie de la lumière
	print(rarity)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("sword_attack") and player_is_area == true and state == STATE.Idle:
		state = STATE.OPEN
		print(rng.randf_range(10, 220))


	
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
		
