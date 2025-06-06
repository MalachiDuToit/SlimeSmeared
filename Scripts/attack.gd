extends State
 
func enter():
	super.enter()
	combo()
 #Defines and plays the first attack animation
func attack(move = "1"):
	await get_tree().create_timer(1.0).timeout 
	animation_player.play("Attack_" + move)
	await animation_player.animation_finished
 

#Defines and plays the combo, which contains both attacks
func combo():
	var move_set = ["1","1","2"]
	for i in move_set:
		await attack(i)
 #infinitly loops the combo attack
	combo()
#Changes the state to either Follow or Teleport
func transition():
	if owner.direction.length() > 40:
		get_parent().change_state("Follow")
	if owner.direction.length() > 150:
		get_parent().change_state("Teleport")
