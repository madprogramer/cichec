extends Node2D

onready var tilemap = $TileMap
onready var highlight = $Highlight

onready var dirtDictionary = {
	"name" : {
		"Normal" : {
			"id" : 8,
			"itemName": "Normal",
			"itemIcon": tilemap.tile_set.tile_get_texture(8)
		},
		"Plowed" : {
			"id" : 12,
			"itemName": "Plowed",
			"itemIcon": tilemap.tile_set.tile_get_texture(12)
		},
		"Plowed_Watered" : {
			"id" : 15,
			"itemName": "Plowed_Watered",
			"itemIcon": tilemap.tile_set.tile_get_texture(15)
		},
		"Sowed" : {
			"id" : 14,
			"itemName": "Sowed",
			"itemIcon": tilemap.tile_set.tile_get_texture(14)
		},
		"Sowed_Watered" : {
			"id" : 13,
			"itemName": "Sowed_Watered",
			"itemIcon": tilemap.tile_set.tile_get_texture(13)
		}
	},
	"id" : {
		8 : {
			"id" : 8,
			"itemName": "Normal",
			"itemIcon": tilemap.tile_set.tile_get_texture(8)
		},
		12 : {
			"id" : 12,
			"itemName": "Plowed",
			"itemIcon": tilemap.tile_set.tile_get_texture(12)
		},
		15 : {
			"id" : 15,
			"itemName": "Plowed_Watered",
			"itemIcon": tilemap.tile_set.tile_get_texture(15)
		},
		14 : {
			"id" : 14,
			"itemName": "Sowed",
			"itemIcon": tilemap.tile_set.tile_get_texture(14)
		},
		13 : {
			"id" : 13,
			"itemName": "Sowed_Watered",
			"itemIcon": tilemap.tile_set.tile_get_texture(13)
		}
	}
};

onready var seedDictionary = {
	"name" : {
		"DummySeed" : {
			"name" : "DummySeed",
			"id" : 0,
			"seed" : preload("res://Scripts/Biology/dummySeed.gd")
		}
	},
	"id" : {
		0 : {
			"name" : "DummySeed",
			"id" : 0,
			"seed" : preload("res://Scripts/Biology/dummySeed.gd")
		}
	}
}

func _ready():
	pass
	

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


func _on_Player_plow():
	var pos = get_mouse_cell()
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
	
	print(dirtDictionary["id"][type].itemName)
	
	if dirtDictionary["id"][type].itemName == "Normal":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed"].id)
	pass


func _on_Player_water():
	var pos = get_mouse_cell()
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
	
	print(dirtDictionary["id"][type].itemName)
	
	if dirtDictionary["id"][type].itemName == "Plowed":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed_Watered"].id)
	if dirtDictionary["id"][type].itemName == "Sowed":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sowed_Watered"].id)
	
	pass

var seeds = []

func _on_Player_sow(item):
	var pos = get_mouse_cell()
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
	
	print(dirtDictionary["id"][type].itemName)
	
	if dirtDictionary["id"][type].itemName == "Plowed":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sowed"].id)
		seeds.append({
			"item": item,
			"cell": pos
		})
	elif dirtDictionary["id"][type].itemName == "Plowed_Watered":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sowed_Watered"].id)
		seeds.append({
			"item": item,
			"cell": pos
		})
	
	
	pass
