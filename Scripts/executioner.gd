extends CharacterBody2D

@onready var player = get_parent().find_child("Player")
@onready var animated_sprite = $AnimatedSprite2D
@onready var progress_bar: ProgressBar = $UI/ProgressBar

var direction : Vector2
var Health = 10: 
	set(value):
		Health = value
		progress_bar.value = value
		if value <= 0:
			progress_bar.visible = false
			find_child("FiniteStateMachine").change_state("Death")

var player_in_hitbox = false
var damage_timer : Timer

func _ready():
	set_physics_process(false)
	
	damage_timer = Timer.new()
	damage_timer.wait_time = 1.0  # Damage interval (1 second)
	damage_timer.one_shot = false  # Allow repeated firing
	damage_timer.connect("timeout", Callable(self, "_on_damage_timer_timeout"))
	add_child(damage_timer)


func _process(_delta):
	direction = player.position - position
	if direction.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false

func _physics_process(delta):
	velocity = direction.normalized() * 30
	move_and_collide(velocity * delta)

func take_damage():
	Health -= 1
	print("Damage taken")

# Called when player enters the hitbox
func _on_execution_hitbox_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player_in_hitbox = true
		if not damage_timer.is_stopped():
			damage_timer.stop()
		damage_timer.start()


# Called when player exits the hitbox
func _on_execution_hitbox_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		player_in_hitbox = false
		damage_timer.stop()

# Called when the timer completes
func _on_damage_timer_timeout():
	if player_in_hitbox:
		player.take_damage()
