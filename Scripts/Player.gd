extends KinematicBody2D

onready var hud = get_node("HUD")
onready var animationplayer = get_node("AnimationPlayer")
onready var idlesprite = get_node("IdleSprite")
onready var idlebacksprite = get_node("IdleBackSprite")
onready var walksprite = get_node("WalkSprite")
onready var walkbacksprite = get_node("WalkBackSprite")

const SPEED = 80
var direction = {
	"x" : "right",
	"y" : "down"
}

func get_current_item():
	return hud.get_current_item()

func set_direction(d1, d2):
	if direction.x != d1:
		direction.x = d1
		walksprite.flip_h = !walksprite.flip_h
		walkbacksprite.flip_h = !walkbacksprite.flip_h
		idlesprite.flip_h = !idlesprite.flip_h
		idlebacksprite.flip_h = !idlebacksprite.flip_h
	
	if direction.y != d2:
		direction.y = d2

func move():
	var move_vec = Vector2(0, 0)
	move_vec.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	move_vec.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	move_vec = move_vec.normalized()
	
	move_and_slide(move_vec * SPEED)
	
	if move_vec.x > 0:
		set_direction("right", direction.y)
	elif move_vec.x < 0:
		set_direction("left", direction.y)
	
	if move_vec.y < 0:
		set_direction(direction.x, "up")
	elif move_vec.y > 0:
		set_direction(direction.x, "down")
	
	if move_vec.x != 0 or move_vec.y != 0:
		if direction.y == "down":
			animationplayer.current_animation = "walk"
			walksprite.visible = true
		else:
			animationplayer.current_animation = "walkback"
			walkbacksprite.visible = true
	else:
		if direction.y == "down":
			animationplayer.current_animation = "idle"
			idlesprite.visible = true
		else:
			animationplayer.current_animation = "idleback"
			idlebacksprite.visible = true

func _process(delta):
	idlesprite.visible = false
	idlebacksprite.visible = false
	walksprite.visible = false
	walkbacksprite.visible = false
	move()
	
func _input(event):
	if hud.dialogue_is_playing == true:
		return
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_SPACE:
				use(get_current_item())

signal plow;
signal water;
signal sow;
signal pick_seed;
signal scan;

var seed_names = [
	"DummySeed",
	"SunlightSeed",
	"WaterseekerSeed",
	"RainbowSeed"
]

func use(item):
	if !item:
		print("NULL")
		print(hud.current_hud)
#		var x = 0
#		x = x / x
		if hud.current_hud == "seedtoolbar":
			emit_signal("pick_seed")
		return
#	elif dirtDictionary["id"][tilemap.get_cellv(get_mouse_cell())].name == "Sowed" or dirtDictionary["id"][tilemap.get_cellv(get_mouse_cell())].name == "Sowed_Watered":
#		if hud.current_hud == "seedtoolbar":
#			if flowercontainer. emit_signal("pick_seed") 
	
	print(item.name)
	
	if item.name == "seed_bag":
		if hud.current_hud != "seedbag":
			hud.show("seedbag")
			hud.current_hud = "seedbag"
		else:
			hud.show("toolbar")
			hud.current_hud = "toolbar"
	
	elif item.name == "bag":
		if hud.current_hud != "inventory":
			hud.show("inventory")
			hud.current_hud = "inventory"
		else:
			hud.show("toolbar")
			hud.current_hud = "toolbar"
	
	elif item.name == "hoe":
		emit_signal("plow")
	
	elif item.name == "watering_can":
		emit_signal("water")
		
	elif item.name == "scanner":
		emit_signal("scan")
	
	else: 
		for seed_name in seed_names:
			if seed_name == item.name:
				emit_signal("sow", item)
				return

func add_seed(originalItem):
	var i = hud.seedbag.add_seed(originalItem)
	if i < 4:
		hud.show("seedtoolbar")
	print("i: ", i)
	pass
	
#onready var tilemap = get_node("../TileMap") # possible bug ##############################################################
#onready var dirtDictionary = get_node("../../World").dirtDictionary

#func get_mouse_cell():
#	return tilemap.world_to_map(get_global_mouse_position())

func _ready():
	pass