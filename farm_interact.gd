extends Area2D

@export var interact_name: String = "Farm"
@export var is_interactable: bool = true

@onready var menu = $"../CanvasLayer/farm_menu"
@onready var error_label = $"../CanvasLayer/farm_menu/VBoxContainer/MarginContainer3/Label"
func interact():
	error_label.text = ""
	menu.show()
	
func close_menu():
	menu.hide()
