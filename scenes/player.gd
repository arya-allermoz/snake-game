extends CharacterBody2D


const SPEED = 32.0
const UP: Vector2i = Vector2i(0,-1)
const DOWN: Vector2i = Vector2i(0,1)
const LEFT: Vector2i = Vector2i(-1,0)
const RIGHT: Vector2i = Vector2i(1,0)

var current_dir: Vector2i = UP
var selected_dir: Vector2i = current_dir

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
	current_dir = selected_dir
	position += SPEED*current_dir
