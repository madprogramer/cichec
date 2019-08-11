extends geneticStructure

class_name dummyflower

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

#Identifier End

#Genes Begin
var matGenes = initGenes({"size": 0,
	"color": [0,0,0],
	"seeds": 0,
	"polens": 0})
var patGenes = initGenes({"size": 0,
	"color": [0,0,0],
	"seeds": 0,
	"polens": 0})
var phenoGenes = initGenes({"size": 0,
	"color": [0,0,0],
	"seeds": 0,
	"polens": 0})
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
var pollinatedsprite = null

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

func set_pollinatedsprite(pollinatedsprite):
	self.pollinatedsprite = pollinatedsprite
#Age End

#Polination Begin
var polinated = false

func polinate():
#	print("There is a flower trying to spread its polen")
#	print("Killer polen is eating at your flesh!")
	
	print("https://github.com/EnoughSensei/cichec/issues/12")
#	var polinationCount = phenoGenes.getPolens();
	var polinationCount = 3
	var polRange = 2
	var polen = []
	
	for i in range(polinationCount):
		var polX = randi()%(2*polRange) - polRange
		var polY = randi()%(2*polRange) - polRange
		
		var polenGenes = getPolenGenes()
		
		for gene in matGenes:
			if boolChoice():
				polenGenes[gene] = matGenes[gene];
			else:
				polenGenes[gene] = patGenes[gene];
				
		#THIS IS SO SAD 
		#ALEXA PLAY SKILLET ~ NOT GONNA DIE 	
			
		#print(Vector2(polX,polY))
		#print(polenGenes)
		polen.push_back( [ id, pos + Vector2(polX,polY), polenGenes, [uniqueId, "INSERT PATERNAL PHENODATA"] ] )
		
	return polen
	
func try_polinate():
	if current_stage == 3:
		return polinate()
	return []
	
var newSeed = null
	
func getPolinated(polenData):
#	print("Someone is trying to polinate me: ", polenData)
	var polenGenes = polenData[2]
	
	#use polenData to generate seeds
	polinated = true
	
#	print(newSeed)
	
	newSeed.GENES = polenGenes
	newSeed.fatherId = polenData[3][0]
	newSeed.motherId = polenData[3][1]
#	print("newSeed's parents: ", polenData[3][0], " ", polenData[3][1])
	
#	self.setColor()
	
#	print("pollinated")
	sprite.visible = false
	pollinatedsprite.visible = true
	deadsprite.visible = false
	
#	print("TODO: Update sprite of polinated");
#	print("TODO: Generate seeds: polenData holds Information from father plant")
	print("polenGenes holds information from mother");

func isPolinated():
	return polinated
	
func harvest():
	print("TODO: ADD CORRECT SEEDS TO INVENTORY")
	polinated = false
	set_dead()
	return newSeed

#Polination end

#Utility
func boolChoice():
	return (randi()%2 == 0)
	
func getPolenGenes():
	var polenGenes = {}
	
	for gene in matGenes:
		if boolChoice():
			polenGenes[gene] = matGenes[gene];
		else:
			polenGenes[gene] = patGenes[gene];
	return polenGenes


#Phenotype computations

#Phenotype computations end

func _on_flower_death():
	print("really dead")
	sprite.visible = false
	pollinatedsprite.visible = false
	deadsprite.visible = true
	pass
	
func pickup():
	sprite.visible = false
	pollinatedsprite.visible = false
	deadsprite.visible = false
	queue_free()
	
const ItemClass = preload("res://Scripts/Seed.gd");
	
# pilgrim™: Ugly solutions require modern problems.
func set_seed(originalItem):
	var itemName = originalItem.name
	
	var itemIcon = originalItem.texture
	
	var itemValue = -1
	
	var itemSeed = originalItem.seedClass
	
	var GENES = originalItem.GENES
	
	newSeed = ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, GENES);
	newSeed.fatherId = fatherId
	newSeed.motherId = motherId

func set_genes(GENES):
	initGenes(GENES)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass