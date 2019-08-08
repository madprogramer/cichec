extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bar = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var barpiecesprite = get_node("BarPieceSprite")
	
	for i in range(10):
		var bar_piece = Sprite.new()
		bar_piece.set_offset(Vector2(i - 4, 0))
		bar_piece.set_texture(barpiecesprite.get_texture())
		add_child(bar_piece)
		bar.push_back(bar_piece)
	set_value(100)
	pass # Replace with function body.
	
var value = 100
	
func set_value(x):
	value = x
	for i in range(10):
		if (i+1) * 10 > x:
			bar[i].visible = false
		else:
			bar[i].visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
