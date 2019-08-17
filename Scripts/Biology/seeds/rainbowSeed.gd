extends dummySeed

class_name rainbowSeed

func _init(pos, GENES):
	id = 2;
	flower = preload("res://Scripts/Biology/flowers/rainbowFlower.gd").new(pos, GENES)
#	print("GENES: ", GENES)

# Called when the node enters the scene tree for the first time.
