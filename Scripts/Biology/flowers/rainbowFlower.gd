extends dummyflower

class_name rainbowFlower

# Declare member variables here. Examples:

#Phenotype computations
#Phenotype computations end

# Called when the node enters the scene tree for the first time.

func _init(pos):
	id = 2;
	randomize()
	uniqueId = randi()
	
	sprite = Sprite.new()
	sprite.position = pos
	
	print(pos)
	randomize()
	setSize(randf())
	if isShort():
		sprite.set_texture(preload("res://Assets/Flowers/RainbowFlower-short.png"))
	else:
		sprite.set_texture(preload("res://Assets/Flowers/RainbowFlower.png"))
	
	sprite.set_hframes(4)
	
	var ColorManager = colors.new()
	setColor( ColorManager.RYB2RGB([2,0,1]) )
	
	var color = getColor()
	
	sprite.set_self_modulate(Color(color[0], color[1], color[2]))
	
	deadsprite = Sprite.new()
	deadsprite.position = pos
	
	if isShort():
		deadsprite.set_texture(preload("res://Assets/Flowers/RainbowFlower-short-dead.png"))
	else:
		deadsprite.set_texture(preload("res://Assets/Flowers/RainbowFlower-dead.png"))
	deadsprite.visible = false
	deadsprite.set_self_modulate(sprite.get_self_modulate())
	
	pollinatedsprite = Sprite.new()
	pollinatedsprite.position = pos
	if isShort():
		pollinatedsprite.set_texture(preload("res://Assets/Flowers/RainbowFlower-short-pollinated.png"))
	else:
		pollinatedsprite.set_texture(preload("res://Assets/Flowers/RainbowFlower-pollinated.png"))
	pollinatedsprite.visible = false
	pollinatedsprite.set_self_modulate(sprite.get_self_modulate())
	
	