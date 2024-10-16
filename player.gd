extends CharacterBody2D

enum STATE {
	Idle,
	Move,
	Attack
}

var state = STATE.Idle

@export var speed = 220

var input_direction = Vector2.ZERO
var dir = Vector2.ZERO

func _ready() -> void:
	$AnimatedSprite2D.play("idle_down")

func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	
	if input_direction != Vector2.ZERO:
		dir = input_direction
		state = STATE.Move
	else:
		state = STATE.Idle

	if Input.is_action_just_pressed("sword_attack") and state != STATE.Attack:
		state = STATE.Attack

func animate():
	match state:
		STATE.Move:
			velocity = input_direction * speed
			move_and_slide()
			play_movement_animation()
			
		STATE.Attack:
			play_attack_animation()

func play_movement_animation():
	if dir == Vector2(1, 0):
		$AnimatedSprite2D.play("move_right")
	elif dir == Vector2(-1, 0):
		$AnimatedSprite2D.play("move_left")
	elif dir == Vector2(0, 1):
		$AnimatedSprite2D.play("move_down")
	elif dir == Vector2(0, -1):
		$AnimatedSprite2D.play("move_up")

func play_attack_animation():
	match dir:
		Vector2(0, 1):
			$AnimatedSprite2D.play("sword_attack_down")
		Vector2(0, -1):
			$AnimatedSprite2D.play("sword_attack_up")
		Vector2(1, 0):
			$AnimatedSprite2D.play("sword_attack_right")
		Vector2(-1, 0):
			$AnimatedSprite2D.play("sword_attack_left")
	
	state = STATE.Idle  # Reset state after attack animation is played

func _physics_process(delta):
	get_input()
	animate()

func _on_animated_sprite_2d_animation_finished() -> void:
	match $AnimatedSprite2D.animation:
		"sword_attack_down":
			$AnimatedSprite2D.play("idle_down")
		"sword_attack_up":
			$AnimatedSprite2D.play("idle_up")
		"sword_attack_right":
			$AnimatedSprite2D.play("idle_right")
		"sword_attack_left":
			$AnimatedSprite2D.play("idle_left")
