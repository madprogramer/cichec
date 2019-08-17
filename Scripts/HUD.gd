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
onready var dialoguething = dialoguebox.get_node("Dialogue-thing")

onready var mentalhealth = get_node("MentalHealth")

onready var quest = get_node("Quest")
onready var progressbar = get_node("Quest/ProgressBar")

onready var dummyFlowerRenderer = get_node("dummyFlowerRenderer")

onready var shop = get_node("Shop")

var current_hud = "toolbar"

var cursor = null

func set_dummyFlower(sprite, type):
	dummyFlowerRenderer.add_dummyFlower(sprite, type)

func render_dummyFlower(dummyFlowerViewer1, dummyFlowerViewer2):
	prints("YUH", dummyFlowerViewer1.dummyFlower, dummyFlowerViewer2.dummyFlower)
	set_dummyFlower(dummyFlowerViewer1.dummyFlower, 0)
	set_dummyFlower(dummyFlowerViewer2.dummyFlower, 1)
	var flowers = dummyFlowerRenderer.render([dummyFlowerViewer1.dummyFlower,dummyFlowerViewer2.dummyFlower])
	add_child(flowers[0].sprite)
	add_child(flowers[1].sprite)
	flowers[0].sprite.visible = true
	flowers[0].sprite.frame = 3
	flowers[0].sprite.offset = Vector2(4, 4)
	
	flowers[1].sprite.visible = true
	flowers[1].sprite.frame = 3
	flowers[1].sprite.offset = Vector2(-4, 4)
	
#	var x = 0
#	x = x / x
	
	return dummyFlowerRenderer.flowers

func set_cursor_shape(texture):
	if texture == null:
		if cursor != null:
			cursor.set_texture(texture)
	else:
		if cursor == null:
			cursor = Sprite.new()
			cursor.centered = false
			add_child(cursor)
			cursor.set_owner(self)
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
	
	if current_hud == "toolbar" and toolbar.slotList[current_slot[current_hud]].item:
		if toolbar.slotList[current_slot[current_hud]].item.itemName == "hoe":
			if dialogue_is_playing == false:
#				set_cursor_shape(preload("res://Assets/Items/Hoe/MouseIcon.png"))
#				set_cursor_shape(null)
				pass
			else:
#				set_cursor_shape(null)
				pass
		elif toolbar.slotList[current_slot[current_hud]].item.itemName == "watering_can":
			if dialogue_is_playing == false:
#				set_cursor_shape(preload("res://Assets/Items/Watering_Can/MouseIcon.png"))
#				set_cursor_shape(null)
				pass
			else:
#				set_cursor_shape(null)
				pass
		else:
#			set_cursor_shape(null)
			pass
	else:
#		set_cursor_shape(null)
		pass

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
	
func scroll_up():
	if current_hud == "inventory":
		if inventory.rect_position.y != 0:
			inventory.rect_position.y += 16
	elif current_hud == "seedbag":
		if seedbag.rect_position.y != 0:
			seedbag.rect_position.y += 16
	elif current_hud == "shop":
		if shop.rect_position.y != 0:
			shop.rect_position.y += 16

func scroll_down():
	if current_hud == "inventory":
		if inventory.rect_position.y != -64:
			inventory.rect_position.y -= 16
	elif current_hud == "seedbag":
		if seedbag.rect_position.y != -64:
			seedbag.rect_position.y -= 16
	elif current_hud == "shop":
		if shop.rect_position.y != -64:
			shop.rect_position.y -= 16

func chest_opened():
	print("CHEST OPENED")
	inventory.set_mode("sell")
	show("inventory")

func chest_closed():
	print("CHEST CLOSED")
	inventory.set_mode("normal")

func shop_opened():
	show("shop")

func _input(event):
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		cursor.offset = Vector2(event.position.x, event.position.y);
	if inputEnabled == false:
		return
	if dialogue_is_playing:
		return
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		cursor.offset = Vector2(event.position.x, event.position.y);
		
		if event is InputEventMouseButton and event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				scroll_up()

			elif event.button_index == BUTTON_WHEEL_DOWN:
				scroll_down()
		
 
	
	elif event is InputEventKey:
		if event.pressed:
			if event.scancode == KEY_B:
				chest_opened()
			
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
					toolbar.put_holding_item()
					current_hud = "bagtoolbar"
					show("bagtoolbar")
						
				elif current_hud == "bagtoolbar":
					bagtoolbar.put_holding_item()
					current_hud = "seedtoolbar"
					show("seedtoolbar")
					
				elif current_hud == "seedtoolbar":
					seedtoolbar.put_holding_item()
					current_hud = "toolbar"
					show("toolbar")

			if event.scancode == KEY_TAB:
				if toolbar_visible == true:
					toolbar_hide()
				else:
					toolbar_show()
				pass #############################################################
			
			if event.scancode == KEY_Q:
				if quest.visible == false:
					quest.popup(Rect2(0, 0, 64, 32))
				else:
					quest.hide()
				pass
			
			if current_hud == "inventory":
				if event.scancode == KEY_DOWN:
					scroll_down()
				
				if event.scancode == KEY_UP:
					scroll_up()
				
			if current_hud == "shop":
				if event.scancode == KEY_DOWN:
					scroll_down()
				
				if event.scancode == KEY_UP:
					scroll_up()
			
			if current_hud == "seedbag":
				if event.scancode == KEY_DOWN:
					scroll_down()
					
				if event.scancode == KEY_UP:
					scroll_up()
			
			if event.scancode == KEY_ESCAPE:
				show("toolbar")
		

