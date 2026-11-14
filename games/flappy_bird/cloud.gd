extends Node2D
class_name Cloud


var speed = -80


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = randi_range(100, 900)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta


func _on_cloud_exited_screen() -> void:
	position.x += 1300
	position.y = randi_range(100, 900)
