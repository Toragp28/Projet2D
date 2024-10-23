extends Node2D

enum STATE {
	Idle,
	OPEN,
	OPENNED
}

var state = STATE.Idle
var player_is_area = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("sword_attack") and player_is_area == true and state == STATE.Idle:
		state = STATE.OPEN
		print("sword")

	
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
