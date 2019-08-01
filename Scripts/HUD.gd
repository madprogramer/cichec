extends CanvasLayer

onready var inventory = get_node("Inventory")
onready var toolbar = get_node("Toolbar")
onready var seedbag = get_node("SeedBag")

func show(name):
	inventory.visible = false
	toolbar.visible = false
	seedbag.visible = false
	
	if name == "inventory":
		inventory.visible = true
	elif name == "toolbar":
		toolbar.visible = true
	elif name == "seedbag":
		seedbag.visible = true
	else:
		print("ERROR, %s in undefined" % name)

func _process(delta):
	pass

func _ready():
	show("toolbar")
	pass