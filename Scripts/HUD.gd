extends Node2D

enum TileID {
	DIRT,
	WATERED_DIRT,
	PLOVED_DIRT,
	WATERED_PLOVED_DIRT,
	SOWED_DIRT,
	WATERED_SOWED_DIRT
}

onready var tilemap = $CanvasLayer/TileMap

func change_cell(cell, id):
	if cell == 0:
		

func _process(delta):
	
	pass

func _ready():
	pass