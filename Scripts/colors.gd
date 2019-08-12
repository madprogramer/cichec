extends Node

class_name colors

#Desired Colors in RYB

var black = Vector3(0.2,0.2,0.2)

var red = Vector3(1,0,0)
var yellow = Vector3(1,1,0.2)
var blue = Vector3(0,0,1)

var orange = Vector3(1,0.6,0.2)
var green = Vector3(0,0.9,0.15)
var purple = Vector3(0.7,0.1,1)

var white = Vector3(1,1,1)

func RYB2RGB(RYBTarget):
	
	#Factors (Make sure to normalize!)
	var r = RYBTarget[0]/2.0
	var y = RYBTarget[1]/2.0
	var b = RYBTarget[2]/2.0
	
	return black * (1-r) * (1-y) * (1-b) + \
	red * (r) * (1-y) * (1-b) + \
	blue * (1-r) * (1-y) * (b) + \
	yellow * (1-r) * (y) * (1-b) + \
	orange * (r) * (y) * (1-b) + \
	green * (1-r) * (y) * (b) + \
	purple * (r) * (1-y) * (b) + \
	white * (r) * (y) * (b)