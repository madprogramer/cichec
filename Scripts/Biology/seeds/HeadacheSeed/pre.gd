extends dummySeed

func _ready():
	randomize()
	setSize(randf())
	setColor([1, 1, 1])
	setSeeds(1)
	setPolens(1)

func _init():
	_ready()

func set_seedClass():
	seedClass = preload("res://Scripts/Biology/seeds/headacheSeed.gd")