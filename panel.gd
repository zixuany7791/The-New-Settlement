extends Panel

@onready var sell_button = $Sell
@onready var interact_label = $"../../../TileMapLayer/trunk/CharacterBody2D/Interaction Component/InteractLabel"
@onready var player = $"../../../TileMapLayer/trunk/CharacterBody2D"
@onready var close_button = $"close"
func _ready():
	hide()
	sell_button.pressed.connect(sell_wood)
	close_button.pressed.connect(close_pressed)

func disable_player_movement():
	player.set_interacting_state(true)
func enable_player_movement():
	player.set_interacting_state(false)
func sell_wood():
	if ResourceManager.resources["wood"] >= 50:
		ResourceManager.resources["currency"] += 10
		ResourceManager.resources["wood"] -= 50
	else:
		print("yes")
func close_pressed():
	interact_label.show()
	enable_player_movement()

	hide()
