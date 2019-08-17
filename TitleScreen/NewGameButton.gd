extends TextureRect

signal new_game

func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("new_game")
		print("NEW GAME")