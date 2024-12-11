extends Control

func _process(delta: float) -> void:
	if Input.is_action_pressed("esc"):
		get_tree().quit()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://MenuStuff/MenuScenes/options_menu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
