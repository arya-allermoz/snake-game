extends Area2D

signal food_consumed


func _on_body_entered(body: Node2D) -> void:
	# when the player overlaps the food, generates new food instance and delete this instance
	if get_node("/root/level/player") == body:
		food_consumed.emit()

	call_deferred("queue_free")


func _on_area_entered(_area: Area2D) -> void:
	# if the food spawns on the tail, spawn a new instance and delete the previous one
	get_node("/root/level").spawn_food()
	call_deferred("queue_free")
