extends StaticBody2D

signal destroyed

func destroy() -> void:
	queue_free()
	destroyed.emit()
