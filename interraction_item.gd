extends Node2D

var player_entered = false
var broke = true
var growing = false
var is_farming_now = false
var woodscene = preload("res://wood.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _wood_spawn():
	var wood_instance = woodscene.instantiate()
	var home = get_node(".")
	home.add_child(wood_instance)
	wood_instance.position = Vector2(0, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_entered == true and Input.is_action_pressed("sword_attack") and is_farming_now == false:
		$broke.start()
		is_farming_now = true
	if $AnimatedSprite2D.get("stade") != 5 and growing == false:
		growing = true
		$grow_cooldown.start()
		


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_node("box"):
		player_entered = true


func _on_broke_timeout() -> void:
	is_farming_now = false
	$broke.paused
	_wood_spawn()


func _on_grow_cooldown_timeout() -> void:
	growing = false
