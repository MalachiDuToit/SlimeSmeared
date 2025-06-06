extends Control


func _on_level_1_pressed() -> void:
	print("Level 1 toggled")
	get_tree().change_scene_to_file("res://Levels/Level_1.tscn")


func _on_level_2_pressed() -> void:
	print("Level 2 Toggled")
	get_tree().change_scene_to_file("res://Levels/Level_2.tscn")


func _on_level_3_pressed() -> void:
	print("Level 3 Toggled")
	get_tree().change_scene_to_file("res://Levels/Level_3.tscn")


func _on_emu_pressed() -> void:
	print("EEEEEEEEEMMMMMMMMMMUUUUUU!!!!!!!!!!!!!!")
	get_tree().change_scene_to_file("res://Scenes/Emu.tscn")
