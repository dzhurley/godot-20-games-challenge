extends CharacterBody2D


@export var speed = 1000
var processing_input = false


func reset() -> void:
	position = Vector2(150, 750)
	processing_input = false


func start() -> void:
	processing_input = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if !processing_input:
		return

	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
	else:
		velocity.x = 0

	move_and_collide(velocity * delta)
