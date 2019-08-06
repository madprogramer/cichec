extends dummyflower

class_name sunlightFlower

# Declare member variables here. Examples:

#Phenotype computations
#Phenotype computations end

# Called when the node enters the scene tree for the first time.

func _init(pos):
	id = 1;
	sprite = Sprite.new()
	sprite.offset = pos
	print(pos)
	sprite.set_texture(preload("res://Assets/Flowers/SunlightFlower.png"))
	sprite.set_hframes(4)
	
	deadsprite = Sprite.new()
	deadsprite.offset = pos
	deadsprite.set_texture(preload("res://Assets/Flowers/SunlightFlower-dead.png"))
	deadsprite.visible = false