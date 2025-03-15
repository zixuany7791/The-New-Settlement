extends CharacterBody2D

@export var speed = 40
var is_interacting = false
const SPEED = 40.0
const JUMP_VELOCITY = 10000

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(delta):
	if is_interacting:
		return  # Skip movement logic if interacting
	get_input()
	move_and_slide()

func set_interacting_state(state: bool):
	is_interacting = state
	print(state)
