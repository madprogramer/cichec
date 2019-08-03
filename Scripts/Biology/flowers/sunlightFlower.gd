extends dummyflower

class_name sunlightFlower

# Declare member variables here. Examples:

#Phenotype computations
#Phenotype computations end

# Called when the node enters the scene tree for the first time.

func _init(pos):
	sprite = Sprite.new()
	sprite.offset = pos
	print(pos)
	sprite.set_texture(preload("res://Assets/Flowers/SunlightFlower.png"))
	sprite.set_hframes(4)
	# add_child(sprite)
	# var x = 0
	# x = x / x

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
