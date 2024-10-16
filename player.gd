extends CharacterBody2D


##################################### VARIABLE #############################################

#Variable Paramètre
@export var speed = 400

#Variable Onready

#Variable
var input_direction = Vector2(0, 0)

################################### FONCTION ##################################################


func get_input():
	input_direction = Input.get_vector("m_left", "m_right", "m_up", "m_down")
	velocity = input_direction * speed
	
func _physics_process(delta):
	get_input()
	move_and_slide()
