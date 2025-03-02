extends StaticBody2D

@onready var interaction_area: Area2D = $InteractionArea
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	interaction_area.interact = _on_interact
	
func _on_interact():
	print("worked")
