extends Control

@onready var population_label = $VBoxContainer/MarginContainer/population
@onready var production_label = $VBoxContainer/MarginContainer2/production
@onready var assign_button = $Add
@onready var remove_button = $Remove
@onready var exit_button = $exit
@onready var interact_label = $"../../../Node2D/TileMapLayer/trunk/CharacterBody2D/Interaction Component/InteractLabel"
@onready var player = $"../../../Node2D/TileMapLayer/trunk/CharacterBody2D"
@onready var delete_button = $"MarginContainer/Delete"
@onready var error_label = $"VBoxContainer/MarginContainer3/Label"
var assigned_workers := 0
var max_workers := 5
var wood_per_worker := 1

func _ready():
	hide()
	assign_button.pressed.connect(assign_worker)
	remove_button.pressed.connect(remove_worker)
	exit_button.pressed.connect(exit_pressed)
	delete_button.pressed.connect(delete_pressed)

func assign_worker():
	if ResourceManager.resources["unemployed"] > 0:
		if assigned_workers < max_workers:
			assigned_workers += 1
			ResourceManager.resources["unemployed"] -= 1
			ResourceManager.add_production("wood", wood_per_worker)
			population_label.text = "Workforce Population: "  + str(assigned_workers) + "/" + str(max_workers)
			production_label.text = "Production rate: " + str(assigned_workers*wood_per_worker)+"/" + "s"
			error_label.text = ""
		else:
			error_label.text = "Maximum worker capacity reached."
	else:
		error_label.text = "There are no more available workers."

func remove_worker():
	if assigned_workers > 0:
		assigned_workers -= 1
		ResourceManager.resources["unemployed"] += 1
		ResourceManager.add_production("wood", -(wood_per_worker))
		population_label.text = "Workforce Population: "  + str(assigned_workers) + "/" + str(max_workers)
		production_label.text = "Production rate: " + str(assigned_workers*wood_per_worker)+"/" + "s"
		error_label.text = ""
	else:
		error_label.text = "There are no more workers left."

func disable_player_movement():
	player.set_interacting_state(true)
func enable_player_movement():
	player.set_interacting_state(false)

func exit_pressed():
	interact_label.show()
	enable_player_movement()

	hide()

func delete_pressed():
	ResourceManager.resources["unemployed"] += assigned_workers
	ResourceManager.add_production("wood", -(assigned_workers*wood_per_worker))
	if get_node("../../../Node2D/CanvasLayer/Popupmenu").placed_obstacles.has(get_node("../../../Node2D/CanvasLayer/Popupmenu").get_building_position(get_node("../..").position)):
		get_node("../../../Node2D/CanvasLayer/Popupmenu").placed_obstacles.erase(get_node("../../../Node2D/CanvasLayer/Popupmenu").get_building_position(get_node("../..").position))
	interact_label.show()
	enable_player_movement()
	get_node("../../").queue_free()
