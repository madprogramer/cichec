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
	
	return flowers