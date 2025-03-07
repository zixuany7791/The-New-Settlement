extends Control

var buildings = [
	{"name": "House", "cost": 50},
	{"name": "Farm", "cost": 100},
	{"name": "Barracks", "cost": 200}
]

func _ready():
	var container = $Panel/VBoxContainer
	for building in buildings:
		var btn = Button.new()
		btn.text = building["name"] + " ($" + str(building["cost"]) + ")"
		btn.connect("pressed", Callable(self, "_on_building_selected").bind(building))
		container.add_child(btn)

func _on_building_selected(building):
	print("Selected:", building["name"])
	# Call a function to place the building in the game world
