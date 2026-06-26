extends Control

func _ready():
	$VBoxContainer/VBoxContainer/PlayButton.pressed.connect(_on_play_pressed)
	$VBoxContainer/VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Rooms/level_generator.tscn")

func _on_quit_pressed():
	get_tree().quit()
