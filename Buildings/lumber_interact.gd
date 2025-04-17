extends Area2D

@export var interact_name: String = "LumberYard"
@export var is_interactable: bool = true
 
@onready var menu = $"../CanvasLayer/Lumber_menu"
func interact():
	menu.show()
	
func close_menu():
	menu.hide()
	
