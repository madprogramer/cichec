extends dummySeed

class_name rainbowSeed

func _init(pos):
	flower = preload("res://Scripts/Biology/flowers/rainbowFlower.gd").new(pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
