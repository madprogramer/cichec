extends dummySeed

class_name waterseekerSeed

func _init(pos):
	flower = preload("res://Scripts/Biology/flowers/waterseekerFlower.gd").new(pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
