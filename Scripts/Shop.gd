# Inventory.gd
extends GridContainer;
const ItemClass = preload("res://Scripts/Item.gd");
const SeedClass = preload("res://Scripts/Seed.gd");
const ItemSlotClass = preload("res://Scripts/ItemSlot.gd");

const slotTexture = preload("res://Assets/Misc/Slot-texture.png");

var player

const itemImages = [
	preload("res://Assets/Highlight/Highlight.png")
];

var itemDictionary = {
	"seed1" : {
		"itemName" : "WaterseekerSeed",
		"itemIcon" : preload("res://Assets/Seeds/WaterseekerSeed/toolbar.png"),
		"itemValue" : 2,
		"count" : 3,
		"_seed" : preload("res://Scripts/Biology/seeds/waterseekerSeed.gd"),
		"dummySeed" : preload("res://Scripts/Biology/seeds/WaterseekerSeed/pre.gd"),
		"seedbag" : true,
		"newFlower" : load("res://Scripts/Biology/flowers/WaterseekerFlower/flower.gd")
	}
};

var slotList = Array();
var itemList = Array();

var holdingItem = null;

var toBuyArray = []

func set_player(p):
	player = p

func _ready():
	connect("buy", self, "buy")
	
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
		itemList.append(SeedClass.new(itemName, itemIcon, null, itemValue, itemSeed, itemDummySeed, itemCount));
		itemList[itemList.size() - 1].newFlower = newFlower.new()
	for i in range(32):
		var slot = ItemSlotClass.new(i);
		slotList.append(slot);
		slotList[i].highlight_sprite.position = Vector2((i % 4) + 10 - (i % 4), (i / 4) + 10 - (i / 4))
		add_child(slot);
		slot.set_owner(self)
		
	for i in range(itemList.size()):
		slotList[i].setItem(itemList[i])
	
	pass

func buy(toBuyArray):
	for i in toBuyArray:
		if player.balance >= slotList[i].item.itemValue:
			player.hud.seedbag.add_seed(slotList[i].item)
			player.balance -= slotList[i].item.itemValue
	pass

signal buy(toBuyArray)

func _input(event):
	if event is InputEventKey and event.is_pressed() and visible == true:
		if event.scancode == KEY_ENTER:
			emit_signal("buy", toBuyArray)
			print("BUY")
	
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		if holdingItem != null && holdingItem.picked:
			holdingItem.rect_global_position = Vector2(event.position.x, event.position.y);

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var clickedSlot;
#		var sellMode = false;
		var sellMode = true
		
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
				holdingItem.rect_global_position = Vector2(event.position.x, event.position.y);
		else:
			if clickedSlot != null and clickedSlot.item != null:
				if clickedSlot.highlight_sprite.visible == false:
					clickedSlot.highlight()
					toBuyArray.push_back(clickedI)
				else:
					clickedSlot.highlight_sprite.visible = false
					toBuyArray.erase(clickedI)
				print(toBuyArray)
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