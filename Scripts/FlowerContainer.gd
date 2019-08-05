extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var spriteMatrix = []

func add_sprite(pos, sprite, type):
	var sprite1 = spriteMatrix[pos.x][pos.y][type]
	var sprite2 = sprite
	sprite1.offset = sprite2.offset
	sprite1.set_self_modulate(sprite2.get_self_modulate())
	sprite1.set_texture(sprite2.get_texture())
	sprite1.set_hframes(sprite2.get_hframes())
	sprite1.visible = sprite2.visible
	
func get_sprite(pos, type):
	return spriteMatrix[pos.x][pos.y][type]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, 30):
		var spriteArray = []
		for j in range(0, 30):
			var spritePhases = []
			for k in range(0, 2):
				spritePhases.push_back(Sprite.new())
			spriteArray.push_back(spritePhases)
		spriteMatrix.push_back(spriteArray)
	
	for i in range(0, 30):
		for j in range(0, 30):
			for k in range(0, 2):
				add_child(spriteMatrix[i][j][k])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
