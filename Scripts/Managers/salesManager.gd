extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var valueDictionary = {
	"WaterseekerFlower" : 1
}

func set_valueDictionary(valueDictionary):
	self.valueDictionary = valueDictionary

func calcFromDictionary(countDictionary):
	var total = 0
	
	for key in valueDictionary:
		if countDictionary[key] == null:
			continue
		total += countDictionary[key] * valueDictionary[key]
	
	return total

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
