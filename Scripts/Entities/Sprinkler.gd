extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal sprinkler_water(pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Particles2D").emitting = true
	
	yield(get_tree().create_timer(5.0), "timeout")

	playing = false
	frame = 0

	get_node("Particles2D").emitting = false
#
#	var spriteframes = get_sprite_frames()
#	var firstframe = spriteframes.get_frame("default", 0)
#
#	var size = firstframe.get_size()

	var size = get_node("Position2D").position
	
	emit_signal("sprinkler_water", Vector2(position.x + size.x, position.y + size.y))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
