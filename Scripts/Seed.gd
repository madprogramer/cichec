extends TextureRect

var itemIcon;
var itemName;
var itemSlot;
var picked = false;
var seedClass = null;
var _seed = null
var count = 1
var label = null
var labelpos = Vector2()

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
	
	label = Label.new()
	labelpos = label.rect_position
	labelpos.x += 12
	labelpos.y += 10
	label.rect_position = labelpos
	add_child(label)
	set_count(count)
	
#	hint_tooltip = "%s %d" % [itemName, count] 
	hint_tooltip = "%s" % [itemName] 
		
	self.itemSlot = itemSlot;
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;
	pass

func set_count(c):
	count = c
#	hint_tooltip = "%s %d" % [itemName, count]
	label.text = "%d" % [count]
	label.rect_position = labelpos

func pickItem():
	mouse_filter = Control.MOUSE_FILTER_IGNORE;
	picked = true;
	pass
	
func putItem():
	rect_global_position = Vector2(0, 0);
	mouse_filter = Control.MOUSE_FILTER_PASS;
	picked = false;
	pass