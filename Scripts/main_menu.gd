extends Control



func _on_button_2_pressed() -> void:
	print("start pressed")
	get_tree().change_scene_to_file("res://Levels/Level_1.tscn")


func _on_button_3_pressed() -> void:
	print("options pressed")
	get_tree().change_scene_to_file("res://Scenes/Options.tscn")


func _on_button_4_pressed() -> void:
	print("exit pressed")
	get_tree().quit()
