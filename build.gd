extends Node2D  

var mynode = preload("res://buildings/building_block.tscn")  # Load the building block scene

func _physics_process(delta):
	if Input.is_action_just_pressed("LMC"):
		var mouse_position = get_global_mouse_position()
		place_building({"image_path": "res://path_to_your_image.png"}, mouse_position)  # Example usage
		print("Mouse Position: ", mouse_position)

func inst(pos):
	var instance = mynode.instantiate()
	instance.position = pos
	add_child(instance)

func place_building(building_data, position):
	var new_building = mynode.instantiate()  # Create an instance using mynode
	new_building.position = position  # Set position
	
	# Assign image only if "image_path" exists
	if "image_path" in building_data:
		var sprite = new_building.get_node("Sprite2D")
		if sprite:  # Check if Sprite2D exists in the scene
			sprite.texture = load(building_data["image_path"])
		else:
			print("Error: 'Sprite2D' node not found in building_block.tscn")
	
	add_child(new_building)  # Add to the scene
