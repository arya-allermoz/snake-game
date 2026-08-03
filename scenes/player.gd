extends CharacterBody2D

const SPEED = 32.0
const UP: Vector2i = Vector2i(0, -1)
const DOWN: Vector2i = Vector2i(0, 1)
const LEFT: Vector2i = Vector2i(-1, 0)
const RIGHT: Vector2i = Vector2i(1, 0)

@export var tail_segments: Node2D

var current_dir: Vector2i = UP # direction the snake is currently moving in
var selected_dir: Vector2i = current_dir # direction the snake will move in at the end of the timer

var tail_scene: PackedScene = preload("res://scenes/tail_segment.tscn")
var tail_array: Array[Area2D]


func _ready() -> void:
	# initialisation
	tail_array = []
	position.x = 304.0
	position.y = 180.0

	# initial tail
	var tail: Area2D = tail_scene.instantiate()
	tail.position = Vector2i(304, 212)
	tail_array.append(tail)
	tail_segments.add_child(tail)
	tail = tail_scene.instantiate()
	tail.position = Vector2i(304, 244)
	tail_array.append(tail)
	tail_segments.add_child(tail)
	tail = tail_scene.instantiate()
	tail.position = Vector2i(304, 276)
	tail_array.append(tail)
	tail_segments.add_child(tail)
	tail = tail_scene.instantiate()
	tail.position = Vector2i(304, 308)
	tail_array.append(tail)
	tail_segments.add_child(tail)


func _process(_delta: float) -> void:
	if Input.is_action_pressed("up") and current_dir != DOWN:
		selected_dir = UP
	elif Input.is_action_pressed("down") and current_dir != UP:
		selected_dir = DOWN
	elif Input.is_action_pressed("left") and current_dir != RIGHT:
		selected_dir = LEFT
	elif Input.is_action_pressed("right") and current_dir != LEFT:
		selected_dir = RIGHT

	if is_colliding_with_tail():
		clear_tail_segments()
		get_node("/root/level").restart_level()
		_ready()


func is_colliding_with_tail() -> bool:
	for tail in tail_array:
		if tail.position.x == position.x and tail.position.y == position.y:
			return true
	return false


func clear_tail_segments() -> void:
	for tail in tail_array:
		tail.queue_free()


func _on_timer_timeout() -> void:
	# updates the stored positions of the tail segments
	for i in range(len(tail_array) - 1, 0, -1):
		tail_array[i].position = tail_array[i - 1].position
	tail_array[0].position = position

	# moves the head
	current_dir = selected_dir
	position += SPEED * current_dir


func _grow_tail() -> void:
	var tail: Area2D = tail_scene.instantiate()
	tail.position = tail_array.back().position
	tail_array.append(tail)
	get_node("/root/level/tail").call_deferred("add_child", tail)
