extends Node2D
class_name Pipes


signal hit
signal score


var speed = -100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = randi_range(200, 600)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta


func _on_pipe_exited_screen() -> void:
	queue_free()


func _on_pipe_body_entered(body: Node2D) -> void:
	hit.emit()


func _on_gate_body_entered(body: Node2D) -> void:
	score.emit()
