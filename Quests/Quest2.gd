extends Node2D

onready var world = get_node("World")

const ItemClass = preload("res://Scripts/Seed.gd");

var itemDictionary = {
	0: {
		"itemName" : "RainbowSeed",
		"itemIcon" : preload("res://Assets/Seeds/RainbowSeed/toolbar.png"),
		"itemValue" : -1,
		"count" : 3,
		"_seed" : preload("res://Scripts/Biology/seeds/rainbowSeed.gd"),
		"dummySeed" : preload("res://Scripts/Biology/seeds/RainbowSeed/rainblue.gd"),
		"seedbag" : true
	},
	1: {
		"itemName" : "RainbowSeed",
		"itemIcon" : preload("res://Assets/Seeds/RainbowSeed/toolbar.png"),
		"itemValue" : -1,
		"count" : 3,
		"_seed" : preload("res://Scripts/Biology/seeds/rainbowSeed.gd"),
		"dummySeed" : preload("res://Scripts/Biology/seeds/RainbowSeed/rainred.gd"),
		"seedbag" : true
	}
}

var itemList = []

func ready():
	world.player.hud.set_quest(["SELL 40 UNITS OF", "MEDICINE"], 0)
	world.player.hud.progress = 0
	world.player.hud.progress_target = 40
	world.connect("medicine_collected", self, "progress")
	world.player.hud.connect("quest_finished", self, "quest_finished")
	
	for item in itemDictionary:
		var itemName = itemDictionary[item].itemName;
		var itemIcon = itemDictionary[item].itemIcon;
		var itemValue = itemDictionary[item].itemValue;
		var itemSeed = itemDictionary[item]._seed
		var itemDummySeed = itemDictionary[item].dummySeed.new()
		var itemCount = itemDictionary[item].count
#		print(itemDummySeed.getColor())  works here
		itemDummySeed.set_seedClass()
		#itemList.append(ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, itemDummySeed));
		itemList.append(ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, itemDummySeed, itemCount));
		world.player.add_seed(itemList[itemList.size() - 1] )

func progress():
	world.player.hud.progress()

signal quest_finished

func quest_finished():
	print("QUEST FINISHED")
	emit_signal("quest_finished")