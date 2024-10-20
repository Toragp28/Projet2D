extends Control

var isOpen: bool = false

func open():
	visible = true  # Changer à true pour afficher l'inventaire
	isOpen = true

func close():
	visible = false
	isOpen = false
