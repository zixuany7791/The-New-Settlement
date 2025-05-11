extends Area2D

@export var interact_name: String = "LumberYard"
@export var is_interactable: bool = true
 
@onready var menu = $"../CanvasLayer/Lumber_menu"
@onready var error_label = $"../CanvasLayer/Lumber_menu/VBoxContainer/MarginContainer3/Label"
func interact():
	error_label.text = ""
	menu.show()
	
func close_menu():
	menu.hide()
	
