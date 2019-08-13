extends GridContainer;
const ItemClass = preload("res://Scripts/Item.gd");
const SeedClass = preload("res://Scripts/Seed.gd");

const ItemSlotClass = preload("res://Scripts/ItemSlot.gd");

const slotTexture = preload("res://Assets/Misc/Slot-texture.png");

onready var itemImages = {
	"hoe": preload("res://Assets/Items/Hoe/MouseIcon.png"),
	"watering_can": preload("res://Assets/Items/Watering_can-cleared.png"),
	"seed_bag": preload("res://Assets/Items/Seed-cleared.png"),
	"bag": preload("res://Assets/Items/Bag-cleared.png")
};

onready var itemDictionary = {
	0: {
		"itemName": "hoe",
		"itemValue": -1,
		"itemIcon": itemImages["hoe"],
		"itemClass" : ItemClass
	},
	1: {
		"itemName": "watering_can",
		"itemValue": -1,
		"itemIcon": itemImages["watering_can"],
		"itemClass" : ItemClass
	},
	2: {
		"itemName": "seed_bag",
		"itemValue": -1,
		"itemIcon": itemImages["seed_bag"],
		"itemClass" : ItemClass
	},
	3: {
		"itemName": "bag",
		"itemValue": -1,
		"itemIcon": itemImages["bag"],
		"itemClass" : ItemClass
	}
};

var slotList = Array();
var itemList = Array();

signal transfer(item)

var holdingItem = null;

func _ready():
	for item in itemDictionary:
		var itemName = itemDictionary[item].itemName;
		var itemIcon = itemDictionary[item].itemIcon;
		var itemValue = itemDictionary[item].itemValue;
		var itemClass = itemDictionary[item].itemClass
		
		if itemClass == ItemClass:# important note: not ItemClass, it is itemClass [i at the start is lowercase]
			itemList.append(itemClass.new(itemName, itemIcon, null, itemValue));
			itemList[itemList.size()-1].itemClass = itemClass
		else:
			var x = 0
			x = x / x
	
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
		elif clickedSlot != null and clickedSlot.item != null:
			if Input.is_action_pressed("chest_transfer"):
				if clickedSlot.item.itemClass == ItemClass:
					emit_signal("transfer_item", clickedSlot.item)
				else:
					var x = 0
					x = x / x
				clickedSlot.item = null
			else:
				holdingItem = clickedSlot.item;
				clickedSlot.pickItem();
				holdingItem.rect_global_position = Vector2(event.position.x, event.position.y);
	pass
