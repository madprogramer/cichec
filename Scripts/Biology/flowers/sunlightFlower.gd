extends dummyflower

class_name sunlightFlower

# Declare member variables here. Examples:

#Phenotype computations
#Phenotype computations end

# Called when the node enters the scene tree for the first time.

func _init(pos):
	id = 1;
	randomize()
	uniqueId = randi()
	
	sprite = Sprite.new()
	sprite.position = pos
	print(pos)
	sprite.set_texture(preload("res://Assets/Flowers/SunlightFlower.png"))
	sprite.set_hframes(4)
	
	deadsprite = Sprite.new()
	deadsprite.position = pos
	deadsprite.set_texture(preload("res://Assets/Flowers/SunlightFlower-dead.png"))
	deadsprite.visible = false
	
	pollinatedsprite = Sprite.new()
	pollinatedsprite.position = pos
#	if isShort():
#		pollinatedsprite.set_texture(preload("res://Assets/Flowers/SunlightFlower-short-pollinated.png"))
#	else:
	pollinatedsprite.set_texture(preload("res://Assets/Flowers/SunlightFlower-pollinated.png"))
	pollinatedsprite.visible = false
	pollinatedsprite.set_self_modulate(sprite.get_self_modulate())