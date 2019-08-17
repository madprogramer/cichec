extends Node2D

onready var world = get_node("World")

#const ItemClass = preload("res://Scripts/Seed.gd");
#
#var itemDictionary = {
#	0: {
#		"itemName" : "SunlightSeed",
#		"itemIcon" : preload("res://Assets/Seeds/SunlightSeed/toolbar.png"),
#		"itemValue" : -1,
#		"count" : 3,
#		"_seed" : preload("res://Scripts/Biology/seeds/sunlightSeed.gd"),
#		"dummySeed" : preload("res://Scripts/Biology/seeds/SunlightSeed/pre.gd"),
#		"seedbag" : true
#	},
#	1: {
#		"itemName" : "HeadacheSeed",
#		"itemIcon" : preload("res://Assets/Seeds/HeadacheSeed/toolbar.png"),
#		"itemValue" : -1,
#		"count" : 3,
#		"_seed" : preload("res://Scripts/Biology/seeds/headacheSeed.gd"),
#		"dummySeed" : preload("res://Scripts/Biology/seeds/HeadacheSeed/pre.gd"),
#		"seedbag" : true
#	}
#}

var itemList = []

func _ready():
	world._ready()
	world.player.hud.set_quest(["TUTORIAL"], 0)
	world.player.hud.progress_target = 1
#	world.connect("tile_hydrated", self, "progress")
	world.player.hud.connect("quest_finished", self, "quest_finished")
	
#	for item in itemDictionary:
#		var itemName = itemDictionary[item].itemName;
#		var itemIcon = itemDictionary[item].itemIcon;
#		var itemValue = itemDictionary[item].itemValue;
#		var itemSeed = itemDictionary[item]._seed
#		var itemDummySeed = itemDictionary[item].dummySeed.new()
#		var itemCount = itemDictionary[item].count
##		print(itemDummySeed.getColor())  works here
#		itemDummySeed.set_seedClass()
#		#itemList.append(ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, itemDummySeed));
#		itemList.append(ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, itemDummySeed, itemCount));
#		world.player.add_seed(itemList[itemList.size() - 1] )

func progress():
	world.player.hud.progress()

signal quest_finished

func quest_finished():
	print("QUEST FINISHED")
	emit_signal("quest_finished")