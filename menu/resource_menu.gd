extends Control

@onready var Population_Label: Label = $Population/MarginContainer2/Label
@onready var Wood_Label: Label = $Wood/MarginContainer2/Label
@onready var Worker_Label: Label = $Worker/MarginContainer2/Label
@onready var Currency_Label: Label = $Currency/MarginContainer2/Label
@onready var Food_Label: Label = $Food/MarginContainer2/Label
@onready var button = $Button
@onready var menu = $"../Popupmenu"
func _ready():
	button.pressed.connect(on_pressed)
func _process(delta):
	Worker_Label.text = str(ResourceManager.resources["unemployed"])+ "/" + str(ResourceManager.resources["population"])
	Wood_Label.text = str(ResourceManager.resources["wood"])
	Population_Label.text = str(ResourceManager.resources["population"])+ "/" +str(ResourceManager.resources["capacity"])
	Currency_Label.text = str(ResourceManager.resources["currency"])
	Food_Label.text = str(ResourceManager.resources["food"])
	

func on_pressed():
	if menu.visible:
		menu.close_menu()
	else:	
		menu.open_menu()
		


func _on_population_mouse_entered() -> void:
	Tooltip.AssignText("Population", "People that are in this city","This city currently have " + str(ResourceManager.resources["population"]) + " people")
	Tooltip.ItemPopup(Rect2i(Vector2i($"Population".global_position),Vector2i($"Population".size)))
func _on_population_mouse_exited() -> void:
	Tooltip.HidePopup()


func _on_worker_mouse_entered() -> void:
	Tooltip.AssignText("Worker", "People that are able to do labor","This city currently have " + str(ResourceManager.resources["unemployed"]) + " workers available out of " + str(ResourceManager.resources["population"]) + " workers")
	Tooltip.ItemPopup(Rect2i(Vector2i($"Worker".global_position),Vector2i($"Worker".size)))


func _on_worker_mouse_exited() -> void:
	Tooltip.HidePopup()


func _on_wood_mouse_entered() -> void:
	Tooltip.AssignText("Wood", "It can be used for buildings","This city currently have " + str(ResourceManager.resources["wood"]) + " wood")
	Tooltip.ItemPopup(Rect2i(Vector2i($"Wood".global_position),Vector2i($"Wood".size)))
	


func _on_wood_mouse_exited() -> void:
	Tooltip.HidePopup()


func _on_currency_mouse_entered() -> void:
	Tooltip.AssignText("Money", "This city currently have " + str(ResourceManager.resources["currency"]) + " money", "")
	Tooltip.ItemPopup(Rect2i(Vector2i($"Currency".global_position),Vector2i($"Currency".size)))
	

func _on_currency_mouse_exited() -> void:
	Tooltip.HidePopup()


func _on_food_mouse_entered() -> void:
	Tooltip.AssignText("Food", "This city currently have " + str(ResourceManager.resources["currency"]) + " food", "")
	Tooltip.ItemPopup(Rect2i(Vector2i($"Currency".global_position),Vector2i($"Currency".size)))


func _on_food_mouse_exited() -> void:
	Tooltip.HidePopup()
