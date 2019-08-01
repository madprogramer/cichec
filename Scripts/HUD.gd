# HUD.gd
# Manages inventory, toolbar, and seedbag
extends CanvasLayer

onready var inventory = get_node("Inventory")
onready var toolbar = get_node("Toolbar")
onready var seedbag = get_node("SeedBag")
onready var highlight = get_node("Highlight")

var current_hud = "toolbar"
var current_tool = 0

# sets current toolbar tool to x
func set_current_tool(x):
	print(x)
	current_tool = x
	change_highlight(current_tool)
	
#changes current tool highlight to x
func change_highlight(x):
	highlight.rect_position.x =  x * 16
	pass

func _input(event):
	if event is InputEventKey:
		if event.pressed and current_hud == "toolbar":
			if event.scancode == KEY_1:
				set_current_tool(0)
			elif event.scancode == KEY_2:
				set_current_tool(1)
			elif event.scancode == KEY_3:
				set_current_tool(2)
			elif event.scancode == KEY_4:
				set_current_tool(3)


# makes hud with name visible, makes others invisible
func show(name):
	inventory.visible = false
	toolbar.visible = false
	seedbag.visible = false
	highlight.visible = false
	
	if name == "inventory":
		inventory.visible = true
	elif name == "toolbar":
		toolbar.visible = true
		highlight.visible = true
	elif name == "seedbag":
		seedbag.visible = true
	else:
		print("ERROR, %s in undefined" % name)

func _process(delta):
	show(current_hud)
	pass

func _ready():
	show(current_hud)
	pass