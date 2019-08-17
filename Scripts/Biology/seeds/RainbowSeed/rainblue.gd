extends dummySeed

func _ready():
	setSize(0.5)
	setColor([0, 0, 1])
	setSeeds(1)
	setPolens(1)
	
func _init():
	_ready()
	
func set_seedClass():
	seedClass = preload("res://Scripts/Biology/seeds/rainbowSeed.gd")