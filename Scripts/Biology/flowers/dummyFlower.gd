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
var stages = [
	2,
	4,
	6,
	8
];
var current_stage = 0
var sprite = null
var current_frame = 0

func age_up():
	age = age + 1
	if age > stages[current_stage]:
		stage_up()
		
func stage_up():
	current_stage = min(stages.size()-1, current_stage + 1)
	change_frame(current_stage)

func change_frame(x):
	sprite.set_frame(x)

#Age End

#Phenotype computations
#Phenotype computations end


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass