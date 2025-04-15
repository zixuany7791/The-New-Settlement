extends StaticBody2D

@onready var interaction_area: Area2D = $Lumber_interact
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	interaction_area.interact = _on_interact

# When the player interact with the building, it would print in the console
func _on_interact():
	print("worked")
