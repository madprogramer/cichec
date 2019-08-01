# HUD.gd
# Manages inventory, toolbar, and seedbag
extends CanvasLayer

onready var inventory = get_node("Inventory")
onready var inventory_back = get_node("Inventory-back")
onready var inventory_front = get_node("Inventory-front")

onready var toolbar = get_node("Toolbar")
onready var toolbar_front = get_node("Toolbar-front")

onready var bagtoolbar = get_node("BagToolbar")
onready var seedtoolbar = get_node("SeedToolbar")
onready var seedbag = get_node("SeedBag")
onready var highlight = get_node("Highlight")

var current_hud = "toolbar"

var current_slot = {
	"toolbar" : 0,
}

# sets current toolbar slot to x
func set_current_slot(name, x):
	# print(x)
	current_slot[name] = x
	change_highlight(current_slot[name])
	
#highlights slot x
func change_highlight(x):
	print(x)
	highlight.rect_position.x =  x * 16
	pass

func _input(event):
	if event is InputEventKey:
		# changing current toolbar tool
		if event.pressed and current_hud == "toolbar":
			if event.scancode == KEY_1:
				set_current_slot("toolbar", 0)
			elif event.scancode == KEY_2:
				set_current_slot("toolbar", 1)
			elif event.scancode == KEY_3:
				set_current_slot("toolbar", 2)
			elif event.scancode == KEY_4:
				set_current_slot("toolbar", 3)
		
		# changing current toolbar tool
		if event.pressed and current_hud == "bagtoolbar":
			if event.scancode == KEY_1:
				set_current_slot("bagtoolbar", 0)
			elif event.scancode == KEY_2:
				set_current_slot("bagtoolbar", 1)
			elif event.scancode == KEY_3:
				set_current_slot("bagtoolbar", 2)
			elif event.scancode == KEY_4:
				set_current_slot("bagtoolbar", 3)
		
		# changing current toolbar tool
		if event.pressed and current_hud == "seedtoolbar":
			if event.scancode == KEY_1:
				set_current_slot("seedtoolbar", 0)
			elif event.scancode == KEY_2:
				set_current_slot("seedtoolbar", 1)
			elif event.scancode == KEY_3:
				set_current_slot("seedtoolbar", 2)
			elif event.scancode == KEY_4:
				set_current_slot("seedtoolbar", 3)
		
		
		if event.pressed and current_hud == "toolbar":
			if event.scancode == KEY_SHIFT:
				show("bagtoolbar")
				current_hud = "bagtoolbar"
				pass
		elif event.pressed and current_hud == "bagtoolbar":
			if event.scancode == KEY_SHIFT:
				show("seedtoolbar")
				current_hud = "seedtoolbar"
				pass
		elif event.pressed and current_hud == "seedtoolbar":
			if event.scancode == KEY_SHIFT:
				show("toolbar")
				current_hud = "toolbar"
				pass

# makes hud with name visible, makes others invisible

var bagtoolbar_flag = false
var seedtoolbar_flag = false

func show(name):
	inventory.visible = false
	inventory_back.visible = false
	inventory_front.visible = false
	
	toolbar.visible = false
	toolbar_front.visible = false
	
	seedbag.visible = false
	highlight.visible = false
	bagtoolbar.visible = false
	seedtoolbar.visible = false
	
	if bagtoolbar_flag:
		for i in range(bagtoolbar.slotList.size()):
			if bagtoolbar.slotList[i]:
				bagtoolbar.slotList[i].queue_free()
		bagtoolbar.slotList = []
		bagtoolbar_flag = false
	
	if seedtoolbar_flag:
		for i in range(seedtoolbar.slotList.size()):
			if seedtoolbar.slotList[i]:
				seedtoolbar.slotList[i].queue_free()
		seedtoolbar.slotList = []
		seedtoolbar_flag = false
	
	
	if name == "inventory":
		inventory.visible = true
		inventory_back.visible = true
		inventory_front.visible = true
	elif name == "toolbar":
		toolbar.visible = true
		highlight.visible = true
		toolbar_front.visible = true
	elif name == "seedbag":
		inventory_back.visible = true
		inventory_front.visible = true
		seedbag.visible = true
	elif name == "bagtoolbar":
		var items = []
		for i in range(4):
			items.push_back(inventory.slotList[i].item)
		bagtoolbar.set_toolbar(items)
		bagtoolbar.visible = true
		bagtoolbar_flag = true
		highlight.visible = true
		toolbar_front.visible = true
	elif name == "seedtoolbar":
		var items = []
		for i in range(4):
			items.push_back(seedbag.slotList[i].item)
		seedtoolbar.set_toolbar(items)
		seedtoolbar.visible = true
		seedtoolbar_flag = true
		highlight.visible = true
		toolbar_front.visible = true
	else:
		print("ERROR, %s in undefined" % name)
	
	current_hud = name

func _process(delta):
	# show(current_hud)
	pass

func _ready():
	show(current_hud)
	pass