extends dummySeed

func _ready():
	randomize()
	setSize(0.8)
	setColor([1, 0, 0])
	setSeeds(5)
	setPolens(20)

func _init():
	_ready()

func set_seedClass():
	seedClass = preload("res://Scripts/Biology/seeds/waterseekerSeed.gd")