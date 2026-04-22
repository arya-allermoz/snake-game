extends CharacterBody2D


const SPEED = 32.0
const UP: Vector2i = Vector2i(0,-1)
const DOWN: Vector2i = Vector2i(0,1)
const LEFT: Vector2i = Vector2i(-1,0)
const RIGHT: Vector2i = Vector2i(1,0)

var current_dir: Vector2i = UP

func _process(_delta: float) -> void:
	if Input.is_action_pressed("up"):
		current_dir = UP
	elif Input.is_action_pressed("down"):
		current_dir = DOWN
	elif Input.is_action_pressed("left"):
		current_dir = LEFT
	elif Input.is_action_pressed("right"):
		current_dir = RIGHT

func _on_timer_timeout() -> void:
	position += SPEED*current_dir
