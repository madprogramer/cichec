extends Node2D

const start_tile_size = 20

var seeds = {}

#func _ready():
#	for i in range(-2, start_tile_size + 1):
#		for j in range(-2, start_tile_size + 1):
#			seeds[Vector2(i,j)] = null
#	print("INITED SEEDS")