extends Node2D
class_name State
 
@onready var debug = owner.find_child("debug")
@onready var player = owner.get_parent().find_child("Player")
@onready var animation_player = owner.find_child("AnimationPlayer")
 
func _ready():
	set_physics_process(false)
	if player == null:
		push_error("Player node not found!")
	else:
		print("Player found: ", player.name)
func enter():
	set_physics_process(true)
 
func exit():
	set_physics_process(false)
 
func transition():
	pass
 
func _physics_process(_delta):
	transition()
	debug.text = name
