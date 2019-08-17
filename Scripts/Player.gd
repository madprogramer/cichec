extends KinematicBody2D

onready var hud = get_node("HUD")
onready var animationplayer = get_node("AnimationPlayer")
onready var idlesprite = get_node("IdleSprite")
onready var idlebacksprite = get_node("IdleBackSprite")
onready var walksprite = get_node("WalkSprite")
onready var walkbacksprite = get_node("WalkBackSprite")

var balance = 0

const SPEED = 80
var direction = {
	"x" : "right",
	"y" : "down"
}

# function to remove decrease a seed from toolbar
func iamnotsorry(i):
#	print("TEMP")
	hud.seedbag.iamsorry(i)
	hud.show("seedtoolbar")

var inputEnabled = true

func deactivate():
	inputEnabled = false

func activate():
	inputEnabled = true

func _ready():
	hud.seedtoolbar.connect("remove_seed", self, "iamnotsorry")

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
	if inputEnabled == false:
		return
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
	
var validNames = [
	"hoe",
	"watering_can",
	"scanner",
	"sprinkler_spawner"
]
	
func _input(event):
	if inputEnabled == false:
		return
	if hud.dialogue_is_playing == true:
		return
	if event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_SPACE:
				prints("used", get_current_item())
				use(get_current_item())
				
	else:
		if Input.is_action_just_pressed("mouse_select"):
			var current_item = get_current_item()
			if current_item != null:
				for validName in validNames:
					if current_item.name == validName:
						use(get_current_item())
						break

signal plow;
signal water;
signal sow;
signal pick_seed;
signal scan;
signal spawn_sprinkler

var seed_names = [
	"DummySeed",
	"SunlightSeed",
	"WaterseekerSeed",
	"RainbowSeed",
	"HeadacheSeed"
]

func use(item):
	if !item:
		if hud.current_hud == "seedtoolbar":
			emit_signal("pick_seed")
		return
	
	prints("itemname", item.name)
	
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
		
	elif item.name == "sprinkler_spawner":
		emit_signal("spawn_sprinkler")
	
	else: 
		for seed_name in seed_names:
			if item.name.find(seed_name) != -1:
				emit_signal("sow", item)
				break
				
func decrease(item):
	print("count before: ", item.count)
	item.decrease_count()
	print("count after: ", item.count)
	
	if item.count == 0:
		item = null
		hud.seedbag.slotList[hud.current_slot["seedtoolbar"]].item.queue_free()
		hud.seedbag.slotList[hud.current_slot["seedtoolbar"]].item = null
	else:
		hud.seedbag.slotList[hud.current_slot["seedtoolbar"]].item.set_count(item.count)
	
	hud.show("seedtoolbar")

func add_seed(originalItem):
	var i = hud.seedbag.add_seed(originalItem)
	if i != -1 and i < 4:
#		var items = []
#		for i in range(4):
#			items.push_back(hud.seedbag.slotList[i].item)
#		hud.seedtoolbar.set_toolbar(items)
		hud.show("seedtoolbar")
	print("i: ", i)

func remove_seed(originalItem):
	var i = hud.seedbag.remove_seed(originalItem)
	print("i: ", i)

func add_flower(flower):
	var i = hud.inventory.add_flower(flower)
	if i != -1 and i < 4:
		hud.show("bagtoolbar")
	print("i: ", i)