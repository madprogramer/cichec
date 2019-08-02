extends GridContainer;
const ItemClass = preload("res://Scripts/Seed.gd");
const ItemSlotClass = preload("res://Scripts/ItemSlot.gd");

const slotTexture = preload("res://icon-scaled.png");
const itemImages = [
	preload("res://Assets/Highlight.png")
];

const itemDictionary = {
	0: {
		"itemName": "Ring",
		"itemValue": 456,
		"itemIcon": itemImages[0],
		"_seed": null
	},
	1: {
		"itemName": "Sword",
		"itemValue": 100,
		"itemIcon": itemImages[0],
		"_seed": null
	},
	2: {
		"itemName": "Iron Ring",
		"itemValue": 987,
		"itemIcon": itemImages[0],
		"_seed": null
	},
	3: {
		"itemName": "Temp",
		"itemValue": 10000,
		"itemIcon": itemImages[0],
		"_seed": null
	},
	4: {
		"itemName" : "DummySeed",
		"itemIcon" : preload("res://Assets/Seed-cleared.png"),
		"itemValue" : -1,
		"_seed" : preload("res://Scripts/Biology/seeds/dummySeed.gd")
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
		itemList.append(ItemClass.new(itemName, itemIcon, null, itemValue, itemSeed));
	
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
		
		if holdingItem != null:
			if clickedSlot.item != null:
				var tempItem = clickedSlot.item;
				var oldSlot = slotList[slotList.find(holdingItem.itemSlot)];
				clickedSlot.pickItem();
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
	pass