extends Control
class_name BuildingMenu
# Signal emitted when a building is selected
signal building_selected(building_scene)

# List of available buildings
var buildings = [
	{"name": "House", "cost": 50, "scene": preload("res://Buildings/house/house.tscn")},
	{"name": "Lumberyard", "cost": 50, "scene": preload("res://Buildings/lumberyard/LumberYard.tscn")},
]


# Variables for building placement
var can_place_building := false
var selected_building_scene : PackedScene
var building_preview : Node2D  # This will hold our preview instance
var preview_visible := false

var placed_buildings = {}


func _ready():
	# Add buttons for each building in the Popup menu
	var container = $Control/Panel/VBoxContainer
	for building in buildings:
		var btn = Button.new()
		btn.text = building["name"] + " ($" + str(building["cost"]) + ")"
		btn.custom_minimum_size = Vector2(200, 100)
		btn.connect("pressed", Callable(self, "_on_building_selected").bind(building["scene"]))
		container.add_child(btn)

	# Hide the menu initially
	hide()

	

func _process(delta):
	if can_place_building:
		update_building_preview()

func _on_building_selected(building_scene):

	selected_building_scene = building_scene
	can_place_building = true
	
	if is_instance_valid(building_preview):
		building_preview.queue_free()
		building_preview = null
	# Create preview instance if it doesn't exist
	if selected_building_scene:
		building_preview = selected_building_scene.instantiate()
		building_preview.modulate = Color(1, 1, 1, 0.5)  # Make it semi-transparent
		get_node("../trunk").add_child(building_preview)
		preview_visible = true
	

func update_building_preview():
	if building_preview:
		var mouse_position = get_global_mouse_position()
		building_preview.position = mouse_position
		building_preview.scale = Vector2(0.33, 0.33)
		

func place_building(pos):
	if selected_building_scene:
		var num = 999
		for building in placed_buildings:
			if building.distance_to(pos) < num:
				num = building.distance_to(pos)
			if building.distance_to(pos) < 85:
				print("You are trying to place the building at ", pos)
				print(building.distance_to(pos))
				return
		var instance = selected_building_scene.instantiate()
		instance.position = pos
		instance.scale = Vector2(0.33, 0.33)
		print("Placing building at:", instance.position)
		get_node("../trunk").add_child(instance)
		placed_buildings[instance.position] = instance
		print(placed_buildings)
		
		# Don't disable placement after placing, keep the preview active
	else:
		print("No building selected!")

func _physics_process(delta):
	if can_place_building and Input.is_action_just_pressed("LMC"):
		var mouse_position = get_global_mouse_position()
		place_building(mouse_position)
	
	# Right click to cancel placement
	if can_place_building and Input.is_action_just_pressed("RMC"):
		cancel_building_placement()

func cancel_building_placement():
	can_place_building = false
	if is_instance_valid(building_preview):
		building_preview.queue_free()
		building_preview = null




	
