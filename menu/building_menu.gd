extends Control
class_name BuildingMenu
# Signal emitted when a building is selected
signal building_selected(building_scene)

@onready var player_camera = get_node("../trunk/CharacterBody2D/Camera2D")  # Player's camera
@onready var map_camera = get_node("../MapCamera")  # Map-view camera
@onready var player = get_node("../trunk/CharacterBody2D/")

# List of available buildings
var buildings = [
	{"name": "House", "cost": 10, "scene": preload("res://Buildings/house/house.tscn")},
	{"name": "Lumberyard", "cost": 10, "scene": preload("res://Buildings/lumberyard/LumberYard.tscn")},
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
		btn.text = building["name"] + " (" +str(building["cost"]) + " wood)"
		btn.custom_minimum_size = Vector2(200, 100)
		btn.connect("pressed", Callable(self, "_on_building_selected").bind(building["scene"]))
		container.add_child(btn)
	
	if map_camera:
		player_camera.make_current()  # Enable the player's camera
	# Hide the menu initially
	hide()

	

func _process(delta):
	if can_place_building:
		update_building_preview()

func _on_building_selected(building_scene):
	for building in buildings:
		if building["scene"] == building_scene:
			var cost = building["cost"]
			if ResourceManager.resources["wood"] >= cost:
				selected_building_scene = building_scene
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
				print("Not enough wood to select this building.")
			break
	

func update_building_preview():
	if building_preview:
		var mouse_position = get_global_mouse_position()
		building_preview.position = mouse_position
		building_preview.scale = Vector2(0.33, 0.33)
		

func place_building(pos):
	if not selected_building_scene:
		print("No building selected!")
		return

	# Get cost of the selected building
	var cost = 0
	for building in buildings:
		if building["scene"] == selected_building_scene:
			cost = building["cost"]
			break

	if ResourceManager.resources["wood"] < cost:
		print("Not enough wood to place this building.")
		return

	# Proximity check
	for building in placed_buildings:
		if building.distance_to(pos) < 85:
			print("Too close to another building at", pos)
			return

	# Place the building
	var instance = selected_building_scene.instantiate()
	instance.position = pos
	instance.scale = Vector2(0.33, 0.33)
	get_parent().get_parent().get_parent().add_child(instance)
	placed_buildings[instance.position] = instance
	ResourceManager.resources["wood"] -= cost
	print("Placed at:", instance.position, "Wood left:", ResourceManager.resources["wood"])

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
	show()
func close_menu():
	enable_player_movement()
	switch_to_player_camera()
	cancel_building_placement()
	hide()
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_menu"):
		open_menu()
	if event.is_action_pressed("escape"):
		close_menu()



	
