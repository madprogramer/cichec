extends dummySeed

class_name headacheSeed

func _init(pos, GENES):
	id = 4;
	flower = preload("res://Scripts/Biology/flowers/headacheFlower.gd").new(pos, GENES)
#	flower.set_genes(GENES)