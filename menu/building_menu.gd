extends Control

signal building_selected(building_scene)

var buildings = [
	{"name": "House", "cost": 50, "scene": preload("res://Buildings/building_block.tscn")},
]

var popup_menu : Popup  # Reference to the Popup node

func _ready():
	# Add buttons for each building in Popup menu
	var container = $Control/Panel/VBoxContainer
	for building in buildings:
		var btn = Button.new()
		btn.text = building["name"] + " ($" + str(building["cost"]) + ")"
		btn.connect("pressed", Callable(self, "_on_building_selected").bind(building))
		container.add_child(btn)

# Button click and emit the selected building
func _on_building_selected(building):
	print("Selected:", building["name"])
	emit_signal("building_selected", building["scene"])  # Send scene data to game world
	hide()  # close menu when a selection is made
