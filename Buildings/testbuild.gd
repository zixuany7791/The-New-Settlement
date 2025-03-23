extends Node2D  

var mynode = preload("res://Buildings/building_block.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("LMC"):
		# Get the current global mouse position dynamically
		var mouse_position = get_global_mouse_position()
		inst(mouse_position)
		print("Mouse Position: ", mouse_position)


func inst(pos):
	var instance = mynode.instantiate()
	instance.position = pos
	add_child(instance)
