extends AnimatedSprite2D

@onready var script_ = get_node(".")
var stade = 5

func _ready() -> void:
	$".".play("stade 5")
	

func _physics_process(delta: float) -> void:
	print(stade)
	$".".play("stade" + str(stade))


func _on_broke_timeout() -> void:
	stade -= 1
	
