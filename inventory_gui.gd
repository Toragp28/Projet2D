extends Control

var isOpen: bool = false

@onready var inventory: Inventory = preload("res://inventory/playerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

func _ready():
	inventory.updated.connect(update)
	update()

func update():
	for i in range(min(inventory.items.size(), slots.size())):
		slots[i].update(inventory.items[i])

func open():
	visible = true  # Changer à true pour afficher l'inventaire
	isOpen = true

func close():
	visible = false
	isOpen = false
