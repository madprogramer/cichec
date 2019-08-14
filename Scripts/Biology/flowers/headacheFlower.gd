extends dummyflower

class_name headacheFlower

# Declare member variables here. Examples:

#Phenotype computations
#Phenotype computations end

# Called when the node enters the scene tree for the first time.

func _init(pos, GENES):
	set_genes(GENES)
	id = 4;
	randomize()
	uniqueId = randi()
	
	sprite = Sprite.new()
	sprite.position = pos
	print(pos)
	sprite.set_texture(preload("res://Assets/Flowers/HeadacheFlower.png"))
	sprite.set_hframes(4)
	
	deadsprite = Sprite.new()
	deadsprite.position = pos
#	if isShort():
#		deadsprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower-short-dead.png"))
#	else:
	deadsprite.set_texture(preload("res://Assets/Flowers/HeadacheFlower-dead.png"))
	deadsprite.visible = false
	
	pollinatedsprite = Sprite.new()
	pollinatedsprite.position = pos
#	if isShort():
#		pollinatedsprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower-short-pollinated.png"))
#	else:
	pollinatedsprite.set_texture(preload("res://Assets/Flowers/HeadacheFlower-pollinated.png"))
	pollinatedsprite.visible = false
	pollinatedsprite.set_self_modulate(sprite.get_self_modulate())