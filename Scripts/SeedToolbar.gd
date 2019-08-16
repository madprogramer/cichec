extends GridContainer;

signal toolbar_changed

const SeedClass = preload("res://Scripts/Seed.gd");
const ItemSlotClass = preload("res://Scripts/ItemSlot.gd");

const slotTexture = preload("res://icon-scaled.png");

var slotList = Array();
var itemList = Array();

var holdingItem = null;
var currentItem = 0;

func _ready():
	pass

func set_itemlist(items):
	var itemList = []
	for i in range(items.size()):
		var item = items[i]
		if item != null:
			itemList.append(SeedClass.new(item.name, item.texture, null, -1, item.seedClass, item.dummySeed, item.count))
			itemList[i].set_count(item.count)
			itemList[i].fatherId = item.fatherId
			itemList[i].motherId = item.motherId
			itemList[i].newFlower = item.newFlower
		else:
			itemList.append(null)
	return itemList

func set_toolbar(items):
	var itemList = set_itemlist(items)
#	print(itemList)
	for i in range(itemList.size()):
			var slot = ItemSlotClass.new(i)
			slotList.append(slot)
			add_child(slot)
			slot.set_owner(self)
			
			if itemList[i] != null:
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
	var clickedSlot;
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
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
			
	if event is InputEventMouseButton and event.button_index == BUTTON_RIGHT and event.pressed:
		for slot in slotList:
			var slotMousePos = slot.get_local_mouse_position();
			var slotTexture = slot.texture;
			var isClicked = slotMousePos.x >= 0 && slotMousePos.x <= slotTexture.get_width() && slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height();
			if isClicked:
				clickedSlot = slot;
		if clickedSlot != null:
			if clickedSlot.item != null:
				print("Can't remove seed from here")
	
	pass
	

func put_holding_item():
	if holdingItem == null:
		return
	holdingItem.itemSlot.putItem(holdingItem)
	holdingItem = null
	emit_signal("toolbar_changed")
