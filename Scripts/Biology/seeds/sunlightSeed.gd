extends dummySeed

class_name sunlightSeed

# Declare member variables here. Examples:

#Corresponding Plant

func _init(pos):
	flower = preload("res://Scripts/Biology/flowers/sunlightFlower.gd").new(pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass