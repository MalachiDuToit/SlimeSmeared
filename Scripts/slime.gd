extends Node2D

const SPEED = 60

var direction  = 1
@onready var rc_right: RayCast2D = $rcRight
@onready var rc_left: RayCast2D = $rcLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rc_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if rc_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
	position.x += direction * SPEED * delta
