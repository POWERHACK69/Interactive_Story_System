extends PanelContainer

var stat = {"health": 5, "mana": 30, "coins": 5, "strength": 6, "intelligence": 9}

@onready var stats_label = $MarginContainer/VBoxContainer/HBoxContainer/Label

func _ready():
	stats_label.text = str("Health: "+str(stat["health"])+", "+"Mana: "+str(stat["mana"])+ ", "+"Coins: "+str(stat["coins"])+"\nStrength: "+str(stat["strength"])+", "+"Intelligence: "+str(stat["intelligence"]))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	stats_label.text = str("Health: "+str(stat["health"])+", "+"Mana: "+str(stat["mana"])+ ", "+"Coins: "+str(stat["coins"])+"\nStrength: "+str(stat["strength"])+", "+"Intelligence: "+str(stat["intelligence"]))
	for stats in stat:
		if stat[stats] <=0:
			stat[stats] = 0


func _on_button_pressed():
	OS.shell_open("https://www.youtube.com/@-RedIndieGames")
