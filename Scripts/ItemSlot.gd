extends TextureRect

var slotIndex;
var item = null;

func _init(slotIndex):
	self.slotIndex = slotIndex;
	name = "ItemSlot_%d" % slotIndex
	texture = preload("res://Assets/Misc/Slot-texture.png");
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;
	pass

func setItem(newItem):
	add_child(newItem);
	newItem.set_owner(self)
	item = newItem;
	item.itemSlot = self;
	pass;
	
func pickItem():
	item.pickItem();
	remove_child(item);
	get_parent().get_parent().add_child(item);
	item = null;

func putItem(newItem):
	item = newItem;
	item.itemSlot = self;
	item.putItem();
	get_parent().get_parent().remove_child(item);
	add_child(item);
	item.set_owner(self)
	pass;
