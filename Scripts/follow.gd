extends State

# Max speed when far from the player
var max_speed := 80.0
# Distance at which the enemy starts to slow down
var slow_radius := 100.0

func _enter_tree():
	randomize()

func enter():
	super.enter()
	owner.set_physics_process(true)
	animation_player.play("Idle")

func exit():
	super.exit()
	owner.set_physics_process(false)

func _physics_process(delta):
	if player == null:
		push_error("Player is null in Follow state!")
		return

	var to_player = player.global_position - owner.global_position
	var distance = to_player.length()
	var direction = to_player.normalized()

	# Speed scales down as the enemy gets closer
	var speed = max_speed
	if distance < slow_radius:
		speed *= distance / slow_radius

	# Move toward player
	owner.global_position += direction * speed * delta

	#Transitions to Attack or Teleport depending on distance
	if distance < 40:
		get_parent().change_state("Attack")
	elif distance > 300:
		get_parent().change_state("Teleport")
