extends AnimatedSprite2D

@onready var script_ = get_node(".")

var stade = 5
var max_stade = 5

func _ready() -> void:
	if $".".get_parent().get_node("Area2D").has_method("is_stone"):
		stade = 3
		max_stade = 3
		$".".play("stade 3")
	else:
		stade = 5
		max_stade = 5
		$".".play("stade 5")
	
func _physics_process(delta: float) -> void:

	$".".play("stade " + str(stade))

	


func _on_broke_timeout() -> void:

	stade -= 1
	

	



func _on_grow_cooldown_timeout() -> void:

	stade += 1
