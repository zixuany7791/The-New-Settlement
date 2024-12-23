extends CharacterBody2D

@export var speed = 400
<<<<<<< HEAD
const SPEED = 330.0
const JUMP_VELOCITY = -450.0
=======
const SPEED = 200.0
const JUMP_VELOCITY = 10000
>>>>>>> 59bcdf7f0c64c21a069dd8f0bef7a43b4a085b7b
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
