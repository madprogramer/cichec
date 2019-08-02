extends Node

var time = 0

var frames = []

func _init(Animation):
	var animation = Animation
	var curr_t = 0
	var curr_frame = preload("res://icon-scaled.png")
	
	for Frame in Animation:
		print (Frame)
		# for t in range(curr, Frame)
		
	pass

func get_time():
	return time

func set_time(t):
	time = t

func pass_time():
	time = time + 1

func get_frame():
	return preload("res://icon-scaled.png")
	pass