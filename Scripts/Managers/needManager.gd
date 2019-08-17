extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var needDictionary = {
	"WaterseekerFlower" : 1
}

func set_needDictionary(needDictionary):
	self.needDictionary = needDictionary

func calcFromArray(array):
	var countDictionary = {}
	for i in range(array.size()):
		if countDictionary.has(array[i].itemName) == false:
			countDictionary[array[i].itemName] = 1 # array[i].count
		else:
			countDictionary[array[i].itemName] += 1 # array[i].count
	
	for key in needDictionary:
		if countDictionary[key] == null:
			return -1
		if countDictionary[key] < needDictionary[key]:
			return -1
		countDictionary[key] -= needDictionary[key]
	
	return countDictionary

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
