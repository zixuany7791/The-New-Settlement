extends StaticBody2D

@onready var interaction_area: Area2D = $Lumber_interact
@onready var sprite_2d: Sprite2D = $LumberYard
@onready var menu = $"CanvasLayer/Lumber_menu"
#func _ready() -> void:
var building_position
func assign_position(pos):
	building_position = pos
func get_building_position():
	return building_position
func remove_worker_from_menu():
	menu.died_assigned_workers()
