extends AnimatedSprite2D

@onready var script_ = get_node(".")
var stade = 5

func _ready() -> void:
	$".".play("stade 5")
	

func _physics_process(delta: float) -> void:

	$".".play("stade " + str(stade))

	


func _on_broke_timeout() -> void:
	stade -= 1
	

	



func _on_grow_cooldown_timeout() -> void:
	print("cool")
	stade += 1
