extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	await get_tree().create_timer(1).timeout
	show()
	get_tree().paused = true
	pass

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	queue_free()
	



func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
