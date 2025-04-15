extends Control

@onready var interaction_component = get_node("../../CharacterBody2D/Interaction Component")

func _ready():
	hide()
	interaction_component.connect("lumber_interacted", Callable(self, "_on_interact"))
	
	interaction_component.connect("escape_pressed", Callable(self, "_on_escape_pressed"))

func _on_interact():
	show()
func _on_escape_pressed():
	hide()
