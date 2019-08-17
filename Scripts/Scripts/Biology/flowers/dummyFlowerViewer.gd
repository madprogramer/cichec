extends geneticStructure

class_name dummyflowerviewer

# Declare member variables here. Examples:

#Identifier Begin

var id = 0
var uniqueId = null
var fatherId = 0
var motherId = 0

#If set to true, position will be ignored; 
#Use for flowers stored in the inventory
var inInventory = false;

var pos = Vector2(0,0)

	
#Own Phenotype
#Genes End

#Age Begin

#var age = 0;
#var stages = [
#	2,
#	4,
#	6,
#	8
#];

#Utility
func boolChoice():
	return (randi()%2 == 0)
	
const SeedClass = preload("res://Scripts/Seed.gd");
	
# pilgrim™: Ugly solutions require modern problems.
#	# themadprogramer™: No u
const ItemClass = preload("res://Scripts/Item.gd")

var dummyFlower = null

func set_dummyFlower(flower):
	dummyFlower = flower

func _init(flower):
	set_dummyFlower(flower)