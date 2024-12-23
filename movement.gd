extends CharacterBody2D

@export var speed = 400
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
