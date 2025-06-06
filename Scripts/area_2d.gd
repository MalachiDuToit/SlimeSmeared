extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("enable_double_jump"):
		body.enable_double_jump()
		queue_free()
