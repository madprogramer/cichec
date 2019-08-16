extends Node2D

var seeds = [null, null]
var flowers = [null, null]

func add_dummyFlower(flower, type):
	seeds[type] = flower

func render():
	for i in range(2):
		var pos = Vector2(0, 0)
		if i == 1:
			pos.x = 48
		flowers[i] = seeds[i].flower.dummySeed.seedClass.new(
			pos,
			seeds[i].GENES
		)
		flowers[i] = flowers[i].flower
		
#		var x = 0
#		x = x / x
	
func get_sprite(pos, type):
	return spriteArray[type]

func add_dummyFlower(type, sprite):
	print("TRYING TO ADD DUMMY FLOWER")
	if type == 0:
		add_sprite(Vector2(0, 0), sprite, type)
	elif type == 1:
		add_sprite(Vector2(48, 0), sprite, type)
	else:
		assert(false)

func _ready():
	for k in range(0, 2):
		spriteArray.push_back(null)
	return flowers

