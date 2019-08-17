extends Node2D

var itemInfo = {
	"itemName" : "WaterseekerFlower",
	"itemIcon" : preload("res://Assets/Flowers/WaterseekerFlower/toolbar.png"),
	"itemValue" : -1,
	"itemClass" : load("res://Scripts/Item.gd")
}
var itemClass = preload("res://Scripts/Item.gd")

var item

func _ready():
	item = itemClass.new(itemInfo.itemName, itemInfo.itemIcon, null, itemInfo.itemValue, itemInfo.itemClass)
	print(item.texture)
	item.itemInfo = itemInfo
	item.set_newFlower(item)
#	item.newFlower.texture = item.texture

func _init():
	_ready()