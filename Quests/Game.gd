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