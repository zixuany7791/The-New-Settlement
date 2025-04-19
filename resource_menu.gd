extends Control

@onready var Population_Label: Label = $Population/MarginContainer2/Label
@onready var Wood_Label: Label = $Wood/MarginContainer2/Label
@onready var Money_Label: Label

func _process(delta):
	Population_Label.text = str(ResourceManager.resources["unemployed"])
