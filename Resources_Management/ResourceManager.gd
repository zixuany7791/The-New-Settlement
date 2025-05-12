extends Node

var resources = {
	"wood": 120,
	"unemployed": 6,
	"capacity": 6,
	"population": 20,
	"currency": 0,
}

var production_rates = {
	"wood": 0,
	"unemployed": 0,
	"population": 0,
	"currency": 0,
}

var production_interval := 1.0
var homeless_interval := 5.0
var time_accumulator := 0.0
var death_timer := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_accumulator += delta
	
	if time_accumulator >= production_interval:
		produce_resources()
		time_accumulator = 0
	if 	ResourceManager.resources["population"] > ResourceManager.resources["capacity"]:
		death_timer += delta
		if death_timer >= homeless_interval: 
			ResourceManager.resources["population"] -=1
			death_timer = 0
	else: 
		death_timer = 0

func produce_resources():
	for res in production_rates:
		resources[res] += production_rates[res]
		
func add_production(resource_name: String, amount: int):
	if production_rates.has(resource_name):
		production_rates[resource_name] += amount
	else:
		production_rates[resource_name] = amount
