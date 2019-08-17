extends TextureRect

var itemIcon;
var itemName;
var itemSlot;
var picked = false;
var itemClass;
var itemInfo
var newFlower;
var itemValue

func _init(itemName, itemTexture, itemSlot, itemValue, itemClass):
	self.itemClass = itemClass
	name = itemName;
	self.itemName = itemName;
	texture = itemTexture;
	self.itemValue = itemValue
#	show_behind_parent = true
#	if itemValue != -1:
#		hint_tooltip = "%s\n%d" % [itemName, itemValue];
#	else:
#		hint_tooltip = "%s" % [itemName];
#	show_behind_parent = false
	###
	# Rect.size_flags_horizontal = 40
	# Rect.size_flags_vertical = 40
	# expand = false
	# stretch_mode = TextureRect.STRETCH_KEEP
	###
	self.itemSlot = itemSlot;
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;

func pickItem():
	mouse_filter = Control.MOUSE_FILTER_IGNORE;
	picked = true;
	
func putItem():
	rect_position = Vector2(0, 0);
	mouse_filter = Control.MOUSE_FILTER_PASS;
	picked = false;

func set_newFlower(nf):
	newFlower = load("res://Scripts/Item.gd").new(nf.name, nf.texture, null, nf.itemValue, nf.itemClass)