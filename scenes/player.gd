extends CharacterBody2D

const SPEED = 32.0
const UP: Vector2i = Vector2i(0,-1)
const DOWN: Vector2i = Vector2i(0,1)
const LEFT: Vector2i = Vector2i(-1,0)
const RIGHT: Vector2i = Vector2i(1,0)

var current_dir: Vector2i = UP # direction the snake is currently moving in
var selected_dir: Vector2i = current_dir # direction the snake will move in at the end of the timer

var tail_scene: PackedScene = preload("res://scenes/tail_segment.tscn")
var tail_array: Array[Vector2i] = [Vector2i(304, 212), Vector2i(304, 244), Vector2i(304, 276), Vector2i(304, 308)]

func _process(_delta: float) -> void:
	if Input.is_action_pressed("up") and current_dir != DOWN:
		selected_dir = UP
	elif Input.is_action_pressed("down") and current_dir != UP:
		selected_dir = DOWN
	elif Input.is_action_pressed("left") and current_dir != RIGHT:
		selected_dir = LEFT
	elif Input.is_action_pressed("right") and current_dir != LEFT:
		selected_dir = RIGHT


func _on_timer_timeout() -> void:
	# updates the stored positions of the tail segments
	for i in range(len(tail_array)-1, 0, -1):
		tail_array[i] = tail_array[i-1]
	tail_array[0] = position
	
	# moves the head
	current_dir = selected_dir
	position += SPEED*current_dir
	
	# spawns the tail segments
	# TODO: store instances in array instead of creating new ones everytime
	for i in range(len(tail_array)):
		var tail: Area2D = tail_scene.instantiate() as Area2D
		tail.position = tail_array[i]
		get_node("/root/level/tail").add_child(tail)


func _grow_tail() -> void:
	tail_array.append(Vector2i.ZERO)
