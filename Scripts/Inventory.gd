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

signal sell(toSellArray)
var toSellArray = []

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
		slotList[i].highlight_sprite.position = Vector2((i % 4) + 10 - (i % 4), (i / 4) + 10 - (i / 4))
		add_child(slot);
		slot.set_owner(self)
		
	for i in range(itemList.size()):
		slotList[i].setItem(itemList[i])
	
	pass

func set_mode(mode):
	if mode == "sell":
		sellMode = true
	elif mode == "normal":
		sellMode = false
	else:
		assert(false)

func _input(event):
	if event is InputEventKey and event.is_pressed() and visible == true:
		if event.scancode == KEY_ENTER:
			emit_signal("sell", toSellArray)
			print("SELL")
	
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		if holdingItem != null && holdingItem.picked:
			holdingItem.rect_position = Vector2(event.position.x, event.position.y);

var sellMode = false

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var clickedSlot;
#		var sellMode = false;
#		sellMode = true
		
		var clickedI = 0
		var i = 0
		
		for slot in slotList:
			var slotMousePos = slot.get_local_mouse_position();
			var slotTexture = slot.texture;
			var isClicked = slotMousePos.x >= 0 && slotMousePos.x <= slotTexture.get_width() && slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height();
			if isClicked:
				clickedI = i
				if not sellMode:
					clickedSlot = slot;
				else:
					clickedSlot = slot
					print("We're working on sell mode")
					print(slot);
			i += 1
		
		if not sellMode:
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
				holdingItem.rect_position = Vector2(event.position.x, event.position.y);
		else:
			if clickedSlot != null and clickedSlot.item != null:
				if clickedSlot.highlight_sprite.visible == false:
					clickedSlot.highlight()
					toSellArray.push_back(clickedI)
				else:
					clickedSlot.highlight_sprite.visible = false
					toSellArray.erase(clickedI)
				print(toSellArray)
	pass

func add_flower(originalItem):
	for i in range(32):
		if slotList[i].item == null:
			print("ading to slot ", i)
#			var itemName = originalItem.name
			var itemName = originalItem.item.itemName
			print (itemName)
			
			var itemIcon = originalItem.item.texture
			print (itemIcon)
			
#			var x = 0
#			x = x / x
			
			var itemValue = -1
			
			var itemClass = originalItem.itemClass
			
			var newItem = ItemClass.new(itemName, itemIcon, null, itemValue, itemClass);
			
			slotList[i].setItem(newItem)
			
#			var x = 0
#			x = x / x
			return i
	return -1