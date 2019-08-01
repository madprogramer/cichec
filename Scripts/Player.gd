extends KinematicBody2D

onready var hud = get_node("HUD")

const SPEED = 80

func move():
	var move_vec = Vector2(0, 0)
	move_vec.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	move_vec.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	
	move_vec = move_vec.normalized()
	
	move_and_slide(move_vec * SPEED)

func _process(delta):
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

signal plow;
signal water;

func use(item):
	print(item.name)
	
	if item.name == "seed_bag":
		if hud.current_hud != "seedbag":
			hud.show("seedbag")
			hud.current_hud = "seedbag"
		else:
			hud.show("toolbar")
			hud.current_hud = "toolbar"
	
	if item.name == "bag":
		if hud.current_hud != "inventory":
			hud.show("inventory")
			hud.current_hud = "inventory"
		else:
			hud.show("toolbar")
			hud.current_hud = "toolbar"
	
	if item.name == "hoe":
		emit_signal("plow")
	
	if item.name == "watering_can":
		emit_signal("water")

func _ready():
	pass