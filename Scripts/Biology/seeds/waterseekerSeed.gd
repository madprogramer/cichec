extends dummySeed

class_name waterseekerSeed

func _init(pos, GENES):
	id = 3;
	flower = preload("res://Scripts/Biology/flowers/waterseekerFlower.gd").new(pos, GENES)
	flower.father = self
	flower.mother = self
#	flower.set_genes(GENES)