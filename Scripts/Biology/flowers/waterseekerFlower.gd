extends dummyflower

class_name waterseekerFlower

# Declare member variables here. Examples:

#Phenotype computations
#Phenotype computations end

# Called when the node enters the scene tree for the first time.

func _init(pos):
	id = 3;
	randomize()
	uniqueId = randi()
	
	sprite = Sprite.new()
	sprite.offset = pos
	print(pos)
	sprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower.png"))
	sprite.set_hframes(4)
	
	deadsprite = Sprite.new()
	deadsprite.offset = pos
#	if isShort():
#		deadsprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower-short-dead.png"))
#	else:
	deadsprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower-dead.png"))
	deadsprite.visible = false
	
	pollinatedsprite = Sprite.new()
	pollinatedsprite.offset = pos
#	if isShort():
#		pollinatedsprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower-short-pollinated.png"))
#	else:
	pollinatedsprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower-pollinated.png"))
	pollinatedsprite.visible = false
	pollinatedsprite.set_self_modulate(sprite.get_self_modulate())