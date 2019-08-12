extends dummySeed

func _ready():
	setSize(0)
	setColor([0, 0, 0])
	setSeeds(1)
	setPolens(1)
	
func set_seedClass():
	seedClass = preload("res://Scripts/Biology/seeds/rainbowSeed.gd")