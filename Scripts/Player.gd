extends KinematicBody2D

onready var hud = get_node("HUD")

const SPEED = 20

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
				use(hud.toolbar.slotList[hud.current_slot].item)

func use(item):
	print(item.name)
	# if item.name == "seed_bag":
	#	if hud.current_hud != "seedbag":
	#		hud.show("seedbag")
	#	else:
	#		hud.show("toolbar")

func _ready():
	pass