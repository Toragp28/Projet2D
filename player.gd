extends CharacterBody2D


##################################### VARIABLE #############################################

#Variable Paramètre
@export var speed = 400

#Variable Onready

#Variable
var input_direction = Vector2(0, 0)

################################### FONCTION ##################################################


func get_input():
	input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if input_direction == Vector2(1, 0):
		$AnimatedSprite2D.play("move_right")
		
	elif input_direction == Vector2(-1, 0):
		$AnimatedSprite2D.play("move_left")
		
	elif input_direction == Vector2(0, 1):
		$AnimatedSprite2D.play("move_down")
		
	elif input_direction == Vector2(0, -1):
		$AnimatedSprite2D.play("move_up")

		
	
	
func _physics_process(delta):
	get_input()
	move_and_slide()
