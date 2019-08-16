extends Node

class_name moneyManager

var funds = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fundsAdd(amount):
	funds += amount
	
func fundsDeduct(amount):
	funds -= amount
	
func fundsEnough(amount):
	if (funds - amount) >= 0 :
		return true
	return false