extends Control

@onready var delete_button = $delete
@onready var interact_label = $"../../../Node2D/TileMapLayer/trunk/CharacterBody2D/Interaction Component/InteractLabel"
@onready var player = $"../../../Node2D/TileMapLayer/trunk/CharacterBody2D"
func _ready():
	hide()
	delete_button.pressed.connect(delete_pressed)

func disable_player_movement():
	player.set_interacting_state(true)
func enable_player_movement():
	player.set_interacting_state(false)
func delete_pressed():
	ResourceManager.resources["capacity"] -= 5
	if get_node("../../../Node2D/TileMapLayer/Popupmenu").placed_obstacles.has(get_node("../../../Node2D/TileMapLayer/Popupmenu").get_building_position(get_node("../..").position)):
		get_node("../../../Node2D/TileMapLayer/Popupmenu").placed_obstacles.erase(get_node("../../../Node2D/TileMapLayer/Popupmenu").get_building_position(get_node("../..").position))
	interact_label.show()
	enable_player_movement()
	get_node("../../").queue_free()
