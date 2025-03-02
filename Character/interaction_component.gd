extends Node2D
@onready var interact_label: Label = $InteractLabel
var current_interactions = []
var can_interact := true
 
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if current_interactions:
			can_interact = false
			interact_label.hide()

func _process(_delta: float) -> void:
	if current_interactions and can_interact:
		current_interactions.sort_custom(_sort_by_nearest)
		if current_interactions[0].is_interactable: 
			interact_label.text  = current_interactions[0].interact_name
			interact_label.show()
		
func _sort_by_nearest(area1, area2):
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area1.global_position)
	return area1_dist < area2_dist
func _on_interaction_area_area_entered(area: Area2D) -> void:
	current_interactions.push_back(area)


func _on_interaction_area_area_exited(area: Area2D) -> void:
	current_interactions.erase(area)
