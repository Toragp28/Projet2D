extends CharacterBody2D


##################################### VARIABLE #############################################

enum STATE {
	Idle,
	Move,
	Attack
	}

var state = STATE.Idle

#Variable Paramètre
@export var speed = 100



#Variable Onready

#Variable
var input_direction = Vector2(0, 0)
var dir = Vector2.ZERO

var ressource = 0
var number_of_gem = 10



################################### FONCTION ##################################################
func tree_cut():
	pass
func _ready() -> void:
	$AnimatedSprite2D.play("idle_down")


func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	
	

func animatation():
	velocity = input_direction * speed
	
	if input_direction == Vector2(1, 0):
		dir = input_direction
		$AnimatedSprite2D.play("move_right")
		
	elif input_direction == Vector2(-1, 0):
		dir = input_direction
		$AnimatedSprite2D.play("move_left")
		
	elif input_direction == Vector2(0, 1):
		dir = input_direction
		$AnimatedSprite2D.play("move_down")
		
	elif input_direction == Vector2(0, -1):
		dir = input_direction
		$AnimatedSprite2D.play("move_up")
		
	if Input.is_action_just_pressed("sword_attack"):

		if dir == Vector2(0, 1):
			$AnimatedSprite2D.play("sword_attack_down")
		if dir == Vector2(0, -1):
			$AnimatedSprite2D.play("sword_attack_up")
		if dir == Vector2(1, 0):
			$AnimatedSprite2D.play("sword_attack_right")
		if dir == Vector2(-1, 0):
			$AnimatedSprite2D.play("sword_attack_left")
			
	
			

		
	
	
func _physics_process(delta):

	$CanvasLayer/ressource.clear()
	$CanvasLayer/ressource.add_text(str(ressource))
	$gem/number.clear()
	$gem/number.add_text(str(number_of_gem))
	
	get_input()
	animatation()
	move_and_slide()
	


func _on_animated_sprite_2d_animation_finished() -> void:
	if $AnimatedSprite2D.animation == "sword_attack_down":
		$AnimatedSprite2D.play("idle_down")
	if $AnimatedSprite2D.animation == "sword_attack_up":
		$AnimatedSprite2D.play("idle_up")
	if $AnimatedSprite2D.animation == "sword_attack_right":
		$AnimatedSprite2D.play("idle_right")
	if $AnimatedSprite2D.animation == "sword_attack_left":
		$AnimatedSprite2D.play("idle_left")


func _on_inventory_gui_focus_entered() -> void:
	pass # Replace with function body.
