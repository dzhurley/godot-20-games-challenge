extends Node


func _ready() -> void:
	get_node('UI/MainMenu/Play').grab_focus()


func _on_ui_start() -> void:
	$Level.start_countdown()


func _on_level_game_over() -> void:
	$UI.game_over()
