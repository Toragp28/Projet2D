extends CharacterBody2D

const SPEED = 200.0
var direction = Vector2.ZERO
var animated_sprite: AnimatedSprite2D
var is_attacking = false
var attack_duration = 0.5  # Duration of the attack in seconds
var attack_time_left = 0.0  # Time left for the attack to finish
var attack_hitbox: Area2D  

func _ready() -> void:
	animated_sprite = $AnimatedSprite2D
	attack_hitbox = $AttackHitbox  
	attack_hitbox.set_deferred("monitoring", false)  # Initially disable the hitbox

func _process(delta: float) -> void:
	# If the player is attacking, count down the attack timer
	if is_attacking:
		attack_time_left -= delta
		if attack_time_left <= 0.0:
			_on_attack_animation_finished()

	# Movement
	if not is_attacking:
		velocity = direction * SPEED
		move_and_slide()

		# Walking animation
		if direction.length() > 0:
			play_movement_animation()
		else:
			if animated_sprite.animation != "idle":
				animated_sprite.stop()

func _input(event: InputEvent) -> void:
	# Handle player movement
	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	direction = direction.normalized()

	# Detect the Enter key for triggering the attack animation
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER and not is_attacking:
			print("Enter key pressed, triggering attack animation.")
			if direction.length() == 0:  # If the character is stationary
				animated_sprite.play("attack_walk_down")  # Play the standing attack animation
			else:
				play_attack_animation()

func play_attack_animation() -> void:
	if not is_attacking:
		is_attacking = true
		attack_time_left = attack_duration
		attack_hitbox.set_deferred("monitoring", true)  # Enable collision detection
		print("Playing attack animation.")

		# Play the attack animation based on the current direction
		if direction.x > 0:
			animated_sprite.play("attack_walk_right")
		elif direction.x < 0:
			animated_sprite.play("attack_walk_left")
		elif direction.y < 0:
			animated_sprite.play("attack_walk_up")
		elif direction.y > 0:
			animated_sprite.play("attack_walk_down")

func _on_attack_animation_finished() -> void:
	is_attacking = false
	attack_hitbox.set_deferred("monitoring", false)  # Disable collision detection
	print("Attack animation finished.")

func play_movement_animation() -> void:
	# Play movement animation based on the direction
	if direction.x > 0:
		animated_sprite.play("walk_right")
	elif direction.x < 0:
		animated_sprite.play("walk_left")
	elif direction.y < 0:
		animated_sprite.play("walk_up")
	elif direction.y > 0:
		animated_sprite.play("walk_down")
