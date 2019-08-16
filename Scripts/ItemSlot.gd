extends TextureRect

var slotIndex;
var highlight_sprite = null
var item = null;

func _init(slotIndex):
	self.slotIndex = slotIndex;
	name = "ItemSlot_%d" % slotIndex
	texture = preload("res://Assets/Misc/Slot-texture.png");
#	show_behind_parent = true
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;
	highlight_sprite = AnimatedSprite.new()
	highlight_sprite.frames = preload("res://Assets/Highlight/Shop/Shop.tres")
	highlight_sprite.visible = false

func highlight():
	highlight_sprite.visible = true
	highlight_sprite.playing = true
#	highlight_sprite.show_behind_parent = false

func setItem(newItem):
	add_child(newItem);
	add_child(highlight_sprite)
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
