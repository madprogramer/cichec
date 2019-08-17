extends Control

onready var rect = get_node("Rect")

signal pass_day

func _gui_input(event):
#	print(event)
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var slotMousePos = rect.get_local_mouse_position();
		var slotTexture = rect.texture;
		var isClicked = slotMousePos.x >= 0 && slotMousePos.x <= slotTexture.get_width() && slotMousePos.y >= 0 && slotMousePos.y <= slotTexture.get_height();
		if isClicked:
			emit_signal("pass_day")
			print("PASS_DAY")