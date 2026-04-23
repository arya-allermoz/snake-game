extends Node2D

var food_scene: PackedScene = preload("res://scenes/food.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_food()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func spawn_food() -> void:
	# creates new food instance and conencts the signals
	var food = food_scene.instantiate() as Area2D
	food.connect("food_consumed", _on_food_consumed)
	
	# randomizes it's position while staying on the grid
	food.position = Vector2i( (randi()%21)*32 - 16, ((randi()%12)*32 - 12) )
	add_child(food)

func _on_food_consumed() -> void:
	call_deferred("spawn_food")
