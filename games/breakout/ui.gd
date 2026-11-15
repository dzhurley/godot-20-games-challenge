extends CanvasLayer


signal start


func _ready() -> void:
	get_node("%Play").grab_focus()


func game_over() -> void:
	$GameOver.show()
	get_node('%Restart').grab_focus()


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")


func _on_play_pressed() -> void:
	start.emit()
	$MainMenu.hide()
	$HUD.show()
	$Countdown.show()


func _on_restart_pressed() -> void:
	start.emit()
	$Countdown.show()
	$GameOver.hide()


func _on_back_pressed() -> void:
	get_node('%Score').text = "Score: %d" % 0
	$MainMenu.show()
	$HUD.hide()
	$GameOver.hide()
	get_node('%Play').grab_focus()


func update_lives(lives_remaining: int) -> void:
	get_node('%Lives').text = "Lives: %d" % lives_remaining


func update_score(score: int) -> void:
	get_node('%Score').text = "Score: %d" % score


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
