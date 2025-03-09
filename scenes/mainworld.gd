extends Node2D

var popup_menu_scene = preload("res://menu/popupmenu.tscn") 
var popup_menu : Control 
var player : Node2D 
var camera : Camera2D  

func _ready():
	popup_menu = popup_menu_scene.instantiate()
	add_child(popup_menu)
	popup_menu.hide() 
	player = get_node("CharacterBody2D")
	camera = get_node("Camera2D")

func _input(event):
	# Detect when the "m" key is pressed
	if Input.is_action_just_pressed("m"):
		toggle_menu()

func toggle_menu():
	if popup_menu.visible:
		popup_menu.hide()  # Hide the menu
	else:
		popup_menu.show()  # Show the menu
