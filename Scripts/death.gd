extends State

func enter():
	super.enter()
	animation_player.play("Death")
	#SceneManager.load_new_scene("res://Levels/Endgame.tscn","wipe_to_right")
	get_tree().change_scene_to_file("res://Levels/Endgame.tscn")
func boss_slain():
	animation_player.play("Boss_Slain")
