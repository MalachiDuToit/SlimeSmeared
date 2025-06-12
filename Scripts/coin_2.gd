extends Area2D

@onready var sound_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
@export var disable_sound := false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node2D) -> void:
	if not disable_sound:
		sound_player.play()
		await sound_player.finished
	print("level completed")

	# Get the current scene's file path
	var current_scene_file = get_tree().current_scene.scene_file_path

	# Extract the level number from the file name, e.g., "level_3" → 3
	var file_name = current_scene_file.get_file().get_basename() # "level_3"
	var level_number = file_name.get_slice("_", 1).to_int()
	var next_level_number = level_number + 1

	# Build the next level's path
	var next_level_file = "res://Levels/level_" + str(next_level_number) + ".tscn"
	print(next_level_file)

	hide()
	get_tree().change_scene_to_file(next_level_file)
