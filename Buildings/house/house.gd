extends StaticBody2D

@onready var interaction_area: Area2D = $House_interact
@onready var sprite_2d: Sprite2D = $Sprite2D
#
func assign_position(pos):
	pass
#
## When the player interact with the building, it would print in the console
#func _on_interact():
	#print("worked")
