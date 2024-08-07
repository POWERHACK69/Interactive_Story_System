extends Node

# Path to the dialog file
@export var dialogPath = "res://story/Sample_Story.json"
# Current phrase number
var phraseNum : int = 0
# Flag to indicate if the dialog is finished
var finished :bool = false
# Dictionary that contains all the text content of the game
var content_dict: Dictionary = {}


# Called when the node is added to the scene
func _ready():
	# Load the content dictionary from the dialog file
	load_content_dict()
	
	
# Function to load the content dictionary
func load_content_dict():
	# Open the file for reading
	var f = FileAccess.open(dialogPath, FileAccess.READ)
	# Check if the file exists
	assert(f.file_exists(dialogPath),"File path does not exist")
	
	# Read the content of the file as text
	var json = f.get_as_text()
	var json_object = JSON.new()

	# Parse the JSON text
	json_object.parse(json)
	# Store the parsed data in the content dictionary
	content_dict = json_object.data

# Return the value of content_dict
func get_content_dict() -> Dictionary:
	return content_dict
	
# Function to move to the next phrase in the dialog
func nextPhrase():
	# Check if the current phrase number is greater than or equal to the number of phrases
	if phraseNum >= len(content_dict):
		# If so, do not proceed (potentially end the dialog)
		#queue_free() # This line is commented out; it would free the node
		return
	# Set finished flag to false
	finished = false
	
