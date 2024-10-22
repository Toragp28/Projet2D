extends Node2D

var player_entered = false
var broke = true
var growing = false
var is_farming_now = false
var wood_scene = preload("res://item/wood.tscn")
var cooldown_pickup_wood = load("res://item/wood.tscn")
var cobblestone_scene = preload("res://item/cobblestone.tscn")
var cooldown_pickup_cobble = load("res://item/cobblestone.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _item_spawn(item_name):
	if item_name == "wood":
		print("test")
		var wood_instance = wood_scene.instantiate()


		var home = get_node(".")
		home.add_child(wood_instance)
		wood_instance.position = Vector2(0, 0)
		var cooldown_timer = wood_instance.get_node("Cooldown_pickup")
		cooldown_timer.start()
	elif item_name == "cobble":

		var cobble_instance = cobblestone_scene.instantiate()
		var home = get_node(".")
		home.add_child(cobble_instance)
		cobble_instance.position = Vector2(0, 0)
		var cooldown_timer = cobble_instance.get_node("Cooldown_pickup")


	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_entered == true and Input.is_action_pressed("sword_attack") and is_farming_now == false and $AnimatedSprite2D.stade >=2:
		print("marche")
		$broke.start()
		is_farming_now = true
	if $AnimatedSprite2D.get("stade") != $AnimatedSprite2D.max_stade and growing == false:
		growing = true
		$grow_cooldown.start()
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_node("box2"):
		player_entered = true


func _on_broke_timeout() -> void:

	$broke.paused
	if $".".has_node("tree"):
		_item_spawn("wood")
	elif $".".has_node("stone"):
		_item_spawn("cobble")
	is_farming_now = false

func _on_grow_cooldown_timeout() -> void:
	growing = false


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.has_node("box2"):
		player_entered = false
