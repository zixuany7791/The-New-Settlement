extends Node2D
@onready var interact_label: Label = $InteractLabel

# the array that stores the object that can be interact by the player
var current_interactions = [] 
var can_interact := true

@onready var player = get_parent()  # Assuming the interaction is a child of the player


func _ready():

	interact_label.hide()

	
func disable_player_movement():
	player.set_interacting_state(true)
func enable_player_movement():
	player.set_interacting_state(false)
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		interact_label.hide()
		if current_interactions:
			disable_player_movement()
			current_interactions[0].interact()
	if event.is_action_pressed("escape") and can_interact:
		interact_label.show()
		if current_interactions:
			current_interactions[0].close_menu()
			enable_player_movement()
			

func _process(_delta: float) -> void:
	if current_interactions and can_interact:
		# interact with the object that is closest to the player
		current_interactions.sort_custom(_sort_by_nearest)
			
# See which interactable object is the nearest
func _sort_by_nearest(area1, area2):
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	return area1_dist < area2_dist

# When the player enters an interactable area, the object gets added into the array
func _on_interaction_area_area_entered(area: Area2D) -> void:
	current_interactions.push_back(area)
	if current_interactions[0].is_interactable: 
			interact_label.text  = "Press e to enter"
			interact_label.show()
	

# When the player leaves an interactable area, the object gets deleted into the array
func _on_interaction_area_area_exited(area: Area2D) -> void:
	current_interactions.erase(area)
	if current_interactions.is_empty():
		interact_label.hide()
