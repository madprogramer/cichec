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
	randomize()
	setSize(randf())
	if isShort():
		sprite.set_texture(preload("res://Assets/Flowers/RainbowFlower-short.png"))
	else:
		sprite.set_texture(preload("res://Assets/Flowers/RainbowFlower.png"))
	
	sprite.set_hframes(4)
	
	setColor([1, 0, 0, 1])
	
	var color = getColor()
	
	sprite.set_self_modulate(Color(color[0], color[1], color[2], color[3]))
	
	deadsprite = Sprite.new()
	deadsprite.offset = pos
	deadsprite.set_texture(preload("res://Assets/Flowers/RainbowFlower-dead.png"))
	deadsprite.visible = false
	deadsprite.set_self_modulate(sprite.get_self_modulate())