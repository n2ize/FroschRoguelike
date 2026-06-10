extends Node
const Deathscreen = preload("res://deathscreen.tscn")

func show_death_screen():
	var ui = Deathscreen.instantiate()
	get_tree().current_scene.add_child(ui)
	
