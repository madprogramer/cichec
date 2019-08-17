extends Node

class_name salesManager

var price = {
	"sprinkler_spawner" : 500,
	"scanner" : 1000
}
# Called when the node enters the scene tree for the first time.

func _ready():
	pass # Replace with function body.

func sizeBonus(price,item):
	if item is dummyflower and not item.isShort():
		price *= 1.5
	return price
	
func colorBonus(price, item, color):
	return price

func bonuses(item): 
	var p = price[item.itemName]
	p = sizeBonus(price,item)
	p = colorBonus(price,item,[0,0,0])
	return p

func makeSales(soldStuff):
	print("TODO: Find a way to make sales informative")
	print("TODO: Bonuses BASED ON rules")
	
	var PROFIT = 0
	
	#Assuming Array
	for stuff in soldStuff:
		print(stuff)
		PROFIT += bonuses(stuff)
		
	return {earning: PROFIT}