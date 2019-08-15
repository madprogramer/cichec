extends GridContainer;

signal toolbar_changed

const ItemClass = preload("res://Scripts/Item.gd");
const ItemSlotClass = preload("res://Scripts/ItemSlot.gd");

const slotTexture = preload("res://Assets/Misc/Slot-texture.png");

# onready var tilemap = $TileMap #get_node("TileMap");

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
		"itemIcon": itemImages["hoe"]
	},
	1: {
		"itemName": "watering_can",
		"itemValue": -1,
		"itemIcon": itemImages["watering_can"]
	},
	2: {
		"itemName": "seed_bag",
		"itemValue": -1,
		"itemIcon": itemImages["seed_bag"]
	},
	3: {
		"itemName": "bag",
		"itemValue": -1,
		"itemIcon": itemImages["bag"]
	}
};

var slotList = Array();
var itemList = Array();

var holdingItem = null;
var currentItem = 0;

func _ready():
	# rect_global_position = Vector2(0, 48)
	for item in itemDictionary:
		var itemName = itemDictionary[item].itemName;
		var itemIcon = itemDictionary[item].itemIcon;
		var itemValue = itemDictionary[item].itemValue;
		itemList.append(ItemClass.new(itemName, itemIcon, null, itemValue, null));
	
	for i in range(4):
		var slot = ItemSlotClass.new(i);
		slotList.append(slot);
		add_child(slot);
		slot.set_owner(self)
	
	for i in range(itemList.size()):
		slotList[i].setItem(itemList[i])
	pass

func _input(event):
	# print(event)
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		if holdingItem != null && holdingItem.picked:
			holdingItem.rect_global_position = Vector2(event.position.x, event.position.y);
	
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT:
		put_holding_item()

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var clickedSlot;
		for slot in slotList:
			var slotMousePos = slot.get_local_mouse_position();
			var slotTexture = slot.texture;
			var isClicked = slotMousePos.x >= 0 && slotMousePos.x <= slotTexture.get_width() && slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height();
			if isClicked:
				clickedSlot = slot;
		if !clickedSlot:
			pass
		elif holdingItem != null:
			if clickedSlot and clickedSlot.item != null:
				var tempItem = clickedSlot.item;
				var oldSlot = slotList[slotList.find(holdingItem.itemSlot)];
				clickedSlot.pickItem();
				clickedSlot.putItem(holdingItem);
				holdingItem = null;
				oldSlot.putItem(tempItem);
				emit_signal("toolbar_changed")
			elif clickedSlot:
				clickedSlot.putItem(holdingItem);
				holdingItem = null;
				emit_signal("toolbar_changed")
		elif clickedSlot.item != null:
			holdingItem = clickedSlot.item;
			clickedSlot.pickItem();
			holdingItem.rect_global_position = Vector2(event.position.x, event.position.y);
			emit_signal("toolbar_changed")
	pass

func put_holding_item():
	if holdingItem == null:
		return
	holdingItem.itemSlot.putItem(holdingItem)
	holdingItem = null
	emit_signal("toolbar_changed")