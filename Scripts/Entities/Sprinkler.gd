extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal sprinkler_water(pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Sprinklers")
#	activate()

func water():
	var size = get_node("Position2D").position
	
	emit_signal("sprinkler_water", Vector2(position.x + size.x, position.y + size.y))

func activate():
	get_node("Particles2D").emitting = true
	
	yield(get_tree().create_timer(5.0), "timeout")

	playing = false
	frame = 0

	get_node("Particles2D").emitting = false

	var size = get_node("Position2D").position
	
	emit_signal("sprinkler_water", Vector2(position.x + size.x, position.y + size.y))
