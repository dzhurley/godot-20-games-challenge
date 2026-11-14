extends CanvasLayer


signal start


func game_over() -> void:
	$GameOver.show()
	get_node('GameOver/Restart').grab_focus()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_play_pressed() -> void:
	$MainMenu.hide()
	$Score.show()
	$Countdown.show()
	start.emit()


func _on_restart_pressed() -> void:
	$Score.text = "%d" % 0
	$Countdown.show()
	start.emit()
	$GameOver.hide()


func _on_back_pressed() -> void:
	$Score.text = "%d" % 0
	$MainMenu.show()
	$Score.hide()
	$GameOver.hide()
	get_node('MainMenu/Play').grab_focus()


func _on_level_update_score() -> void:
	$Score.text = "%d" % (int($Score.text) + 1)


func _on_level_update_countdown(value: int) -> void:
	if value > 0:
		$Countdown.text = "%d" % value
	else:
		$Countdown.text = "Go!"
		var go_timer = get_tree().create_timer(1)
		go_timer.timeout.connect(hide_go)


func hide_go():
	$Countdown.text = ""
	$Countdown.hide()
