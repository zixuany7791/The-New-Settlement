extends Control

@onready var Population_Label: Label = $Population/MarginContainer2/Label
@onready var Wood_Label: Label = $Wood/MarginContainer2/Label
@onready var Money_Label: Label
@onready var button = $Button
@onready var menu = $"../../TileMapLayer/Popupmenu"
func _ready():
	button.pressed.connect(on_pressed)
func _process(delta):
	Population_Label.text = str(ResourceManager.resources["unemployed"])
	#Wood_Label.text = str(ResourceManager.resources["wood"])
	Wood_Label.text = str(
	$"../../TileMapLayer".local_to_map($"../../TileMapLayer".to_local($"../../TileMapLayer/MapCamera".get_screen_transform().affine_inverse() * get_viewport().get_mouse_position())
	))
func on_pressed():
	if menu.visible:
		menu.close_menu()
	else:
		menu.open_menu()
