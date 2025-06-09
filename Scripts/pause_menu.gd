extends Control

func _ready() -> void:
	set_process_mode(Node.PROCESS_MODE_ALWAYS)
	$AnimationPlayer.play("RESET")
	visible = false

func _process(delta: float) -> void:
	# Handle pause toggle input
	test_esc()

func test_esc():
	if Input.is_action_just_pressed("Pause"):
		if get_tree().paused:
			resume()
		else:
			pause()

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	visible = true

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	visible = false

# Resume button
func _on_button_pressed() -> void:
	resume()

# Retry button
func _on_button_2_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

# Quit to main menu button
func _on_button_3_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
