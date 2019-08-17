extends Node2D

var itemInfo = {
	"itemName" : "RainbowFlower",
	"itemIcon" : preload("res://Assets/Flowers/WaterseekerFlower/toolbar.png"),
	"itemValue" : -1,
	"itemClass" : load("res://Scripts/Item.gd")
}
var itemClass = preload("res://Scripts/Item.gd")

var item

func _ready():
	item = itemClass.new(itemInfo.itemName, itemInfo.itemIcon, null, itemInfo.itemValue, itemClass)

func _init():
	_ready()