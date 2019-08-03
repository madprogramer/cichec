extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var spriteMatrix = []

func add_sprite(pos, sprite):
	var sprite1 = spriteMatrix[pos.x][pos.y]
	var sprite2 = sprite
	sprite1.offset = sprite2.offset
	sprite1.set_texture(sprite2.get_texture())
	sprite1.set_hframes(sprite2.get_hframes())
	
func get_sprite(pos):
	return spriteMatrix[pos.x][pos.y]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, 200):
		var spriteArray = []
		for j in range(0, 200):
			spriteArray.push_back(Sprite.new())
		spriteMatrix.push_back(spriteArray)
	
	for i in range(0, 200):
		for j in range(0, 200):
			add_child(spriteMatrix[i][j])
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
