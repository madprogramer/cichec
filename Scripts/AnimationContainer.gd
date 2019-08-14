extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func spawn_animation(pos, animatedSprite, looping = false):
	if get_node(str(pos)) != null:
		return
	var newSprite = AnimatedSprite.new()
	newSprite.set_sprite_frames(animatedSprite.get_sprite_frames())
	newSprite.set_offset(pos * 1 / animatedSprite.get_global_scale())
	newSprite.set_speed_scale(animatedSprite.get_speed_scale())
	newSprite.set_global_scale(animatedSprite.get_global_scale())
	newSprite.connect("animation_finished", self, "_on_animatedSprite_finished", [newSprite, looping])
	newSprite.frame = animatedSprite.frame
	newSprite.play()
	newSprite.name = str(pos)
	add_child(newSprite)
	
func _on_animatedSprite_finished(animatedSprite, looping):
	if looping:
		return
	animatedSprite.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
