extends CharacterBody2D


var dead = true
const JUMP_VELOCITY = -300.0
const GRAVITY = 900.0
var current_gravity = GRAVITY


signal off_screened


func start() -> void:
	dead = false
	current_gravity = GRAVITY
	$AnimatedSprite2D.play()


func _physics_process(delta: float) -> void:
	if dead:
		return
		
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	velocity.y += current_gravity * delta

	move_and_collide(velocity * delta)


func kill() -> void:
	velocity = Vector2.ZERO
	current_gravity = 0
	$AnimatedSprite2D.stop()
	dead = true


func _on_screen_exited() -> void:
	off_screened.emit()
