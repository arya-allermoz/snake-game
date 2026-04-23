extends Node2D

signal grow_tail

var food_scene: PackedScene = preload("res://scenes/food.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#spawns the initial food
	spawn_food()


# handles spawning a new instance of food randomly on the map
func spawn_food() -> void:
	# creates new food instance and connects the signals
	var food = food_scene.instantiate() as Area2D
	food.connect("food_consumed", _on_food_consumed)
	
	# randomizes its position while staying aligned to the grid
	food.position = Vector2i( (randi()%20)*32 + 16, ((randi()%11)*32 + 20) )
	
	# adds the instance to the scene tree to make it appear
	add_child(food)


# handles calling all other methods when food is consumed
func _on_food_consumed() -> void:
	call_deferred("spawn_food")
	grow_tail.emit()
