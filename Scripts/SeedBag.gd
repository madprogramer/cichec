extends GridContainer;
const ItemClass = preload("res://Scripts/Seed.gd");
const ItemSlotClass = preload("res://Scripts/ItemSlot.gd");

const slotTexture = preload("res://icon-scaled.png");
const itemImages = [
	preload("res://Assets/Highlight/Highlight.png")
];

var itemDictionary = {
	0: {
		"itemName" : "RainbowSeed",
		"itemIcon" : preload("res://Assets/Seeds/RainbowSeed/toolbar.png"),
		"itemValue" : -1,
		"_seed" : preload("res://Scripts/Biology/seeds/rainbowSeed.gd"),
		"GENES" : {
			"size": 0,
			"color": [0,0,0,0],
			"seeds": 0,
		},
		"seedbag" : true
	},
	1: {
		"itemName" : "SunlightSeed",
		"itemIcon" : preload("res://Assets/Seeds/SunlightSeed/toolbar.png"),
		"itemValue" : -1,
		"_seed" : preload("res://Scripts/Biology/seeds/sunlightSeed.gd"),
		"GENES" : {
			"size": 0,
			"color": [0,0,0,0],
			"seeds": 0,
		},
		"seedbag" : true
	},
	2: {
		"itemName": "WaterseekerSeed",
		"itemValue": -1,
		"itemIcon" : preload("res://Assets/Seeds/WaterseekerSeed/toolbar.png"),
		"_seed": preload("res://Scripts/Biology/seeds/waterseekerSeed.gd"),
		"GENES" : {
			"size": 0,
			"color": [0,0,0,0],
			"seeds": 0,
		},
		"seedbag" : true
	}
};

var slotList = Array();
var itemList = Array();

var holdingItem = null;

func _ready():
	for item in itemDictionary:
		var itemName = itemDictionary[item].itemName;
		var itemIcon = itemDictionary[item].itemIcon;
		var itemValue = itemDictionary[item].itemValue;
		var itemSeed = itemDictionary[item]._seed
		var itemGENES = itemDictionary[item].GENES
		itemList.append(ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, itemGENES));
	
	for i in range(16):
		var slot = ItemSlotClass.new(i);
		slotList.append(slot);
		add_child(slot);
		
	for i in range(itemList.size()):
		slotList[i].setItem(itemList[i])
	pass

func _input(event):
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		if holdingItem != null && holdingItem.picked:
			holdingItem.rect_global_position = Vector2(event.position.x, event.position.y);

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var clickedSlot;
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
			holdingItem.rect_global_position = Vector2(event.position.x, event.position.y);
			clickedSlot.item = null
	pass
	
func add_seed(originalItem):
	for i in range(16):
		if slotList[i].item != null:
			if slotList[i].item.itemName == originalItem.itemName:
				if (slotList[i].item.fatherId == originalItem.fatherId and slotList[i].item.motherId == originalItem.motherId) or (slotList[i].item.fatherId == originalItem.motherId and slotList[i].item.motherId == originalItem.fatherId):
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
			
			var itemSeed = originalItem.seedClass
#			print (itemSeed)
			
			var GENES = originalItem.GENES
			
			var newItem = ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed, GENES);
			
			newItem.fatherId = originalItem.fatherId
			newItem.motherId = originalItem.motherId
			
			slotList[i].setItem(newItem)
			return i
	return -1