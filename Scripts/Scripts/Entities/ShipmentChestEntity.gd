extends TextureRect

#onready var inventory = get_node("CanvasLayer/ChestInventory")
#onready var inventory = get_node("CanvasLayer/ChestInventory")
onready var sfxplayer = get_node("SfxPlayer3")
signal chest_opened
signal chest_closed

func _ready():
	#inventory.visible = false
	pass
	
func _input(event):
	if event is InputEventKey and event.pressed and event.scancode == KEY_ESCAPE:
#		if inventory.visible == true:
		#	inventory.visible = false
		sfxplayer.stream=(load("res://Assets/EnvanterSFX_2.wav"))
		sfxplayer.play()
		emit_signal("chest_closed")
		print("WIP")
	pass
	
func _gui_input(event):
	if event is InputEventMouseButton:
#		if inventory.visible == false:
		#	inventory.visible = true
		sfxplayer.stream=(load("res://Assets/EnvanterSFX_2.wav"))
		sfxplayer.play()
		emit_signal("chest_opened")
		pass