extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var spriteArray = []

func add_sprite(pos, sprite, type):
	spriteArray[type] = Sprite.new()
	var sprite1 = spriteArray[type]
	var sprite2 = sprite
#	sprite1.offset = sprite2.offset
	sprite1.position = sprite2.position
	sprite1.set_self_modulate(sprite2.get_self_modulate())
	sprite1.set_texture(sprite2.get_texture())
	sprite1.set_hframes(sprite2.get_hframes())
	sprite1.set_frame(0)
	sprite1.visible = sprite2.visible
	add_child(spriteArray[type])
	spriteArray[type].set_owner(self)
	
func get_sprite(pos, type):
	return spriteArray[type]

func add_dummyFlower(type, sprite):
	if type == 0:
		add_sprite(Vector2(0, 0), sprite, type)
	elif type == 1:
		add_sprite(Vector2(48, 0), sprite, type)
	else:
		assert(false)

func _ready():
	for k in range(0, 2):
		spriteArray.push_back(null)
