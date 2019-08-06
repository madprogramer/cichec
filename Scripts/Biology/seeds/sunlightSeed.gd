extends dummySeed

class_name sunlightSeed

# Declare member variables here. Examples:

#Corresponding Plant

func _init(pos):
	id=1;
	flower = preload("res://Scripts/Biology/flowers/sunlightFlower.gd").new(pos)