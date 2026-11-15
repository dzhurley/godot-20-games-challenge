extends Node


var countdown = 4


signal update_countdown
signal remove_life


func start_countdown() -> void:
	countdown = 3

	$StartTimer.start()
	_on_start_timer_timeout()

	
func start() -> void:
	$Paddle.start();
	$Ball.start();


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
