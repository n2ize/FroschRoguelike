extends Control

func _ready():
	if not $VBoxContainer/VBoxContainer/PlayButton.pressed.is_connected(_on_play_button_pressed):
		$VBoxContainer/VBoxContainer/PlayButton.pressed.connect(_on_play_button_pressed)
	print("main menu ready called")
	
func _on_play_button_pressed() -> void:
	print("play pressed")
	get_tree().change_scene_to_file("res://Rooms/level_generator.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
