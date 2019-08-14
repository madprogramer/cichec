extends Node2D

const normal_tile_size = 6
const start_tile_size = 20

onready var audioplayer = get_node("AudioStreamPlayer")

onready var tilemap = get_node("TileMap")
onready var highlight = get_node("Highlight")

onready var ysort = get_node("YSort")

onready var flowercontainer = get_node("YSort")
onready var dirtmarkcontainer = ysort.get_node("DirtmarkContainer")

onready var hoeplowanimation = ysort.get_node("HoePlowAnimation")
onready var wateringcanwateranimation = ysort.get_node("WateringCanWaterAnimation")

onready var animationcontainer = get_node("AnimationContainer")
onready var player = ysort.get_node("Player")
onready var dialogueplayer = preload("res://Dialogues/DialogueAction.gd").new()

onready var desertanimation = get_node("DesertAnimation")

onready var dirtList = [
	{
		"id" : 35,
		"itemName": "Normal",
		"itemIcon": tilemap.tile_set.tile_get_texture(35)
	},
	{
		"id" : 36,
		"itemName" : "Normal",
		"itemIcon": tilemap.tile_set.tile_get_texture(36)
	},
	{
		"id" : 37,
		"itemName" : "Normal",
		"itemIcon": tilemap.tile_set.tile_get_texture(37)
	},
	{
		"id" : 38,
		"itemName" : "Normal",
		"itemIcon": tilemap.tile_set.tile_get_texture(38)
	},
	{
		"id" : 39,
		"itemName" : "Normal",
		"itemIcon": tilemap.tile_set.tile_get_texture(39)
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
	},
	{
		"id" : 40,
		"itemName" : "Sprinkler",
		"itemIcon" : tilemap.tile_set.tile_get_texture(40)
	},
	{
		"id" : 41,
		"itemName" : "Desert",
		"itemIcon" : tilemap.tile_set.tile_get_texture(41)
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

func is_normal(id):
	for dirt in dirtList:
		if dirt.id == id:
			if dirt.itemName == "Normal":
				return true
			else:
				return false
	return false

var seeds = {}

var songs = [
	load("res://Musics/ChokkaSong.wav"),
	load("res://Musics/ChokkaSong3.wav"),
	load("res://Musics/ChokkaSong4.wav")
]

var current_song = 0

func next_song():
	current_song += 1
	if current_song == songs.size():
		current_song = 0
	
	audioplayer.stream = songs[current_song]
	audioplayer.play()

func _ready():
	randomize()
	
	current_song = randi() % songs.size()
	audioplayer.stream = songs[current_song]
	audioplayer.play()
	
	
	"""
	for i in range(start_tile_size):
		var seedsRow = []
		for j in range(start_tile_size):
			seedsRow.push_back(null)
		seeds.push_back(seedsRow)
	"""
	
	for i in range(-2, start_tile_size + 1):
		for j in range(-2, start_tile_size + 1):
			seeds[Vector2(i,j)] = null
	
	for dirt in dirtList:
		dirtDictionary["name"][dirt["itemName"]] = dirt
		dirtDictionary["id"][dirt["id"]] = dirt
		
	for _seed in _seedList:
		_seedDictionary["name"][_seed.name] = _seed
		_seedDictionary["id"][_seed.id] = _seed
	
	for i in range(0, start_tile_size):
		for j in range(0, start_tile_size):
			tilemap.set_cell(j, i, dirtDictionary["name"]["Desert"].id)

	for i in range(0, normal_tile_size):
		for j in range(0, normal_tile_size):
			tilemap.set_cell(j, i, 35 + randi() % 5)
			
	for i in range(-2, start_tile_size + 1):
		for j in range(-2, start_tile_size + 1):
			if tilemap.get_cell(j, i) != -1 and dirtDictionary["id"][tilemap.get_cell(j, i)].itemName == "Desert":
				if i % 2 == 0:
					desertanimation.frame += 5
				desertanimation.frame = (desertanimation.frame + j * 5) % 10
				animationcontainer.spawn_animation(Vector2((i + 0.5) * tilemap.cell_size.x, (j + 0.5) * tilemap.cell_size.y), desertanimation, true)
			
	dialogueplayer.connect("started", player.hud, "dialogue_started")
	dialogueplayer.connect("finished", player.hud, "dialogue_finished")
	dialogueplayer._ready()
	add_child(dialogueplayer)

func get_mouse_cell():
	return tilemap.world_to_map(get_global_mouse_position())

func highlight_cursor():
	var mouse_cell = get_mouse_cell()
	highlight.set_cellv(mouse_cell, 0)
	
func clear_highlight():
	for i in range(-100, 100):
		for j in range(-100, 100):
			highlight.set_cell(j, i, -1)

func _process(delta):
#	print("FLAG3")
#	dialogueplayer.connect("text_changed", player.hud, "change_dialogue_text", [dialogueplayer.dialogue[str(dialogueplayer.line)]])
	clear_highlight()
	highlight_cursor()
#	var localMousePos = get_local_mouse_position()
#	var globalMousePos = get_global_mouse_position()
#
#	if localMousePos.x < 0:
#		get_viewport().warp_mouse(Vector2(0 + globalMousePos.x - localMousePos.x, globalMousePos.y))
#	if localMousePos.x > 64:
#		get_viewport().warp_mouse(Vector2(64 + globalMousePos.x - localMousePos.x, globalMousePos.y))
#
#	if localMousePos.y < 0:
#		get_viewport().warp_mouse(Vector2(globalMousePos.x, 0 + globalMousePos.y - localMousePos.y))
#	if localMousePos.y > 64:
#		get_viewport().warp_mouse(Vector2(globalMousePos.x, 64 + globalMousePos.y - localMousePos.y))
	
	pass
	
func pass_day():
	var polenMap = {}
	#polenMap[speciesId][coordinate(X,Y)]
	
	#for i in range(seeds.size()):	for j in range(seeds[i].size()):
	for i in range(start_tile_size + 1):	for j in range(start_tile_size + 1):
		var item = seeds[Vector2(i,j)]
		
		if item == null:
			continue
		
		var _seed = item._seed
		var _flower = _seed.flower
		
		# 『STAND NAME: BOOST』『STAND USER: SUNLIGHT FLOWER』
		if !_flower.isDead() and !_flower.isPolinated():
			if _flower.id == 1:
				boost_main(Vector2(i, j))
	
	for i in range(start_tile_size + 1):	for j in range(start_tile_size + 1):
		var item = seeds[Vector2(i,j)]
		
		if item == null:
			continue
		for phase in range(5):
#			print("phase: ", phase)
			
			#Selection
			var _seed = item._seed
			var _flower = _seed.flower
			
			#Phase 0
			#
			#Spread Polen if Applicable
			#Age Up
			#Ignore Ded
			if phase == 0:
				print(Vector2(i, j), _flower.id)
				var _polen = _flower.try_polinate()
				#print("STANDO POWAH")
				if _polen.size() > 0:
					#print("Todo: After fixing coordinates, propogate polenMap to determine locations polen spreads to");
					for p in _polen:
						if not p[0] in polenMap:
							polenMap[ p[0] ] = {} 
						polenMap[ p[0] ][ p[1] ] = p;
			#Phase 1
			#Look at polen spread, polinate valid targets
			elif phase == 1:
				for species in polenMap:
					for coordinates in polenMap[species]:
#						print("Polinating " + String(coordinates) + " with " + String(species) + " polen.")
						#print("Trying to polinate")
						#print("Todo: In phase 1, check if anything in polenMap lies at a coordinate where this a plant of the given species AND THEN polinate");
						var polenData = polenMap[species][coordinates]
						var seedAt
						var flowerAt
						var speciesAt
						
						if seeds.has(polenData[1]) and seeds[polenData[1]] != null:
							seedAt = seeds[polenData[1]]._seed
							flowerAt = seedAt.flower
							speciesAt = flowerAt.id
						else:
							continue
						

						#print("Species at location:")
						#print(speciesAt)

						polenData[3][1] = flowerAt.uniqueId
						print(polenData[3])

						#FIXTHIS'e flowermap'ten species'ı aynı olan çiçeğin id'si kullnalıcak
						#ID farklıysa atla
						
						if speciesAt == species and !flowerAt.isDead():
#							print("pollinating")
							flowerAt.getPolinated(polenData)
						#use FIXTHIS.harvest() to collect
			
			#Phase 2
			#Age Up
			elif phase == 2:
				#print("Todo: Add waterseeker trigerred sand tile to earth updates here");
				if !_flower.isDead() and !_flower.isPolinated():
					if _flower.id == 3:
						cultivate_main(Vector2(i, j))
					
				
			#Phase 3
			#Age Up
			elif phase == 3:
				#print("Todo: Add check to prevent plant from dying the day it was polinated in phase 2");
				if _flower.isDead():
					pass
				if _flower.isPolinated():
					print("Todo: Determine how to disperse seeds from unharvested plant");
					pass
				_flower.age_up()
			
			elif phase == 4:
				print("Day advanced!")
			
	get_tree().call_group("Sprinklers", "water")
	
	yield(get_tree(), "idle_frame")
	
	for i in range(0, start_tile_size):
		for j in range(0, start_tile_size):
			var type = tilemap.get_cell(j, i)
			var name = dirtDictionary["id"][type].itemName
			
			if name == "Sowed_Watered":
				plow(Vector2(j, i))
				tilemap.set_cell(j, i, dirtDictionary["name"]["Sowed"].id)
			elif name == "Plowed_Watered":
				plow(Vector2(j, i))
				tilemap.set_cell(j, i, dirtDictionary["name"]["Plowed"].id)
			elif name == "Plowed":
				if (randf() > 0.40):
					deplow(Vector2(j, i))
					tilemap.set_cell(j, i, dirtDictionary["name"]["Normal"].id)
			elif name == "Sowed":
				kill_plant(Vector2(j, i))
					
	get_tree().call_group("Sprinklers", "activate")

func boost_main(pos):
	for i in range(-1, 1 + 1):
		for j in range(-1, 1 + 1):
			var targetpos = pos + Vector2(i, j)
			var targetitem = seeds[targetpos]
			if targetitem == null:
				continue
			
			var targetseed = targetitem._seed
			var targetflower = targetseed.flower
			
			targetflower.boost()

signal tile_hydrated

func cultivate(pos):
	print("trying to cultivate: ", pos)
	tilemap.set_cellv(pos, dirtDictionary["name"]["Normal"].id)
	pos = Vector2((pos.x + 0.5) * tilemap.cell_size.x, (pos.y + 0.5) * tilemap.cell_size.y)
	animationcontainer.get_node(str(pos)).queue_free()
	emit_signal("tile_hydrated")

func cultivate_main(pos):
	print("cultivate_main: ", pos)
	var times = randi()% 4
	for i in times :
		var xr = randi()%4 - 2
		var yr = randi()%4 - 2
		
		var targetpos = pos + Vector2(xr, yr)
		
		var type = tilemap.get_cellv(targetpos)
		
		if type == -1:
			continue
		
		if dirtDictionary["id"][type].itemName == "Desert":
			cultivate(targetpos)
	


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			if player.hud.dialogue_is_playing == false:
				dialogueplayer.interact("res://Dialogues/test_dialogue.json")
				dialogueplayer.connect("text_changed", player.hud, "change_dialogue_text")

		if event.pressed and event.scancode == KEY_CONTROL:
			pass_day()
		if event.pressed and event.scancode == KEY_R:
			emit_signal("tile_hydrated")
		if event.pressed and event.scancode == KEY_N:
			next_song()

func cursor_outside_of_window():
	#print("pos: ", get_viewport().get_mouse_position())
	var pos = get_viewport().get_mouse_position()
	if pos.x >= 0 and pos.x <= 64 and pos.y >= 0 and pos.y <= 64:
		return false
	return true
	

var directions = [
	Vector2(0, 1),
	Vector2(-1, 0),
	Vector2(0, -1),
	Vector2(1, 0)
]

func kill_plant(pos):
	seeds[pos]._seed.flower.set_dead()

func deplow(pos):
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
					(4),
					0)
	dirtmarkcontainer.add_sprite(
		pos,
		Vector2(
			(pos.x) * tilemap.cell_size.x + 6,
			(pos.y) * tilemap.cell_size.y + 6),
		4,
		0)

func plow(pos):
#	print("plow: ", pos)
	tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed"].id)
	for direction in range(0, 4):
		if (tilemap.get_cellv(Vector2(
				pos.x + directions[direction].x,
				pos.y + directions[direction].y) ) != -1):
			var dirtNameAtTarget = dirtDictionary["id"][tilemap.get_cellv(Vector2(
					pos.x + directions[direction].x,
					pos.y + directions[direction].y) )].itemName
			if dirtNameAtTarget == "Normal" or dirtNameAtTarget == "Plowed":
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

func _plow_Routine(pos):
	spawn_animation(Vector2(
	(pos.x) * tilemap.cell_size.x + 6,
	(pos.y) * tilemap.cell_size.y + 6),
	hoeplowanimation)
#		animationcontainer.connect("animationFinished", self, "plow", [pos])
	var animation = animationcontainer.get_node(
	str(Vector2(
		(pos.x) * tilemap.cell_size.x + 6,
		(pos.y) * tilemap.cell_size.y + 6)))
#		print(animation)
	animation.connect("animation_finished", self, "plow", [pos])

func removeCrop(pos, debugMode = true):
	if debugMode:
		print("PRINTING")
		print(seeds[pos]._seed.flower.phenoGenes)
		_pick_seed_Routine(pos, true)
	else:
		pass 

func _on_Player_plow():
	var pos = get_mouse_cell()
	
	if cursor_outside_of_window():
		return
	
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
	
#	print(dirtDictionary["id"][type].itemName)
	
	#Plow normal soil
	if dirtDictionary["id"][type].itemName == "Normal":
		_plow_Routine(pos)
	
	#Plow to remove crops
	elif dirtDictionary["id"][type].itemName == "Sowed":
		_plow_Routine(pos)
		removeCrop(pos)
	
	#Plow to remove watered crops
	elif dirtDictionary["id"][type].itemName == "Sowed_Watered":
		_plow_Routine(pos)
		removeCrop(pos)
		
	pass
	
func water(pos):
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
	
	if dirtDictionary["id"][type].itemName == "Plowed":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed_Watered"].id)
	elif dirtDictionary["id"][type].itemName == "Sowed":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sowed_Watered"].id)
	else:
		return
		
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
	
	if cursor_outside_of_window():
		return
	
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
	
	if dirtDictionary["id"][type].itemName == "Plowed" or dirtDictionary["id"][type].itemName == "Sowed":
		spawn_animation(Vector2(
			(pos.x) * tilemap.cell_size.x + 6,
			(pos.y) * tilemap.cell_size.y + 6),
			wateringcanwateranimation)
#		animationcontainer.connect("animationFinished", self, "plow", [pos])
		var animation = animationcontainer.get_node(
			str(Vector2(
				(pos.x) * tilemap.cell_size.x + 6,
				(pos.y) * tilemap.cell_size.y + 6)))
		print(animation)
		animation.connect("animation_finished", self, "water", [pos])
	pass

func sow(pos, item):
	print("itempos:", pos)

	var _seed = item.dummySeed.seedClass.new(Vector2(
		(pos.x + 0.5) * tilemap.cell_size.x,
		(pos.y) * tilemap.cell_size.y),
		item.dummySeed.GENES
	)
	
#	var x = 0
#	x = x / x
#	var _seed = item.dummySeed.seedClass
	
#	var class1 = item.seedClass
#	var class2 = item.dummySeed
	
	_seed.flower.fatherId = item.fatherId
	_seed.flower.motherId = item.motherId
	
	_seed.flower.set_seed(item)
	_seed.flower.set_newFlower(item.newFlower.itemInfo)
	
	_seed.flower.sprite.name = str(seeds.size()) + "0"
	flowercontainer.add_sprite(pos, _seed.flower.sprite, 0)
	_seed.flower.set_sprite(flowercontainer.get_sprite(pos, 0))
	
	_seed.flower.deadsprite.name = str(seeds.size()) + "1"
	flowercontainer.add_sprite(pos, _seed.flower.deadsprite, 1)
	_seed.flower.set_deadsprite(flowercontainer.get_sprite(pos, 1))
	
	_seed.flower.pollinatedsprite.name = str(seeds.size()) + "2"
	flowercontainer.add_sprite(pos, _seed.flower.pollinatedsprite, 2)
	_seed.flower.set_pollinatedsprite(flowercontainer.get_sprite(pos, 2))
	
	#Set Position
#	print(pos)
	_seed.flower.pos = pos
	
	var newItem = player.hud.seedbag.ItemClass.new(item.itemName, item.itemIcon, item.itemSlot, -1, item.seedClass, item.dummySeed, item.count)
	
	newItem.fatherId = item.fatherId
	newItem.motherId = item.motherId
	
	seeds[pos] = {
		"_seed": _seed,
		#"cell": pos,
		"originalItem" : newItem
	}

func _on_Player_sow(item):
	var pos = get_mouse_cell()
	
	if cursor_outside_of_window():
		return
	
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
		
	if dirtDictionary["id"][type].itemName == "Plowed":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sowed"].id)
		player.decrease(player.get_current_item())
		sow(pos, item)
		
	elif dirtDictionary["id"][type].itemName == "Plowed_Watered":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sowed_Watered"].id)
		player.decrease(player.get_current_item())
		sow(pos, item)
	pass

	

func _pick_seed_Routine(pos, force = false):
	#print("am I forcing")
	#print(force)
	
	var type = tilemap.get_cellv(pos)
	
	if type == -1:
		return
	
	if force:
		var item = seeds[pos]
		if item == null:
			return
		print(item._seed.id)
		
		var _seed = item._seed
		var flower = _seed.flower
		
		if dirtDictionary["id"][type].itemName == "Sowed":
			tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed"].id)
		else:
			tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed_Watered"].id)

		if flower.isMature() and !flower.isDead() and !flower.isPolinated():
			flower = flower.pickup()
			player.add_flower(flower.newFlower)
			seeds[pos] = null
			
		elif flower.isDead() or flower.isPolinated():
			player.add_seed(flower.newSeed)
			flower.harvest()
			seeds[pos] = null
		return
		
	if dirtDictionary["id"][type].itemName == "Sowed" or dirtDictionary["id"][type].itemName == "Sowed_Watered":
		var item = seeds[pos]
		if item == null:
			return
		print(item._seed.id)
		
		var _seed = item._seed
		var flower = _seed.flower
		
		print(flower.isDead())
		print(flower.isPolinated())
		print(flower.isMature())
		
		if flower.isDead() or flower.isPolinated() or (!flower.isDead() and !flower.isPolinated() and flower.isMature()):
			
			if dirtDictionary["id"][type].itemName == "Sowed":
				tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed"].id)
			else:
				tilemap.set_cellv(pos, dirtDictionary["name"]["Plowed_Watered"].id)
				
			if flower.isMature() and !flower.isDead() and !flower.isPolinated():
				print("WRYYYYYYYYYYYYYYY")
				flower = flower.pickup()
				player.add_flower(flower.newFlower)
				seeds[pos] = null
				
			elif flower.isDead() or flower.isPolinated():
				print("WRY?")
				player.add_seed(flower.newSeed)
				flower.harvest()
				seeds[pos] = null
			return
				
	
	
func _on_Player_pick_seed():
	var pos = get_mouse_cell()
	
	if cursor_outside_of_window():
		return
	_pick_seed_Routine(pos)
	

func _on_HoePlowAnimation_animation_finished():
	pass # Replace with function body.


func _on_WateringCanWaterAnimation_animation_finished():
	pass # Replace with function body.


func _on_Player_scan():
	# Very ugly, but couldn't think of anything else
	player.get_current_item().scan(get_mouse_cell(), seeds)
	pass # Replace with function body.


# I wait outside the pilgrim's door, with insufficient schemes 
func _on_ExitDoor_body_shape_entered(body_id, body, body_shape, area_shape):
	if body == player:
		pass_day()
		player.position = Vector2(32, 32)
	pass # Replace with function body.


func _on_Sprinkler_sprinkler_water(pos):
#	print("Sprinkler finished at ", pos)
	var cellpos = tilemap.world_to_map(pos)
#	print("...and it's cell position: ", cellpos)
	for i in range(-1, 2):
		for j in range(-1, 2):
			water(Vector2(cellpos.x + i, cellpos.y + j))

func _on_Player_spawn_sprinkler():
	var pos = get_mouse_cell()
	if dirtDictionary["id"][tilemap.get_cellv(pos)].itemName == "Normal":
		tilemap.set_cellv(pos, dirtDictionary["name"]["Sprinkler"].id)
		var sprinkler = player.get_current_item().spawn(Vector2(
			(pos.x + 0.5) * tilemap.cell_size.x,
			(pos.y + 0.5) * tilemap.cell_size.y))
#		print(sprinkler)
		sprinkler.connect("sprinkler_water", self, "_on_Sprinkler_sprinkler_water")
		get_node("YSort").add_child(sprinkler)
#		print("sprinkler.global_position: ", sprinkler.global_position)


func _on_Sprinkler2_sprinkler_water(pos):
	_on_Sprinkler_sprinkler_water(pos)
	pass # Replace with function body.

func _on_AudioStreamPlayer_finished():
	next_song()
	pass # Replace with function body.
