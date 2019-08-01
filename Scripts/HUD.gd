# HUD.gd
# Manages inventory, toolbar, and seedbag
extends CanvasLayer

onready var inventory = get_node("Inventory")
onready var toolbar = get_node("Toolbar")
onready var bagtoolbar = get_node("BagToolbar")
onready var seedbag = get_node("SeedBag")
onready var highlight = get_node("Highlight")

var current_hud = "toolbar"
var current_slot = 0

# sets current toolbar slot to x
func set_current_slot(x):
	# print(x)
	current_slot = x
	change_highlight(current_slot)
	
#highlights slot x
func change_highlight(x):
	highlight.rect_position.x =  x * 16
	pass

func _input(event):
	if event is InputEventKey:
		# changing current toolbar tool
		if event.pressed and current_hud == "toolbar":
			if event.scancode == KEY_1:
				set_current_slot(0)
			elif event.scancode == KEY_2:
				set_current_slot(1)
			elif event.scancode == KEY_3:
				set_current_slot(2)
			elif event.scancode == KEY_4:
				set_current_slot(3)
		
		if event.pressed and current_hud == "toolbar":
			if event.scancode == KEY_SHIFT:
				show("bagtoolbar")
				current_hud = "bagtoolbar"
				pass
		elif event.pressed and current_hud == "bagtoolbar":
			if event.scancode == KEY_SHIFT:
				show("toolbar")
				current_hud = "toolbar"
				pass
		

# makes hud with name visible, makes others invisible

var flag = false

func show(name):
	inventory.visible = false
	toolbar.visible = false
	seedbag.visible = false
	highlight.visible = false
	bagtoolbar.visible = false
	
	if flag:
		for i in range(bagtoolbar.slotList.size()):
			if bagtoolbar.slotList[i]:
				bagtoolbar.slotList[i].queue_free()
		bagtoolbar.slotList = []
		flag = false
	
	if name == "inventory":
		inventory.visible = true
	elif name == "toolbar":
		toolbar.visible = true
		highlight.visible = true
	elif name == "seedbag":
		seedbag.visible = true
	elif name == "bagtoolbar":
		var items = []
		for i in range(4):
			items.push_back(inventory.slotList[i].item)
		bagtoolbar.set_toolbar(items)
		bagtoolbar.visible = true
		flag = true
	else:
		print("ERROR, %s in undefined" % name)
	
	current_hud = name

func _process(delta):
	# show(current_hud)
	pass

func _ready():
	show(current_hud)
	pass