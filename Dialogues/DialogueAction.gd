extends Node
class_name DialogueAction

#export (String, FILE, "*.json") var dialogue_file_path : String

var dialogue_file_path
var dialogue = null

signal started
signal finished
signal text_changed

func _ready():
	 dialogue_file_path = "res://Dialogues/test_dialogue.json"

func interact(file_path):
	line = 1
	self.dialogue_file_path = file_path
#	print("FLAG")
	dialogue = load_dialogue(self.dialogue_file_path)
	emit_signal("started")
	play_dialogue()
	
func load_dialogue(file_path):
	var file = File.new()
	print(file_path)
	assert file.file_exists(file_path)
	
	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_text())
	print(file.get_as_text())
	assert dialogue.size() > 0
	return dialogue
	
var line = 1
	
func play_dialogue():
	yield(get_tree(), "idle_frame")
#	print(">", dialogue[str(line)])
	emit_signal("text_changed", [dialogue[str(line)]])
#	print(dialogue[str(line)].name)
#	print(dialogue[str(line)].text)
#		yield(get_tree(), "idle_frame")
#			pass

func continue_dialogue():
	if line + 1 > dialogue.size():
		print("FINISHED")
		emit_signal("finished")
	else:
		line = line + 1
		play_dialogue()

func _process(delta):
	if Input.is_action_just_pressed("mouse_select"):
		continue_dialogue()