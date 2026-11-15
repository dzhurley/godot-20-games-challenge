extends Node


var score = 0
var lives_remaining = 3


func _on_ui_start() -> void:
	score = 0
	lives_remaining = 3
	$UI.update_score(score)
	$UI.update_lives(lives_remaining)
	$Level.start_countdown()


func game_over() -> void:
	$UI.game_over()


func _on_level_remove_life() -> void:
	lives_remaining -= 1
	$UI.update_lives(lives_remaining)
	if lives_remaining == 0:
		game_over()
	else:
		$UI/Countdown.show()
		$Level.start_countdown()
