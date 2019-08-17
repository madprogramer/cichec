extends TextureRect

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

signal start_game

func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		emit_signal("start_game")