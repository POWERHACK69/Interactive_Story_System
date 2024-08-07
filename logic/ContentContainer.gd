extends VBoxContainer


var player_stats : Dictionary

var used_hp = false
var is_dead = false
var shown_death = false


@export var start_page:String = "000_prologue"
@export var death_page:String = "health_is_zero"
@export var mana_low_page:String = "mana_is_zero" #you can go ahead and implement something with this

# Declare variables for UI elements and connect them to their respective nodes in the scene
@onready var title_label: Label = %Label
@onready var statindicator: RichTextLabel = %StatIndicator
@onready var picture: TextureRect = %TextureRect
@onready var narr_text: RichTextLabel = %RichTextLabel
@onready var choices_con: VBoxContainer = %VBoxContainer
@onready var choice_1: PanelContainer = %ChoiceContainer
@onready var choice_2: PanelContainer = %ChoiceContainer2
@onready var choice_3: PanelContainer = %ChoiceContainer3
@onready var choice_4: PanelContainer = %ChoiceContainer4

# Variables to store the content data and the current page identifier
var content_dict: Dictionary
var current_page: String

# Called when the node is added to the scene
func _ready() -> void:
	statindicator.text = ""
	# Initialize the content dictionary from an external source
	content_dict = ContentData.content_dict
	
	# Set the current page to the prologue
	current_page = start_page
	# Set the content for the current page
	set_content(content_dict[current_page])

	# Connect choice button signals to the process_choice function
	choice_1.connect("choice_btn_pressed", Callable(self, "process_choice"))
	choice_2.connect("choice_btn_pressed", Callable(self, "process_choice"))
	choice_3.connect("choice_btn_pressed", Callable(self, "process_choice"))
	choice_4.connect("choice_btn_pressed", Callable(self, "process_choice"))


func _process(delta):
	player_stats = $"../../../..".stat
	if player_stats["health"] <=0:
		is_dead = true 
		
	if is_dead and shown_death == false:
		var death_text = str(content_dict[death_page]["narr_text"])+"\n"
		print("death text is ",death_text)
		narr_text.text = narr_text.text+"\n"+death_text
		var output =content_dict[death_page]["choices"][str(1)]
		print(output)
		set_choice_btn(content_dict[death_page])
		shown_death=true	


# Function to process a choice made by the user
func process_choice(choice_index: int) -> void:
	# Reset the stat indicator text
	statindicator.text = ""
	
	# If the player is dead, set the current page to the death page
	if is_dead == true:
		current_page = death_page
	
	# Get the output value from the choices dictionary
	if content_dict[current_page]["choices"][str(choice_index)].has("output"):
		get_parent().scroll_vertical = 0
		var output_value = content_dict[current_page]["choices"][str(choice_index)]["output"]
		
	# Check for requirements in the choice
		if content_dict[current_page]["choices"][str(choice_index)].has("requirement"):
			var requirements = content_dict[current_page]["choices"][str(choice_index)]["requirement"]
			for requirement in requirements.keys():
				if player_stats[requirement] < requirements[requirement] and content_dict[current_page]["choices"][str(choice_index)].has("failed_output"):
					if requirement == "mana":
						var health_deduction
						health_deduction = player_stats[requirement] - requirements[requirement]
						player_stats["health"] += round(health_deduction * 1.5)
						statindicator.text = statindicator.text + "\n" + "[color=red]" + str("health") + " has decreased by " + str(round(-health_deduction * 1.5)) + "[/color]"
						used_hp = true
						output_value = content_dict[current_page]["choices"][str(choice_index)]["output"]
					else:
						output_value = content_dict[current_page]["choices"][str(choice_index)]["failed_output"]
						
		
		# Apply buffs if present in the choice
		if content_dict[current_page]["choices"][str(choice_index)].has("buffs"):
			var buff_value = content_dict[current_page]["choices"][str(choice_index)]["buffs"]
			print(buff_value.keys())
			for key in buff_value.keys():
				if buff_value[key] >= 0:
					statindicator.text = statindicator.text + "\n" + "[color=green]" + str([key][0]) + " has increased by " + str(buff_value[key]) + "[/color]"
				elif buff_value[key] < 0:
					statindicator.text = statindicator.text + "\n" + "[color=red]" + str([key][0]) + " has decreased by " + str(-buff_value[key]) + "[/color]"
				player_stats[key] += buff_value[key]

		# Set the current page to the output value
		current_page = output_value
		print(content_dict[output_value])
		set_content(content_dict[output_value])

		


# Function to set the content of the current page
func set_content(output_value) -> void:
	set_title(output_value)      # Set the title
	set_picture(output_value)    # Set the picture
	set_narr_text(output_value)  # Set the narrative text
	set_choice_btn(output_value) # Set the choice buttons


# Function to set the title text
func set_title(output_value) -> void:
	title_label.text = str(output_value["title"])

# Function to set the picture texture
func set_picture(output_value) -> void:
	if output_value.has("picture"):
		picture.texture = load(output_value["picture"])
	else:
		picture.texture = null
		
# Function to set the narrative text
func set_narr_text(output_value) -> void:
	narr_text.text = str(output_value["narr_text"])


# Function to set the choice buttons
func set_choice_btn(output_value) -> void:
	# Hide all choice buttons initially
	for choice_i in choices_con.get_children():
		if choice_i.visible:
			choice_i.set_text("")
			choice_i.visible = false
			
	# Display and set text for each choice button based on the current content
	if is_dead == false:
		for choice in output_value["choices"]:
			match choice:
				"1":
					choice_1.set_text(str(output_value["choices"][str(choice_1.choice_index)]["text"]))
					choice_1.visible = true
				"2":
					choice_2.set_text(str(output_value["choices"][str(choice_2.choice_index)]["text"]))
					choice_2.visible = true
				"3":
					choice_3.set_text(str(output_value["choices"][str(choice_3.choice_index)]["text"]))
					choice_3.visible = true
				"4":
					choice_4.set_text(str(output_value["choices"][str(choice_4.choice_index)]["text"]))
					choice_4.visible = true
					
	elif is_dead == true:
		for choice in content_dict[death_page]["choices"]:
			match choice:
				"1":
					choice_1.set_text(str(content_dict[death_page]["choices"][str(choice_1.choice_index)]["text"]))
					choice_1.visible = true
				"2":
					choice_2.set_text(str(content_dict[death_page]["choices"][str(choice_2.choice_index)]["text"]))
					choice_2.visible = true
				"3":
					choice_3.set_text(str(content_dict[death_page]["choices"][str(choice_3.choice_index)]["text"]))
					choice_3.visible = true
				"4":
					choice_4.set_text(str(content_dict[death_page]["choices"][str(choice_4.choice_index)]["text"]))
					choice_4.visible = true

