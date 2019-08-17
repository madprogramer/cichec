extends dummySeed

func _ready():
	randomize()
	setSize(0.5)
	setColor([1, 1, 1])
	setSeeds(5)
	setPolens(5)

func _init():
	_ready()

func set_seedClass():
	seedClass = preload("res://Scripts/Biology/seeds/waterseekerSeed.gd")