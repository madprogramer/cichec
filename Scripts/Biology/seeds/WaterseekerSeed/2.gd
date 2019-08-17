extends dummySeed

func _ready():
	randomize()
	setSize(0.55)
	setColor([0, 1, 0])
	setSeeds(10)
	setPolens(10)

func _init():
	_ready()

func set_seedClass():
	seedClass = preload("res://Scripts/Biology/seeds/waterseekerSeed.gd")