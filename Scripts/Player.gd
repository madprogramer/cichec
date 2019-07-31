extends KinematicBody2D

enum TileID {
	DIRT,
	WATERED_DIRT,
	PLOVED_DIRT,
	WATERED_PLOVED_DIRT,
	SOWED_DIRT,
	WATERED_SOWED_DIRT
}

onready var tilemap = $Tilemap

const SPEED = 20

var toolbar = [0, 1, 2, 3]
var toolbar_sprites = []

func _ready():
	pass

func move():
	var move_vec = Vector2(0, 0)
	move_vec.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	move_vec.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	move_vec = move_vec.normalized()
	
	move_and_slide(move_vec * SPEED)

func _process(delta):
	move()
	for i in toolbar:
		toolbar_sprites.push_back(Sprite.new())
		# toolbar_sprites[i].set_texture(tilemap.tile_set.tile_get_texture(toolbar[i]))
		toolbar_sprites[i].set_texture($PlayerSprite.get_texture())
	pass
