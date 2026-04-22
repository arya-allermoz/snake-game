extends Node2D

var food_scene: PackedScene = preload("res://scenes/food.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_food()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func spawn_food() -> void:
	# TODO: Food is not instanciated (not appearing)
	print("food ate")
	var food = food_scene.instantiate() as Area2D
	food.connect("food_consumed", _on_food_consumed)
	food.position = Vector2i( (randi()%21)*32, ((randi()%12)*32 + 4) )

func _on_food_consumed() -> void:
	# TODO: fix signal connection
	print("food aten")
	spawn_food()
