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

onready var dialoguebox = get_node("DialogueBox")
onready var dialoguetexture = dialoguebox.get_node("CharacterTexture")
onready var dialoguebackground = dialoguebox.get_node("Background")
onready var dialoguetext = dialoguebox.get_node("Text")
onready var dialoguename = dialoguebox.get_node("Name")

onready var mentalhealth = get_node("MentalHealth")

onready var quest = get_node("Quest")

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
	
func get_current_item():
	if current_hud == "toolbar":
		return (toolbar.slotList[current_slot["toolbar"]].item)
		
	elif current_hud == "inventory":
		return (toolbar.slotList[current_slot["toolbar"]].item)
	
	elif current_hud == "seedbag":
		return (toolbar.slotList[current_slot["toolbar"]].item)
	
	elif current_hud == "bagtoolbar":
		return (bagtoolbar.slotList[current_slot["bagtoolbar"]].item)
	
	elif current_hud == "seedtoolbar":
		return (seedtoolbar.slotList[current_slot["seedtoolbar"]].item)
	return null
	
#highlights slot x
func change_highlight(x):
	print(x)
	print(current_hud)
	highlight.offset.x =  x * 16 + 8
	
	if current_hud == "toolbar":
		if toolbar.slotList[current_slot[current_hud]].item.itemName == "hoe":
			if dialogue_is_playing == false:
				set_cursor_shape(preload("res://Assets/Items/Hoe/MouseIcon.png"))
			else:
				set_cursor_shape(null)
		elif toolbar.slotList[current_slot[current_hud]].item.itemName == "watering_can":
			if dialogue_is_playing == false:
				set_cursor_shape(preload("res://Assets/Items/Watering_Can/MouseIcon.png"))
			else:
				set_cursor_shape(null)
		else:
			set_cursor_shape(null)
	else:
		set_cursor_shape(null)

var switchToolKeys = [
	KEY_1,
	KEY_2,
	KEY_3,
	KEY_4
]

func switch_tools(event, current_hud_):
	for i in range(switchToolKeys.size()):
		if event.scancode == switchToolKeys[i]:
			set_current_slot(current_hud_, i)
			return
		

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
			
			highlight.offset.y += 1
			
			mentalhealth.position.y += 1
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
			
			highlight.offset.y -= 1
			
			mentalhealth.position.y -= 1
		toolbar_visible = true
		showing_toolbar = false
	pass

func _input(event):
	if dialogue_is_playing:
		return
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		cursor.offset = Vector2(event.position.x, event.position.y);
	
	elif event is InputEventKey:
		if event.pressed:
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
					current_hud = "bagtoolbar"
					show("bagtoolbar")
						
				elif current_hud == "bagtoolbar":
					current_hud = "seedtoolbar"
					show("seedtoolbar")
					
				elif current_hud == "seedtoolbar":
					current_hud = "toolbar"
					show("toolbar")

			if event.scancode == KEY_TAB:
				if toolbar_visible == true:
					toolbar_hide()
				else:
					toolbar_show()
				pass #############################################################
			
			if event.scancode == KEY_Q:
				quest.popup(Rect2(0, 0, 64, 32))
				pass
		
		
func set_quest(var labels = ["TEST1", "TEST2", "TEST3"]):
	
	for i in range(labels.size()):
		quest.remove_child(quest.get_node(str(i)))
		var y = Label.new()
		y.name = str(i)
		y.rect_position = Vector2(4, 6 * (i + 1) + i - 1)
		y.text = labels[i]
		quest.add_child(y)

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
	
	highlight,
	mentalhealth
]

func show(name):
	for hud_element in hud_elements:
		if hud_element != mentalhealth:
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
	set_quest(["QUEST: 1", "HARVEST X FLOWERS", "TIME: X"])
	
func change_dialogue_texture(t):
	dialoguetexture.texture = t

func change_dialogue_background(b):
	dialoguebackground.texture = b

#var current_name = ""

var character_textures = {
	"Wasp" : preload("res://Assets/Characters/Wasp/Wasp13x11.png"),
	"Capo" : preload("res://Assets/Characters/Capo/Capo13x11.png"),
	"Alpamish" : preload("res://Assets/Characters/Alpamish/Alpamish13x11.png")
}

func change_dialogue_text(t):
#	print(t)
	dialoguetext.text = t[0].text
	dialoguename.text = t[0].name
#	if dialoguename.text != current_name:
#		if dialoguename.text != "Capo":
#			change_dialogue_texture(character_textures[dialoguename.text])
#			current_name = dialoguename.text
	change_dialogue_texture(character_textures[dialoguename.text])
	
var dialogue_is_playing = false

func dialogue_started():
	print("STARTED")
	set_cursor_shape(null)
	dialogue_is_playing = true
	for hud_element in hud_elements:
		hud_element.visible = false
	dialoguebox.visible = true
		
func dialogue_finished():
	print("FINISHED")
	dialogue_is_playing = false
	show("toolbar")
	dialoguebox.visible = false