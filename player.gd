extends CharacterBody2D

const SPEED = 200.0
var direction = Vector2.ZERO
var animated_sprite: AnimatedSprite2D
var is_attacking = false
var attack_timer: Timer
var attack_hitbox: Area2D  

func _ready() -> void:
	animated_sprite = $AnimatedSprite2D
	attack_hitbox = $AttackHitbox  
	attack_hitbox.set_deferred("monitoring", false)  

	attack_timer = Timer.new() 
	attack_timer.wait_time = 0.5  
	attack_timer.one_shot = true  
	attack_timer.connect("timeout", Callable(self, "_on_attack_animation_finished"))  
	add_child(attack_timer) 

func _process(delta: float) -> void:
	# Déplacement
	velocity = direction * SPEED
	move_and_slide()

	# Animation de marche
	if not is_attacking:
		if direction.length() > 0:
			play_movement_animation()
		else:
			if animated_sprite.animation != "idle":
				animated_sprite.stop()

func _input(event: InputEvent) -> void:
	# Gérer les mouvements du joueur
	direction.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	direction.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	direction = direction.normalized()

	# Détecter la touche Entrée pour déclencher l'animation d'attaque
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ENTER:
			print("Enter key pressed, triggering attack animation.")
			if direction.length() == 0:  # Si le personnage est statique
				animated_sprite.play("attack_walk_down")  # Joue l'animation d'attaque statique
				is_attacking = true
				attack_hitbox.set_deferred("monitoring", true)  # Active la détection de collision
				attack_timer.start()  # Démarre le timer pour la durée de l'animation
			else:
				play_attack_animation()  # Joue l'animation d'attaque dans la direction actuelle
		elif not event.pressed and event.keycode == KEY_ENTER:
			print("Enter key released, resuming movement animation.")
			# Relancer l'animation de déplacement si la direction est toujours valide
			if direction.length() > 0:
				play_movement_animation()

func play_attack_animation() -> void:
	if not is_attacking:
		is_attacking = true
		print("Playing attack animation.")

		# Joue l'animation d'attaque selon la direction actuelle
		if direction.x > 0:
			animated_sprite.play("attack_walk_right")  # Animation d'attaque vers la droite
		elif direction.x < 0:
			animated_sprite.play("attack_walk_left")  # Animation d'attaque vers la gauche
		elif direction.y < 0:
			animated_sprite.play("attack_walk_up")  # Animation d'attaque vers le haut
		elif direction.y > 0:
			animated_sprite.play("attack_walk_down")  # Animation d'attaque vers le bas

		attack_hitbox.set_deferred("monitoring", true)  # Active la détection de collision
		attack_timer.start()  # Démarre le timer pour la durée de l'animation

func _on_attack_animation_finished() -> void:
	is_attacking = false
	attack_hitbox.set_deferred("monitoring", false)  # Désactive la détection de collision
	print("Attack animation finished.")

func play_movement_animation() -> void:
	# Joue l'animation de mouvement selon la direction actuelle
	if direction.length() > 0:
		if direction.x > 0 and direction.y < 0:
			animated_sprite.play("walk_up")  # Animation marche haut droite
		elif direction.x > 0 and direction.y > 0:
			animated_sprite.play("walk_down")  # Animation marche bas droite
		elif direction.x < 0 and direction.y < 0:
			animated_sprite.play("walk_up")  # Animation marche haut gauche
		elif direction.x < 0 and direction.y > 0:
			animated_sprite.play("walk_down")  # Animation marche bas gauche
		elif direction.x > 0:
			animated_sprite.play("walk_right")  # Animation marche droite
		elif direction.x < 0:
			animated_sprite.play("walk_left")  # Animation marche gauche
		elif direction.y < 0:
			animated_sprite.play("walk_up")  # Animation marche haut
		elif direction.y > 0:
			animated_sprite.play("walk_down")  # Animation marche bas
