extends Node2D

onready var tilemap = get_node("TileMap")
onready var highlight = get_node("Highlight")
onready var flowercontainer = get_node("FlowerContainer")
onready var dirtmarkcontainer = get_node("DirtmarkContainer")
onready var hoeplowanimation = get_node("HoePlowAnimation")
onready var animationcontainer = get_node("AnimationContainer")
onready var player = get_node("Player")

onready var dirtList = [
	{
		"id" : 32,
		"itemName": "Normal",
		"itemIcon": tilemap.tile_set.tile_get_texture(32)
	},
	{
		"id" : 33,
		"itemName" : "Normal",
		"itemIcon": tilemap.tile_set.tile_get_texture(33)
	},
	{
		"id" : 34,
		"itemName" : "Normal",
		"itemIcon": tilemap.tile_set.tile_get_texture(34)
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
	},
	{
		"name" : "RainbowSeed",
		"id" : 2,
		"seed" : preload("res://Scripts/Biology/seeds/rainbowSeed.gd")
	},
	{
		"name" : "WaterseekerSeed",
		"id" : 3,
		"seed" : preload("res://Scripts/Biology/seeds/waterseekerSeed.gd")
	}
]

var _seedDictionary = {
	"name" : {
	},
	"id" : {
	}
}

func spawn_animation(pos, animatedSprite):
	animationcontainer.spawn_animation(pos, animatedSprite)

func _ready():
	randomize()
	for dirt in dirtList:
		dirtDictionary["name"][dirt["itemName"]] = dirt
		dirtDictionary["id"][dirt["id"]] = dirt
		
	for _seed in _seedList:
		_seedDictionary["name"][_seed.name] = _seed
		_seedDictionary["id"][_seed.id] = _seed
	
	for i in range(0, 6):
		for j in range(0, 6):
			tilemap.set_cell(j, i, 32 + randi() % 3)

func get_mouse_cell():
	return tilemap.world_to_map(get_global_mouse_position())

func highlight_cursor():
	var mouse_cell = get_mouse_cell()
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
			
			var polenMap = {}
			#polenMap[speciesId][coordinate(X,Y)]
			
			for item in seeds:
				for phase in range(3):
					
					#Selection
					var _seed = item._seed
					var _flower = _seed.flower
					
					#Phase 0
					#
					#Spread Polen if Applicable
					#Age Up
					#Ignore Ded
					if phase == 0:
						var _polen = _flower.try_polinate()
						#print("STANDO POWAH")
						print(_polen)
						
						print("Todo: After fixing coordinates, propogate polenMap to determine locations polen spreads to");
						polenMap[ _polen[0] ] = 12;
					#Phase 1
					#Look at polen spread, polinate valid targets
					elif phase == 1:
						for species in polenMap:
							for coordinates in polenMap[species]:
								#print("Trying to polinate")
								print("Todo: In phase 1, check if anything in polenMap lies at a coordinate where this a plant of the given species AND THEN polinate");
					#Phase 2
					#Age Up
					elif phase == 2:
						print("Todo: Add check to prevent plant from dying the day it was polinated in phase 2");
						print("Todo: Determine how to disperse seeds from unharvested plant");
						if _flower.isDead():
							pass
						_flower.age_up()
					
					else:
						print("Day advanced!")
				

var directions = [
	Vector2(0, 1),
	Vector2(-1, 0),
	Vector2(0, -1),
	Vector2(1, 0)
]

func plow(pos):
	print("plow: ", pos)
	tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed"].id)
	for direction in range(0, 4):
		if (tilemap.get_cellv(Vector2(
				pos.x + directions[direction].x,
				pos.y + directions[direction].y) ) != -1):
			if dirtDictionary["id"][tilemap.get_cellv(Vector2(
					pos.x + directions[direction].x,
					pos.y + directions[direction].y) )].itemName == "Normal":
				dirtmarkcontainer.add_sprite(
					Vector2(
						pos.x + directions[direction].x,
						pos.y + directions[direction].y),
					Vector2(
						(pos.x + directions[direction].x) * tilemap.cell_size.x + 6,
						(pos.y + directions[direction].y) * tilemap.cell_size.y + 6),
					(direction),
					0)
	dirtmarkcontainer.add_sprite(
		pos,
		Vector2(
			(pos.x) * tilemap.cell_size.x + 6,
			(pos.y) * tilemap.cell_size.y + 6),
		4,
		0)
	
