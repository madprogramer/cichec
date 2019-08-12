extends geneticStructure

class_name dummySeed

# Declare member variables here. Examples:

#Identifier Begin
var id = 0;
#Identifier End

#Genes Begin

#Inherited Genes
var matGenes = initGenes({"size": 0,
	"color": [0,0,0],
	"seeds": 0,
	"polens": 0})
var patGenes = initGenes({"size": 0,
	"color": [0,0,0],
	"seeds": 0,
	"polens": 0})
	
#Full Phenotype of Ancestor
var phenoGenesMat = initGenes({"size": 0,
	"color": [0,0,0],
	"seeds": 0,
	"polens": 0})
	
var phenoGenesPat = initGenes({"size": 0,
	"color": [0,0,0],
	"seeds": 0,
	"polens": 0})
	
#Own Phenotype	
var phenoGenes = initGenes({"size": 0,
	"color": [0,0,0],
	"seeds": 0,
	"polens": 0})
#Genes End

#Corresponding Plant
var flower = null

var fatherId = 0
var motherId = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

