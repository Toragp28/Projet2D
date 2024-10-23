extends Control

var isOpen: bool = false


@onready var slots: Array = $NinePatchRect/GridContainer.get_children()





func open():
	visible = true  # Changer à true pour afficher l'inventaire
	isOpen = true

func close():
	visible = false
	isOpen = false
