extends dummySeed

func _ready():
	randomize()
	setSize(0.2)
	setColor([0, 0, 1])
	setSeeds(20)
	setPolens(5)

func _init():
	_ready()

func set_seedClass():
	seedClass = preload("res://Scripts/Biology/seeds/waterseekerSeed.gd")