var labelArray = []

func set_quest(var labels = ["TEST1", "TEST2", "TEST3"], var progress = 0):
	for i in range(labelArray.size()):
		var temp = labelArray[i]
		quest.remove_child(temp)
		temp.queue_free()
	
	labelArray = []
	
	for i in range(labels.size()):		
		var y = Label.new()
		y.name = str(i)
		y.rect_position = Vector2(4, 6 * (i + 1) + i - 1)
		y.text = labels[i]
		quest.add_child(y)
		y.set_owner(quest)
		labelArray.append(y)
	
	progressbar.set_value(progress)

var progress_target = 1
var progress = 0

signal quest_finished

func progress():
	progress += 1
	if progress == progress_target:
		emit_signal("quest_finished")
	if progress > progress_target:
		progress = progress_target
	progressbar.set_value(100 * progress / progress_target)
	

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
	mentalhealth,
	
	shop
]

func show(name):
	for hud_element in hud_elements:
#		if hud_element != mentalhealth:
		hud_element.visible = false
	
	seedbag.rect_position.y = 0
	inventory.rect_position.y = 0
	
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
	elif name == "shop":
		shop.visible = true
		inventory_back.visible = true
		inventory_front.visible = true
	elif name == "toolbar":
		toolbar.visible = true
		highlight.visible = true
		toolbar_front.visible = true
		change_highlight(current_slot["toolbar"])
		mentalhealth.visible = true
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
		mentalhealth.visible = true
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
		mentalhealth.visible = true
	
	current_hud = name
	if current_hud == "seedtoolbar" or current_hud == "bagtoolbar" or current_hud == "toolbar":
		change_highlight(current_slot[current_hud])

#func _process(delta):
#	show(current_hud)

func refresh():
	print("REFRESH")
	show(current_hud)

var inputEnabled = true

func deactivate():
	inputEnabled = false

func activate():
	inputEnabled = true

func _ready():
	show(current_hud)
	toolbar.connect("toolbar_changed", self, "refresh")
	seedtoolbar.connect("toolbar_changed", self, "refresh")
	bagtoolbar.connect("toolbar_changed", self, "refresh")
	set_quest(["QUEST: 1", "HARVEST X FLOWERS", "TIME: X"])
	
func change_dialogue_texture(t):
	dialoguetexture.texture = t

func change_dialogue_background(b):
	dialoguebackground.texture = b

#var current_name = ""

var character_textures = {
	"Wasp" : preload("res://Assets/Characters/Wasp/Wasp13x11.png"),
	"Capo" : preload("res://Assets/Characters/Capo/Capo13x11.png"),
	"Alpamish" : preload("res://Assets/Characters/Alpamish/Alpamish13x11.png"),
	"Kutalmish" : preload("res://Assets/Characters/Kutalmish/Kutalmish13x11.png")
}

var flag = true

func stop_changing_dialogue_text():
	flag = false
	
func continue_changing_dialogue_text():
	flag = true

func change_dialogue_text(t):
	stop_changing_dialogue_text()
	yield(get_tree(), "idle_frame")
	continue_changing_dialogue_text()
	
	dialoguething.frame = 1
#	print(t)
	dialoguename.text = t[0].name
	change_dialogue_texture(character_textures[dialoguename.text])
	
	dialoguetext.text = ""
	for i in range(t[0].text.length()):
		if flag:
			yield(get_tree(), "idle_frame")
			yield(get_tree(), "idle_frame")
		dialoguetext.text = dialoguetext.text.insert(i, String(t[0].text[i]) )
		print(t[0].text[i])
		print(dialoguetext.text)

	dialoguething.frame = 0
	
	flag = false
	
var dialogue_is_playing = false

func dialogue_started():
	print("STARTED")
#	set_cursor_shape(null)
	dialogue_is_playing = true
	for hud_element in hud_elements:
		hud_element.visible = false
	dialoguebox.visible = true
		
func dialogue_finished():
	print("FINISHED")
	dialogue_is_playing = false
	show("toolbar")
	dialoguebox.visible = false