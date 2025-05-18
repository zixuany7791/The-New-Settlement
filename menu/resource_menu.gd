extends Control

@onready var Population_Label: Label = $Population/MarginContainer2/Label
@onready var Wood_Label: Label = $Wood/MarginContainer2/Label
@onready var Worker_Label: Label = $Worker/MarginContainer2/Label
@onready var Currency_Label: Label = $Currency/MarginContainer2/Label
@onready var button = $Button
@onready var menu = $"../Popupmenu"
func _ready():
	button.pressed.connect(on_pressed)
func _process(delta):
	Worker_Label.text = str(ResourceManager.resources["unemployed"])+ "/" + str(ResourceManager.resources["population"])
	Wood_Label.text = str(ResourceManager.resources["wood"])
	Population_Label.text = str(ResourceManager.resources["population"])+ "/" +str(ResourceManager.resources["capacity"])
	Currency_Label.text = str(ResourceManager.resources["currency"])
	

func on_pressed():
	if menu.visible:
		menu.close_menu()
	else:	
		menu.open_menu()
		


func _on_population_mouse_entered() -> void:
	Tooltip.ItemPopup(Rect2i(Vector2i($"Population".global_position),Vector2i($"Population".size)))
	Tooltip.AssignText("Population", "This city currently have " + str(ResourceManager.resources["population"]) + " people", "")
func _on_population_mouse_exited() -> void:
	Tooltip.HidePopup()


func _on_worker_mouse_entered() -> void:
	Tooltip.ItemPopup(Rect2i(Vector2i($"Worker".global_position),Vector2i($"Worker".size)))
	Tooltip.AssignText("Worker", "This city currently have " + str(ResourceManager.resources["unemployed"]) + " workers available out of " + str(ResourceManager.resources["capacity"]) + " workers", "")


func _on_worker_mouse_exited() -> void:
	Tooltip.HidePopup()


func _on_wood_mouse_entered() -> void:
	Tooltip.ItemPopup(Rect2i(Vector2i($"Wood".global_position),Vector2i($"Wood".size)))
	Tooltip.AssignText("Wood", "This city currently have " + str(ResourceManager.resources["wood"]) + " wood", "")


func _on_wood_mouse_exited() -> void:
	Tooltip.HidePopup()


func _on_currency_mouse_entered() -> void:
	Tooltip.ItemPopup(Rect2i(Vector2i($"Currency".global_position),Vector2i($"Currency".size)))
	Tooltip.AssignText("Money", "This city currently have " + str(ResourceManager.resources["currency"]) + " money", "")

func _on_currency_mouse_exited() -> void:
	Tooltip.HidePopup()
