extends Area2D

@onready var sound_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var disable_sound := false

func _on_body_entered(body: Node2D) -> void:
	if not disable_sound:
		sound_player.play()
		await sound_player.finished
	print("level completed")
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	var next_level_file = "res://Levels/level_" + str(next_level_number) + ".tscn"
	print(next_level_file)
	hide()
	get_tree().change_scene_to_file(next_level_file)
