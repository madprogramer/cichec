extends TextureRect

signal shop_opened
signal shop_closed

func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
		print("SHOP CLOSED")
#		if inventory.visible == true:
		#	inventory.visible = false
		emit_signal("shop_closed")
		print("WIP")
	pass
	
func _gui_input(event):
	if event is InputEventMouseButton:
		print("SHOP OPENED")
#		if inventory.visible == false:
		#	inventory.visible = true
		emit_signal("shop_opened")
		pass