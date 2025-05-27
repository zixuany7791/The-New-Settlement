extends StaticBody2D


@onready var menu = $"CanvasLayer/farm_menu"
#func _ready() -> void:
var building_position
func assign_position(pos):
	building_position = pos
func get_building_position():
	return building_position
func remove_worker_from_menu():
	menu.died_assigned_workers()
