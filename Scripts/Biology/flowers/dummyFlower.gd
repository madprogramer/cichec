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

var boost_flag = false

func boost():
	boost_flag = true

func age_up():
	age = age + 1
	if current_stage < stages.size() and age > stages[current_stage]:
		stage_up()
	
	if boost_flag:
		boost_flag = false
		age_up()
		
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
	#print("dead")
	dead = true
	_on_flower_death()
#	sprite.visible = false
#	deadsprite.offset = sprite.offset
#	deadsprite.visible = true
func _on_flower_death():
	#print("really dead")
	sprite.visible = false
	pollinatedsprite.visible = false
	deadsprite.visible = true
	pass
	
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
	
	print(newSeed)
	
#	var x = 0
#	x = x / x
	
	#newSeed.GENES = polenGenes
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
#	print("TODO: ADD CORRECT SEEDS TO INVENTORY")
	polinated = false
	set_dead()
	var seeds = newSeed
	pickup()
	return seeds

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

#TODO: DECIDE IF THESE SHOULD RETURN EXPLICIT VALLUES
#MIGHT BE MORE USEFUL FOR SCANNER IMPLEMENTATION

#Color
#Color is Unique in that Maternal or Paternal store
#Color data as 1 or 0
#However for Phenogenes 0 means dark, 2 means bright
#But 1 means at tone in between

func phenoColor():
	var myColor = [0,0,0]
	for i in range(3):
		myColor[i] = matGenes.color[i] + patGenes.color[i]
	return myColor
	
#Size
#Average of genes, rounded up
func phenoSize():
	return ceil((matGenes.size + patGenes.size)/2)

#Seeds 
#Random Number in interval of min to max
func phenoSeeds():
	var zuixiao = min(matGenes.seeds, patGenes.seeds)
	var zuida = max(matGenes.seeds, patGenes.seeds)
	return zuixiao + randi()%(zuida-zuixiao+1) + 1
	
#Polen
#Random Number in interval of min to max 
func phenoPolens():
	var zuixiao = min(matGenes.polens, patGenes.polens)
	var zuida = max(matGenes.polens, patGenes.polens)
	return zuixiao + randi()%(zuida-zuixiao+1) + 1

#Phenotype computations end

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
	
	var itemCount = originalItem.count
	
	# themadprogramer™: No u
	#Generate GENES HERE
	GENES["size"] = phenoSize();
	GENES["color"] = phenoColor();
	GENES["seeds"] = phenoSeeds();
	GENES["polens"] = phenoPolens();
	
	originalItem.dummySeed.GENES = GENES
	
	newSeed = ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, originalItem.dummySeed, itemCount);
	newSeed.fatherId = fatherId
	newSeed.motherId = motherId

func set_genes(GENES):
#	print(GENES)
	initGenes(GENES)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass