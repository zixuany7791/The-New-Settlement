extends Control

@onready var Population_Label: Label = $Population/MarginContainer2/Label
@onready var Wood_Label: Label = $Wood/MarginContainer2/Label
@onready var Worker_Label: Label = $Worker/MarginContainer2/Label
@onready var button = $Button
@onready var menu = $"../../TileMapLayer/Popupmenu"
func _ready():
	button.pressed.connect(on_pressed)
func _process(delta):
	Worker_Label.text = str(ResourceManager.resources["unemployed"])+ "/" + str(ResourceManager.resources["capacity"])
	Wood_Label.text = str(ResourceManager.resources["wood"])
	Population_Label.text = str(ResourceManager.resources["population"])+ "/" +str(ResourceManager.resources["capacity"])

	

func on_pressed():
	if menu.visible:
		menu.close_menu()
	else:	
		menu.open_menu()
		
