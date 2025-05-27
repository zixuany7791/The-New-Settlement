extends Node

var resources = {
	"wood": 120,
	"unemployed": 6,
	"capacity": 6,
	"population": 6,
	"currency": 0,
	"food": 30
}

var production_rates = {
	"wood": 0,
	"food": 0
}

var wood_interval := 1
var food_interval := 10
var food_consume_interval := 24
var death_interval := 30.0
var death_timer := 0.0
var float_timer := 0.0
var int_timer := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	float_timer += delta
	if float_timer >= 1.0:
		int_timer += 1
		produce_resources(int_timer)
		float_timer = 0
	
		if int_timer % 24 == 0:
			resources["food"] -= (resources["population"]*2)
	if resources["food"] < resources["population"]*2:
		death_timer += delta
		if death_timer >= death_interval:
			resources["population"]-=1
			death_timer = 0
	else: 
		death_timer = 0

func produce_resources(time):
	if time % wood_interval == 0:
		resources["wood"] += production_rates["wood"]
	if time % food_interval == 0:
		resources["food"] += production_rates["food"]
		
func add_production(resource_name: String, amount: int):
	if production_rates.has(resource_name):
		production_rates[resource_name] += amount
	else:
		production_rates[resource_name] = amount
