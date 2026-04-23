extends Area2D

signal food_consumed

func _on_body_entered(body: Node2D) -> void:
	
	# when the player overlaps the food, generates new food instance and delete this instance
	if get_node("/root/level/player") == body:
		food_consumed.emit()
	
	# if it spawns on the tail, respawn it again
	else:
		get_node("/root/level").spawn_food()
	
	call_deferred("queue_free")
