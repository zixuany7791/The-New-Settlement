extends CharacterBody2D

@export var speed = 400

@onready var all_interactions = []

@onready var interactLabel = $"Interaction Component/InteractLabel"
const SPEED = 340.0
const JUMP_VELOCITY = 10000

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()


# Interaction Methods

func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interaction()
	
func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)

func update_interaction():
	if all_interactions:
		interactLabel.text = all_interactions[0].interact_label
	else:
		interactLabel.text = ""
