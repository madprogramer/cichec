extends TextureRect

var itemIcon;
var itemName;
var itemSlot;
var picked = false;
var seedClass = null;
var _seed = null

func _init(itemName, itemTexture, itemSlot, itemValue, seedClass):
	# print(seedClass)
	if seedClass == null:
		self.seedClass = null;
	else:
		self.seedClass = seedClass
	name = itemName;
	self.itemName = itemName;
	texture = itemTexture;
	itemIcon = itemTexture
	
	if itemValue != -1:
		hint_tooltip = "%s\n%d" % [itemName, itemValue];
	else:
		hint_tooltip = "%s" % [itemName];
		
	self.itemSlot = itemSlot;
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;
	pass

func pickItem():
	mouse_filter = Control.MOUSE_FILTER_IGNORE;
	picked = true;
	pass
	
func putItem():
	rect_global_position = Vector2(0, 0);
	mouse_filter = Control.MOUSE_FILTER_PASS;
	picked = false;
	pass