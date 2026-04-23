extends Area2D

signal food_consumed

func _on_body_entered(_body: Node2D) -> void:
	# when the player overlaps the food, generates new food instance and delete this instance
	food_consumed.emit()
	call_deferred("queue_free")
