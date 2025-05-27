extends Panel

@onready var sellWood_button = $SellWood
@onready var buyPeople_button = $BuyPeople
@onready var interact_label = $"../../../TileMapLayer/trunk/CharacterBody2D/Interaction Component/InteractLabel"
@onready var player = $"../../../TileMapLayer/trunk/CharacterBody2D"
@onready var close_button = $"close"
@onready var error_label = $"error"
func _ready():
	hide()
	sellWood_button.pressed.connect(sell_wood)
	close_button.pressed.connect(close_pressed)
	

func disable_player_movement():
	player.set_interacting_state(true)
func enable_player_movement():
	player.set_interacting_state(false)
func sell_wood():
	if ResourceManager.resources["wood"] >= 50:
		ResourceManager.resources["currency"] += 10
		ResourceManager.resources["wood"] -= 50
		error_label.text = ""
	else:
		error_label.text = "Not enough wood"
func buy_people():
	if ResourceManager.resources["currency"] >= 100:
		ResourceManager.resources["population"] += 1
		ResourceManager.resources["currency"] -= 100
	else:
		error_label.text = "Not enough money"
func close_pressed():
	interact_label.show()
	enable_player_movement()
	hide()
