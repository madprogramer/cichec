extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Particles2D").emitting = true
	
#	yield(get_tree().create_timer(1.0), "timeout")
#
#	playing = false
#	frame = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
