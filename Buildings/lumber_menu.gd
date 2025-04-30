extends Control


@onready var population_label = $VBoxContainer/MarginContainer/population
@onready var production_label = $VBoxContainer/MarginContainer2/production
@onready var assign_button = $Add
@onready var remove_button = $Remove
@onready var exit_button = $exit
@onready var interact_label = $"../../../Node2D/TileMapLayer/trunk/CharacterBody2D/Interaction Component/InteractLabel"
@onready var player = $"../../../Node2D/TileMapLayer/trunk/CharacterBody2D"
var assigned_workers := 0
var max_workers := 5
var wood_per_worker := 1

func _ready():
	hide()
	assign_button.pressed.connect(assign_worker)
	remove_button.pressed.connect(remove_worker)
	exit_button.pressed.connect(exit_pressed)

func assign_worker():
	if assigned_workers < max_workers and ResourceManager.resources["unemployed"] > 0:
		assigned_workers += 1
		ResourceManager.resources["unemployed"] -= 1
		ResourceManager.add_production("wood", wood_per_worker)
		population_label.text = "Workforce Population: "  + str(assigned_workers) + "/" + str(max_workers)
		production_label.text = "Production rate: " + str(assigned_workers)+"/" + "s"
	else:
		print("No available population or max workers reached")

func remove_worker():
	if assigned_workers > 0:
		assigned_workers -= 1
		ResourceManager.resources["unemployed"] += 1
		ResourceManager.add_production("wood", -(wood_per_worker))
		population_label.text = "Workforce Population: "  + str(assigned_workers) + "/" + str(max_workers)
		production_label.text = "Production rate: " + str(assigned_workers)+"/" + "s"
	else:
		print("No more workers")

func disable_player_movement():
	player.set_interacting_state(true)
func enable_player_movement():
	player.set_interacting_state(false)

func exit_pressed():
	interact_label.show()
	enable_player_movement()
	hide()
