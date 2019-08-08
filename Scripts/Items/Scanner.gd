extends dummyItem

var itemClass

func _init(itemName, itemTexture, itemSlot, itemValue, itemClass):
	self.itemClass = itemClass
	name = itemName;
	self.itemName = itemName;
	texture = itemTexture;
	if itemValue != -1:
		hint_tooltip = "%s\n%d" % [itemName, itemValue];
	else:
		hint_tooltip = "%s" % [itemName];
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
	
func scan(pos, seedList):
	for item in seedList:
		var flower = item._seed.flower
		if flower.pos == pos:
			print("Scan results: ")
			print(flower.getSize())
			print(flower.getColor())
			print(flower.getSeeds())
			print("Scan finished")
			var x = PopupDialog.new()
			add_child(x)
			
			var labels = [
				"SIZE: " + str(flower.getSize()),
				"COLOR: " + str(flower.getColor()),
				"SEEDS: " + str(flower.getSeeds())
			]
			
			for i in range(labels.size()):
				var y = Label.new()
				y.rect_position = Vector2(4, 6 * (i + 1) + i - 1)
				y.text = labels[i]
				x.add_child(y)
			
			x.popup(Rect2(0, 0, 64, 32))
			
			return
	print("Couldn't find the scanned flower")