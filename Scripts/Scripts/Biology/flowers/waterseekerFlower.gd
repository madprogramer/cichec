extends dummyflower

class_name waterseekerFlower

# Declare member variables here. Examples:

#Phenotype computations
#Phenotype computations end

# Called when the node enters the scene tree for the first time.



func _init(pos, GENES):
	
	set_genes(GENES)
	id = 3;
	
	#Stages
	stages = [
		1,
		3,
		5,
		12
	];

	
	randomize()
	uniqueId = randi()
	
	sprite = Sprite.new()
	sprite.position = pos
	print(pos)
	if isShort():
		sprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower-short.png"))
	else:
		sprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower.png"))
	sprite.set_hframes(4)
	
	deadsprite = Sprite.new()
	deadsprite.position = pos
	if isShort():
		deadsprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower-short-dead.png"))
	else:
		deadsprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower-dead.png"))
	deadsprite.visible = false
	
	pollinatedsprite = Sprite.new()
	pollinatedsprite.position = pos
	if isShort():
		pollinatedsprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower-short-pollinated.png"))
	else:
		pollinatedsprite.set_texture(preload("res://Assets/Flowers/WaterseekerFlower-pollinated.png"))
	pollinatedsprite.visible = false
	
	for i in range(1000):
		pass
		
	var color = getColor()
	
	var ColorManager = colors.new()
	
#	print("GENES: ", GENES)
	setColor( ColorManager.RYB2RGB([color[0],color[1],color[2] ]) )
		
	var colors_array = color#ColorManager.RYB2RGB(color)
		
#	var colors_array = getColor()
#	print("colors_array: ", colors_array)
		
	sprite.set_self_modulate(Color(colors_array[0], colors_array[1], colors_array[2]))
	deadsprite.set_self_modulate(sprite.get_self_modulate())
	pollinatedsprite.set_self_modulate(sprite.get_self_modulate())
	
func cultivate():
	if( current_stage == 3 ):
		print("Spreading water around, probably")