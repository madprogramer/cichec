# Inventory.gd
extends GridContainer;
const ItemClass = preload("res://Scripts/Item.gd");
const ItemSlotClass = preload("res://Scripts/ItemSlot.gd");

const slotTexture = preload("res://Assets/Misc/Slot-texture.png");

const itemImages = [
	preload("res://Assets/Highlight/Highlight.png")
];

var itemDictionary = {
	"scanner" : {
		"itemName" : "scanner",
		"itemIcon" : preload("res://Assets/Items/Scanner/Scanner.png"),
		"itemValue" : -1,
		"itemClass" : preload("res://Scripts/Items/Scanner.gd")
	},
	"sprinkler_spawner" : {
		"itemName" : "sprinkler_spawner",
		"itemIcon" : preload("res://Assets/Items/SprinklerSpawner/Icon.png"),
		"itemValue" : -1,
		"itemClass" : preload("res://Scripts/Entities/SprinklerSpawner.gd")
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
		var itemClass = itemDictionary[item].itemClass
		
		# important note: not ItemClass, it is itemClass [i at the start is lowercase]
		itemList.append(itemClass.new(itemName, itemIcon, null, itemValue, itemClass));
	
	for i in range(32):
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

func add_flower(originalItem):
	for i in range(32):
		if slotList[i].item == null:
			print("ading to slot ", i)
			var itemName = originalItem.name
			print (itemName)
			
			var itemIcon = originalItem.texture
			print (itemIcon)
			
			var itemValue = -1
			
			var itemClass = originalItem.itemClass
			
			var newItem = ItemClass.new(itemName, itemIcon, null, itemValue, itemClass);
			
			slotList[i].setItem(newItem)
			
#			var x = 0
#			x = x / x
			return i
	return -1