extends CanvasLayer

@onready var inventory = $InventoryGui

func _ready():
	inventory.close()
	print("L'inventaire est fermé au démarrage.")

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		if inventory.isOpen:  # Utiliser la variable de votre script d'inventaire
			inventory.close()
			print("L'inventaire a été fermé.")
		else:
			inventory.open()
			print("L'inventaire a été ouvert.")
