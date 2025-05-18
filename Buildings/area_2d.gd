extends Area2D

@export var interact_name: String = "Boat"
@export var is_interactable: bool = true

@onready var menu = $"CanvasLayer/Panel"
func interact():
	menu.show()
	menu.error_label.text = ""
func close_menu():
	menu.hide()
	
	
