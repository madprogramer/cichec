extends TextureRect

var itemIcon;
var itemName;
var itemSlot;
var picked = false;
var seedClass = dummySeed.new();
var _seed = null
var count = 1
var label = null
var labelpos = Vector2()

var itemClass

#Position in World
#var pIW = Vector2()

func _init(itemName, itemTexture, itemSlot, itemValue, itemClass):
	self.itemClass = itemClass
	name = itemName;
	self.itemName = itemName;
	texture = itemTexture;
#	if itemValue != -1:
#		hint_tooltip = "%s\n%d" % [itemName, itemValue];
#	else:
#		hint_tooltip = "%s" % [itemName];
	###
	# Rect.size_flags_horizontal = 40
	# Rect.size_flags_vertical = 40
	# expand = false
	# stretch_mode = TextureRect.STRETCH_KEEP
	###
	self.itemSlot = itemSlot;
	mouse_filter = Control.MOUSE_FILTER_PASS;
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND;
	pass

func set_count(c):
	count = c
#	hint_tooltip = "%s %d" % [itemName, count]
	label.text = "%d" % [count]
	label.rect_position = labelpos
	
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
	rect_global_position = Vector2(0, 0);
	mouse_filter = Control.MOUSE_FILTER_PASS;
	picked = false;
	
func spawn(pos):
	var newSprinkler = load("res://Scenes/Entities/Sprinkler.tscn").instance()
	var size = newSprinkler.get_node("Position2D").position
	pos -= size
	print(pos)
	newSprinkler.global_position = pos
#	get_tree().current_scene.get_node("YSort").add_child(newSprinkler)
	return newSprinkler