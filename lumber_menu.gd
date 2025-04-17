extends Control

@onready var interaction_component = get_node("../../../Node2D/TileMapLayer/trunk/CharacterBody2D/Interaction Component")
@onready var population_label = $Label
@onready var assign_button = $Button
@onready var ui_panel = self

var assigned_workers := 0
var max_workers := 5
var wood_per_worker := 1

func _ready():
	hide()
	interaction_component.connect("lumber_interacted", Callable(self, "_on_interact"))
	
	interaction_component.connect("escape_pressed", Callable(self, "_on_escape_pressed"))
	assign_button.pressed.connect(assign_worker)

func assign_worker():
	if assigned_workers < max_workers and ResourceManager.resources["population"] > 0:
		assigned_workers += 1
		ResourceManager.resources["population"] -= 1
		ResourceManager.add_production("wood", wood_per_worker)
		population_label.text = "Workforce Population: "  + str(assigned_workers) + "/" + str(max_workers)
	else:
		print("No available population or max workers reached")

func _on_interact():
	UIManager.open_lumberyard_ui(ui_panel)
	
func _on_escape_pressed():
	hide()
