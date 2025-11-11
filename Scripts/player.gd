extends Node2D

@export var speed := 300.0

func _process(delta: float) -> void:
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	position += input_dir * speed * delta
