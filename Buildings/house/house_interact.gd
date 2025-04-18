extends Area2D

@export var interact_name: String = "House"
@export var is_interactable: bool = true

#@onready var menu = $"../../../Popupmenu"



		

func interact():
	print("works")
func close_menu():
	print("we closing menu ong")
