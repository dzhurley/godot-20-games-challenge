extends CanvasLayer


func _ready() -> void:
	get_node('%SelectGame').grab_focus()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_game_pressed(game_name: String) -> void:
	get_tree().change_scene_to_file("res://games/" + game_name + "/main.tscn")


func _on_select_game_pressed() -> void:
	get_node('SelectMenu').show()
	get_node('%FlappyBird').grab_focus()


func _on_close_select_pressed() -> void:
	get_node('SelectMenu').hide()
	get_node('%SelectGame').grab_focus()
