extends Node

class_name geneticStructure

var GENES = {
	"size": 0,
	"color": [0,0,0,0],
	"seeds": 0,
	"polens": 0,
}

#Modify Genes
func setSize(x):
	GENES["size"] = x
func setColor(x):
	GENES["color"] = x
func setSeeds(x):
	GENES["seeds"] = x
func setPolens(x):
	GENES["polens"] = x
	
#Access Genes
func getSize():
	return GENES["size"]
func getColor():
	return GENES["color"]
func getSeeds():
	return GENES["seeds"]
func getPolens():
	return GENES["polens"]
	
func isShort():
	if getSize() < 0.5:
		return true
	return false

#Compute Genes
func computeSize(a,b):
	return (a+b+1)/2
func computeColor(a,b):
	var se = [0,0,0,0]
	for i in range(4):
		se[i] = a[i]+b[i]
	return se
func computeSeeds(a,b):
	return randi()%(int(abs(a-b))) + int(max(a,b))


#Initialize
func initGenes(structure):
	for s in structure:
		GENES[s] = structure[s];
	return GENES

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass