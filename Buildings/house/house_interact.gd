extends Area2D

@export var interact_name: String = "House"
@export var is_interactable: bool = true

@onready var menu = $"../../../Popupmenu"
@onready var player_camera = get_node("../../CharacterBody2D/Camera2D")  # Player's camera
@onready var map_camera = get_node("../../../MapCamera")  # Map-view camera

func _ready():
	# Ensure the map camera is not active initially
	if map_camera:
		player_camera.make_current()  # Enable the player's camera
		
func switch_to_map_camera():
	if map_camera:
		map_camera.make_current()
func switch_to_player_camera():
	if map_camera:
		player_camera.make_current()
func interact():
	switch_to_map_camera()
	menu.show()
func close_menu():
	switch_to_player_camera()
	menu.hide()
	menu.cancel_building_placement()
