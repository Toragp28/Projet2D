extends Node2D

var player_entered = false
var broke = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if player_entered == true and Input.is_action_just_pressed("sword_attack"):
		$broke.start()
	if $AnimatedSprite2D.get('stade') != 5:
		$"cooldown reload".start()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.has_node("box"):
		player_entered = true


func _on_broke_timeout() -> void:
	$broke.paused


func _on_cooldown_reload_timeout() -> void:
	var current_stade = $AnimatedSprite2D.get("stade")
	$AnimatedSprite2D.set("stade", current_stade + 1)
