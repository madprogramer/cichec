extends dummySeed

class_name waterseekerSeed

func _init(pos, GENES):
	id=3;
	flower = preload("res://Scripts/Biology/flowers/waterseekerFlower.gd").new(pos)
	flower.set_genes(GENES)