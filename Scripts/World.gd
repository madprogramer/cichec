extends Node2D

onready var tilemap = $TileMap
onready var highlight = $Highlight
onready var flowercontainer = $FlowerContainer

onready var dirtList = [
	{
		"id" : 30,
		"itemName": "Normal",
		"itemIcon": tilemap.tile_set.tile_get_texture(30)
	},
	{
		"id" : 26,
		"itemName": "Plowed",
		"itemIcon": tilemap.tile_set.tile_get_texture(26)
	},
	{
		"id" : 27,
		"itemName": "Plowed_Watered",
		"itemIcon": tilemap.tile_set.tile_get_texture(27)
	},
	{
		"id" : 28,
		"itemName": "Sowed",
		"itemIcon": tilemap.tile_set.tile_get_texture(28)
	},
	{
		"id" : 29,
		"itemName": "Sowed_Watered",
		"itemIcon": tilemap.tile_set.tile_get_texture(29)
	}
]

var dirtDictionary = {
	"name" : {
		
	},
	"id" : {
		
	}
}

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

func _ready():
	randomize()
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
		var _seed = item.seedClass.new(Vector2((pos.x + 0.5) * tilemap.cell_size.x , (pos.y) * tilemap.cell_size.y))
		# print (_seed)
		_seed.flower.sprite.name = str(seeds.size())
		# add_child(_seed.flower.sprite)
		flowercontainer.add_sprite(pos, _seed.flower.sprite)
		_seed.flower.set_sprite(flowercontainer.get_sprite(pos))
		seeds.push_back({
			"_seed": _seed,
			"cell": pos
		})
	elif dirtDictionary["id"][type].itemName == "Plowed_Watered":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sowed_Watered"].id)
		var _seed = item.seedClass.new(Vector2((pos.x + 0.5) * tilemap.cell_size.x , (pos.y) * tilemap.cell_size.y))
		# print (_seed)
		_seed.flower.sprite.name = str(seeds.size())
		# add_child(_seed.flower.sprite)
		flowercontainer.add_sprite(pos, _seed.flower.sprite)
		_seed.flower.set_sprite(flowercontainer.get_sprite(pos))
		seeds.push_back({
			"_seed": _seed,
			"cell": pos
		})
	pass