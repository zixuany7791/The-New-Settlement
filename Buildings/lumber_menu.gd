extends Control


@onready var population_label = $VBoxContainer/MarginContainer/population
@onready var production_label = $VBoxContainer/MarginContainer2/production
@onready var assign_button = $Button
@onready var ui_panel = self

var assigned_workers := 0
var max_workers := 5
var wood_per_worker := 1

func _ready():
	hide()
	
	assign_button.pressed.connect(assign_worker)

func assign_worker():
	if assigned_workers < max_workers and ResourceManager.resources["population"] > 0:
		assigned_workers += 1
		ResourceManager.resources["population"] -= 1
		ResourceManager.add_production("wood", wood_per_worker)
		population_label.text = "Workforce Population: "  + str(assigned_workers) + "/" + str(max_workers)
		production_label.text = "Production rate: " + str(assigned_workers)+"/" + "s"
	else:
		print("No available population or max workers reached")

	
