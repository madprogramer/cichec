extends geneticStructure

class_name dummyflower

# Declare member variables here. Examples:

#Genes Begin
var matGenes = initGenes({})
var patGenes = initGenes({})
var phenoGenes = initGenes({})
#Genes End

#Age Begin
var age = 0;
var stages = [];
var sprites = [];
#Age End

#Phenotype computations
#Phenotype computations end


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass