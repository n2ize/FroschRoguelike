extends Node
const Deathscreen = preload("res://UI/deathscreen.tscn")
const Level_Ui = preload("res://UI/InLevelUI.tscn")

func show_death_screen():
	var ui = Deathscreen.instantiate()
	get_tree().current_scene.add_child(ui)
	
func show_Level_Ui():
	var ui = Level_Ui.instantiate()
	get_tree().current_scene.add_child(ui)
