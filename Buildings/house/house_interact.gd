extends Area2D

@export var interact_name: String = "House"
@export var is_interactable: bool = true

# House function:

# People live in there, duh.
@onready var menu = $"../CanvasLayer/house_menu"
func interact():
	menu.show()
	
func close_menu():
	menu.hide()
