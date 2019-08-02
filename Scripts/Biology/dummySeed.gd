extends geneticStructure

# Classes Begin
const GrowthAnimationClass = preload("res://Scripts/Biology/growthAnimation.gd")
# Classes End

# Declare member variables here. Examples:

#Genes Begin
var matGenes = initGenes()
var patGenes = initGenes()
var phenoGenes = initGenes()
#Genes End

#Age Begin
var age = 0;
#Age End

#Growth Animation Begin
var growthAnimation = GrowthAnimationClass.new({
	0: preload("res://Assets/Seeds/DummySeed/1.png")
})
#Growth Animation End

# Phenotype computations

func _init():
	set_name("DummySeed")
	pass