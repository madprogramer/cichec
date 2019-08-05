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
onready var highlight = get_node("HighlightTemp")

var current_hud = "toolbar"

var cursor = null

func set_cursor_shape(texture):
	if texture == null:
		cursor.set_texture(texture)
	else:
		if cursor == null:
			cursor = Sprite.new()
			add_child(cursor)
		cursor.set_texture(texture)

var current_slot = {
	"toolbar" : 0,
	"bagtoolbar" : 0,
	"seedtoolbar" : 0
}

# sets current toolbar slot to x
func set_current_slot(name, x):
	# print(x)
	current_slot[name] = x
	change_highlight(current_slot[name])
	
#highlights slot x
func change_highlight(x):
	print(x)
	highlight.offset.x =  x * 16 + 8
	
	if current_hud == "toolbar":
		if toolbar.slotList[current_slot[current_hud]].item.itemName == "hoe":
			set_cursor_shape(preload("res://Assets/Hoe/MouseIcon.png"))
		else:
			set_cursor_shape(null)
	else:
		set_cursor_shape(null)

func switch_tools(event, current_hud_):
	if event.scancode == KEY_1:
		set_current_slot(current_hud_, 0)
	elif event.scancode == KEY_2:
		set_current_slot(current_hud_, 1)
	elif event.scancode == KEY_3:
		set_current_slot(current_hud_, 2)
	elif event.scancode == KEY_4:
		set_current_slot(current_hud_, 3)
		

var hiding_toolbar = false

func toolbar_hide():
	if hiding_toolbar:
		return
	else:
		hiding_toolbar = true
	
		for i in range(16):
			yield(get_tree(), "idle_frame")
			toolbar.rect_position.y += 1
			seedtoolbar.rect_position.y += 1
			bagtoolbar.rect_position.y += 1
			
			toolbar_front.rect_position.y += 1
			
			highlight.rect_position.y += 1
		toolbar_visible = false
		hiding_toolbar = false
	pass

var showing_toolbar = false

var toolbar_visible = true

func toolbar_show():
	if hiding_toolbar:
		return
	elif showing_toolbar:
		return
	else:
		showing_toolbar = true
	
		for i in range(16):
			yield(get_tree(), "idle_frame")
			toolbar.rect_position.y -= 1
			seedtoolbar.rect_position.y -= 1
			bagtoolbar.rect_position.y -= 1
			
			toolbar_front.rect_position.y -= 1
			
			highlight.rect_position.y -= 1
		toolbar_visible = true
		showing_toolbar = false
	pass

func _input(event):
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		cursor.offset = Vector2(event.position.x, event.position.y);
	
	elif event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_5:
				if toolbar_visible:
					toolbar_hide()
				else:
					toolbar_show()
			# changing current toolbar tool
			if current_hud == "toolbar":
				switch_tools(event, current_hud)
			
			# changing current toolbar tool
			if current_hud == "bagtoolbar":
				switch_tools(event, current_hud)
			
			# changing current toolbar tool
			if current_hud == "seedtoolbar":
				switch_tools(event, current_hud)
			
			if event.scancode == KEY_SHIFT:
				if current_hud == "toolbar":
					show("bagtoolbar")
					current_hud = "bagtoolbar"
						
				elif current_hud == "bagtoolbar":
					show("seedtoolbar")
					current_hud = "seedtoolbar"
					
				elif current_hud == "seedtoolbar":
					show("toolbar")
					current_hud = "toolbar"

			if event.scancode == KEY_TAB:
				if toolbar_visible == true:
					toolbar_hide()
				else:
					toolbar_show()
				pass #############################################################
		

# makes hud with name visible, makes others invisible

var bagtoolbar_flag = false
var seedtoolbar_flag = false

onready var hud_elements = [
	inventory,
	inventory_back,
	inventory_front,
	
	toolbar,
	toolbar_front,
	
	seedbag,
	bagtoolbar,
	seedtoolbar,
	
	highlight
]

func show(name):
	for hud_element in hud_elements:
		hud_element.visible = false
	
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
		change_highlight(current_slot["toolbar"])
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
		change_highlight(current_slot["bagtoolbar"])
	elif name == "seedtoolbar":
		var items = []
		for i in range(4):
			items.push_back(seedbag.slotList[i].item)
		seedtoolbar.set_toolbar(items)
		seedtoolbar.visible = true
		seedtoolbar_flag = true
		highlight.visible = true
		toolbar_front.visible = true
		change_highlight(current_slot["seedtoolbar"])
	
	current_hud = name

func _ready():
	show(current_hud)