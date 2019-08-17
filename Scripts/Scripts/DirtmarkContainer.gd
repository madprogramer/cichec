extends Node2D

var dirtmarks = []
var dirtmarkswater = []

var spriteMatrix = []

func global_direction(direction):
	return (direction - 0 + 4) % 4

func reverse_direction(direction):
	return (direction + 2) % 4

func add_sprite(pos, globalpos, direction, type):
#	print(pos)
#	print(direction)
	# print(globalpos)
	if direction == 4:
		for i in range(0, 4):
			spriteMatrix[pos.x][pos.y][i].visible = false
	else:
		if type == 0:
			spriteMatrix[pos.x][pos.y][direction].texture = dirtmarks[direction].texture
		elif type == 1:
			spriteMatrix[pos.x][pos.y][direction].texture = dirtmarkswater[direction].texture
		spriteMatrix[pos.x][pos.y][direction].rotation = dirtmarks[direction].rotation
		spriteMatrix[pos.x][pos.y][direction].global_position = globalpos
		spriteMatrix[pos.x][pos.y][direction].visible = true
	
func clear_sprite(pos, direction):
	spriteMatrix[pos.x][pos.y][direction].free()
	spriteMatrix[pos.x][pos.y][direction] = Sprite.new()
	
func water_sprite(pos, globalpos, direction):
	add_sprite(pos, globalpos, direction, 1)
#	direction = global_direction(direction)
#	print(pos)
#	print(direction)
#	#if 1:
#	if direction == 4:
#		for i in range(0, 4):
#			spriteMatrix[pos.x][pos.y][i].visible = false
#	else:
#		spriteMatrix[pos.x][pos.y][direction].set_texture(dirtmarkswater[direction].get_texture())
#		spriteMatrix[pos.x][pos.y][direction].set_rotation_degrees(dirtmarkswater[direction].get_rotation_degrees())
#		spriteMatrix[pos.x][pos.y][direction].global_position = globalpos
#
func _ready():
	var dirtmarksprite = Sprite.new()
	dirtmarksprite.set_texture(preload("res://Assets/Dirt/DirtMarks/1.png"))
	
	for i in range(0, 4):
		var newdirtmark = Sprite.new()
		newdirtmark.set_texture(dirtmarksprite.get_texture())
		newdirtmark.set_rotation_degrees(global_direction(i) * 90 )
		dirtmarks.push_back(newdirtmark)
	
	var dirtmarkspritewater = Sprite.new()
	dirtmarkspritewater.set_texture(preload("res://Assets/Dirt/DirtMarks/2.png"))
	
	for i in range(0, 4):
		# print("<", i, ">")
		var newdirtmarkwater = Sprite.new()
		newdirtmarkwater.set_texture(dirtmarkspritewater.get_texture())
		newdirtmarkwater.set_rotation_degrees(i * 90)
		dirtmarkswater.push_back(newdirtmarkwater)
	
	
	
	for i in range(0, 30):
		var spriteArray = []
		for j in range(0, 30):
			var spriteSides = []
			for k in range(0, 4):
				var sprite = Sprite.new()
				spriteSides.push_back(sprite)
			spriteArray.push_back(spriteSides)
		spriteMatrix.push_back(spriteArray)
#
	for i in range(0, 30):
		for j in range(0, 30):
#			add_child(spriteMatrix[i][j][0])
			for k in range(0, 4):
#				print(spriteMatrix[i][j][k])
				add_child(spriteMatrix[i][j][k])
				spriteMatrix[i][j][k].set_owner(self)
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
