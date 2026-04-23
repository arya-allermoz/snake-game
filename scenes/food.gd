extends Area2D

signal food_consumed

var is_consumed: bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(_body: Node2D) -> void:
	food_consumed.emit()
	is_consumed = true
	call_deferred("queue_free")
