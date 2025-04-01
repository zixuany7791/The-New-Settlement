extends Node2D
@onready var interact_label: Label = $InteractLabel
var popup_menu_scene = preload("res://menu/popupmenu.tscn") 
var popup_menu : Control 
# the array that stores the object that can be interact by the player
var current_interactions = [] 

var can_interact := true
@onready var player = get_parent()  # Assuming the interaction is a child of the player

@onready var player_camera = get_node("../Camera2D")  # Player's camera
@onready var map_camera = get_node("../../MapCamera")  # Map-view camera


func _ready():
	popup_menu = popup_menu_scene.instantiate()
	add_child(popup_menu)
	popup_menu.print_tree()
	popup_menu.hide() 
	interact_label.hide()

	# Ensure the map camera is not active initially
	if map_camera:
		player_camera.make_current()  # Enable the player's camera
	
func switch_to_map_camera():
	if map_camera:
		map_camera.make_current()
		print("Switched to MapCamera")

func switch_to_player_camera():
	if map_camera:
		player_camera.make_current()
		print("Switched to PlayerCamera")

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		interact_label.hide()
		if current_interactions: 
			toggle_menu_show()
			switch_to_map_camera()
	if event.is_action_pressed("escape") and can_interact:
		interact_label.show()
		if current_interactions:
			var menu_script = popup_menu as BuildingMenu
			menu_script.cancel_building_placement()
			toggle_menu_close()
			switch_to_player_camera()
			

func _process(_delta: float) -> void:
	if current_interactions and can_interact:
		# interact with the object that is closest to the player
		current_interactions.sort_custom(_sort_by_nearest)
		if current_interactions[0].is_interactable: 
			interact_label.text  = current_interactions[0].interact_name
			interact_label.show()
			
# See which interactable object is the nearest
func _sort_by_nearest(area1, area2):
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist

# When the player enters an interactable area, the object gets added into the array
func _on_interaction_area_area_entered(area: Area2D) -> void:
	current_interactions.push_back(area)

# When the player leaves an interactable area, the object gets deleted into the array
func _on_interaction_area_area_exited(area: Area2D) -> void:
	current_interactions.erase(area)
	if current_interactions.is_empty():
		interact_label.hide()

func toggle_menu_show():
	popup_menu.show()  # Show the menu
	player.set_interacting_state(true)
func toggle_menu_close():
	popup_menu.hide()  # Hide the menu
	player.set_interacting_state(false)
