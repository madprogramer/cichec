extends GridContainer;
const ItemClass = preload("res://Scripts/Seed.gd");
const ItemSlotClass = preload("res://Scripts/ItemSlot.gd");

const slotTexture = preload("res://icon-scaled.png");
const itemImages = [
	preload("res://Assets/Highlight/Highlight.png")
];

var itemDictionary = {
	0: {
		"itemName" : "WaterseekerSeed",
		"itemIcon" : preload("res://Assets/Seeds/WaterseekerSeed/toolbar.png"),
		"itemValue" : -1,
		"count" : 3,
		"_seed" : preload("res://Scripts/Biology/seeds/waterseekerSeed.gd"),
		"dummySeed" : preload("res://Scripts/Biology/seeds/WaterseekerSeed/pre.gd"),
		"seedbag" : true,
		"newFlower" : load("res://Scripts/Biology/flowers/WaterseekerFlower/flower.gd")
	}
}


var slotList = Array();
var itemList = Array();

var holdingItem = null;

func _ready():
	for item in itemDictionary:
		var itemName = itemDictionary[item].itemName;
		var itemIcon = itemDictionary[item].itemIcon;
		var itemValue = itemDictionary[item].itemValue;
		var itemSeed = itemDictionary[item]._seed
		var itemDummySeed = itemDictionary[item].dummySeed.new()
		var itemCount = itemDictionary[item].count
		var newFlower = itemDictionary[item].newFlower
#		print(itemDummySeed.getColor())  works here
		itemDummySeed.set_seedClass()
		#itemList.append(ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, itemDummySeed));
		itemList.append(ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, itemDummySeed, itemCount));
		itemList[itemList.size() - 1].newFlower = newFlower.new()
	
	for i in range(16):
		var slot = ItemSlotClass.new(i);
		slotList.append(slot);
		slotList[i].highlight_sprite.position = Vector2((i % 4) * 16 + 8, (i / 4) * 16 + 8)
		add_child(slot);
		slot.set_owner(self)
		
	for i in range(itemList.size()):
		slotList[i].setItem(itemList[i])
	pass

func _input(event):
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		if holdingItem != null && holdingItem.picked:
			holdingItem.rect_position = Vector2(event.position.x, event.position.y);

func _gui_input(event):
	var clickedSlot;
	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		for slot in slotList:
			var slotMousePos = slot.get_local_mouse_position();
			var slotTexture = slot.texture;
			var isClicked = slotMousePos.x >= 0 && slotMousePos.x <= slotTexture.get_width() && slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height();
			if isClicked:
				clickedSlot = slot;
		if clickedSlot == null:
			pass
		elif holdingItem != null:
			if clickedSlot.item != null:
				var tempItem = clickedSlot.item;
				var oldSlot = slotList[slotList.find(holdingItem.itemSlot)];
				clickedSlot.pickItem();
				clickedSlot.item = null
				clickedSlot.putItem(holdingItem);
				holdingItem = null;
				oldSlot.putItem(tempItem);
			else:
				clickedSlot.putItem(holdingItem);
				holdingItem = null;
		elif clickedSlot.item != null:
			holdingItem = clickedSlot.item;
			clickedSlot.pickItem();
			holdingItem.rect_position = Vector2(event.position.x, event.position.y);
			clickedSlot.item = null
		
	pass

func iamsorry(i):
	var clickedSlot = null;
	
	clickedSlot = slotList[i]
	
	if clickedSlot != null:
		if clickedSlot.item != null:
			remove_seed(clickedSlot.item)

const DIFF = 0.25
	
func similar(arr1, arr2):
	if arr1.size() != arr2.size():
		print("I CAN'T DO THAT, THAT IS ILLEGAL")
		return false
	
	for i in range(arr1.size()):
		var diff = abs(arr1[i] - arr2[i])
		if diff > DIFF:
			return false

	return true
	
func remove_seed(originalItem):
	#print("TODO: might need to change this to take input based on index rather than ogItem")
	if originalItem.count == 0:
		return -1
	
	for i in range(16):
		if slotList[i].item != null:
			if slotList[i].item.itemName == originalItem.itemName:
				if (slotList[i].item.fatherId == originalItem.fatherId and slotList[i].item.motherId == originalItem.motherId) or (slotList[i].item.fatherId == originalItem.motherId and slotList[i].item.motherId == originalItem.fatherId):
					if similar(slotList[i].item.dummySeed.getColor(), originalItem.dummySeed.getColor()):
						#slotList[i].item.set_count(slotList[i].item.count - 1)
							
						print("removing from slot ", i)
						print("seed count on this slot:", slotList[i].item.count-1)
						
						slotList[i].item.decrease_count()
						#if slotList[i].item.get_count() == 0:
						#	slotList[i].item.queue_free()
						#	slotList[i].item = null
							
						return i
#
#	for i in range(16):
#		if slotList[i].item == null:
#			print("removing from slot ", i)
#			var itemName = originalItem.name
#			print (itemName)
#
#			var itemIcon = originalItem.texture
#			print (itemIcon)
#
#			var itemValue = -1
#
#			var itemSeed = originalItem.dummySeed.seedClass
##			print (itemSeed)
#
##			var GENES = originalItem.GENES
#
#			var newItem = ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, originalItem.dummySeed, originalItem.count);
#
#			newItem.fatherId = originalItem.fatherId
#			newItem.motherId = originalItem.motherId
#
#			slotList[i].setItem(newItem)
#			return i
#	return -1
	
func add_seed(originalItem):
	if originalItem.count == 0:
		return -1
	
	for i in range(16):
		if slotList[i].item != null:
			if slotList[i].item.itemName == originalItem.itemName:
				if (slotList[i].item.fatherId == originalItem.fatherId and slotList[i].item.motherId == originalItem.motherId) or (slotList[i].item.fatherId == originalItem.motherId and slotList[i].item.motherId == originalItem.fatherId):
					if similar(slotList[i].item.dummySeed.getColor(), originalItem.dummySeed.getColor()):
						slotList[i].item.set_count(slotList[i].item.count + originalItem.count)
						print("adding to slot ", i)
						print("seed count on this slot:", slotList[i].item.count)
						return i
			
	for i in range(16):
		if slotList[i].item == null:
			print("ading to slot ", i)
			var itemName = originalItem.name
			print (itemName)
			
			var itemIcon = originalItem.texture
			print (itemIcon)
			
			var itemValue = -1
			
			var itemSeed = originalItem.dummySeed.seedClass
#			print (itemSeed)
			
#			var GENES = originalItem.GENES
			
			var newItem = ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, originalItem.dummySeed, originalItem.count);
			
			newItem.fatherId = originalItem.fatherId
			newItem.motherId = originalItem.motherId
			
			slotList[i].setItem(newItem)
			return i
	return -1