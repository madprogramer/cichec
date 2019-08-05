extends KinematicBody2D

onready var hud = get_node("HUD")
onready var animationplayer = get_node("AnimationPlayer")
onready var idlesprite = get_node("IdleSprite")
onready var walksprite = get_node("WalkSprite")

const SPEED = 80
var direction = "right"

func set_direction(d):
	if direction == d:
		return
	direction = d
	walksprite.flip_h = !walksprite.flip_h
	idlesprite.flip_h = !idlesprite.flip_h

func move():
	var move_vec = Vector2(0, 0)
	move_vec.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	move_vec.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	move_vec = move_vec.normalized()
	
	move_and_slide(move_vec * SPEED)
	
	if move_vec.x > 0:
		set_direction("right")
	elif move_vec.x < 0:
		set_direction("left")
	
	if move_vec.x != 0 or move_vec.y != 0:
		animationplayer.current_animation = "walk"
		walksprite.visible = true
	else:
		animationplayer.current_animation = "idle"
		idlesprite.visible = true

func _process(delta):
	idlesprite.visible = false
	walksprite.visible = false
	move()
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and hud.current_hud == "toolbar":
			if event.scancode == KEY_SPACE:
				use(hud.toolbar.slotList[hud.current_slot["toolbar"]].item)
		
		elif event.pressed and hud.current_hud == "inventory":
			if event.scancode == KEY_SPACE:
				use(hud.toolbar.slotList[hud.current_slot["toolbar"]].item)
		
		elif event.pressed and hud.current_hud == "seedbag":
			if event.scancode == KEY_SPACE:
				use(hud.toolbar.slotList[hud.current_slot["toolbar"]].item)
		
		elif event.pressed and hud.current_hud == "bagtoolbar":
			if event.scancode == KEY_SPACE:
				use(hud.bagtoolbar.slotList[hud.current_slot["bagtoolbar"]].item)
		
		elif event.pressed and hud.current_hud == "seedtoolbar":
			if event.scancode == KEY_SPACE:
				use(hud.seedtoolbar.slotList[hud.current_slot["seedtoolbar"]].item)
		

signal plow;
signal water;
signal sow;
signal pick_seed;

var seed_names = [
	"DummySeed",
	"SunlightSeed",
	"WaterseekerSeed",
	"RainbowSeed"
]

func use(item):
	if !item:
		print("NULL")
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
	
	else: 
		for seed_name in seed_names:
			if seed_name == item.name:
				emit_signal("sow", item)
				return

func add_seed(originalItem):
	var i = hud.seedbag.add_seed(originalItem)
	if i < 4:
		hud.show("seedtoolbar")
	pass
	
#onready var tilemap = get_node("../TileMap") # possible bug ##############################################################
#onready var dirtDictionary = get_node("../../World").dirtDictionary

#func get_mouse_cell():
#	return tilemap.world_to_map(get_global_mouse_position())

func _ready():
	pass