#extends Node2D
#
#class_name pickedDummyFlower
#
#var itemInfo = {
#	"itemName" : "sprinkler_spawner",
#	"itemIcon" : load("res://Assets/Items/SprinklerSpawner/Icon.png"),
#	"itemValue" : -1,
#	"itemClass" : load("res://Scripts/Item.gd")
#}
#var itemClass = preload("res://Scripts/Item.gd")
#
#var item
#
#func _ready():
#	item = itemClass.new(itemInfo.itemName, itemInfo.itemIcon, null, itemInfo.itemValue)