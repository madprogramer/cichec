extends Node2D

onready var tilemap = $TileMap
onready var highlight = $Highlight

onready var dirtList = [
	{
		"id" : 8,
		"itemName": "Normal",
		"itemIcon": tilemap.tile_set.tile_get_texture(8)
	},
	{
		"id" : 16,
		"itemName": "Plowed",
		"itemIcon": tilemap.tile_set.tile_get_texture(16)
	},
	{
		"id" : 17,
		"itemName": "Plowed_Watered",
		"itemIcon": tilemap.tile_set.tile_get_texture(17)
	},
	{
		"id" : 19,
		"itemName": "Sowed",
		"itemIcon": tilemap.tile_set.tile_get_texture(19)
	},
	{
		"id" : 18,
		"itemName": "Sowed_Watered",
		"itemIcon": tilemap.tile_set.tile_get_texture(18)
	}
]

var dirtDictionary = {
	"name" : {
		
	},
	"id" : {
		
	}
}

#onready var dirtDictionary = {
#	"name" : {
#		"Normal" : {
#			"id" : 8,
#			"itemName": "Normal",
#			"itemIcon": tilemap.tile_set.tile_get_texture(8)
#		},
#		"Plowed" : {
#			"id" : 16,
#			"itemName": "Plowed",
#			"itemIcon": tilemap.tile_set.tile_get_texture(16)
#		},
#		"Plowed_Watered" : {
#			"id" : 17,
#			"itemName": "Plowed_Watered",
#			"itemIcon": tilemap.tile_set.tile_get_texture(17)
#		},
#		"Sowed" : {
#			"id" : 19,
#			"itemName": "Sowed",
#			"itemIcon": tilemap.tile_set.tile_get_texture(19)
#		},
#		"Sowed_Watered" : {
#			"id" : 18,
#			"itemName": "Sowed_Watered",
#			"itemIcon": tilemap.tile_set.tile_get_texture(18)
#		}
#	},
#	"id" : {
#		8 : {
#			"id" : 8,
#			"itemName": "Normal",
#			"itemIcon": tilemap.tile_set.tile_get_texture(8)
#		},
#		16 : {
#			"id" : 16,
#			"itemName": "Plowed",
#			"itemIcon": tilemap.tile_set.tile_get_texture(16)
#		},
#		17 : {
#			"id" : 17,
#			"itemName": "Plowed_Watered",
#			"itemIcon": tilemap.tile_set.tile_get_texture(17)
#		},
#		19 : {
#			"id" : 19,
#			"itemName": "Sowed",
#			"itemIcon": tilemap.tile_set.tile_get_texture(19)
#		},
#		18 : {
#			"id" : 18,
#			"itemName": "Sowed_Watered",
#			"itemIcon": tilemap.tile_set.tile_get_texture(18)
#		}
#	}
#};

onready var _seedList = [
	{
		"name" : "DummySeed",
		"id" : 0,
		"seed" : preload("res://Scripts/Biology/seeds/dummySeed.gd")
	},
	{
		"name" : "SunlightSeed",
		"id" : 1,
		"seed" : preload("res://Scripts/Biology/seeds/sunlightSeed.gd")
	}
]

var _seedDictionary = {
	"name" : {
	},
	"id" : {
	}
}
#onready var seedDictionary = {
#	"name" : {
#		"DummySeed" : {
#			"name" : "DummySeed",
#			"id" : 0,
#			"seed" : preload("res://Scripts/Biology/seeds/dummySeed.gd")
#		}
#	},
#	"id" : {
#		0 : {
#			"name" : "DummySeed",
#			"id" : 0,
#			"seed" : preload("res://Scripts/Biology/seeds/dummySeed.gd")
#		}
#	}
#}

func _ready():
	for dirt in dirtList:
		dirtDictionary["name"][dirt["itemName"]] = dirt
		dirtDictionary["id"][dirt["id"]] = dirt
		
	for _seed in _seedList:
		_seedDictionary["name"][_seed.name] = _seed
		_seedDictionary["id"][_seed.id] = _seed
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

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_CONTROL:
			for item in seeds:
				var _seed = item._seed
				_seed.flower.age_up()
		


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
		var _seed = item.seedClass.new(Vector2(pos.x * 16 + 8, pos.y * 16))
		print (_seed)
		_seed.flower.sprite.name = str(seeds.size())
		add_child(_seed.flower.sprite)
		seeds.push_back({
			"_seed": _seed,
			"cell": pos
		})
	elif dirtDictionary["id"][type].itemName == "Plowed_Watered":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sowed_Watered"].id)
		var _seed = item.seedClass.new(Vector2(pos.x * 16 + 8, pos.y * 16))
		print (_seed)
		_seed.flower.sprite.name = str(seeds.size())
		add_child(_seed.flower.sprite)
		seeds.push_back({
			"_seed": _seed,
			"cell": pos
		})
	pass