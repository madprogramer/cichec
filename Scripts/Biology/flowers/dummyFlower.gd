extends geneticStructure

class_name dummyflower

# Declare member variables here. Examples:

#Static Variables

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
var deadsprite = null

func age_up():
	age = age + 1
	if current_stage < stages.size() and age > stages[current_stage]:
		stage_up()
		
func stage_up():
	current_stage = current_stage + 1
	if current_stage >= stages.size():
		set_dead()
	else:
		change_frame(current_stage)

func polinate():
	print("There is a flower trying to spread its polen")
	
func try_polinate():
	if current_stage == 3:
		polinate();

func change_frame(x):
	sprite.set_frame(x)

var dead = false

func isDead():
	return dead

func set_dead():
	print("dead")
	dead = true
	_on_flower_death()
#	sprite.visible = false
#	deadsprite.offset = sprite.offset
#	deadsprite.visible = true
	
func set_sprite(sprite):
	self.sprite = sprite
	
func set_deadsprite(deadsprite):
	self.deadsprite = deadsprite
#Age End

#Phenotype computations
#Phenotype computations end

func _on_flower_death():
	print("really dead")
	sprite.visible = false
	deadsprite.visible = true
	pass
	
func pickup():
	sprite.visible = false
	deadsprite.visible = false
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass