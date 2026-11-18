extends Node

@onready var brick_scene: PackedScene = load('res://games/breakout/brick.tscn')
@onready var viewport = get_viewport().get_visible_rect().size

var countdown = 4

signal update_countdown
signal remove_life
signal score_point


func start_countdown(reset_bricks: bool) -> void:
	countdown = 3

	if reset_bricks:
		get_tree().call_group('bricks', 'queue_free')
		add_bricks();

	$StartTimer.start()
	_on_start_timer_timeout()

	
func start() -> void:
	$Paddle.start();
	$Ball.start();


func add_bricks() -> void:
	var y = 200;
	var x = 150;
	while y < viewport.y / 2:
		while x < viewport.x:
			var brick = brick_scene.instantiate()
			brick.position = Vector2(x, y)
			brick.add_to_group('bricks')
			add_child(brick)
			brick.destroyed.connect(_on_brick_destroyed)
			
			x += 200
		x = 150
		y += 50


func _on_brick_destroyed() -> void:
	score_point.emit()


func _on_start_timer_timeout() -> void:
	update_countdown.emit(countdown)
	if countdown == 0:
		$StartTimer.stop()
		start()
	countdown -= 1


func _on_ball_exited() -> void:
	remove_life.emit()
	$Paddle.reset();
	$Ball.reset();
