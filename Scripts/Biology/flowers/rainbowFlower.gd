extends dummyflower

class_name rainbowFlower

# Declare member variables here. Examples:

#Phenotype computations
#Phenotype computations end

# Called when the node enters the scene tree for the first time.

func _init(pos):
	sprite = Sprite.new()
	sprite.offset = pos
	print(pos)
	sprite.set_texture(preload("res://Assets/Flowers/RainbowFlower.png"))
	sprite.set_hframes(4)
	
	# add_child(sprite)
	# var x = 0
	# x = x / x
	
func set_sprite(sprite):
	self.sprite = sprite

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass