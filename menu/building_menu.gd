extends Control

# Signal emitted when a building is selected
signal building_selected(building_scene)


# List of available buildings
var buildings = [
	{"name": "House", "cost": 50, "scene": preload("res://Buildings/building_block.tscn")},
]

# Reference to the PopupMenu node
var popup_menu : Popup

# Variables for building placement
var can_place_building := false
var selected_building_scene : PackedScene

func _ready():
	# Add buttons for each building in the Popup menu
	var container = $Control/Panel/VBoxContainer
	for building in buildings:
		var btn = Button.new()
		btn.text = building["name"] + " ($" + str(building["cost"]) + ")"
		print("Connecting button for:", building["name"])
		btn.connect("pressed", Callable(self, "_on_building_selected").bind(building["scene"]))
		container.add_child(btn)

	# Hide the menu initially
	hide()

# Button click handler: Emit the selected building
func _on_building_selected(building_scene):
	print("Emitting building_selected signal with scene:", building_scene)
	emit_signal("building_selected", building_scene)
	selected_building_scene = building_scene
	can_place_building = true
	print(can_place_building)
	hide()  # Hide the menu after selecting a building

# Handle building placement
func _physics_process(delta):
	if can_place_building and Input.is_action_just_pressed("LMC"):
		var mouse_position = get_global_mouse_position()
		print("Placing building at:", mouse_position)
		place_building(mouse_position)

# Place the selected building at the given position
func place_building(pos):
	if selected_building_scene:
		print("Placing building at:", pos)
		var instance = selected_building_scene.instantiate()
		instance.position = pos
		instance.scale = Vector2(0.33, 0.33)
		print(get_parent().get_parent().get_parent())
		get_parent().get_parent().get_parent().add_child(instance)  # Add the building to the parent scene
		can_place_building = false  # Disable building placement after placing the building
		print(can_place_building)
	else:
		print("No building selected!")

# Show the popup menu
func show_menu():
	show()

# Hide the popup menu
func hide_menu():
	hide()
