extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var tutorial = get_node("Tutorial")
onready var quest1 = get_node("Quest1")

onready var quests = [
	tutorial,
	quest1
]

var current_quest = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	tutorial.connect("quest_finished", self, "next_quest")
	pass # Replace with function body.

signal game_over

func next_quest():
	if current_quest + 1 >= quests.size():
		emit_signal("game_over")
		print("GAME OVER")
		return
	transfer_world(quests[current_quest], quests[current_quest + 1])
	current_quest += 1
	quests[current_quest].connect("quest_finished", self, "next_quest")

func transfer_world(quest1, quest2):
	quest2.world = quest1.world
	quest1 = null
	quest2.ready()
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_T:
			var packed_scene = PackedScene.new()
			packed_scene.pack(quests[current_quest].world)
			ResourceSaver.save("res://world_save.tscn", packed_scene)
			
			var packed_scene_seed = PackedScene.new()
			packed_scene_seed.pack(quests[current_quest].world._seeds)
			ResourceSaver.save("res://seeds_save.tscn", packed_scene_seed)
			
			print("SAVED")
			
		if event.pressed and event.scancode == KEY_Y:
			# Load the PackedScene resource
			var packed_scene = load("res://world_save.tscn")
			# Instance the scene
			var my_scene = packed_scene.instance()
			
			quests[current_quest].world.queue_free()
			quests[current_quest].world = my_scene
			quests[current_quest].add_child(quests[current_quest].world)
			quests[current_quest].world.set_owner(quests[current_quest])
			
			var packed_scene_seed = load("res://seeds_save.tscn").instance()
			
			quests[current_quest].world._seeds = packed_scene_seed
			
			print("LOADED")