extends Control
class_name BuildingMenu

@onready var player_camera = get_node("../../TileMapLayer/trunk/CharacterBody2D/Camera2D")  # Player's camera
@onready var map_camera = get_node("../../TileMapLayer/MapCamera")  # Map-view camera
@onready var player = get_node("../../TileMapLayer/trunk/CharacterBody2D/")
@onready var label = $"Control/Panel/Label"
@onready var house_button = $"Control/Panel/VBoxContainer/house_button"
@onready var lumberyard_button = $"Control/Panel/VBoxContainer/lumberyard_button"
@onready var farm_button = $"Control/Panel/VBoxContainer/farm_button"
# List of available buildings
var buildings = [
	{"name": "House", "cost": 10, "scene": preload("res://Buildings/house/house.tscn")},
	{"name": "Lumberyard", "cost": 10, "scene": preload("res://Buildings/lumberyard/LumberYard.tscn")},
	{"name": "Farm", "cost": 10, "scene": preload("res://Buildings/farm/farm.tscn")}
]
var selected_building : Dictionary


# Variables for building placement
var can_place_building := false
var selected_building_scene : PackedScene
var building_preview : Node2D  # This will hold our preview instance
var preview_visible := false

var placed_obstacles = {}
var placed_trees = {}

func _ready():
	# Add buttons for each building in the Popup menu
	house_button.connect("pressed", Callable(self, "_on_building_selected").bind(buildings[0]))
	lumberyard_button.connect("pressed", Callable(self, "_on_building_selected").bind(buildings[1]))
	farm_button.connect("pressed",Callable(self, "_on_building_selected").bind(buildings[2]))
	if map_camera:
		player_camera.make_current()  # Enable the player's camera
	# Hide the menu initially
	
	var tree_tile_ids = [2]  # tree tile ID 
	for pos in $"../../TileMapLayer/trunk".get_used_cells(): 
		var tile_id = $"../../TileMapLayer/trunk".get_cell_source_id(pos)
		if tile_id in tree_tile_ids:
			placed_trees[pos] = "trees"
		
	hide()
	

	

func _process(delta):
	if can_place_building:
		update_building_preview()

func _on_building_selected(building_scene):
	
			var cost = building_scene["cost"]
			if ResourceManager.resources["wood"] >= cost:
				selected_building_scene = building_scene["scene"]
				selected_building = building_scene
				can_place_building = true

				if is_instance_valid(building_preview):
					building_preview.queue_free()
					building_preview = null

				# Create preview instance
				building_preview = selected_building_scene.instantiate()
				building_preview.modulate = Color(1, 1, 1, 0.5)
				get_parent().get_parent().get_parent().add_child(building_preview)
				preview_visible = true
			else:
				label.text = "Not enough wood to place down this building."
	

func update_building_preview():
	if building_preview:
		var mouse_position = map_camera.get_screen_transform().affine_inverse()* get_viewport().get_mouse_position()
		building_preview.position = mouse_position
		building_preview.scale = Vector2(0.33, 0.33)
	if ResourceManager.resources["wood"] < 10:
		cancel_building_placement()
		

func place_building(pos):
	if not selected_building_scene:
		#print("No building selected!")
		return

	# Get cost of the selected building
	var cost = selected_building["cost"]
	
	if ResourceManager.resources["wood"] < cost:
		label.text = "Not enough wood to place down this building."
		return

	# Proximity check
	for building in placed_obstacles:
		if building.distance_to(get_building_position(pos)) < 4 or get_building_position(pos).y > 9:
			label.text = "You cannot place the building there."
			return
		
	for building in placed_trees:
		if building.distance_to(get_building_position(pos)) < 2 or get_building_position(pos).y > 9:
			label.text = "You cannot place the building there."
			return
			
	
	# Place the building
	var instance = selected_building_scene.instantiate()
	instance.position = pos
	instance.scale = Vector2(0.33, 0.33)
	get_parent().get_parent().get_parent().add_child(instance)
	placed_obstacles[get_building_position(pos)] = instance
	ResourceManager.resources["wood"] -= cost
	if selected_building["name"] == "House":
		ResourceManager.resources["capacity"]+=5
	label.text = ""
	

func _physics_process(delta):
	if can_place_building and Input.is_action_just_pressed("LMC"):
		var mouse_position = map_camera.get_screen_transform().affine_inverse()* get_viewport().get_mouse_position()
		place_building(mouse_position)
	
	# Right click to cancel placement
	if can_place_building and Input.is_action_just_pressed("RMC"):
		cancel_building_placement()

func cancel_building_placement():
	can_place_building = false
	if is_instance_valid(building_preview):
		building_preview.queue_free()
		building_preview = null

func disable_player_movement():
	player.set_interacting_state(true)
func enable_player_movement():
	player.set_interacting_state(false)
func switch_to_map_camera():
	if map_camera:
		map_camera.make_current()
func switch_to_player_camera():
	if map_camera:
		player_camera.make_current()

func open_menu():
	disable_player_movement()
	switch_to_map_camera()
	label.text = ""
	show()
	
func close_menu():
	enable_player_movement()
	switch_to_player_camera()
	cancel_building_placement()
	hide()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		if visible:
			close_menu()
		else:
			open_menu()
	if event.is_action_pressed("escape"):
		close_menu()
		
func get_building_position(pos: Vector2):
	return $"../../TileMapLayer".local_to_map(
		$"../../TileMapLayer".to_local(
			pos))

# Tooltip section
func _on_house_button_mouse_entered() -> void:
	Tooltip.AssignText("House", "A warm shelter for 10 people", "Cost: 10 wood")
	Tooltip.ItemPopup(Rect2i(Vector2i($"Control/Panel/VBoxContainer/house_button".global_position),Vector2i($"Control/Panel/VBoxContainer/house_button".size)))
func _on_house_button_mouse_exited() -> void:
	Tooltip.HidePopup()


func _on_lumberyard_button_mouse_entered() -> void:
	Tooltip.AssignText("Lumberyard", "Wood generator", "Cost: 10 wood")
	Tooltip.ItemPopup(Rect2i(Vector2i($"Control/Panel/VBoxContainer/lumberyard_button".global_position),Vector2i($"Control/Panel/VBoxContainer/lumberyard_button".size)))
	
func _on_lumberyard_button_mouse_exited() -> void:
	Tooltip.HidePopup()


func _on_farm_button_mouse_entered() -> void:
	Tooltip.AssignText("Farm", "You can grow food here", "Cost: 10 wood")
	Tooltip.ItemPopup(Rect2i(Vector2i($"Control/Panel/VBoxContainer/lumberyard_button".global_position),Vector2i($"Control/Panel/VBoxContainer/lumberyard_button".size)))


func _on_farm_button_mouse_exited() -> void:
	Tooltip.HidePopup()
