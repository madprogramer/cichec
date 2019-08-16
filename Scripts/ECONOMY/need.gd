extends Node

class_name needManager

var stockpile = {}
var consumption = {}

var types = {}

var provided = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#Add New Needs For This Level
func addNeed(name, start, consumed, typeDict):
	stockpile[name] = start
	consumption[name] = consumed
	types[name] =  {}
	
	for type in typeDict:
		types[name][type] = typeDict[type]

#Add Resources to be Stockpiled at the end of the day
func fulfillNeed():
	print("TODO: update this based on shipments")
	
#Update Needs 		
func tickNeed():
	for need in types:
		
		print("TODO: RECEIVE FROM SHIPMENTS, ADD BONUSES FOR SIZE/COLOR MATCH")
		#for type in types[need]:
		#	provided[need] += types[need]
		
		stockpile[need] -= consumption[need]
		#Deficit
		var needDeficit = - min(0,stockpile[need])
		if needDeficit > 0:
			print( "Deficit of " + str(needDeficit) + " for " + need)
			stockpile[need] = 0
		
	#return deficits to lower stability
	return []
		