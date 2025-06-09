extends CharacterBody2D

var enemy_in_range = false
var health = 100
var player_alive = true
var is_attacking = false
var is_hurt = false
var can_double_jump = false
var has_double_jumped = false

# Base stats
const BASE_SPEED = 150.0
const BASE_JUMP = -305.0

# Current (modifiable) stats
var SPEED = BASE_SPEED
var JUMP_VELOCITY = BASE_JUMP

@onready var health_display: Label = $HealthDisplay
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_hitbox: Area2D = $AttackHitbox
@onready var enemy: Node2D = get_parent().find_child("Executioner", true, false)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	# --- Handle Attack Input ---
	if Input.is_action_just_pressed("attack") and not is_attacking and not is_hurt:
		is_attacking = true
		animated_sprite.play("Attack")
		await animated_sprite.animation_finished
		if enemy and enemy.has_node("Execution_Hitbox"):
			var boss_hitbox = enemy.get_node("Execution_Hitbox")
			var frontHBox = get_node("AttackHit")
			if frontHBox.overlaps_area(boss_hitbox):
				enemy.take_damage() 	
				print("Boss hurt")
		
		is_attacking = false

	#Handle Jumping and Double Jump
	if Input.is_action_just_pressed("jump"):
		if is_on_floor() and not is_attacking and not is_hurt:
			velocity.y = JUMP_VELOCITY
			has_double_jumped = false
		elif can_double_jump and not has_double_jumped and not is_on_floor() and not is_attacking and not is_hurt:
			velocity.y = JUMP_VELOCITY
			has_double_jumped = true

	#Handle Movement Direction
	var direction := Input.get_axis("move_left", "move_right")

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# --- Handle Movement and Animation ---
	if not is_attacking and not is_hurt:
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("default")
			else:
				animated_sprite.play("Run")
		else:
			animated_sprite.play("Jump")

	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_range = true

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_range = false

#Power-Up Boost Handler
func apply_speed_boost():
	SPEED = BASE_SPEED * 2
	JUMP_VELOCITY = BASE_JUMP * 1.5
	#print("Speed Boost Activated!")

	await get_tree().create_timer(7.5).timeout

	SPEED = BASE_SPEED
	JUMP_VELOCITY = BASE_JUMP
	#print("Speed Boost Wore Off")

func enable_double_jump():
	can_double_jump = true
	#print("Double Jump Unlocked!")

func die():
	#print("Player has died.")
	set_process(false)
	set_physics_process(false)
	animated_sprite.play("Death")
	await animated_sprite.animation_finished
	get_tree().reload_current_scene()

func take_damage():
	if is_hurt:
		return

	is_hurt = true
	health -= 10 
	health_display.text = str(health / 10)
	#print("Player took damage! Health now:", health)

	# --- Knockback ---
	var knockback_force = 80.0
	var direction = sign(global_position.x - enemy.global_position.x)
	velocity.x = direction * knockback_force
	velocity.y = -knockback_force * 0.5
	move_and_slide()
	animated_sprite.play("Hurt")
	await animated_sprite.animation_finished

	is_hurt = false

	if health <= 0:
		die()
