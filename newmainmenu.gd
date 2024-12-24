extends Node2D



func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/paper_airplane_game.tscn")



func _on_locker_pressed() -> void:
	pass # Replace with function body.



func _on_options_pressed() -> void:
	pass # Replace with function body.



func _on_quit_pressed() -> void:
	get_tree().quit()
