extends TextureRect

var itemIcon;
var itemName;
var itemSlot;
var itemClass;
var itemValue;
var picked = false;
var seedClass = null;
var _seed = null
var count = 1
var label = null
var labelpos = Vector2()
var GENES = {}
var fatherId = 0
var motherId = 0
var dummySeed
var newFlower
#Position in World
#var pIW = Vector2()

func _init(itemName, itemTexture, itemSlot, itemValue, seedClass, dummySeed, count):
#func _init(itemName, itemTexture, itemSlot, itemValue, dummySeed, count):
	self.dummySeed = dummySeed
	self.GENES = dummySeed.GENES
#	print(dummySeed.GENES)
#	print(self.GENES)
	# print(seedClass)
	
	if seedClass == null:
		self.seedClass = null;
	else:
		self.seedClass = seedClass
		
	name = itemName;
	self.itemName = itemName;
	texture = itemTexture;
	itemIcon = itemTexture
	self.itemValue = itemValue
	
	label = Label.new()
	labelpos = label.rect_position
	labelpos.x += 12
	labelpos.y += 10
	label.rect_position = labelpos
	add_child(label)
	label.set_owner(self)
	set_count(count)
	
#	hint_tooltip = "%s %d" % [itemName, count] 
#	hint_tooltip = "%s" % [itemName] 
		
	self.itemSlot = itemSlot;
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;

func set_count(c):
	count = c
#	hint_tooltip = "%s %d" % [itemName, count]
	label.text = "%d" % [count]
	label.rect_position = labelpos
	
func get_count():
	return count
	
func decrease_count():
	set_count(count - 1)
	if count == 0:
		delete()

func delete():
	itemSlot.item = null
	queue_free()

func pickItem():
	mouse_filter = Control.MOUSE_FILTER_IGNORE;
	picked = true;
	
func putItem():
	rect_position = Vector2(0, 0);
	mouse_filter = Control.MOUSE_FILTER_PASS;
	picked = false;