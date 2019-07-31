extends Node2D

func _ready():
	pass
	
onready var tilemap = $TileMap
onready var highlight = $Highlight

func get_mouse_cell():
	return tilemap.world_to_map(get_global_mouse_position())

func highlight_cursor():
	var mouse_cell = get_mouse_cell()
	# print(mouse_cell.x, " ", mouse_cell.y)
	highlight.set_cellv(mouse_cell, 0)
	pass
	
func clear_highlight():
	for i in range(-100, 100):
		for j in range(-100, 100):
			highlight.set_cell(j, i, -1)

func _process(delta):
	clear_highlight()
	highlight_cursor()
	pass