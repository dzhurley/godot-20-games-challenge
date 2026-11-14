extends Node2D


var cloud_scene = preload("res://games/flappy_bird/cloud.tscn")
var pipes_scene = preload("res://games/flappy_bird/pipes.tscn")
var countdown = 4


signal update_countdown
signal game_over
signal update_score


func get_clouds() -> Array[Node]:
	return get_children().filter(func (child): return child is Cloud)


func get_pipes() -> Array[Node]:
	return get_children().filter(func (child): return child is Pipes)


func start_countdown() -> void:
	countdown = 3
	for cloud in get_clouds():
		cloud.queue_free()
	for pipes in get_pipes():
		pipes.queue_free()

	$StartTimer.start()
	_on_start_timer_timeout()
	$Player.position = Vector2(200, 400);

	add_clouds_at(100)
	add_clouds_at(300)
	add_clouds_at(500)
	add_clouds_at(700)
	add_clouds_at(900)
	add_clouds_at(1100)
	add_clouds_at(1300)
	for cloud in get_clouds():
		cloud.speed = 0

	add_pipes_at(700)
	add_pipes_at(1000)
	add_pipes_at(1300)
	for pipes in get_pipes():
		pipes.speed = 0
	
	
func start() -> void:
	$Player.start();
	for cloud in get_clouds():
		cloud.speed = -80
	for pipes in get_pipes():
		pipes.speed = -100
	$PipeTimer.start()


func stop() -> void:
	$PipeTimer.stop()
	for cloud in get_clouds():
		cloud.speed = 0
	for pipes in get_pipes():
		pipes.speed = 0


func add_clouds_at(x: int):
	var cloud = cloud_scene.instantiate()
	cloud.position.x = x
	add_child(cloud)
	move_child(cloud, 1)
	

func add_pipes_at(x: int):
	var pipes = pipes_scene.instantiate()
	pipes.hit.connect(_on_death)
	pipes.score.connect(_on_bird_score)
	pipes.position.x = x
	add_child(pipes)
	


func _on_pipe_timer_timeout() -> void:
	add_pipes_at(1300)


func _on_death():
	stop()
	$Player.kill()
	game_over.emit()


func _on_bird_score():
	update_score.emit()


func _on_start_timer_timeout() -> void:
	update_countdown.emit(countdown)
	if countdown == 0:
		$StartTimer.stop()
		start()
	countdown -= 1
