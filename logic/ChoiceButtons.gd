extends PanelContainer


# Create custom signal to be able to call in content.tscn
signal choice_btn_pressed(choice_index)

# Export variable that will only accept integers 1, 2, 3, 4
@export var choice_index: int = 1 # (int, 1, 4)

@onready var choice_text: Label = $MarginContainer/Label



func _on_button_pressed():
	emit_signal("choice_btn_pressed", choice_index)
	
# Set text to ChoiceText
func set_text(new_text: String) -> void:
	choice_text.text = new_text
