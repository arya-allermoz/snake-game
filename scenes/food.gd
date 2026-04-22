extends Area2D

signal food_consumed

var level: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = get_tree().current_scene


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("food eated: " + str(body))
	if body == get_tree().get_node("player"):
		food_consumed.emit()
		queue_free()