func _on_Player_plow():
	var pos = get_mouse_cell()
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
	
	print(dirtDictionary["id"][type].itemName)
	
	if dirtDictionary["id"][type].itemName == "Normal":
		spawn_animation(Vector2(
			(pos.x) * tilemap.cell_size.x + 6,
			(pos.y) * tilemap.cell_size.y + 6),
			hoeplowanimation)
#		animationcontainer.connect("animationFinished", self, "plow", [pos])
		var animation = animationcontainer.get_node(
			str(Vector2(
				(pos.x) * tilemap.cell_size.x + 6,
				(pos.y) * tilemap.cell_size.y + 6)))
		print(animation)
		animation.connect("animation_finished", self, "plow", [pos])
	pass
	
func water(pos):
	for direction in range(0, 4):
		var newpos = Vector2(pos.x + directions[direction].x, pos.y + directions[direction].y)
		var newposglobal = Vector2(newpos.x * tilemap.cell_size.x + 6, newpos.y * tilemap.cell_size.y + 6)
		var typeid = tilemap.get_cellv(newpos)
		
		if typeid != -1:
			var typename = dirtDictionary["id"][typeid].itemName
			
			if typename == "Normal" or typename == "Plowed" or typename == "Sowed":
				dirtmarkcontainer.clear_sprite(pos, (direction))
			
			dirtmarkcontainer.water_sprite(
				newpos,
				newposglobal,
				direction)
	
	dirtmarkcontainer.water_sprite(
		pos,
		Vector2(
			(pos.x) * tilemap.cell_size.x + 6,
			(pos.y) * tilemap.cell_size.y + 6),
		4)

func _on_Player_water():
	var pos = get_mouse_cell()
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
	
	if dirtDictionary["id"][type].itemName == "Plowed":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed_Watered"].id)
		
		water(pos)
		
	if dirtDictionary["id"][type].itemName == "Sowed":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sowed_Watered"].id)
		
		water(pos)
	pass

var seeds = []

func sow(pos, item):
	var _seed = item.seedClass.new(Vector2(
		(pos.x + 0.5) * tilemap.cell_size.x,
		(pos.y) * tilemap.cell_size.y)
	)
	
	_seed.flower.sprite.name = str(seeds.size()) + "0"
	flowercontainer.add_sprite(pos, _seed.flower.sprite, 0)
	_seed.flower.set_sprite(flowercontainer.get_sprite(pos, 0))
	
	_seed.flower.deadsprite.name = str(seeds.size()) + "1"
	flowercontainer.add_sprite(pos, _seed.flower.deadsprite, 1)
	_seed.flower.set_deadsprite(flowercontainer.get_sprite(pos, 1))
	
	#Set Position
	print(pos)
	_seed.flower.pos = pos
	
	var newItem = player.hud.seedbag.ItemClass.new(item.itemName, item.itemIcon, item.itemSlot, -1, item.seedClass)
	
	seeds.push_back({
		"_seed": _seed,
		#"cell": pos,
		"originalItem" : newItem
	})

func _on_Player_sow(item):
	var pos = get_mouse_cell()
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
		
	if dirtDictionary["id"][type].itemName == "Plowed":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sowed"].id)
		
		sow(pos, item)
		
	elif dirtDictionary["id"][type].itemName == "Plowed_Watered":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sowed_Watered"].id)
		
		sow(pos, item)
	pass
	
	
func _on_Player_pick_seed():
	var pos = get_mouse_cell()
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
		
	if dirtDictionary["id"][type].itemName == "Sowed":
		for item in seeds:
			if item.cell == pos:
				var _seed = item._seed
				var flower = _seed.flower
				if flower.isDead():
					flower.pickup()
					tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed"].id)
					player.add_seed(item.originalItem)
					seeds.erase(item)
					break
				
		
	elif dirtDictionary["id"][type].itemName == "Sowed_Watered":
		for item in seeds:
			if item.cell == pos:
				var _seed = item._seed
				var flower = _seed.flower
				if flower.isDead():
					flower.pickup()
					tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed_Watered"].id)
					player.add_seed(item.originalItem)
					seeds.erase(item)
					break

func _on_HoePlowAnimation_animation_finished():
	pass # Replace with function body.
