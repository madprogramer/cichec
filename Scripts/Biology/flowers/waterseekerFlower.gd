extends dummyflower

class_name waterseekerFlower

# Declare member variables here. Examples:

#Phenotype computations
#Phenotype computations end

# Called when the node enters the scene tree for the first time.

func _init(pos):
	sprite = Sprite.new()
	sprite.offset = pos
	print(pos)
	sprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower.png"))
	sprite.set_hframes(4)
	
func set_sprite(sprite):
	self.sprite = sprite