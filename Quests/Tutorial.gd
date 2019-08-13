extends Node2D

onready var world = get_node("World")

func _ready():
	world.player.hud.set_quest(["HYDRATE 25 TILES"], 0)
	world.player.hud.progress_target = 25
	world.connect("tile_hydrated", self, "progress")
	world.player.hud.connect("quest_finished", self, "quest_finished")

func progress():
	world.player.hud.progress()

signal quest_finished

func quest_finished():
	print("QUEST FINISHED")
	emit_signal("quest_finished")