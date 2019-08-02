extends Node

class_name geneticStructure

var GENES = {
	"size": 0,
	"color": [0,0,0,0],
	"seeds": 0,
}

#Modify Genes
func setSize(x):
	GENES["size"] = x
func setColor(x):
	GENES["color"] = x
func setSeeds(x):
	GENES["seeds"] = x
	
#Access Genes
func getSize():
	return GENES["size"]
func getColor():
	return GENES["color"]
func getSeeds():
	return GENES["seeds"]
	

#Initialize
func initGenes():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_name(newName):
	name = newName