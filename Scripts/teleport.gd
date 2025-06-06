extends State

var can_transition: bool = false

func enter():
	super.enter()
	animation_player.play("Skill")
	await animation_player.animation_finished
	teleport()
	can_transition = true
	transition()

func teleport():
	owner.position = player.position + Vector2.RIGHT * 40

func transition():
	if can_transition:
		get_parent().change_state("Attack")
		can_transition = false
